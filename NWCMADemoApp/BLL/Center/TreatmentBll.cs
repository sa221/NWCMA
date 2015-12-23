using System.Collections.Generic;
using NWCMADemoApp.DAL.Center;
using NWCMADemoApp.Models.CenterModel;

namespace NWCMADemoApp.BLL.Center
{
    public class TreatmentBll
    {
        readonly TreatmentDal _treatmentDal = new TreatmentDal();
        public bool TreatementEntry(List<TreatmentModel> treatments, int centerId)
        {
            return _treatmentDal.TreatementEntry(treatments) && _treatmentDal.UpdateQuantity(treatments,centerId);
        }

        public int GetQuantity(int medicineId, int centerId)
        {
            return _treatmentDal.GetQuantity(medicineId, centerId);
        }

    }
}