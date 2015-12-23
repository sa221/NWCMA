using System;
using System.Web.UI;
using NWCMADemoApp.BLL.Admin;
using NWCMADemoApp.Models.AdminModel;

namespace NWCMADemoApp.Pages.Admin
{
    public partial class Login : Page
    {
        readonly LoginBll _loginBll = new LoginBll();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void loginButton_Click(object sender, EventArgs e)
        {
            LoginModel loginModel = new LoginModel();
            loginModel.Code = codeTextBox.Text;
            loginModel.Password = passwoedTextBox.Text;

            if (!_loginBll.IsCodePasswordExist(loginModel))
            {
                failStatusLabel.InnerText = "Enter correct information";
            }
            else
            {
               
               Session["loginInformation"] = _loginBll.GetLoginTypeAndName(loginModel);
                Response.Redirect("~/Pages/Admin/AdminHome.aspx");
                
              
            }
        }
    }
}