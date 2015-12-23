using System;

namespace NWCMADemoApp.Models.AdminModel
{
    [Serializable]
    public class LoginModel
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public string Password { get; set; }
        public int LoginType { get; set; }
        public string LoginName { get; set; }

    }
}