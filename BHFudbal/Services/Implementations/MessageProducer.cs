using BHFudbal.Services.Interfaces;
using RabbitMQ.Client;
using System;
using System.Text;
using System.Text.Json;

namespace BHFudbal.Services.Implementations
{
    public class MessageProducer : IMessageProducer
    {
        public void SendingMessage<T>(T message, string routingKey, string exchadminangeKey)
        {
            ConnectionFactory _factory = new ConnectionFactory() { HostName = Environment.GetEnvironmentVariable("RABBITMQ_HOSTNAME") ?? "rabbitmq", Port = 5672 };
            _factory.UserName = Environment.GetEnvironmentVariable("RABBITMQ_DEFAULT_USER") ?? "mirza";
            _factory.Password = Environment.GetEnvironmentVariable("RABBITMQ_DEFAULT_PASS") ?? "pass123";
            _factory.VirtualHost = Environment.GetEnvironmentVariable("RABBITMQ_VIRTUAL_HOST") ?? "/";
            IConnection _conn = _factory.CreateConnection();

            Guid guid = Guid.NewGuid();
            var channel = _conn.CreateModel();
            var queue = $"message-{guid}";
            channel.QueueDeclare(queue, durable: true, exclusive: true);
            var jsonString = JsonSerializer.Serialize(message);
            var body = Encoding.UTF8.GetBytes(jsonString);
            channel.BasicPublish(exchadminangeKey, routingKey, body: body);
        }
    }
}
