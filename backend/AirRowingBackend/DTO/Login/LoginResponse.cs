using AirRowingBackend.Entities;

namespace AirRowingBackend.DTO.Login
{
    public class LoginResponse
    {
        public int status { get; set; }
        public string? message { get; set; }
        public UserInfo? userinfos { get; set; }
        public string? token { get; set; }

    }
}
