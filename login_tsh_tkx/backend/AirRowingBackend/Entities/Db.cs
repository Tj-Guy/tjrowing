using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace AirRowingBackend.Entities
{
    public class RowingDb: DbContext
    {
        public RowingDb(DbContextOptions options) : base(options)
        {
        }

        public DbSet<UserInfo> UserInfos { get; set; } = null!;

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            UserInfo.ConfigureDbContext(modelBuilder);

        }
    }
}
