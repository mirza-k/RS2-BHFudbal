using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using System;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;
using System.Threading;
using System.Threading.Tasks;

namespace BHFudbal.Subscriber
{
    internal class Program
    {
        private static IConnection _connection;
        private static IModel _channel;
        private static readonly string[] Queues = { "LoginQueue", "TransferQueue" };
        private static readonly string ExchangeName = "my_direct_exchange";

        static void Main(string[] args)
        {
            InitializeConnection();

            foreach (var queue in Queues)
            {
                Task.Run(() => ListenToQueue(queue));
            }

            // keep it hanging 
            Thread.Sleep(Timeout.Infinite);

            Cleanup();
        }

        private static void InitializeConnection()
        {
            var factory = new ConnectionFactory()
            {
                HostName = Environment.GetEnvironmentVariable("RABBITMQ_HOSTNAME") ?? "rabbitmq",
                Port = 5672,
                UserName = Environment.GetEnvironmentVariable("RABBITMQ_DEFAULT_USER") ?? "mirza",
                Password = Environment.GetEnvironmentVariable("RABBITMQ_DEFAULT_PASS") ?? "pass123",
                VirtualHost = Environment.GetEnvironmentVariable("RABBITMQ_VIRTUAL_HOST") ?? "/"
            };

            const int maxRetries = 10;
            int retryCount = 0;

            while (retryCount < maxRetries)
            {
                try
                {
                    _connection = factory.CreateConnection();
                    _channel = _connection.CreateModel();
                    Console.WriteLine("Connection established successfully!");
                    break;
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Failed to connect to RabbitMQ. Retry count: {retryCount + 1}. Error: {ex.Message}");
                    retryCount++;
                    Thread.Sleep(10000);
                }
            }

            if (_connection == null)
            {
                Console.WriteLine("Failed to establish a connection to RabbitMQ after multiple retries. Exiting application.");
                Environment.Exit(1);
            }

            _channel.ExchangeDeclare(exchange: ExchangeName, type: ExchangeType.Direct);

            foreach (var queue in Queues)
            {
                _channel.QueueDeclare(queue: queue, durable: false, exclusive: false, autoDelete: false, arguments: null);
                _channel.QueueBind(queue: queue, exchange: ExchangeName, routingKey: queue);
            }
        }

        private static void ListenToQueue(string queueName)
        {
            var consumer = new EventingBasicConsumer(_channel);
            consumer.Received += async (model, ea) =>
            {
                if (ea.RoutingKey == "LoginKey")
                {
                    var body = ea.Body.ToArray();
                    var message = Encoding.UTF8.GetString(body);
                    Console.WriteLine($" [x] {queueName} received {message}");
                }
                else if (ea.RoutingKey == "GradKey")
                {
                    await ProccessApiMessage(eventArgs: ea);
                }
            };

            _channel.BasicConsume(queue: queueName, autoAck: true, consumer: consumer);
        }

        private static async Task ProccessApiMessage(BasicDeliverEventArgs eventArgs)
        {
            using (var httpClient = new HttpClient())
            {
                byte[] body = eventArgs.Body.ToArray();
                string message = Encoding.UTF8.GetString(body);

                var options = new JsonSerializerOptions
                {
                    PropertyNameCaseInsensitive = true,
                };

                MQRabbitMessage mQRabbitMessage = JsonSerializer.Deserialize<MQRabbitMessage>(message);
                var content = new StringContent(mQRabbitMessage.Request, Encoding.UTF8, "application/json");
                string basicAuth = mQRabbitMessage.Auth;

                httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("text/plain"));
                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Basic", basicAuth);

                var response = await httpClient.PostAsync("http://bhfudbal-api:5001/Grad", content);

                if (response.IsSuccessStatusCode)
                {
                    Console.WriteLine("Request succeeded");
                }
                else
                {
                    Console.WriteLine("Request failed");
                }
            }

        }

        private static void Cleanup()
        {
            _channel?.Close();
            _connection?.Close();
        }

        private class MQRabbitMessage
        {
            public string Auth { get; set; }
            public string Request { get; set; }
        }
    }
}