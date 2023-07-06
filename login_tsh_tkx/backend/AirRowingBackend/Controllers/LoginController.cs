using AirRowingBackend.DTO.Login;
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
            var user = await _db.UserInfos.FirstOrDefaultAsync(u => u.UserId == IdPassword.UserId && u.UserPassword == IdPassword.UserPassword);
            if (user == null)
            {
                return NotFound(new { message = "无效的用户标识或密码" });
            }
            else
            {
                return Ok(new { message = "登录成功" });
            }
        }


        [HttpPut]
        public async Task<IActionResult> Register([FromForm] UserInfo userInfo)
        {
            _db.UserInfos.Add(userInfo);
            await _db.SaveChangesAsync();
            return Ok();
        }

    }
}
