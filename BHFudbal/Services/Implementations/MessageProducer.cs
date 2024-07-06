using BHFudbal.Services.Interfaces;
using RabbitMQ.Client;
using System;
using System.Text;
using System.Text.Json;

namespace BHFudbal.Services.Implementations
{
    public class MessageProducer : IMessageProducer
    {
        public void SendingMessage(string message, string routingKey)
        {
            try
            {
                ConnectionFactory factory = new ConnectionFactory()
                {
                    HostName = Environment.GetEnvironmentVariable("RABBITMQ_HOSTNAME") ?? "rabbitmq",
                    Port = 5672,
                    UserName = Environment.GetEnvironmentVariable("RABBITMQ_DEFAULT_USER") ?? "mirza",
                    Password = Environment.GetEnvironmentVariable("RABBITMQ_DEFAULT_PASS") ?? "pass123",
                    VirtualHost = Environment.GetEnvironmentVariable("RABBITMQ_VIRTUAL_HOST") ?? "/"
                };

                using var connection = factory.CreateConnection();
                using var channel = connection.CreateModel();

                // Declare a direct exchange
                channel.ExchangeDeclare(exchange: "my_direct_exchange", type: ExchangeType.Direct);

                // Declare queues
                channel.QueueDeclare(queue: "LoginQueue", durable: false, exclusive: false, autoDelete: false, arguments: null);
                channel.QueueDeclare(queue: "TransferQueue", durable: false, exclusive: false, autoDelete: false, arguments: null);
                channel.QueueDeclare(queue: "OcjeneQueue", durable: false, exclusive: false, autoDelete: false, arguments: null);

                // Bind queues to the exchange with specific routing keys
                channel.QueueBind(queue: "LoginQueue", exchange: "my_direct_exchange", routingKey: "LoginKey");
                channel.QueueBind(queue: "TransferQueue", exchange: "my_direct_exchange", routingKey: "GradKey");
                channel.QueueBind(queue: "OcjeneQueue", exchange: "my_direct_exchange", routingKey: "OcjeneKey");

                //var jsonString = JsonSerializer.Serialize(message);
                var body = Encoding.UTF8.GetBytes(message);

                // Publish the message to the direct exchange with the routing key
                channel.BasicPublish(exchange: "my_direct_exchange", routingKey: routingKey, basicProperties: null, body: body);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error in SendingMessage: {ex.Message}");
            }
        }
    }
}