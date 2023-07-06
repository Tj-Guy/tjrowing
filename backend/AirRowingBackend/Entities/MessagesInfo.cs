using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace AirRowingBackend.Entities
{
    [Table("messages_info")]
    public class MessagesInfo
    {
        [Required]
        [Key]
        [Column("message_id")]
        public int MessageId { get; set; }

        [Required]
        [Key]
        [Column("message_type")]
        public int MessageType { get; set; }

        [Required]
        [Column("message_content")]
        public string MessageContent { get; set; } = "";

        [Required]
        [Column("like_num")]
        public int LikeNum { get; set; }

        [Required]
        [Column("collection_num")]
        public int CollectionNum { get; set; }

        [Required]
        [Column("message_time")]
        public DateTime MessageTime { get; set; }

        public static void ConfigureDbContext(ModelBuilder modelBuilder)
        {
        }

    }
}



