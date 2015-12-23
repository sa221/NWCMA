<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/MasterPages/MasterPageAdmin.Master" AutoEventWireup="true" CodeBehind="ViewDoctor.aspx.cs" Inherits="NWCMADemoApp.Pages.Center.ViewDoctor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="content">
       <%--<form id="form1" runat="server">--%>
            
            <div class="col-xs-6 col-sm-3 col-md-7 placeholder">
          <asp:GridView ID="doctorGridView" AllowPaging="True" PageSize="5" CssClass="table table-responsive table-bordered" AutoGenerateColumns="False" runat="server" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" GridLines="Horizontal" OnPageIndexChanging="doctorGridView_PageIndexChanging">
        
           <Columns>
               <asp:BoundField HeaderText="Name" DataField="Name"/>
                <asp:BoundField HeaderText="Degree" DataField="Degree"/>
                <asp:BoundField HeaderText="Specialization" DataField="Specialization"/>
           </Columns>

           <FooterStyle BackColor="White" ForeColor="#333333" />
           <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
           <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
           <RowStyle BackColor="White" ForeColor="#333333" />
           <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
           <SortedAscendingCellStyle BackColor="#F7F7F7" />
           <SortedAscendingHeaderStyle BackColor="#487575" />
           <SortedDescendingCellStyle BackColor="#E5E5E5" />
           <SortedDescendingHeaderStyle BackColor="#275353" />

       </asp:GridView> 
      </div> 
      <%-- </form> --%>
       
       
    </div>

</asp:Content>
