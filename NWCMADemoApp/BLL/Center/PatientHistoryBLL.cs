using System.Collections.Generic;
using NWCMADemoApp.DAL.Center;
using NWCMADemoApp.Models.CenterModel;

namespace NWCMADemoApp.BLL.Center
{
    public class PatientHistoryBll
    {
        readonly PatientHistoryDal _patientHistoryDal = new PatientHistoryDal();

        public List<PatientInformationModel> GetAllHistory(int voterId)
        {
            return _patientHistoryDal.GetAllHistory(voterId);
        }

        public int PatientHistoryEntry(PatientHistoryModel patientHistory)
        {
            return _patientHistoryDal.PatientHistoryEntry(patientHistory);
        }
    }
}