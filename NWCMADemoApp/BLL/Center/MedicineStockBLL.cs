using System.Collections.Generic;
using NWCMADemoApp.DAL.Center;
using NWCMADemoApp.Models.CenterModel;

namespace NWCMADemoApp.BLL.Center
{
    public class MedicineStockBll
    {
        readonly MedicineStockDal _medicineStockDal= new MedicineStockDal();

        public List<MedicineStockModel> GetAllStockReportByCenter(int centerId)
        {
            return _medicineStockDal.GetAllStockInformation(centerId);
        }

    }
}