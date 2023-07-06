using AirRowingBackend.DTO.Login;
using AirRowingBackend.Entities;
using AirRowingBackend.Helpers;
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
        public async Task<IActionResult> UserLogin([FromForm] LoginRequest request)
        {
            var result = await _db.UserInfos.Where(u => (1 == 1
                && u.UserId == request.id
                && u.UserPassword == Md5Helper.CalculateMd5Hash(request.password)
                )).ToListAsync();

            if(result.Count == 0)
            {
                return new OkObjectResult(new LoginResponse { status=0, message="用户名或密码错误"});
            }

            return new OkObjectResult(new LoginResponse { status = 1, message = "登录成功", userinfos = result.First() });
        }


        [HttpPut]
        public async Task<IActionResult> UserRegister([FromForm] RegisterRequest request)
        {
            //检查是否有重名用户
            var check= await _db.UserInfos.Where(u => (1 == 1
                && u.UserId == request.id
                )).ToListAsync();
            if (check.Count > 0)
                return new OkObjectResult(new RegisterResponse { status = 0, message = "用户名重复，注册失败" });

            await _db.UserInfos.AddAsync(new UserInfo
            {
                UserEmail = request.email,
                UserId = request.id,
                UserPassword = Md5Helper.CalculateMd5Hash(request.password)
            });
            await _db.SaveChangesAsync();
            var new_user = await _db.UserInfos.FindAsync(request.id);

            return new OkObjectResult(new RegisterResponse { status = 1, message = "注册成功", userinfos=new_user});
        }
    }
}
