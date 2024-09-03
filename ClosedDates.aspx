<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" EnableEventValidation="false" CodeFile="ClosedDates.aspx.vb" Inherits="ClosedDates" %>

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
                <h3 class="text-themecolor">Closed Dates</h3>
            </div>
            <div class="col-md-7 align-self-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
                    <li class="breadcrumb-item active">Closed Dates</li>
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
                        <li class="nav-item"><a class="nav-link active" href="/ClosedDates">CLOSED DATES</a> </li>
                        <li class="nav-item"><a class="nav-link" href="/staff">STAFF MEMBERS</a> </li>
                        <li class="nav-item"><a class="nav-link" href="/permissionlevels">PERMISSION LEVELS</a></li>
                    </ul>


                    <% Dim countdata As Integer = Utility.IntegerData("SELECT Count(ClosedDatesId) countdata FROM ClosedDates")
                        If countdata = 0 %>
                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane active" role="tabpanel">
                            <div class="card-body">
                                <div class="row">
                                    <div class="align-self-center col-md-12 text-center">
                                        <br />
                                        <h2 style="font-size: 55px;"><i class="fa fa-calendar"></i></h2>
                                        <h3 class="m-b-20">Closed Dates</h3>
                                        <p class="m-b-0 font-14">List the dates your business is closed for public holidays, maintenance or any other reason.</p>
                                        <p class="font-14">Clients will not be able to place online bookings during these days.</p>
                                        <br />
                                        <a href="#" data-toggle="modal" data-target="#closedatemodal" class="btn btn-themecolor waves-effect font-14 waves-light" data-dismiss="modal">New Closed Date</a>

                                        <br />
                                        <br />
                                        <br />
                                        <br />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%Else %>

                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane active" role="tabpanel">
                            <div class="card-body">
                                <div class="row">
                                    <strong>
                                        <asp:Label ID="lblmsg" runat="server"></asp:Label></strong>
                                    <div class="col-md-6 col-sm-6 col-12">
                                        <div class="form-group">
                                            <label>Search by date</label>
                                            <asp:TextBox ID="txtsearchdate" CssClass="form-control mydatepicker" runat="server" placeholder="mm/dd/yyyy" ClientIDMode="Static"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-12">
                                        <div class="form-group">
                                            <label>&nbsp;</label>
                                            <div class="form-group">
                                                <%--<button type="submit" class="btn btn-danger waves-effect btn-block waves-light">Search</button>--%>
                                                <asp:Button ID="btnsearch" runat="server" ClientIDMode="Static" CssClass="btn btn-danger waves-effect btn-block waves-light btnsubmit" Text="Search" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-12">
                                        <div class="form-group">
                                            <label>&nbsp;</label>
                                            <%--<div class="form-group">
                                                <select class="form-control custom-select" data-placeholder="Export As" tabindex="1">
                                                    <option>Export As</option>
                                                    <option value="xlsx">Excel</option>
                                                    <option value="pdf">PDF</option>
                                                    <option value="csv">CSV</option>
                                                </select>
                                            </div>--%>
                                        </div>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-12">
                                        <div class="form-group">
                                            <label>&nbsp;</label>
                                            <div class="form-group">
                                                <label id="lblbtnadd" runat="server">
                                                    <a id="btnadd" class="btn btn-info waves-effect btn-block waves-light fancySmall" href="closeddates_popup.aspx" data-fancybox data-type="iframe" style="color: #fff">Add New</a>
                                                </label>
                                                <%--<button type="button" class="btn btn-themecolor waves-effect font-14 waves-light" data-toggle="modal" data-dismiss="modal" data-target="#closedatemodal">Add New</button>--%>
                                            </div>
                                        </div>
                                    </div>

                                </div>

                                <div class="row">
                                    <div class="col-lg-12 col-xlg-12 col-md-12 col-12">
                                        <div class="table-responsive">
                                            <table class="table table-bordered table-striped pagin-table">
                                                <thead>
                                                    <tr>
                                                        <th>&nbsp;</th>
                                                        <th>Start Date</th>
                                                        <th>End Date</th>
                                                        <th>Description</th>
                                                        <th>Locations</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <asp:ListView ID="ListView1" runat="server" DataKeyNames="ClosedDatesId" DataSourceID="sdscloseddates">
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
                                                                    <a href="closeddates_popup.aspx?cdid=<%# Eval("ClosedDatesId")%>" data-fancybox data-type="iframe" class="fancySmall">
                                                                        <i class="fa fa-circle font-14 m-r-10 text-blue"></i>
                                                                    </a>
                                                                </td>

                                                                <td><a href="closeddates_popup.aspx?cdid=<%# Eval("ClosedDatesId")%>" data-fancybox data-type="iframe" class="fancySmall">
                                                                    <asp:Label ID="Label1" runat="server" Text='<%# Format(CDate(Eval("StartDate")), "MMM dd,yyyy") %>' />
                                                                </a>
                                                                </td>
                                                                <td><a href="closeddates_popup.aspx?cdid=<%# Eval("ClosedDatesId")%>" data-fancybox data-type="iframe" class="fancySmall">
                                                                    <asp:Label ID="Label2" runat="server" Text='<%# Format(CDate(Eval("EndDate")), "MMM dd,yyyy") %>' /></a>
                                                                </td>
                                                                <td><a href="#">
                                                                    <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description") %>' /></a>
                                                                </td>

                                                                <td><a href="closeddates_popup.aspx?cdid=<%# Eval("ClosedDatesId")%>" data-fancybox data-type="iframe" class="fancySmall">
                                                                    <%# GetLocationData(Eval("ClosedDatesId").ToString())%>
                                                                </a>
                                                                </td>
                                                            </tr>
                                                        </ItemTemplate>

                                                    </asp:ListView>

                                                </tbody>

                                            </table>

                                            <asp:Literal ID="ltlpag" runat="server"></asp:Literal>

                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <%  End If %>
                </div>

            </div>
        </div>

    </div>
    <asp:HiddenField ID="hdnuserid" runat="server" ClientIDMode="Static" />
    <!-- ============================================================== -->
    <!-- End Container fluid  -->
    <!-- ============================================================== -->
    <asp:SqlDataSource ID="sdscloseddates" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT * FROM [ClosedDates]"></asp:SqlDataSource>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="Server">
</asp:Content>

