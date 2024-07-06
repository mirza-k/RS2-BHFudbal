using BHFudbal.Model.Requests;
using BHFudbal.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Text.Json;

namespace BHFudbal.Controllers
{
    [ApiController]
    [Authorize]
    [Route("[controller]")]
    public class MQRabbitController : ControllerBase
    {
        private readonly IMessageProducer messageProducer;
        public MQRabbitController(IMessageProducer messageProducer)
        {
            this.messageProducer = messageProducer;
        }

        // This controller simulates behavior of some sort of API getaway. MQRabbit Api will process request and send it to RabbitMQ message queue,
        // then message will be processed in Subscriber(console app) and new api request will be sent in order to complete full action.
        [HttpPost("add-new-message")]
        public IActionResult AddNewMessage([FromBody] GradInsertRequest gradInsertRequest)
        {
            string basicAuth = HttpContext.Request.Headers["Authorization"];
            basicAuth = basicAuth.Substring("Basic ".Length);

            var message = new MQRabbitMessage()
            {
                Auth = basicAuth,
                Request = JsonSerializer.Serialize(gradInsertRequest)
            };

            string jsonMessage = JsonSerializer.Serialize(message);

            messageProducer.SendingMessage(jsonMessage, "GradKey");

            return Ok();
        }
    }
}
