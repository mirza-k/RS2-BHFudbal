using Flurl.Http;
using System.Threading.Tasks;
using BHFudbal.Model;
using BHFudbal.Model.Requests;

namespace BHFudbal.WinUI
{
    public class APIService
    {
        private string _route { get; set; }
        public static string Username { get; set; }
        public static string Password { get; set; }


        public APIService(string route)
        {
            _route = route;
        }

        public async Task<T> Get<T>(object search = null)
        {
            var url = $"{Properties.Settings.Default.APIUrl}/{_route}";
            if (search != null)
            {
                url += "?";
                url += await search.ToQueryString();
            }
            var result = await url.WithBasicAuth(Username, Password).GetJsonAsync<T>();
            return result;
        }

        public async Task<T> Post<T>(object request)
        {
            var url = $"{Properties.Settings.Default.APIUrl}/{_route}";

            var result = await url.WithBasicAuth(Username, Password).PostJsonAsync(request).ReceiveJson<T>();

            return result;
        }

        public async Task<bool> Login(KorisnikInsertRequest request)
        {
            var url = $"{Properties.Settings.Default.APIUrl}/{_route}";
            var result = await url.WithBasicAuth(Username, Password).PostJsonAsync(request).ReceiveJson<bool>();

            return result;
        }

        public async Task<T> GetById<T>(int id)
        {
            var url = $"{Properties.Settings.Default.APIUrl}/{_route}";
            if (id != 0)
            {
                url += $"/{id}";
            }

            var result = await url.WithBasicAuth(Username, Password).GetJsonAsync<T>();
            return result;
        }

        public async Task<T> Update<T>(int id, object request)
        {
            var url = $"{Properties.Settings.Default.APIUrl}/{_route}/{id}";
            var result = await url.WithBasicAuth(Username, Password).PutJsonAsync(request).ReceiveJson<T>();

            return result;
        }
    }
}

