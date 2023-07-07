namespace AirRowingBackend.DTO.BlogArea
{
    public class PostBlog
    {
        public int UserId { get; set; }
        public int MessageId { get; set; }
        public int MessageType { get; set; }
        public string MessageContent { get; set; } = "";
    }
}
