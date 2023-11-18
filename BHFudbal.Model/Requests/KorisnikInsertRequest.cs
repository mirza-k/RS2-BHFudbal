namespace BHFudbal.Model.Requests
{
    public class KorisnikInsertRequest
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public bool AdminPage { get; set; }
        public bool AuthHandler { get; set; }
    }
}
