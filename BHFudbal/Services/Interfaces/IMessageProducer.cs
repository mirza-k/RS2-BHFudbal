namespace BHFudbal.Services.Interfaces
{
    public interface IMessageProducer
    {
        public void SendingMessage<T>(T message, string routingKey, string exchangeKey);
    }
}
