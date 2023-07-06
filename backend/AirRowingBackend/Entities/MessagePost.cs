using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace AirRowingBackend.Entities
{
    [Table("message_post")]
    public class MessagePost
    {
        [Required]
        [Key]
        [Column("user_id")]
        public int UserId { get; set; }

        [Required]
        [Key]
        [Column("message_id")]
        public int MessageId { get; set; }

        [Required]
        [Key]
        [Column("message_type")]
        public int MessageType { get; set; }

        [Required]
        [Column("comment_time")]
        public DateTime CommentTime { get; set; }

        public static void ConfigureDbContext(ModelBuilder modelBuilder)
        {
        }

    }
}
