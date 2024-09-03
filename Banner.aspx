<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Banner.aspx.vb" Inherits="BrandList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="toppart" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="Server">

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
                    <li class="breadcrumb-item active">Banner</li>
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
                        <li class="nav-item"><a class="nav-link" href="team.html">Team</a> </li>
                        <li class="nav-item"><a class="nav-link" href="/accounts">Account</a> </li>
                        <li class="nav-item"><a class="nav-link" href="client.html">Client</a></li>
                        <li class="nav-item"><a class="nav-link" href="/pos">POS</a></li>
                        <li class="nav-item"><a class="nav-link" href="/location">Locations</a></li>
                        <li class="nav-item"><a class="nav-link " href="/country">Country</a></li>
                        <li class="nav-item"><a class="nav-link active" href="/banner">Banner</a></li>
                    </ul>
                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane active" role="tabpanel">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6 col-sm-6 col-12">
                                        <div class="form-group">
                                            <label>Search by banner name</label>
                                            <asp:TextBox ID="txtSearch" runat="server" class="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-12">
                                        <div class="form-group">
                                            <label>&nbsp;</label>
                                            <div class="form-group">
                                                <asp:Button ID="btnSaerch" runat="server" class="btn btn-danger waves-effect btn-block waves-light btnsubmit" Text="Search" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-12">
                                        <div class="form-group">
                                            <label>&nbsp;</label>
                                            <div class="form-group">
                                                <button type="button" class="btn btn-info waves-effect btn-block waves-light" data-toggle="modal" data-target="#editcategorymodal" onclick="ClearID()">Add New</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>



                                <div class="row">
                                    <div class="col-lg-12 col-xlg-12 col-md-12 col-12">
                                        <div>
                                            <table class="table table-bordered table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>Banner Title</th>
                                                        <th>Banner Image</th>
                                                        <th>Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <asp:ListView ID="lstBanner" runat="server">
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td>
                                                                    <a href="#" onclick='GetCountryById(<%# Eval("BannerId")%>)' data-toggle="modal" data-target="#editcategorymodal">
                                                                        <%# Eval("BannerTitle")%>
                                                                    </a>
                                                                </td>

                                                                <td>
                                                                    <img width="30px" height="30px" alt="" src="<%# Eval(" Image")%>"></td>
                                                                <td>
                                                                    <a href="#" onclick='GetBannerById(<%# Eval("BannerId")%>)' data-toggle="modal" data-target="#editcategorymodal">
                                                                        <img src="images/icons/ic-edit.png" />
                                                                    </a>
                                                                    |
                                                                    <a href="#" onclick='DeleteBannerById(<%# Eval("BannerId")%>)'>
                                                                        <img src="images/icons/ic-delete.png" />
                                                                    </a>
                                                                </td>
                                                            </tr>

                                                        </ItemTemplate>
                                                    </asp:ListView>
                                                </tbody>
                                            </table>

                                            <!-- END MODAL -->

                                            <div class="modal fade none-border editcategorymodal" id="editcategorymodal">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h4 class="modal-title">Add/Edit Banner
                                                            </h4>
                                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="ClearID()">×</button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <form role="form">
                                                                <div class="row">
                                                                    <div class="col-sm-6 col-12">
                                                                        <div class="form-group">
                                                                            <asp:HiddenField ID="hidBannerID" runat="server" ClientIDMode="Static" />
                                                                            <label class="control-label">Banner Title</label>

                                                                            <asp:TextBox ID="txtBannerTitle" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                            <asp:RequiredFieldValidator ControlToValidate="txtBannerTitle" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidatortxtBannerTitle" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>


                                                                    <div class="col-sm-6 col-12">
                                                                        <div class="form-group">

                                                                            <label class="control-label">Arabic Banner Title</label>

                                                                            <asp:TextBox ID="txtArBannerTitle" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>

                                                                        </div>
                                                                    </div>




                                                                    <div class="col-sm-6 col-12">
                                                                        <div class="form-group">



                                                                            <div class="checkbox checkbox-success">
                                                                                <%--<input id="checkbox1" type="checkbox">--%>
                                                                                <asp:CheckBox ID="chkActiveBanner" runat="server" ClientIDMode="Static" />
                                                                                <label for="chkActiveBanner">Active </label>
                                                                            </div>
                                                                        </div>


                                                                    </div>
                                                                </div>

                                                                <div class="row">


                                                                    <!--                                                    upload picture-->
                                                                    <div class="col-md-6 col-12">
                                                                        <div class="form-group">
                                                                            <label>Picture: </label>
                                                                            <div class="upload-picture">
                                                                                <div class="text-cemter image-holder">
                                                                                    <img src="https://via.placeholder.com/220x115">
                                                                                    <div class="upload-wrapper" data-toggle="tooltip" data-placement="right" title="" data-original-title="upload picture here" aria-describedy="">
                                                                                        <div class="inner">
                                                                                            <a href="javascript:;" class="file-upload-button"><span class="mdi mdi-upload"></span></a>
                                                                                            <asp:FileUpload ID="fuImageFile" accept="image/*" onchange="loadFile(event)" ClientIDMode="Static" runat="server" />

                                                                                            <asp:HiddenField ID="hdnImageUrl" runat="server" />
                                                                                        </div>

                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <!--                                                    upload picture-->

                                                                </div>
                                                            </form>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <asp:Label ID="lblmsg" runat="server" Font-Size="Medium" ForeColor="Red"></asp:Label>
                                                            <asp:Button ID="btnsave" ValidationGroup="form" CssClass="btn btn-danger waves-effect waves-light btnsubmit" runat="server" Text="Save" ClientIDMode="Static" />
                                                            <button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal" onclick="ClearID()">Close</button>
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
                </div>
            </div>
        </div>

    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="Server">

    <script>
        function ClearID() {



            document.getElementById("hidBannerID").value = "";
            document.getElementById("txtBannerTitle").value = "";
            document.getElementById("txtArBannerTitle").value = "";
            document.getElementById("chkActiveBanner").checked = false;


        }




        function DeleteBannerById(x) {


            var BannerId = x;


            if (confirm("Are You Sure You Want To Delete ?")) {

                $.ajax({
                    type: 'Post',
                    url: 'Banner.aspx/DeleteBannerById',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({
                        BannerId: BannerId
                    }),
                    dataType: "json",
                    success: function() {
                        location.reload();

                    }

                });

            } else {

            }

        }



        function GetBannerById(x) {

            var BannerId = x;

            ClearID();
            $.ajax({
                type: 'Post',
                url: 'Banner.aspx/GetBannerById',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({
                    BannerId: BannerId
                }),
                dataType: "json",
                success: function(result) {
                    $.each(result,
                        function(key, value) {
                            document.getElementById('hidBannerID').value = value.hidBannerID;
                            document.getElementById('txtBannerTitle').value = value.txtBannerTitle;
                            document.getElementById('txtArBannerTitle').value = value.txtArBannerTitle;


                            $("[id$='imgSmallImage']").attr("src", value.Image);


                            if (value.chkActiveBanner !== false) {
                                //document.getElementById('chkbookings').prop('checked', true);
                                document.getElementById("chkActiveBanner").checked = true;
                            } else {
                                document.getElementById("chkActiveBanner").checked = false;
                                //document.getElementById('chkbookings').prop('checked', false);
                            }



                        });
                }

            });
        }

    </script>


</asp:Content>
