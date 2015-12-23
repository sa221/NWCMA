<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/MasterPages/MasterPageAdmin.Master" AutoEventWireup="true" CodeBehind="TreatmentHistory.aspx.cs" Inherits="NWCMADemoApp.Pages.Center.TreatmentHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript" language="javascript">
        function ValidateForm() {
            var ret = true;
            if (document.getElementById("ContentPlaceHolder1_voterIdTextBox").value == "") {
                document.getElementById("ContentPlaceHolder1_idLabel").innerText = "ID is required";
                ret = false;
            } else {
                document.getElementById("ContentPlaceHolder1_idLabel").innerText = "";
            }

            return ret;
        }
    </script>

    <%--<form id="form1" runat="server">--%>
    <div class="container" runat="server">
        <br />
        <h2 class="page-header">Treatment
        </h2>
        <div class="col-xs-12 col-sm-12 col-md-12 placeholder">
            <div class="row placeholders">
                <table class="table table-responsive">
                    <tr>
                        <td><b>Voter Id</b></td>
                        <td>
                            <asp:TextBox ID="voterIdTextBox" Width="200px" CssClass="form-control" runat="server"></asp:TextBox>
                        </td>
                        <td>

                            <asp:Label ID="idLabel" runat="server" ForeColor="red"></asp:Label>

                        </td>
                        <td>
                            <asp:Button ID="showDetailsButton" CssClass="btn btn-primary left" runat="server" Text="Show Details" OnClick="showDetailsButton_Click" OnClientClick="return ValidateForm()" /></td>
                    </tr>
                    <tr>
                        <td><b>Name</b></td>
                        <td>
                            <asp:TextBox ID="patientNameTextBox" Width="200px" CssClass="form-control" runat="server"></asp:TextBox>
                        </td>
                        <%-- <td>

                            <asp:Label ID="patientNameLabel" runat="server" ForeColor="red"></asp:Label>

                        </td>--%>
                    </tr>
                    <tr>
                        <td><b>Address</b></td>
                        <td>
                            <asp:TextBox ID="addressTextBox" Width="200px" CssClass="form-control" TextMode="MultiLine" runat="server"></asp:TextBox>
                        </td>
                        <%-- <td>

                            <asp:Label ID="addressLabel" runat="server" ForeColor="red"></asp:Label>

                        </td>--%>
                    </tr>

                </table>
                <div class="historyDiv" runat="server">
                    <asp:GridView ID="treatmentHistoryGrid" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="895px">
                        <AlternatingRowStyle BackColor="#DCDCDC" />
                        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#0000A9" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#000065" />
                    </asp:GridView>

                </div>
                <div>
                    <br\ />
                    <asp:Button ID="generatePDFButton" CssClass="btn btn-default" runat="server" Text="Generate PDF" OnClick="generatePDFButton_Click" />
                </div>

            </div>

        </div>


    </div>

    <%-- </form>   --%>
</asp:Content>
