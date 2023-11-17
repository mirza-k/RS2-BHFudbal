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
            ConnectionFactory _factory = new ConnectionFactory() { HostName = "rabbitmq", Port = 5672 };
            _factory.UserName = "guest";
            _factory.Password = "guest";
            IConnection _conn = _factory.CreateConnection();

            Guid guid = Guid.NewGuid();
            var channel = _conn.CreateModel();
            var queue = $"message-{guid}";
            channel.QueueDeclare(queue, durable: true, exclusive: true);
            var jsonString = JsonSerializer.Serialize(message);
            var body = Encoding.UTF8.GetBytes(jsonString);
            channel.BasicPublish("", "test", body: body);
        }
    }
}
