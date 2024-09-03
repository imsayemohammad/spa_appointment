<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Team.aspx.vb" Inherits="Team" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="/css/pages/google-vector-map.css" rel="stylesheet" />
    <link href="/css/pages/jquery-gmaps-latlon-picker.css" rel="stylesheet" />



    <script src="/assets/plugins/jquery/jquery.min.js"></script>
    <!-- google maps api -->
    <%--<script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyAAoCreJSTSKMSraR3BTeIV8TBxoyI4OWA&amp;libraries=places"></script>--%>
    <script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyAAoCreJSTSKMSraR3BTeIV8TBxoyI4OWA&amp"></script>
    <script src="/js/jquery-gmaps-latlon-picker.js"></script>
    <%--<script src="/assets/plugins/gmaps/gmaps.min.js"></script>
    <script src="/assets/plugins/gmaps/jquery.gmaps.js"></script>--%>
    <!--    <script type="text/javascript" charset="UTF-8" src="http://maps.googleapis.com/maps-api-v3/api/js/34/4/util.js"></script>-->
    <style type="text/css">
        .wt1 {
            width: 357px !important;
        }

        .spanarea span {
            position: absolute;
            font-size: 0.3em;
            top: -1px;
            color: #fff;
            right: 15.5px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="toppart" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="Server">

    <div class="container-fluid">

        <div class="row page-titles">
            <div class="col-md-5 align-self-center">
                <h3 class="text-themecolor">Team</h3>
            </div>
            <div class="col-md-7 align-self-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
                    <li class="breadcrumb-item active">Team</li>
                </ol>
            </div>

        </div>

        <div class="row">
            <div class="col-md-12">

                <div class="card">

                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs profile-tab">
                        <li class="nav-item"><a class="nav-link active" href="/team">TEAM</a> </li>
                        <li class="nav-item"><a class="nav-link" href="/workinghours">WORKING HOURS</a> </li>
                        <li class="nav-item"><a class="nav-link" href="/ClosedDates">CLOSED DATES</a> </li>
                        <li class="nav-item"><a class="nav-link " href="/staff">STAFF MEMBERS</a> </li>
                        <li class="nav-item"><a class="nav-link" href="/permissionlevels">PERMISSION LEVELS</a></li>
                    </ul>
                    <!-- Tab panes -->

                    <div class="tab-content">
                        <div class="tab-pane active" role="tabpanel">
                            <div class="card-body">
                                <div class="row">

                                    <div class="col-md-6 col-sm-6 col-12">
                                        <div class="form-group">
                                            <label>Search by name or mobile number</label>
                                            <asp:TextBox ID="txtsearch" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-12">
                                        <div class="form-group">
                                            <label>&nbsp;</label>
                                            <div class="form-group">
                                                <asp:Button ID="btnsearch" runat="server" ClientIDMode="Static" CssClass="btn btn-danger waves-effect btn-block waves-light btnsubmit" Text="Search" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-12">
                                        <div class="form-group">
                                            <label>&nbsp;</label>
                                            <div class="form-group">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-12">
                                        <div class="form-group">
                                            <label>&nbsp;</label>
                                            <div class="form-group">


                                                <label id="Label1" runat="server">
                                                    <a id="btnadd" class="btn btn-info waves-effect btn-block waves-light fancySmall" href="Team_popup.aspx" data-fancybox data-type="iframe" style="color: #fff">Add New</a>
                                                </label>

                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-12 col-xlg-12 col-md-12 col-12">
                                        <div class="table-responsive">
                                            <table class="table table-bordered table-striped">
                                                <thead>
                                                    <tr>             
                                                        <th>&nbsp;</th>
                                                        <th>NAME</th>
                                                        <th>Details</th>

                                                        <th>Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <asp:ListView ID="lstTeam" runat="server" DataKeyNames="TeamID" DataSourceID="sdsTeam">
                                                        <EmptyDataTemplate>
                                                            <table id="Table1" runat="server" style="">
                                                                <tr>
                                                                    <td>No data was found.</td>
                                                                </tr>
                                                            </table>
                                                        </EmptyDataTemplate>
                                                        <ItemTemplate>
                                                            <tr style="">
                                                                <td>
                                                                    <a>
                                                                        <i class="fa fa-circle font-14 m-r-10 " style="color:<%# Eval("Color")%> "></i>
                                                                    </a>
                                                                </td>

                                                                <td><a href="/team-memeber?id=<%# Eval("TeamID")%>">
                                                                    <asp:Label ID="lblTeamName" runat="server" Text='<%# Eval("TeamName") %>' /></a>
                                                                </td>

                                                                <td><a href="Team_popup.aspx?id=<%# Eval("TeamID")%>">
                                                                    <asp:Label ID="lblTeamDetails" runat="server" Text='<%# Eval("Description") %>' /></a>
                                                                </td>


                                                                <td>
                                                                    <a href="Team_popup.aspx?id=<%# Eval("TeamID")%>" data-fancybox data-type="iframe" class="fancySmall">
                                                                        <img src="images/icons/ic-edit.png" /></a>
                                                                </td>
                                                            </tr>
                                                        </ItemTemplate>

                                                    </asp:ListView>

                                                </tbody>

                                            </table>





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


    <asp:SqlDataSource ID="sdsTeam" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT * FROM TeamMST"></asp:SqlDataSource>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="Server">
    <!--c3 JavaScript -->
    <script src="/assets/plugins/d3/d3.min.js"></script>
    <script src="/assets/plugins/c3-master/c3.min.js"></script>
    <!-- Popup message jquery -->
    <script src="/assets/plugins/toast-master/js/jquery.toast.js"></script>


</asp:Content>
