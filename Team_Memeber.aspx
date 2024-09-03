<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Team_Memeber.aspx.vb" Inherits="Team" %>

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
                <h3 class="text-themecolor">
                    <asp:Literal ID="ltrTeamName" runat="server"></asp:Literal></h3>
            </div>
            <div class="col-md-7 align-self-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
                    <li class="breadcrumb-item active">Team Members</li>
                </ol>
            </div>

        </div>

        <div class="row">
            <div class="col-md-12">
                <a style="color: #000;" class="pull-right " href="/team"><span class="mdi mdi-chevron-double-left"></span>Back</a>s
            </div>
        </div>



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
                                    </div>

                                </div>
                            </div>
                            <div class="col-md-2 col-sm-2 col-12">
                                <div class="form-group">
                                    <label>&nbsp;</label>
                                    <div class="form-group">


                                        <label id="Label1" runat="server">
                                            <a id="btnadd" class="btn btn-info waves-effect btn-block waves-light fancySmall" href="/Team_Member_Add_popup.aspx?teamId=<%=GetTeamID() %>" data-fancybox data-type="iframe" style="color: #fff">Add New</a>
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
                                                <th>NAME</th>
                                                <th>Details</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <asp:ListView ID="lstTeamMemeber" runat="server">
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
                                                            <%# Eval("FullName")%>
                                                        </td>
                                                        <td>
                                                            <%# Eval("Description")%>
                                                        </td>
                                                        <td>

                                                            <a href="#" onclick='DeleteMemberBySupplierId(<%# Eval("TeamID")%>,<%# Eval("StaffID")%>)'>
                                                                <img src="images/icons/ic-delete.png" />
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
                    </div>
                </div>

            </div>
        </div>

    </div>


</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="Server">
    <!--c3 JavaScript -->
    <script src="/assets/plugins/d3/d3.min.js"></script>
    <script src="/assets/plugins/c3-master/c3.min.js"></script>
    <!-- Popup message jquery -->
    <script src="/assets/plugins/toast-master/js/jquery.toast.js"></script>
    <script>

        function DeleteMemberBySupplierId(x, y) {
            var TeamID = x;

            var StaffID = y;

            if (confirm("Are You Sure You Want To Delete?")) {


                $.ajax({
                    type: 'Post',
                    url: 'Team_Memeber.aspx/DeleteMemberBySupplierId',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ TeamID: TeamID, StaffID: StaffID }),
                    dataType: "json",
                    success: function (result) {
                        $.each(result,
                            function (key, value) {

                            });

                        window.parent.location.href = 'team-memeber?id=' + TeamID;


                    }
                });
            }
        }


    </script>



</asp:Content>
