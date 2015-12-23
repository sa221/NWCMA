namespace NWCMADemoApp.Models.CenterModel
{
    public class PatientHistoryModel
    {
        public int PatientId { get; set; }
        public string Observation { get; set; }
        public string DateOfServices { get; set; }
        public int DoctorId { get; set; }
        public int CenterId { get; set; }
    }
}