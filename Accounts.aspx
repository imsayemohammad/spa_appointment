<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Accounts.aspx.vb" Inherits="Accounts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="toppart" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="Server">
    <!-- Container fluid  -->
    <!-- ============================================================== -->
    <div class="container-fluid">
        <!-- ============================================================== -->
        <!-- Bread crumb and right sidebar toggle -->
        <!-- ============================================================== -->
        <div class="row page-titles">
            <div class="col-md-5 align-self-center">
                <h3 class="text-themecolor">Setup</h3>
            </div>
            <div class="col-md-7 align-self-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
                    <li class="breadcrumb-item active">Account</li>
                </ol>
            </div>

        </div>
        <!-- ============================================================== -->
        <!-- End Bread crumb and right sidebar toggle -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Sales overview chart -->
        <!-- ============================================================== -->
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs profile-tab">
                        <li class="nav-item"><a class="nav-link active" href="/accounts">Account</a> </li>
                        <%--<li class="nav-item"><a class="nav-link" href="/client">Client</a></li>--%>
                        <li class="nav-item"><a class="nav-link" href="/pos">POS</a></li>
                        <li class="nav-item"><a class="nav-link" href="/location">Locations</a></li>
                        <li class="nav-item"><a class="nav-link" href="/country">Country</a></li>
                    </ul>
                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane active" role="tabpanel">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-12 col-12">
                                        <h4>Account Setup</h4>
                                        <p>Manage your business general settings</p>
                                        <ul class="list-group">
                                            <li class="list-group-item"><a href="/company">Company Details</a></li>
                                            <li class="list-group-item"><a href="/currency">Currency</a></li>
                                            <%--<li class="list-group-item"><a href="#">Resources</a></li>--%>
                                            <li class="list-group-item"><a href="/calendarsettings">Calendar Settings</a></li>
                                            <%--<li class="list-group-item"><a href="#">Online Booking Settings</a></li>
                                            <li class="list-group-item"><a href="#">Staff Notifications</a></li>--%>
                                        </ul>
                                    </div>

                                </div>



                            </div>
                        </div>
                    </div>
                </div>


            </div>
        </div>

    </div>


    <!-- ============================================================== -->
    <!-- End Container fluid  -->
    <!-- ============================================================== -->
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="Server">
</asp:Content>

