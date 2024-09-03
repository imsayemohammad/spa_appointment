<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="ClientRating.aspx.vb" Inherits="ClientRating" %>

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
                <h3 class="text-themecolor">Client Rating</h3>
            </div>
            <div class="col-md-7 align-self-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/Home">Home</a></li>
                    <li class="breadcrumb-item"><a href="/client">Client</a></li>
                    <li class="breadcrumb-item active">Client Rating</li>
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
                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane active" role="tabpanel">
                            <div class="card-body">

                                <div class="row staff-name-area">
                                    <div class="col-md-12">
                                        <ul class="nav nav-tabs">
                                            <h4 class="card-title pull-left">
                                                <asp:Label ID="lblClientName" runat="server"></asp:Label>
                                            </h4>
                                            <%--<li>|</li>--%>
                                            <a style="color: #000;" class="pull-right" href="/client"><span class="mdi mdi-chevron-double-left"></span>Back </a>
                                        </ul>
                                    </div>
                                </div>
                                <div class="row">
                                    <strong>
                                        <asp:Label ID="lblmsg" runat="server"></asp:Label>
                                    </strong>
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
                                </div>

                                <div class="row">
                                    <div class="col-lg-12 col-xlg-12 col-md-12 col-12">
                                        <div class="table-responsive">
                                            <table class="table table-bordered table-striped pagin-table">
                                                <thead>
                                                    <tr>
                                                        <th>STAFF</th>
                                                        <th>PHONE</th>
                                                        <th>EMAIL</th>
                                                        <th>SERVICE</th>
                                                        <th>RATINGS</th>
                                                        <th>NOTES</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <asp:ListView ID="ListView1" runat="server" DataKeyNames="ClientId" DataSourceID="sdsclientrating">
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
                                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Name") %>' /></a>
                                                                </td>
                                                                <td><a href="javascript:;">
                                                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("Phone1") %>' /></a>
                                                                </td>
                                                                <td><a href="javascript:;">
                                                                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("Email") %>' /></a>
                                                                </td>
                                                                <td><a href="javascript:;">
                                                                    <%# GetServiceinfo(Eval("ServiceId").ToString())%>
                                                                </a>
                                                                </td>
                                                                <td><a href="javascript:;">
                                                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("Rating") %>' /></a>
                                                                </td>
                                                                <td><a href="javascript:;">
                                                                    <asp:Label ID="Label5" runat="server" Text='<%# Eval("Comment") %>' /></a>
                                                                </td>
                                                            </tr>
                                                        </ItemTemplate>

                                                    </asp:ListView>

                                                </tbody>

                                            </table>
                                            <%--<h6 class="card-subtitle">Displaying 
                                                <code class="bg-light-success">1 - 25 of 3959 total Closed Dates
                                                </code>
                                            </h6>--%>
                                            <asp:Literal ID="ltlpag" runat="server"></asp:Literal>

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

    <asp:SqlDataSource ID="sdsclientrating" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        DeleteCommand="DELETE FROM [ClientRatings] WHERE [ClientId] = @ClientId"
        SelectCommand="Select ClientRatingId, ClientId, s.StaffId, ServiceId, ISNULL(Rating,0), Comment, (s.FirstName + ' ' + s.LastName) Name, s.Phone1, s.Email From ClientRatings cr INNER JOIN Staff s ON cr.StaffID = s.StaffID Where ClientId=@ClientId">
        <DeleteParameters>
            <asp:Parameter Name="ClientId" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="ClientId" QueryStringField="id" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="Server">
</asp:Content>

