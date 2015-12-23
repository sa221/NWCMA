using NWCMADemoApp.DAL.Center;
using NWCMADemoApp.Models.CenterModel;

namespace NWCMADemoApp.BLL.Center
{
    public class PatientBll
    {
        private readonly PatientDal _patientDal = new PatientDal();

        public int NumberOfService(int voterId)
        {
            return _patientDal.NumberOfService(voterId);
        }

        public int PatientEntry(PatientModel patient)
        {
            if (_patientDal.IsExistPatient(patient.VoterId))
            {
                return _patientDal.GetPationtId(patient.VoterId);
            }
            return _patientDal.PatientEntry(patient);
        }

        public PatientModel GetPationtInfo(int patientId)
        {
            if (_patientDal.IsExistPatient(patientId))
            {
                return _patientDal.GetPationtInfo(patientId);
            }
            return new PatientModel();
        }
    }
}