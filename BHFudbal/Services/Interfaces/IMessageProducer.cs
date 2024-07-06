namespace BHFudbal.Services.Interfaces
{
    public interface IMessageProducer
    {
        public void SendingMessage(string message, string routingKey);
    }
}
