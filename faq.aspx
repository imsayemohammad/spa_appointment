<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="faq.aspx.vb" Inherits="faq" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" type="text/css" href="/ui-marketplace/css/bootstrap.min.css" />
    <script src="js/jquery.min.js"></script>
    <script type="text/javascript" src="/ui-marketplace/js/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/ui-marketplace/css/style.css" />

    <link href="/ui-marketplace/css/expandy.css" rel="stylesheet"/>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="Server">

    <div class="about_heading">
        <div class="container">
            <div class="row menu_padiing">
                <h2>FAQ <span><a href="/">Home</a>  /  FAQ</span></h2>
            </div>
        </div>
    </div>

    <div class="m_faq">
        <div class="container">
            <%--<h2 class="heading text-center">FAQ’s</h2>--%>
            <div class="container1">
                <div class="row">
                    <asp:Literal ID="ltrlFaq" runat="server"></asp:Literal>
                </div>

            </div>
        </div>
    </div>

    <%--<div class="about_text">
        <%=Getfaq()%>;
    </div>--%>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="Server">

    <script src="/ui-marketplace/js/expandy.min.js"></script>
    <script>
        $('.container1').makeExpander({
            toggleElement: 'h2',
            jqAnim: true,
            showFirst: true,
            accordion: true,
            speed: 400,
            indicator: 'plusminus'
        });
    </script>
    
    <%--<script>
        $(document).ready(function () {
            $('[data-toggle="tooltip"]').tooltip();
        });
    </script>
    <script type="text/javascript" src="/ui-marketplace/js/equal.js"></script>--%>
</asp:Content>

