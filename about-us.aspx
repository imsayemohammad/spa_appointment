<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="about-us.aspx.vb" Inherits="about_us" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="Server">

     <div class="about_heading">
        <div class="container">
            <div class="row menu_padiing">
                <asp:Literal ID="ltrTitle" runat="server"></asp:Literal>
                <%--<h2>About Us<span><a href="/">Home</a>  /  About us</span></h2>--%>
            </div>
        </div>
    </div>
    <div class="about_text">
        <div class="container">
            <div class="row menu_padiing">
              <asp:Literal ID="ltrlBigDetails" runat="server"></asp:Literal>
                  </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="Server">
</asp:Content>

