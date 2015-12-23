<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/MasterPages/MasterPageAdmin.Master" AutoEventWireup="true" CodeBehind="Treatment.aspx.cs" Inherits="NWCMADemoApp.Pages.Center.Treatment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    

    <script>
        $(function () {
            $("#ContentPlaceHolder1_Calendar1").datepicker();

        });
    </script>
    
    <script type="text/javascript">
        function ValidateForm() {
            var ret = true;
            if (document.getElementById("ContentPlaceHolder1_voterIdTextBox").value == "") {
                document.getElementById("ContentPlaceHolder1_voterIdLabel").innerText = "Patient ID is required";
                ret = false;
            } else {
                document.getElementById("ContentPlaceHolder1_voterIdLabel").innerText = "";
            }
            if (document.getElementById("ContentPlaceHolder1_patientNameTextBox").value == "") {
                document.getElementById("ContentPlaceHolder1_patientNameLabell").innerText = "Name is required";
                ret = false;
            } else {
                document.getElementById("ContentPlaceHolder1_patientNameLabel").innerText = "";
            }
            if (document.getElementById("ContentPlaceHolder1_addressTextBox").value == "") {
                document.getElementById("ContentPlaceHolder1_addressLabel").innerText = "Address is required";
                ret = false;
            } else {
                document.getElementById("ContentPlaceHolder1_addressLabel").innerText = "";
            }
            if (document.getElementById("ContentPlaceHolder1_ageTextBox").value == "") {
                document.getElementById("ContentPlaceHolder1_ageLabel").innerText = "Age is required";
                ret = false;
            } else {
                document.getElementById("ContentPlaceHolder1_ageLabel").innerText = "";
            }
            return ret;
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%-- <form id="form1" runat="server">--%>
    <div class="container">

        <br />
        <h2 class="page-header">Treatment
        </h2>
        <div class="col-xs-12 col-sm-12 col-md-12 placeholder">
            <div class="row placeholders">
                <table class="table table-responsive">
                    <tr>
                        <td><b>Patient Id</b></td>
                        <td>
                            <asp:TextBox ID="voterIdTextBox" CssClass="form-control" runat="server" OnTextChanged="voterIdTextBox_TextChanged"></asp:TextBox>
                            <asp:CompareValidator runat="server" Operator="DataTypeCheck" Type="Integer"
                                ControlToValidate="voterIdTextBox" ErrorMessage="Patient ID must be integer number" ForeColor="red" />
                        </td>
                        <td>
                            <asp:Label ID="voterIdLevel" runat="server" ForeColor="red"></asp:Label>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td><b>Name</b></td>
                        <td>
                            <asp:TextBox ID="patientNameTextBox" CssClass="form-control" runat="server" ></asp:TextBox>
                            <asp:CompareValidator runat="server" Operator="DataTypeCheck" Type="String"
                                ControlToValidate="patientNameTextBox" ErrorMessage="Name must contain charecter" ForeColor="red" />
                        </td>
                        <td>

                            <asp:Label ID="patientNameLabel" runat="server" ForeColor="red"></asp:Label>

                        </td>
                    </tr>
                    <tr>
                        <td><b>Address</b></td>
                        <td>
                            <asp:TextBox ID="addressTextBox" CssClass="form-control" TextMode="MultiLine" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="addressLabel" runat="server" ForeColor="red"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td><b>Age</b></td>
                        <td>
                            <asp:TextBox ID="ageTextBox" CssClass="form-control" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="ageLabel" runat="server" ForeColor="red"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td><b>Service given</b></td>
                        <td>
                            <asp:TextBox ID="serviceNumberTextBox" CssClass="form-control" runat="server"></asp:TextBox>
                        </td>
                        <td><b>times</b></td>
                    </tr>
                    <tr>
                        <td><b>Observation</b></td>
                        <td>
                            <asp:TextBox ID="observationTextBox" CssClass="form-control" TextMode="MultiLine" Rows="8" runat="server"></asp:TextBox>
                        </td>

                        <td><b>Date</b></td>
                        <td>

                            <asp:TextBox ID="Calendar1" runat="server"></asp:TextBox>
                        </td>

                        <td><b>Doctor</b></td>
                        <td>
                            <asp:DropDownList ID="doctorDropDownList" CssClass="form-control" Width="200px" Height="30px" runat="server"></asp:DropDownList>
                        </td>

                    </tr>
                    <tr>
                        <td><b>Disease</b></td>
                        <td>
                            <asp:DropDownList ID="diseaseDropdownList" CssClass="form-control" Width="200px" Height="30px" runat="server"></asp:DropDownList>
                        </td>

                        <td><b>Medicine</b></td>
                        <td>
                            <asp:DropDownList ID="medicineDropDownList" CssClass="form-control" runat="server" Width="200px" Height="30px"></asp:DropDownList>
                        </td>
                        <td><b>Dose</b></td>

                        <td>
                            <asp:DropDownList ID="doseDropdownList" CssClass="form-control" Width="200px" Height="30px" runat="server"></asp:DropDownList>
                        </td>

                        <td>
                            <asp:RadioButtonList ID="medicineIndication" Width="200px" CssClass="radio" runat="server">
                                <asp:ListItem Text="Before meal" Value="1" />
                                <asp:ListItem Text="After meal" Selected="true" Value="2" />
                            </asp:RadioButtonList>
                        </td>


                    </tr>
                    <tr>
                        <td><b>Quantity</b></td>
                        <td>
                            <asp:TextBox ID="quantityTextBox" CssClass="form-control" runat="server"></asp:TextBox>
                        </td>
                        <td><b>Note</b></td>
                        <td>
                            <asp:TextBox ID="noteTextBox" CssClass="form-control" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Button ID="addButton" CssClass="form-control btn btn-primary" runat="server" Text="Add information" OnClick="addButton_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5"><span class="label label-warning" style="float: left; font-size: 20px; position: relative" id="failStatusLabel" runat="server"></span></td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            <asp:GridView ID="addMedicineGridView" CssClass="table table-responsive" AutoGenerateColumns="False" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None">
                                <AlternatingRowStyle BackColor="White" />
                                <Columns>
                                    <asp:BoundField DataField="Disease" HeaderText="Disease" />
                                    <asp:BoundField DataField="DiseaseId" HeaderText="DiseaseId" />
                                    <asp:BoundField DataField="Medicine" HeaderText="Medicine" />
                                    <asp:BoundField DataField="MedicineId" HeaderText="MedicineId" />
                                    <asp:BoundField DataField="Dose" HeaderText="Dose" />
                                    <asp:BoundField DataField="DoseId" HeaderText="DoseId" />
                                    <asp:BoundField DataField="Before/After" HeaderText="Before/After" />
                                    <asp:BoundField DataField="Before/AfterId" HeaderText="Before/AfterId" />
                                    <asp:BoundField DataField="Quntity" HeaderText="Quntity" />
                                    <asp:BoundField DataField="Note" HeaderText="Note" />
                                </Columns>
                                <EditRowStyle BackColor="#7C6F57" />
                                <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                                <RowStyle BackColor="#E3EAEB" />
                                <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                                <SortedAscendingCellStyle BackColor="#F8FAFA" />
                                <SortedAscendingHeaderStyle BackColor="#246B61" />
                                <SortedDescendingCellStyle BackColor="#D4DFE1" />
                                <SortedDescendingHeaderStyle BackColor="#15524A" />

                            </asp:GridView>
                        </td>
                    </tr>

                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td>
                            <asp:Button CssClass="btn btn-primary right" ID="saveButton" runat="server" Text="save" OnClick="saveButton_Click" OnClientClick="return ValidateForm();"/></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <span class="label label-success" style="float: left; font-size: 20px; position: relative" id="sendMedicineSuccessStatusLabel" runat="server"></span>
                            <span class="label label-warning" style="float: left; font-size: 20px; position: relative" id="sendMedicineFailStatusLabel" runat="server"></span>
                        </td>
                    </tr>
                </table>
            </div>

        </div>


    </div>

    <%-- </form>--%>
</asp:Content>
