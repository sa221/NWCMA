using System.Collections.Generic;
using NWCMADemoApp.DAL.Center;
using NWCMADemoApp.Models.CenterModel;

namespace NWCMADemoApp.BLL.Center
{
    public class DoseBll
    {
        readonly DoseDal _doseDal = new DoseDal();


        public List<DoseModel> GetAllDose()
        {
            return _doseDal.GetAllDose();
        }
    }
}