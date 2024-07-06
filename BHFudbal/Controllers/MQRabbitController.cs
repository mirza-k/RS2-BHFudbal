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
