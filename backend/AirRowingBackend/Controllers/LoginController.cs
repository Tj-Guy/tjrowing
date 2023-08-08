using AirRowingBackend.DTO.Login;
using AirRowingBackend.Entities;
using AirRowingBackend.Helpers;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;
using System.Text;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;




// 定义AirRowingBackend命名空间下的Controllers命名空间
namespace AirRowingBackend.Controllers
{
    // 定义AirRowingBackend命名空间下的Controllers命名空间
    [ApiController]
    // 为此Controller定义路由为"log"
    [Route("api/login")]
    public class LoginController : ControllerBase
    {
        // 定义数据库的上下文，用于操作数据库
        private readonly RowingDb _db;
        // 使用依赖注入将数据库上下文注入到控制器中
        public LoginController(RowingDb db)
        {
            _db = db;
        }
        // 定义一个HttpGet方法用于获取所有用户信息
        [HttpGet]
        public async Task<IActionResult> GetUserInfo()
        {
            // 从数据库中获取所有用户信息，并将其转换为Json格式返回
            return new JsonResult(await _db.UserInfos.ToListAsync());
        }
        // 定义一个HttpPost方法用于用户登录
        [HttpPost("UserLogin")]
        public async Task<IActionResult> UserLogin([FromQuery] LoginRequest request)
        {
            // 在数据库中查找用户名和密码都匹配的用户
            var result = await _db.UserInfos.Where(u => u.UserId == request.id &&
                u.UserPassword == Md5Helper.CalculateMd5Hash(request.password)).ToListAsync();

            // 如果没有找到匹配的用户，返回错误信息
            if (result.Count == 0)
            {
                return new OkObjectResult(new LoginResponse { status = 0, message = "用户名或密码错误" });
            }
            // 如果找到了匹配的用户，返回成功信息和用户信息
            var user = result.First();
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes("YourSecretKeyHerePleaseMakeSureItIsAtLeast32CharactersLong"); // Please make sure to use a secure and unique secret
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
            new Claim(ClaimTypes.Name, user.UserId.ToString()),
                    // You can add more claims here, like roles or anything else that could be useful in your application
                }),
                Expires = DateTime.UtcNow.AddDays(7), // The token will expire in 7 days, adjust to your needs
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            var tokenString = tokenHandler.WriteToken(token);

            return new OkObjectResult(new LoginResponse { status = 1, message = "登录成功", token = tokenString, userinfos = user });
        }



        // 定义一个HttpPut方法用于用户注册
        [HttpPut("UserRegister")]
        public async Task<IActionResult> UserRegister([FromQuery] RegisterRequest request)
        {
            //检查是否有重名用户
            var check= await _db.UserInfos.Where(u => (1 == 1
                && u.UserId == request.id
                )).ToListAsync();
            // 定义一个HttpPut方法用于用户注册
            if (check.Count > 0)
                return new OkObjectResult(new RegisterResponse { status = 0, message = "用户名重复，注册失败" });
            // 如果不存在同名的用户，将新用户信息添加到数据库
            await _db.UserInfos.AddAsync(new UserInfo
            {
                UserEmail = request.email,
                UserId = request.id,
                UserPassword = Md5Helper.CalculateMd5Hash(request.password)
            });
            // 保存更改到数据库
            await _db.SaveChangesAsync();
            // 从数据库中获取新添加的用户
            var new_user = await _db.UserInfos.FindAsync(request.id);
            // 返回成功信息和新用户信息
            return new OkObjectResult(new RegisterResponse { status = 1, message = "注册成功", userinfos=new_user});
        }
    }
}
