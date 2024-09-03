<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Client.aspx.vb" Inherits="Client" %>

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
    <!-- ============================================================== -->
    <!-- Container fluid  -->
    <!-- ============================================================== -->
    <div class="container-fluid">
        <!-- ============================================================== -->
        <!-- Bread crumb and right sidebar toggle -->
        <!-- ============================================================== -->
        <div class="row page-titles">
            <div class="col-md-5 align-self-center">
                <h3 class="text-themecolor">Clients</h3>
            </div>
            <div class="col-md-7 align-self-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
                    <li class="breadcrumb-item active">Clients</li>
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
                                        <select class="form-control custom-select" data-placeholder="Export As" tabindex="1">
                                            <option>Export As</option>
                                            <option value="xlsx">Excel</option>
                                            <option value="pdf">PDF</option>
                                            <option value="csv">CSV</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2 col-sm-2 col-12">
                                <div class="form-group">
                                    <label>&nbsp;</label>
                                    <div class="form-group">
                                        <label id="lblbtnadd" runat="server">
                                            <a id="btnadd" class="btn btn-info waves-effect btn-block waves-light addnewFancy" href="Client_popup.aspx" data-fancybox data-type="iframe" style="color: #fff">Add New</a>
                                        </label>
                                        <%--<button type="button" class="btn btn-info waves-effect btn-block waves-light" data-toggle="modal" data-target="#addeditclientmodal">Add New</button>--%>
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
                                                <th>NAME</th>
                                                <th>MOBILE</th>
                                                <th>EMAIL</th>
                                                <th>GENDER</th>
                                                <th>RATINGS</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <asp:ListView ID="ListView1" runat="server" DataKeyNames="ClientID" DataSourceID="sdsClient">
                                                <EmptyDataTemplate>
                                                    <table id="Table1" runat="server" style="">
                                                        <tr>
                                                            <td>No data was found.</td>
                                                        </tr>
                                                    </table>
                                                </EmptyDataTemplate>
                                                <ItemTemplate>
                                                    <tr style="">
                                                        <td><a href="clientinfo?id=<%# Eval("ClientID")%>">
                                                            <asp:Label ID="lblname" runat="server" Text='<%# Eval("Name") %>' /></a>
                                                        </td>
                                                        <td><a href="clientinfo?id=<%# Eval("ClientID")%>">
                                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("Phone1") %>' /></a>
                                                        </td>
                                                        <td><a href="clientinfo?id=<%# Eval("ClientID")%>">
                                                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("Email") %>' /></a>
                                                        </td>
                                                        <td><a href="clientinfo?id=<%# Eval("ClientID")%>">
                                                            <asp:Label ID="Label3" runat="server" Text='<%# Eval("Gender") %>' /></a>
                                                        </td>
                                                        <td><a href="clientrating?id=<%# Eval("ClientID")%>">
                                                            <%# GetRating(Eval("ClientID").ToString())%>
                                                        </a>
                                                        </td>
                                                        <td>
                                                            <a href="Client_popup.aspx?id=<%# Eval("ClientID")%>" data-fancybox data-type="iframe" class="iframeedit">
                                                                <img src="images/icons/ic-edit.png" /></a>
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

                                    <%--<nav aria-label="Page navigation example" class="m-t-40">
                                        <ul class="pagination">
                                            <li class="page-item disabled">
                                                <a class="page-link" href="#" tabindex="-1">Previous</a>
                                            </li>
                                            <li class="page-item"><a class="page-link" href="#">1</a></li>
                                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                                            <li class="page-item">
                                                <a class="page-link" href="#">Next</a>
                                            </li>
                                        </ul>
                                    </nav>--%>
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
    <asp:HiddenField ID="hdnClientid" runat="server" ClientIDMode="Static" />

    <asp:SqlDataSource ID="sdsClient" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT *,(FirstName + ' ' + LastName) Name  FROM [Client]"></asp:SqlDataSource>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="Server">
    <!--c3 JavaScript -->
    <script src="/assets/plugins/d3/d3.min.js"></script>
    <script src="/assets/plugins/c3-master/c3.min.js"></script>
    <!-- Popup message jquery -->
    <script src="/assets/plugins/toast-master/js/jquery.toast.js"></script>


</asp:Content>
