using NWCMADemoApp.DAL.Admin;
using NWCMADemoApp.Models.AdminModel;

namespace NWCMADemoApp.BLL.Admin
{
    public class LoginBll
    {
        readonly LoginDal _loginDal = new LoginDal();

        public bool IsCodePasswordExist(LoginModel loginModel)
        {
            return _loginDal.IsCodePasswordExist(loginModel);
        }

        public LoginModel GetLoginTypeAndName(LoginModel loginModel)
        {
            return _loginDal.GetLoginTypeAndName(loginModel);
        }
    }
}