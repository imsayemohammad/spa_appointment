<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="toppart" runat="Server">
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="Server">

    <!-- ============================================================== -->
    <!-- Container fluid  -->
    <!-- ============================================================== -->
    <div class="container-fluid">
        <!-- ============================================================== -->
        <!-- Bread crumb and right sidebar toggle -->
        <!-- ============================================================== -->
        <div class="row page-titles">
            <div class="col-md-5 align-self-center">
                <h3 class="text-themecolor">Home</h3>
            </div>
            <div class="col-md-7 align-self-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item active"><a href="javascript:void(0)">Home</a></li>
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
                    <div class="card-body">
                        <div class="row homepage">
                            <div class="col-md-6 col-lg-6 col-xlg-6 col-12">
                                <div class="row">
                                    <div class="col-md-12 col-lg-12 col-xlg-12 col-12">
                                        <h4 class="card-title m-b-5 text-center">RECENT SALES </h4>
                                        <hr>
                                    </div>
                                    <div class="col-md-8 col-12 m-b-15">
                                        <select class="custom-select" style="width: 100%">
                                            <option selected="">All location</option>
                                            <option value="1">Abu Dhabi</option>
                                            <option value="2">Al Ain</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 col-12 m-b-15">
                                        <select class="custom-select" style="width: 100%">
                                            <option selected="">Last 7days</option>
                                            <option value="1">10 days</option>
                                        </select>
                                    </div>
                                </div>


                                <div class="card">

                                    <div class="bg-theme stats-bar  m-b-20">
                                        <div class="row">
                                            <div class="col-lg-4 col-md-4">
                                                <div class="p-20 text-center">
                                                    <h6 class="text-white font-10">Appointment</h6>
                                                    <h4 class="text-white m-b-0">345</h4>
                                                </div>
                                            </div>
                                            <div class="col-lg-4 col-md-4 bg-purple">
                                                <div class="p-20 text-center">
                                                    <h6 class="text-white font-10">Appointment Value</h6>
                                                    <h4 class="text-white m-b-0">$7,589</h4>
                                                </div>
                                            </div>
                                            <div class="col-lg-4 col-md-4 bg-megna">
                                                <div class="p-20 text-center">
                                                    <h6 class="text-white font-10">Sales Value</h6>
                                                    <h4 class="text-white m-b-0">$1,476</h4>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div id="sales-overview2" class="p-relative" style="height: 390px;"></div>

                                </div>

                            </div>

                            <div class="col-md-6 col-lg-6 col-xlg-6 col-12">
                                <div class="row">
                                    <div class="col-md-12 col-lg-12 col-xlg-12 col-12">
                                        <h4 class="card-title m-b-5 text-center">Upcoming Appointment </h4>
                                        <hr>
                                    </div>
                                    <div class="col-md-8 col-12 m-b-15">
                                        <select class="custom-select" style="width: 100%">
                                            <option selected="">All location</option>
                                            <option value="1">Abu Dhabi</option>
                                            <option value="2">Al Ain</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 col-12 m-b-15">
                                        <select class="custom-select" style="width: 100%">
                                            <option selected="">Last 7days</option>
                                            <option value="1">10 days</option>
                                        </select>
                                    </div>
                                </div>


                                <div class="card">

                                    <div class="bg-theme stats-bar m-b-20">
                                        <div class="row">
                                            <div class="col-lg-4 col-md-4">
                                                <div class="p-20 text-center">
                                                    <h6 class="text-white font-10">Booked</h6>
                                                    <h4 class="text-white m-b-0">345</h4>
                                                </div>
                                            </div>
                                            <div class="col-lg-4 col-md-4 bg-purple">
                                                <div class="p-20 text-center">
                                                    <h6 class="text-white font-10">Confirmed</h6>
                                                    <h4 class="text-white m-b-0">589</h4>
                                                </div>
                                            </div>
                                            <div class="col-lg-4 col-md-4 bg-megna">
                                                <div class="p-20 text-center">
                                                    <h6 class="text-white font-10">Cancelled</h6>
                                                    <h4 class="text-white m-b-0">76</h4>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div id="ct-sales3-chart" class="p-relative" style="height: 360px;"></div>

                                </div>

                            </div>

                        </div>


                        <!-- ============================================================== -->
                        <!-- End PAge Content -->

                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <div class="card">
                            <div class="table-responsive">
                                <table class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>TOP SERVICES</th>
                                            <th>THIS MONTH</th>
                                            <th>LAST MONTH</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <a href="javascript:;">Essential
                                                </a>
                                            </td>
                                            <td>
                                                <a href="javascript:;">928
                                                </a>
                                            </td>
                                            <td>
                                                <a href="javascript:;">1194
                                                </a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a href="javascript:;">Transport Charge
                                                </a>
                                            </td>
                                            <td>
                                                <a href="javascript:;">928
                                                </a>
                                            </td>
                                            <td>
                                                <a href="javascript:;">114
                                                </a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a href="javascript:;">Essential
                                                </a>
                                            </td>
                                            <td>
                                                <a href="javascript:;">928
                                                </a>
                                            </td>
                                            <td>
                                                <a href="javascript:;">1194
                                                </a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a href="javascript:;">Transport Charge
                                                </a>
                                            </td>
                                            <td>
                                                <a href="javascript:;">928
                                                </a>
                                            </td>
                                            <td>
                                                <a href="javascript:;">114
                                                </a>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <div class="card">
                            <div class="table-responsive">
                                <table class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>TOP STAFF</th>
                                            <th>THIS MONTH</th>
                                            <th>LAST MONTH</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <a href="javascript:;">John
                                                </a>
                                            </td>
                                            <td>
                                                <a href="javascript:;">AED 11,331.25	
                                                </a>
                                            </td>
                                            <td>
                                                <a href="javascript:;">AED 16,203.25
                                                </a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a href="javascript:;">Transport Charge
                                                </a>
                                            </td>
                                            <td>
                                                <a href="javascript:;">AED 11,331.25	
                                                </a>
                                            </td>
                                            <td>
                                                <a href="javascript:;">AED 16,203.25
                                                </a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a href="javascript:;">Essential
                                                </a>
                                            </td>
                                            <td>
                                                <a href="javascript:;">AED 11,331.25	
                                                </a>
                                            </td>
                                            <td>
                                                <a href="javascript:;">AED 16,203.25
                                                </a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a href="javascript:;">Transport Charge
                                                </a>
                                            </td>
                                            <td>
                                                <a href="javascript:;">AED 11,331.25	
                                                </a>
                                            </td>
                                            <td>
                                                <a href="javascript:;">AED 16,203.25
                                                </a>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>



                            </div>
                        </div>
                    </div>
                </div>


            </div>
        </div>
        <asp:HiddenField ID="hdnUserID" runat="server" />
    </div>
    <!-- ============================================================== -->
    <!-- End Container fluid  -->
    <!-- ============================================================== -->
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="Server">
</asp:Content>

