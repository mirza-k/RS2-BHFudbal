using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using System;
using System.Text;
using System.Threading;

namespace BHFudbal.Subscriber
{
    internal class Program
    {
        static void Main(string[] args)
        {
            ConnectionFactory _factory = new ConnectionFactory() { HostName = "rabbitmq", Port = 5672 };
            _factory.UserName = "guest";
            _factory.Password = "guest";

            IConnection _conn = null;
            IModel channel = null;

            // Add retry logic to wait for RabbitMQ to become available
            const int maxRetries = 10;
            int retryCount = 0;

            while (retryCount < maxRetries)
            {
                try
                {
                    _conn = _factory.CreateConnection();
                    channel = _conn.CreateModel();
                    Console.WriteLine("Connection established sucessfully!");
                    break; // Break out of the loop if connection is successful
                }
                catch (Exception ex)
                {
                    // Log or print the exception if needed
                    Console.WriteLine($"Failed to connect to RabbitMQ. Retry count: {retryCount + 1}. Error: {ex.Message}");

                    retryCount++;
                    Thread.Sleep(10000); // Wait for 5 seconds before retrying
                }
            }

            if (channel != null)
            {
                string queueName = "login";
                channel.QueueDeclare(queueName, durable: true, exclusive: true);

                var consumer = new EventingBasicConsumer(channel);
                consumer.Received += (model, eventArgs) =>
                {
                    if (eventArgs.RoutingKey == queueName)
                    {

                        var body = eventArgs.Body.ToArray();
                        var message = Encoding.UTF8.GetString(body);
                        Console.WriteLine($"A message has been received -> {message}");
                    }
                };
                channel.BasicConsume(queueName, true, consumer);
            }
            else
            {
                Console.WriteLine("Failed to establish a connection to RabbitMQ after multiple retries. Exiting application.");
            }

            Thread.Sleep(Timeout.Infinite);
        }
    }
}
