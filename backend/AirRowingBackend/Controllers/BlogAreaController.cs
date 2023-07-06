using AirRowingBackend.DTO.BlogArea;
using AirRowingBackend.Entities;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;

namespace AirRowingBackend.Controllers
{
    [ApiController]
    [Route("blogarea")]
    public class BlogAreaController : ControllerBase
    {
        private readonly RowingDb _db;
        public BlogAreaController(RowingDb db)
        {
            _db = db;
        }

        // 发布动态/评论
        [HttpPost("postblog")]
        public  async Task<IActionResult> BlogPost([FromBody] PostBlog blog)
        {
            DateTime nowtime = DateTime.Now;
            try
            {
                // 创建一个新的数据实体对象
                var newblog = new MessagesInfo
                {
                    MessageId = blog.MessageId,
                    MessageType = blog.MessageType,
                    MessageContent = blog.MessageContent,
                    LikeNum = 0,
                    CollectionNum = 0,
                    MessageTime = nowtime,
                };
                var newpost = new MessagePost
                {
                    UserId = blog.UserId,
                    MessageId = blog.MessageId,
                    MessageType = blog.MessageType,
                    CommentTime= nowtime,
                };
                // 将新数据实体添加到数据库上下文
                _db.MessagesInfos.Add(newblog);
                _db.MessagePosts.Add(newpost);
                // 保存更改到数据库
                await _db.SaveChangesAsync();
                return new OkObjectResult(new { message="插入成功"});
            }
            catch (Exception ex)
            {
                return new OkObjectResult(new { message="插入失败"+ex.Message});
            }
        }

        // 获取所有动态
        [HttpGet("getallblog")]
        public IActionResult AllBlogGet()
        {
            try
            {
                var query = from post in _db.MessagePosts
                            join info in _db.MessagesInfos
                                on new { Id = (int?)post.MessageId, Type = (int?)post.MessageType }
                                equals new { Id = (int?)info.MessageId, Type = (int?)info.MessageType }
                            orderby info.MessageTime descending
                            select new { post.MessageId,post.MessageType,post.UserId, info.MessageContent };
                var result = query.ToList();  // 将查询结果转换为列表
                return new OkObjectResult(result);
            }
            catch (Exception ex)
            {
                return new OkObjectResult(new { message = "获取动态失败" + ex.Message });
            }
        }

    }
}
