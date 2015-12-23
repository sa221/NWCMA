using System.Collections.Generic;
using NWCMADemoApp.DAL.Admin;
using NWCMADemoApp.Models.AdminModel;

namespace NWCMADemoApp.BLL.Admin
{
    public class DiseaseWiseReportBll
    {
        readonly DiseaseWiseReportDal _diseaseWiseReportDal = new DiseaseWiseReportDal();

        public List<DiseaseReportModel> GetAllDiseaseWiseReport(DiseaseReportCarryData diseaseReport)
        {
            return _diseaseWiseReportDal.GetAllDiseaseWiseReport(diseaseReport);
        }

    }
}