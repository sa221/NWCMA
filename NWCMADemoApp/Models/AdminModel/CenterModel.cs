﻿namespace NWCMADemoApp.Models.AdminModel
{
    public class CenterModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Code { get; set; }
        
        public string Password { get; set; }

        //public int DistrictId { get; set; }
        public int ThanaId { get; set; }
        public int DistrictId { get; set; }
        public int LoginType { get; set; }
    }
}