namespace AirRowingBackend.DTO.Login
{
    public class RegisterRequest
    {
        public int id { get; set; }
        public string? email { get; set; }
        public string password { get; set; } = "";
    }
}
