<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Permissionlevels.aspx.vb" Inherits="Permissionlevels" %>

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
                <h3 class="text-themecolor">Staff</h3>
            </div>
            <div class="col-md-7 align-self-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
                    <li class="breadcrumb-item active">Staff</li>
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
                        <li class="nav-item"><a class="nav-link" href="/team">TEAM</a> </li>
                        <li class="nav-item"><a class="nav-link" href="/workinghours">WORKING HOURS</a> </li>
                        <li class="nav-item"><a class="nav-link" href="/ClosedDates">CLOSED DATES</a> </li>
                        <li class="nav-item"><a class="nav-link" href="/staff">STAFF MEMBERS</a> </li>
                        <li class="nav-item"><a class="nav-link active" href="/permissionlevels">PERMISSION LEVELS</a></li>
                    </ul>
                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane active" role="tabpanel">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-lg-12 col-xlg-12 col-md-12 col-12">
                                        <p>Setup which sections are accessible to each user permission level. All logged in staff can access the calendar, and owner accounts have full system access.</p>
                                    </div>
                                    <div class="col-lg-6 col-xlg-6 col-md-6 col-12">

                                        <div class="table-responsive">
                                            <table class="table table-bordered table-striped perTBL">
                                                <thead>
                                                    <tr>
                                                        <th>LOCATIONS</th>
                                                        <th>LOW</th>
                                                        <th>MEDIUM</th>
                                                        <th>HIGH</th>
                                                        <th>OWNER</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>Access All Locations</td>
                                                        <td>
                                                            <input name="group1" type="radio" id="radio_2">
                                                            <label for="radio_2"></label>
                                                        </td>
                                                        <td>
                                                            <input name="group1" type="radio" id="radio_3" checked="checked">
                                                            <label for="radio_3"></label>
                                                        </td>
                                                        <td>
                                                            <input name="group1" type="radio" id="radio_4">
                                                            <label for="radio_4"></label>
                                                        </td>
                                                        <td>
                                                            <input name="group2" type="radio" id="radio_5" class="with-gap" checked="" disabled="">
                                                            <label for="radio_5"></label>
                                                        </td>
                                                    </tr>
                                                </tbody>

                                            </table>

                                            <table class="table table-bordered table-striped perTBL">
                                                <thead>
                                                    <tr>
                                                        <th>BOOKINGS & CLIENTS</th>
                                                        <th>LOW</th>
                                                        <th>MEDIUM</th>
                                                        <th>HIGH</th>
                                                        <th>OWNER</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>Own Calendar</td>
                                                        <td>
                                                            <input name="group3" type="radio" id="radio_6">
                                                            <label for="radio_6"></label>
                                                        </td>
                                                        <td>
                                                            <input name="group3" type="radio" id="radio_7" checked="checked">
                                                            <label for="radio_7"></label>
                                                        </td>
                                                        <td>
                                                            <input name="group3" type="radio" id="radio_8" checked="checked">
                                                            <label for="radio_8"></label>
                                                        </td>
                                                        <td>
                                                            <input name="group4" type="radio" id="radio_9" class="with-gap" checked="" disabled="">
                                                            <label for="radio_9"></label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Other Staff Calendars</td>
                                                        <td>
                                                            <input name="group5" type="radio" id="radio_10">
                                                            <label for="radio_10"></label>
                                                        </td>
                                                        <td>
                                                            <input name="group5" type="radio" id="radio_11" checked="checked">
                                                            <label for="radio_11"></label>
                                                        </td>
                                                        <td>
                                                            <input name="group5" type="radio" id="radio_12">
                                                            <label for="radio_12"></label>
                                                        </td>
                                                        <td>
                                                            <input name="group6" type="radio" id="radio_13" class="with-gap" checked="" disabled="">
                                                            <label for="radio_13"></label>
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td>Home</td>
                                                        <td>
                                                            <input name="group7" type="radio" id="radio_14">
                                                            <label for="radio_14"></label>
                                                        </td>
                                                        <td>
                                                            <input name="group7" type="radio" id="radio_15" checked="checked">
                                                            <label for="radio_15"></label>
                                                        </td>
                                                        <td>
                                                            <input name="group7" type="radio" id="radio_16">
                                                            <label for="radio_16"></label>
                                                        </td>
                                                        <td>
                                                            <input name="group8" type="radio" id="radio_17" class="with-gap" checked="" disabled="">
                                                            <label for="radio_17"></label>
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td>Clients</td>
                                                        <td>
                                                            <input name="group9" type="radio" id="radio_18">
                                                            <label for="radio_18"></label>
                                                        </td>
                                                        <td>
                                                            <input name="group9" type="radio" id="radio_19" checked="checked">
                                                            <label for="radio_19"></label>
                                                        </td>
                                                        <td>
                                                            <input name="group9" type="radio" id="radio_20">
                                                            <label for="radio_20"></label>
                                                        </td>
                                                        <td>
                                                            <input name="group10" type="radio" id="radio_21" class="with-gap" checked="" disabled="">
                                                            <label for="radio_21"></label>
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td>Can download clients</td>
                                                        <td>
                                                            <input name="group9" type="radio" id="radio_18">
                                                            <label for="radio_18"></label>
                                                        </td>
                                                        <td>
                                                            <input name="group9" type="radio" id="radio_19" checked="checked">
                                                            <label for="radio_19"></label>
                                                        </td>
                                                        <td>
                                                            <input name="group9" type="radio" id="radio_20">
                                                            <label for="radio_20"></label>
                                                        </td>
                                                        <td>
                                                            <input name="group10" type="radio" id="radio_21" class="with-gap" checked="" disabled="">
                                                            <label for="radio_21"></label>
                                                        </td>
                                                    </tr>

                                                </tbody>

                                            </table>

                                            <button type="button" class="btn btn-danger waves-effect waves-light" data-dismiss="modal">Save Changes</button>

                                        </div>
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

