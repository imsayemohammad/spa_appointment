<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Country.aspx.vb" Inherits="BrandList" %>

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
                    <li class="breadcrumb-item active">Country</li>
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
                        <li class="nav-item"><a class="nav-link" href="/accounts">Account</a> </li>
                        <%--<li class="nav-item"><a class="nav-link" href="/client">Client</a></li>--%>
                        <li class="nav-item"><a class="nav-link" href="/pos">POS</a></li>
                        <li class="nav-item"><a class="nav-link" href="/location">Locations</a></li>
                        <li class="nav-item"><a class="nav-link active" href="/country">Country</a></li>
                    </ul>
                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane active" role="tabpanel">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6 col-sm-6 col-12">
                                        <div class="form-group">
                                            <label>Search by country name</label>
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
                                                        <th>Country Name</th>
                                                        <th>Country Code</th>
                                                        <th>Flag</th>
                                                        <th>Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <asp:ListView ID="lstBrand" runat="server">
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td>
                                                                    <a href="#" onclick='GetCountryById(<%# Eval("CountryID")%>)'
                                                                        data-toggle="modal" data-target="#editcategorymodal">
                                                                        <%# Eval("CountryName")%>
                                                                    </a>
                                                                </td>
                                                                <td>
                                                                    <a href="#"><%# Eval("MobileCode")%></a>
                                                                </td>
                                                                <td>
                                                                    <img width="30px" height="30px" alt="" src="<%# Eval("CountryFlagImg")%>"></td>
                                                                <td>
                                                                    <a href="#" onclick='GetCountryById(<%# Eval("CountryID")%>)'
                                                                        data-toggle="modal" data-target="#editcategorymodal">
                                                                        <img src="images/icons/ic-edit.png" />
                                                                    </a>
                                                                    |
                                                                <a href="#" onclick='DeleteCountryById(<%# Eval("CountryID")%>)'>
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
                                                            <h4 class="modal-title">Add/Edit Country                              
                                                            </h4>
                                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="ClearID()">×</button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <form role="form">
                                                                <div class="row">
                                                                    <div class="col-sm-6 col-12">
                                                                        <div class="form-group">
                                                                            <asp:HiddenField ID="hidCountryID" runat="server" ClientIDMode="Static" />
                                                                            <label class="control-label">Country Name</label>

                                                                            <asp:TextBox ID="txtCountryName" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                            <asp:RequiredFieldValidator ControlToValidate="txtCountryName" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidatortxtCountryName" runat="server"
                                                                                ErrorMessage="*"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                                 
                                                                    
                                                                    <div class="col-sm-6 col-12">
                                                                        <div class="form-group">
                                                                          
                                                                            <label class="control-label">Arabic Country Name</label>

                                                                            <asp:TextBox ID="txtArCountryName" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                          
                                                                        </div>
                                                                    </div>
                                                                    
                                                                    

                                                                    <div class="col-sm-6 col-12">
                                                                        <div class="form-group">
                                                                            <label class="control-label">Country Code</label>
                                                                            <asp:TextBox ID="txtCountryCode" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                            <asp:RequiredFieldValidator ControlToValidate="txtCountryCode" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1txtCountryCode" runat="server"
                                                                                ErrorMessage="*"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <div class="row">
                                                                    <div class="col-md-6 col-12">
                                                                        <div class="form-group">
                                                                            <label class="control-label">Flag</label>
                                                                            <div class="upload-wrapper">
                                                                                <div class="inner">
                                                                                    <a href="javascript:;" class="file-upload-button">Upload Flag<span class="mdi mdi-upload"></span></a>
                                                                                    <asp:FileUpload ID="fuImageFile" accept="image/*" onchange="loadFile(event)" ClientIDMode="Static" runat="server" />

                                                                                    <asp:HiddenField ID="hdnImageUrl" runat="server" />
                                                                                </div>

                                                                                <div class="image-holder">
                                                                                    <asp:Image ID="imgSmallImage" runat="server" Width="50px" Height="50px" ClientIDMode="Static" />
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </form>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <asp:Label ID="lblmsg" runat="server" Font-Size="Medium" ForeColor="Red"></asp:Label>
                                                            <asp:Button ID="btnsave" ValidationGroup="form" CssClass="btn btn-danger waves-effect waves-light btnsubmit"
                                                                runat="server" Text="Save" ClientIDMode="Static" />
                                                            <button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal" onclick="ClearID()">Close</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                           <%-- <nav aria-label="Page navigation example" class="m-t-40">
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
                                            </nav>                 
                                            --%>

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
            document.getElementById('hidCountryID').value = "";
            document.getElementById('txtCountryCode').value = "";
            document.getElementById('txtCountryName').value = "";
            document.getElementById('txtArCountryName').value = "";
            document.getElementById('hdnImageUrl').value = "";
        }


        function DeleteCountryById(x) {


            var CountryId = x;


            if (confirm("Are You Sure You Want To Delete ?")) {

                $.ajax({
                    type: 'Post',
                    url: 'Country.aspx/DeleteCountryById',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ CountryId: CountryId }),
                    dataType: "json",
                    success: function () {
                        location.reload();

                    }

                });

            } else {

            }

        }

        function GetCountryById(x) {

            var CountryId = x;

            $.ajax({
                type: 'Post',
                url: 'Country.aspx/GetCountryById',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ CountryId: CountryId }),
                dataType: "json",
                success: function (result) {
                    $.each(result,
                        function (key, value) {

                            document.getElementById('hidCountryID').value = value.CountryID;
                            document.getElementById('txtCountryName').value = value.CountryName;
                            document.getElementById('txtArCountryName').value = value.ArCountryName;
                            document.getElementById('txtCountryCode').value = value.MobileCode;
                        
                            $("[id$='imgSmallImage']").attr("src", value.CountryFlag);

                          

                        });
                }

            });
        }
    </script>

    <script type="text/javascript">
        $(document).ready(function () {
            $("<%=imgSmallImage.ClientID %>").hide();
        });

    </script>

    <script type="text/javascript">
        var loadFile = function (event) {
            $("<%=imgSmallImage.ClientID %>").show();
            var output = document.getElementById("<%=imgSmallImage.ClientID %>");
            output.src = URL.createObjectURL(event.target.files[0]);
        };
    </script>
</asp:Content>

