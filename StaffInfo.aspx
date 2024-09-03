<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="StaffInfo.aspx.vb" Inherits="StaffInfo" %>

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
                <h3 class="text-themecolor">
                    <asp:Label ID="lblStaffname" runat="server"></asp:Label>
                </h3>
            </div>
            <div class="col-md-7 align-self-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
                    <li class="breadcrumb-item"><a href="/staff">Staff</a></li>
                    <li class="breadcrumb-item active">Staff Details</li>
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
                        <div class="row">
                            <!-- Column -->
                            <div class="col-md-3 col-lg-3 col-xlg-3 col-6">
                                <div class="card">
                                    <div class="box bg-info text-center">
                                        <h1 class="font-light text-white">
                                            <asp:Label ID="lbltotalappointment" runat="server"></asp:Label>
                                        </h1>
                                        <h3 class="text-white">Appointments</h3>
                                    </div>
                                </div>
                            </div>
                            <!-- Column -->
                            <div class="col-md-3 col-lg-3 col-xlg-3 col-6">
                                <div class="card">
                                    <div class="box bg-danger text-center">
                                        <h1 class="font-light text-white">0</h1>
                                        <h3 class="text-white">No-shows</h3>
                                    </div>
                                </div>
                            </div>
                            <!-- Column -->
                            <div class="col-md-3 col-lg-3 col-xlg-3 col-6">
                                <div class="card">
                                    <div class="box bg-megna text-center">
                                        <h1 class="font-light text-white">AED 0</h1>
                                        <h3 class="text-white">Total Sales</h3>
                                    </div>
                                </div>
                            </div>
                            <!-- Column -->
                            <div class="col-md-3 col-lg-3 col-xlg-3 col-6">
                                <div class="card">
                                    <div class="box bg-warning text-center">
                                        <h1 class="font-light text-white">AED 0</h1>
                                        <h3 class="text-white">Outstanding</h3>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Row -->
                        <div class="row">
                            <!-- Column -->
                            <div class="col-lg-4 col-xlg-3 col-md-5">
                                <div class="card">

                                    <div class="card-body bg-light-inverse">
                                        <asp:Literal ID="ltlclientinfo" runat="server"></asp:Literal>

                                        <a id="btnadd" class="btn btn-danger waves-effect btn-block waves-light addnewFancy" href="Staff_popup.aspx?page=staffinfo&staffid=<%= Request.QueryString("staffid")%>" data-fancybox data-type="iframe" style="color: #fff">Edit</a>
                                    </div>

                                </div>
                            </div>
                            <!-- Column -->
                            <!-- Column -->
                            <div class="col-lg-8 col-xlg-9 col-md-7">
                                <div class="card">
                                    <!-- Nav tabs -->
                                    <ul class="nav nav-tabs profile-tab" role="tablist">
                                        <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#home" role="tab">UPCOMING APPOINTMENTS </a></li>
                                        <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#profile" role="tab">APPOINTMENTS HISTORY </a></li>
                                        <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#settings" role="tab">INVOICES</a> </li>
                                    </ul>
                                    <!-- Tab panes -->
                                    <div class="tab-content">
                                        <div class="tab-pane active" id="home" role="tabpanel">
                                            <div class="card">
                                                <div class="table-responsive">
                                                    <table class="table table-bordered table-striped">
                                                        <thead>
                                                            <tr>
                                                                <th>APPOINTMENTS</th>
                                                                <th>RATE</th>
                                                                <th>DATE</th>
                                                                <th>TIME</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <asp:ListView ID="ListView2" runat="server" DataKeyNames="StaffID" DataSourceID="SqlDataSource1">
                                                                <EmptyDataTemplate>
                                                                    <table id="Table1" runat="server" style="">
                                                                        <tr>
                                                                            <td>No data was found.</td>
                                                                        </tr>
                                                                    </table>
                                                                </EmptyDataTemplate>
                                                                <ItemTemplate>
                                                                    <tr style="">
                                                                        <td><a href="javascript:;">
                                                                            <asp:Label ID="Label0" runat="server" Text='<%# Eval("Title") %>' /></a>
                                                                        </td>
                                                                        <td><a href="javascript:;">
                                                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("ServiceRate") %>' /></a>
                                                                        </td>
                                                                        <td>
                                                                            <%--<asp:Label ID="lblDate" runat="server" Text='<%# Format(CDate(Eval("StartDT")), "MMM dd,yyyy") %>' />--%>
                                                                            <asp:Label ID="lblDate" runat="server" Text='<%# Eval("StartDT") %>' />
                                                                        </td>
                                                                        <td>
                                                                            <b>Strat Time :</b>
                                                                            <asp:Label ID="Label12" runat="server" Text='<%# Eval("StartTime") %>' />
                                                                            <br />
                                                                            <b>End Time :</b>
                                                                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("EndTime")%>' />
                                                                        </td>
                                                                    </tr>
                                                                </ItemTemplate>

                                                            </asp:ListView>

                                                        </tbody>

                                                    </table>



                                                </div>
                                            </div>
                                        </div>
                                        <!--second tab-->
                                        <div class="tab-pane" id="profile" role="tabpanel">
                                            <div class="card">
                                                <div class="table-responsive">
                                                    <table class="table table-bordered table-striped">
                                                        <thead>
                                                            <tr>
                                                                <th>APPOINTMENTS</th>
                                                                <th>RATE</th>
                                                                <th>DATE</th>
                                                                <th>TIME</th>
                                                                <th>RATINGS</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <asp:ListView ID="ListView1" runat="server" DataKeyNames="StaffID" DataSourceID="sdsStaffappoints">
                                                                <EmptyDataTemplate>
                                                                    <table id="Table1" runat="server" style="">
                                                                        <tr>
                                                                            <td>No data was found.</td>
                                                                        </tr>
                                                                    </table>
                                                                </EmptyDataTemplate>
                                                                <ItemTemplate>
                                                                    <tr style="">
                                                                        <td><a href="javascript:;">
                                                                            <asp:Label ID="Label0" runat="server" Text='<%# Eval("Title") %>' /></a>
                                                                        </td>
                                                                        <td><a href="javascript:;">
                                                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("ServiceRate") %>' /></a>
                                                                        </td>
                                                                        <td>
                                                                            <%--<asp:Label ID="lblDate" runat="server" Text='<%# Format(CDate(Eval("StartDT")), "MMM dd,yyyy") %>' />--%>
                                                                            <asp:Label ID="lblDate" runat="server" Text='<%# Eval("StartDT") %>' />
                                                                        </td>
                                                                        <td>
                                                                            <b>Strat Time :</b>
                                                                            <asp:Label ID="Label12" runat="server" Text='<%# Eval("StartTime") %>' />
                                                                            <br />
                                                                            <b>End Time :</b>
                                                                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("EndTime")%>' />
                                                                        </td>
                                                                        <%--<td>
                                                                            <a href="javascript:;">Appoinment Name
                                                                            </a>
                                                                        </td>
                                                                        <td>
                                                                            <a href="javascript:;">200
                                                                            </a>
                                                                        </td>--%>
                                                                        <td><a href="staffrating?id=<%# Eval("StaffID")%>">
                                                                            <%# GetRating(Eval("ServiceId").ToString())%>
                                                                        </a>
                                                                        </td>
                                                                    </tr>
                                                                </ItemTemplate>

                                                            </asp:ListView>
                                                        </tbody>

                                                    </table>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-pane" id="settings" role="tabpanel">
                                            <div class="card">
                                                <div class="table-responsive">
                                                    <table class="table table-bordered table-striped">
                                                        <thead>
                                                            <tr>
                                                                <th>APPOINTMENTS</th>
                                                                <th>TOTAL</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <td>
                                                                    <a href="javascript:;">Appoinment Name
                                                                    </a>
                                                                </td>
                                                                <td>
                                                                    <a href="javascript:;">200
                                                                    </a>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <a href="javascript:;">Appoinment Name
                                                                    </a>
                                                                </td>
                                                                <td>
                                                                    <a href="javascript:;">200
                                                                    </a>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <a href="javascript:;">Appoinment Name
                                                                    </a>
                                                                </td>
                                                                <td>
                                                                    <a href="javascript:;">200
                                                                    </a>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <a href="javascript:;">Appoinment Name
                                                                    </a>
                                                                </td>
                                                                <td>
                                                                    <a href="javascript:;">200
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
                            <!-- Column -->
                        </div>
                        <!-- Row -->
                        <!-- ============================================================== -->
                        <!-- End PAge Content -->

                    </div>
                </div>

            </div>
        </div>

    </div>
    <!-- ============================================================== -->
    <!-- End Container fluid  -->
    <!-- ============================================================== -->

    <asp:SqlDataSource ID="sdsStaffappoints" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT *, CONVERT(VARCHAR(10), StartDate, 101) AS StartDT, CONVERT(VARCHAR(8), StartDateTime, 8) AS StartTime, CONVERT(VARCHAR(8), EndDateTime, 8) AS EndTime FROM ServiceRequestDetails Where StaffID=@StaffID">
        <SelectParameters>
            <asp:QueryStringParameter Name="StaffID" QueryStringField="staffid" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT *, CONVERT(VARCHAR(10), StartDate, 101) AS StartDT, CONVERT(VARCHAR(8), StartDateTime, 8) AS StartTime, CONVERT(VARCHAR(8), EndDateTime, 8) AS EndTime FROM ServiceRequestDetails Where StaffID=@StaffID And GETDATE() < StartDate">
        <SelectParameters>
            <asp:QueryStringParameter Name="StaffID" QueryStringField="staffid" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="Server">
</asp:Content>