using AirRowingBackend.Entities;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace AirRowingBackend.Controllers
{
    [ApiController]
    [Route("log")]
    public class LoginController : ControllerBase
    {
        private readonly RowingDb _db;

        public LoginController(RowingDb db)
        {
            _db = db;
        }

        [HttpGet]
        public async Task<IActionResult> GetUserInfo()
        {
            return new JsonResult(await _db.UserInfos.ToListAsync());
        }

        [HttpPost]
        public async Task<IActionResult> UserLogin([FromForm] User_Id_Password IdPassword)
        {
            var result = await _db.UserInfos.Where(u => {
                return 1 == 1 &&
                u.UserId == IdPassword.id &&
                u.UserPassword == IdPassword.password;
                }).FirstAsync();
        }


    }
}
