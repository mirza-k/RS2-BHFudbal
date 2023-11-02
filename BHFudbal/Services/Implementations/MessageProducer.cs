using BHFudbal.Services.Interfaces;
using RabbitMQ.Client;
using System;
using System.Text;
using System.Text.Json;

namespace BHFudbal.Services.Implementations
{
    public class MessageProducer : IMessageProducer
    {
        public void SendingMessage<T>(T message)
        {
            var factory = new ConnectionFactory()
            {
                HostName = "localhost",
                UserName = "mirza",
                Password = "Test123!",
                VirtualHost = "/"
            };

            Guid guid = Guid.NewGuid();
            var connection = factory.CreateConnection();
            var channel = connection.CreateModel();
            var queue = $"message-{guid}";
            channel.QueueDeclare(queue, durable: true, exclusive: true);
            var jsonString = JsonSerializer.Serialize(message);
            var body = Encoding.UTF8.GetBytes(jsonString);
            channel.BasicPublish("", "test", body: body);
        }
    }
}
