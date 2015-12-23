<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/MasterPages/MasterPageAdmin.Master" AutoEventWireup="true" CodeBehind="AdminHome.aspx.cs" Inherits="NWCMADemoApp.Pages.Admin.AdminHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../../sliderengine/jquery.js"></script>
    <script src="../../sliderengine/amazingslider.js"></script>
    <link rel="stylesheet" type="text/css" href="../../sliderengine/amazingslider-1.css">
    <script src="../../sliderengine/initslider-1.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="content">
        <h1>Welcome to the Community Medicine Automation System</h1>
        <br/>
        
       <div id="amazingslider-wrapper-1" style="display:block;position:relative;max-width:1140px;margin:0px auto 56px; ">
        <div id="amazingslider-1" style="display:block;position:relative;margin:0 auto;">
            <ul class="amazingslider-slides" style="display:none;">
                <li><img src="../../images/cma1.jpg" alt="logo"  title="logo" data-description="My logo" />
                </li>
                <li><img src="../../images/cma2.jpg" alt="Gallary 1"  title="Gallary 1" />
                </li>
                <li><img src="../../images/cma3.jpg" alt="Gallary 2"  title="Gallary 2" />
                </li>
                <li><img src="../../images/cma4.jpg" alt="Gallary 3"  title="Gallary 3" />
                </li>
                <li><img src="../../images/cma5.jpg" alt="Gallary 4"  title="Gallary 4" />
                </li>
                <li><img src="../../images/cma6.jpg" alt="Gallary 4"  title="Gallary 4" />
                </li>
                <li><img src="../../images/cma7.png" alt="Gallary 4"  title="Gallary 4" />
                </li>
                <li><img src="../../images/cma8.jpg" alt="Gallary 4"  title="Gallary 4" />
                </li>
                <li><img src="../../images/cma9.jpg" alt="Gallary 4"  title="Gallary 4" />
                </li>
                <li><img src="../../images/cma10.jpg" alt="Gallary 4"  title="Gallary 4" />
                </li>
                <li><img src="../../images/cma11.jpg" alt="Gallary 4"  title="Gallary 4" />
                </li>
                
            </ul>
            <ul class="amazingslider-thumbnails" style="display:none;">
                <li><img src="../../images/cma1.jpg" alt="logo" title="logo" /></li>
                <li><img src="../../images/cma2.jpg" alt="Gallary 1" title="Gallary 1" /></li>
                <li><img src="../../images/cma3.jpg" alt="Gallary 2" title="Gallary 2" /></li>
                <li><img src="../../images/cma4.jpg" alt="Gallary 3" title="Gallary 3" /></li>
                <li><img src="../../images/cma5.jpg" alt="Gallary 4" title="Gallary 4" /></li>
                <li><img src="../../images/cma6.jpg" alt="Gallary 4" title="Gallary 4" /></li>
                <li><img src="../../images/cma7.png" alt="Gallary 4" title="Gallary 4" /></li>
                <li><img src="../../images/cma8.jpg" alt="Gallary 4" title="Gallary 4" /></li>
                <li><img src="../../images/cma9.jpg" alt="Gallary 4" title="Gallary 4" /></li>
                <li><img src="../../images/cma10.jpg" alt="Gallary 4" title="Gallary 4" /></li>
                <li><img src="../../images/cma11.jpg" alt="Gallary 4" title="Gallary 4" /></li>
            </ul>
        </div>
    </div>
        <br/>
        <br/>
        
   
    </div>

</asp:Content>
