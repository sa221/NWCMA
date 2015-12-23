<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/MasterPages/MasterPageAdmin.Master" AutoEventWireup="true" CodeBehind="DoctorEntry.aspx.cs" Inherits="NWCMADemoApp.Pages.Center.DoctorEntry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <script type="text/javascript" language="javascript">
        function ValidateForm() {
            var ret = true;
            if (document.getElementById("ContentPlaceHolder1_doctorNameTextBox").value == "") {
                document.getElementById("ContentPlaceHolder1_doctorNameLabel").innerText = "Name is required";
                ret = false;
            } else {
                document.getElementById("ContentPlaceHolder1_doctorNameLabel").innerText = "";
            }
            if (document.getElementById("ContentPlaceHolder1_degreeTextBox").value == "") {
                document.getElementById("ContentPlaceHolder1_degreeLabel").innerText = "Degree is required";
                ret = false;
            } else {
                document.getElementById("ContentPlaceHolder1_degreeLabel").innerText = "";
            }
            if (document.getElementById("ContentPlaceHolder1_specializationTextBox").value == "") {
                document.getElementById("ContentPlaceHolder1_specializationLabel").innerText = "Specialization is required";
                ret = false;
            } else {
                document.getElementById("ContentPlaceHolder1_specializationLabel").innerText = "";
            }
            return ret;
        }
    </script>

    <div class="content">
        <%--<form id="form1" runat="server">--%>
        <div class="col-xs-6 col-sm-3 col-md-7 placeholder">
            <table class="table table-responsive">
                <tr>
                    <th>Doctor Entry</th>
                </tr>
                <tr>
                    <td>Name : </td>
                    <td>
                        <asp:TextBox ID="doctorNameTextBox" runat="server" CssClass="form-control"></asp:TextBox></td>
                    <td>
                
                <asp:Label ID="doctorNameLabel" runat="server" ForeColor="red"></asp:Label>
                
            </td>
                    <%--<td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="doctorNameTextBox" runat="server" ErrorMessage="Name is required" ForeColor="red"></asp:RequiredFieldValidator></td>
                --%></tr>
                <tr>
                    <td>Degree : </td>
                    <td>
                        <asp:TextBox ID="degreeTextBox" runat="server" CssClass="form-control"></asp:TextBox></td>
                    <td>
                
                <asp:Label ID="degreeLabel" runat="server" ForeColor="red"></asp:Label>
                
            </td>
                  <%--  <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="degreeTextBox" runat="server" ErrorMessage="Degree is required" ForeColor="red"></asp:RequiredFieldValidator></td>
                --%></tr>

                <tr>
                    <td>Specialization : </td>
                    <td>
                        <asp:TextBox ID="specializationTextBox" runat="server" CssClass="form-control"></asp:TextBox></td>
                    <td>
                
                <asp:Label ID="specializationLabel" runat="server" ForeColor="red"></asp:Label>
                
            </td>
                    <%--<td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="specializationTextBox" runat="server" ErrorMessage="Specialization is required" ForeColor="red"></asp:RequiredFieldValidator></td>
                --%></tr>

                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="saveDoctorButton" runat="server" Text="Save" CssClass="btn btn-default right" OnClick="saveDoctorButton_Click" OnClientClick="return ValidateForm()"/></td>
                </tr>

                <tr>

                    <td colspan="2">
                        <span class="label label-warning" style="float: left; font-size: 20px; position: relative" id="failStatusLabel" runat="server"></span>
                        <span class="label label-success" style="float: left; font-size: 20px; position: relative" id="successStatusLabel" runat="server"></span>
                    </td>
                </tr>
            </table>
        </div>


        <%-- </form> --%>
    </div>

</asp:Content>
