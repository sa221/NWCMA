<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/MasterPages/MasterPageAdmin.Master" AutoEventWireup="true" CodeBehind="CreateCenter.aspx.cs" Inherits="NWCMADemoApp.Pages.Admin.CreateCenter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <%-- <script type="text/javascript" language="javascript">
        function ValidateForm() {
            var ret = true;
            if (document.getElementById("ContentPlaceHolder1_centerNameTextBox").value == "") {
                document.getElementById("ContentPlaceHolder1_centerNameLevel").innerText = "Center Name is required";
                ret = false;
            } else {
                document.getElementById("ContentPlaceHolder1_centerNameLevel").innerText = "";
            }
            //if (document.getElementById("ContentPlaceHolder1_districtDropDownList").value == "") {
            //    document.getElementById("ContentPlaceHolder1_districtDropDownLabel").innerText = "Select a District";
            //    ret = false;
            //} else {
            //    document.getElementById("ContentPlaceHolder1_districtDropDownLabel").innerText = "";
            //}
            //if (document.getElementById("ContentPlaceHolder1_thaneDropDownList").value == "") {
            //    document.getElementById("ContentPlaceHolder1_thaneDropDownLabel").innerText = "Select a Thana";
            //    ret = false;
            //} else {
            //    document.getElementById("ContentPlaceHolder1_thaneDropDownLabel").innerText = "";
            //}
            return ret;
        }
    </script>--%>

    <%-- <form id="form1" runat="server">--%>
    <div class="content" style="min-height: 540px;">
        <div class="col-xs-6 col-sm-3 col-md-7 placeholder">
            <div class="row placeholders">
                <table class="table table-responsive">
                    <tr>
                        <td colspan="2">
                            <h1>Create new Center</h1>
                        </td>

                    </tr>
                    <tr>
                        <td><b>Name of Center</b></td>
                        <td>
                            <asp:TextBox ID="centerNameTextBox" CssClass="form-control" Width="350px" runat="server"></asp:TextBox></td>

                         <td>

                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="centerNameTextBox" runat="server" ForeColor="red" ErrorMessage="Center name is required"></asp:RequiredFieldValidator>

                        </td>
                       <%-- <td>

                            <asp:Label ID="centerNameLabel" runat="server" ForeColor="red"></asp:Label>

                        </td>--%>

                    </tr>
                    <tr>
                        <td><b>District</b></td>
                        <td>
                            <asp:DropDownList ID="districtDropDownList" CssClass="form-control" Width="100%" Height="30px" runat="server" AutoPostBack="True" OnSelectedIndexChanged="districtDropDownList_SelectedIndexChanged"></asp:DropDownList>
                        </td>
                         <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" InitialValue="-1" ForeColor="red" ControlToValidate="districtDropDownList" runat="server" ErrorMessage="select a district"></asp:RequiredFieldValidator>
                        </td>
                       <%-- <td>

                            <asp:Label ID="districtDropDownLabel" runat="server" ForeColor="red"></asp:Label>

                        </td>--%>
                    </tr>
                    <tr>
                        <td><b>Thana</b></td>
                        <td>
                            <asp:DropDownList ID="thaneDropDownList" Width="100%" Height="30px" CssClass="form-control" runat="server"></asp:DropDownList>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" InitialValue="-1" ForeColor="red" ControlToValidate="thaneDropDownList" runat="server" ErrorMessage="Select a thana"></asp:RequiredFieldValidator>
                        </td>
                       <%-- <td>

                            <asp:Label ID="thaneDropDownLabel" runat="server" ForeColor="red"></asp:Label>

                        </td>--%>
                    </tr>

                    <tr>
                        <td></td>
                        <td>
                            <asp:Button CssClass="btn btn-default right" ID="saveButton" runat="server" Text="Save" OnClick="saveButton_Click"  /></td>
                    </tr>
                    <tr>

                        <td colspan="2">
                            <span class="label label-success" style="float: left; font-size: 20px; position: relative" id="successStatusLabel" runat="server"></span>
                            <span class="label label-warning" style="float: left; font-size: 20px; position: relative" id="failStatusLabel" runat="server"></span>
                        </td>


                    </tr>
                </table>
            </div>
        </div>

    </div>

    <%--  </form>--%>
</asp:Content>
