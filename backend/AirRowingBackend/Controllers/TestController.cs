using AirRowingBackend.Entities;
using Microsoft.AspNetCore.Mvc;

namespace AirRowingBackend.Controllers
{
    // 定义AirRowingBackend命名空间下的Controllers命名空间
    [ApiController]
    // 为此Controller定义路由为"log"
    [Route("test")]
    public class TestController
    {
        // 定义数据库的上下文，用于操作数据库
        private readonly RowingDb _db;
        // 使用依赖注入将数据库上下文注入到控制器中
        public TestController(RowingDb db)
        {
            _db = db;
        }
        // 定义一个HttpGet方法用于获取所有用户信息
        [HttpGet]
        public async Task<IActionResult> ConnectionSuccess()
        {
            // 模拟异步操作
            await Task.Delay(100); // 假设有一个异步操作，比如数据库查询或者其他耗时操作

            // 直接返回连接成功信息
            return new OkObjectResult("连接成功");
        }
    }
}
