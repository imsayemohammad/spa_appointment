<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Pos.aspx.vb" Inherits="Pos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="toppart" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="Server">
    <div class="container-fluid">
        <div class="row page-titles">
            <div class="col-md-5 align-self-center">
                <h3 class="text-themecolor">Pos</h3>
            </div>
            <div class="col-md-7 align-self-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
                    <li class="breadcrumb-item active">Pos</li>
                </ol>
            </div>

        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="card">

                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs profile-tab">
                        <li class="nav-item"><a class="nav-link" href="/accounts">Account</a> </li>
                        <%--<li class="nav-item"><a class="nav-link" href="/client">Client</a></li>--%>
                        <li class="nav-item"><a class="nav-link active" href="/pos">POS</a></li>
                        <li class="nav-item"><a class="nav-link" href="/location">Locations</a></li>
                        <li class="nav-item"><a class="nav-link" href="/country">Country</a></li>
                    </ul>
                    <!-- Tab panes -->

                    <div class="tab-content">
                        <div class="tab-pane active" role="tabpanel">
                            <div class="card-body">
                                <div class="col-md-12 col-12">
                                    <h4>Point of Sale</h4>
                                    <p>Manage point of sale settings</p>
                                    <ul class="list-group">

                                        <li class="list-group-item"><a href="/paymentypes">Payment Types</a></li>
                                        <li class="list-group-item"><a href="/vat">Vat</a></li>
                                        <li class="list-group-item"><a href="/discount">Discount Types</a></li>
                                        <%--<li class="list-group-item"><a href="#">Sales Settings</a></li>
                                        <li class="list-group-item"><a href="#">Invoices &amp; Receipts</a></li>--%>
                                    </ul>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>


            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="Server">
</asp:Content>

