using AirRowingBackend.Entities;

namespace AirRowingBackend.DTO.Login
{
    public class RegisterResponse
    {
        public int status { get; set; }
        public string? message { get; set; }
        public UserInfo? userinfos { get; set; }
    }
}
