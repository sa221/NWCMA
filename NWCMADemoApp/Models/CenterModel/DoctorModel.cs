﻿namespace NWCMADemoApp.Models.CenterModel
{
    public class DoctorModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Degree { get; set; }

        public string Specialization { get; set; }
        public int CenterId { get; set; }
    }
}