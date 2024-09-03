<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="AllPackages.aspx.vb" Inherits="AllPackages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="toppart" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="Server">
    
    <div class="container-fluid">
        
        <div class="row page-titles">
            <div class="col-md-5 align-self-center">
                <h3 class="text-themecolor">Packages</h3>
            </div>
            <div class="col-md-7 align-self-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/Home">Home</a></li>
                    <li class="breadcrumb-item active">Packages</li>
                </ol>
            </div>

        </div>


        <div class="row">
            <div class="col-md-12">
                <div class="card">

                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane active" role="tabpanel">
                            <div class="card-body">
                                <div class="row">
                                    <strong>
                                        <asp:Label ID="lblmsg" runat="server"></asp:Label>
                                    </strong>
                                    <div class="col-md-6 col-sm-6 col-12">
                                        <div class="form-group">
                                            <label>Search by Title</label>
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
                                                <label id="lblbtnadd" runat="server">
                                                    <a id="btnadd" class="btn btn-info waves-effect btn-block waves-light addnewFancy" href="AddPackage.aspx" data-fancybox data-type="iframe" style="color: #fff">Add New</a>
                                                </label>
                                                <%--<button type="button" class="btn btn-info waves-effect btn-block waves-light" data-toggle="modal" data-target="#staffmodal" data-backdrop="static" data-keyboard="false">Add New</button>--%>
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
                                                        <th>Title</th>
                                                        <th>Ar Title</th>
                                                        <th>Price</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <asp:ListView ID="ListView1" runat="server" DataKeyNames="ServiceId" DataSourceID="sdsPackage">
                                                        <EmptyDataTemplate>
                                                            <table id="Table1" runat="server" style="">
                                                                <tr>
                                                                    <td>No Package data was found.</td>
                                                                </tr>
                                                            </table>
                                                        </EmptyDataTemplate>
                                                        <ItemTemplate>
                                                            <tr style="">

                                                                <td><a href="AddPackage.aspx?serviceid=<%# Eval("ServiceId")%>" data-fancybox data-type="iframe" class="iframeedit">
                                                                    <asp:Label ID="lblTitle" runat="server" Text='<%# Eval("Title") %>' /></a>
                                                                </td>
                                                                <td><a href="AddPackage.aspx?serviceid=<%# Eval("ServiceId")%>" data-fancybox data-type="iframe" class="iframeedit">
                                                                    <asp:Label ID="lblArTitle" runat="server" Text='<%# Eval("ArTitle") %>' /></a>
                                                                </td>
                                                                <td><a href="javascript:;">
                                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("PackagePrice") %>' /></a>
                                                                </td>

                                                            </tr>
                                                        </ItemTemplate>

                                                    </asp:ListView>

                                                </tbody>

                                            </table>
                                          
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
        </div>

    </div>

    <!-- ============================================================== -->
    <!-- End Container fluid  -->
    <!-- ============================================================== -->

    <asp:HiddenField ID="hdnPackageId" runat="server" ClientIDMode="Static" />
    <asp:SqlDataSource ID="sdsPackage" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="select * from [dbo].[Services] Where IsPackage=1 And status = 1 And ParentId <> 0"></asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="Server">
</asp:Content>

