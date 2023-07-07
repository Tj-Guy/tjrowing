using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace AirRowingBackend.Entities
{
    [Table("users_info")]
    public class UserInfo
    {
        [Required]
        [Key]
        [Column("user_id")]
        public int UserId { get; set; }

        [Column("user_email")]
        public string? UserEmail { get; set; }

        [Required]
        [Column("user_password")]
        public string UserPassword { get; set; } = "";

        public static void ConfigureDbContext(ModelBuilder modelBuilder)
        {
        }

    }
}
