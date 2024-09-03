<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Staff.aspx.vb" Inherits="Staff" %>

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
                <h3 class="text-themecolor">Staff</h3>
            </div>
            <div class="col-md-7 align-self-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/Home">Home</a></li>
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
                        <li class="nav-item"><a class="nav-link active" href="/staff">STAFF MEMBERS</a> </li>
                        <li class="nav-item"><a class="nav-link" href="/permissionlevels">PERMISSION LEVELS</a></li>
                    </ul>
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
                                                    <a id="btnadd" class="btn btn-info waves-effect btn-block waves-light addnewFancy" href="Staff_popup.aspx" data-fancybox data-type="iframe" style="color: #fff">Add New</a>
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
                                                        <th>&nbsp;</th>
                                                        <th>NAME</th>
                                                        <th>MOBILE NUMBER</th>
                                                        <th>EMAIL</th>
                                                        <th>APPOINTMENTS</th>
                                                        <th>USER PERMISSION</th>
                                                        <th>RATINGS</th>
                                                        <th>ACTION</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <asp:ListView ID="ListView1" runat="server" DataKeyNames="StaffID" DataSourceID="sdsstaff">
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
                                                                    <a href="Staff_popup.aspx?staffid=<%# Eval("StaffID")%>" data-fancybox data-type="iframe" class="iframeedit">
                                                                        <i class="fa fa-circle font-14 m-r-10 text-blue"></i>
                                                                    </a>
                                                                </td>
                                                                <td><a href="StaffInfo?staffid=<%# Eval("StaffID")%>">
                                                                    <asp:Label ID="lblname" runat="server" Text='<%# Eval("Name") %>' /></a>
                                                                </td>
                                                                <td><a href="StaffInfo?staffid=<%# Eval("StaffID")%>">
                                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Phone1") %>' /></a>
                                                                </td>
                                                                <td><a href="StaffInfo?staffid=<%# Eval("StaffID")%>">
                                                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("Email") %>' /></a>
                                                                </td>
                                                                <td><a href="javascript:;"><%# Eval("AppBooking") %></a></td>
                                                                <td><a href="javascript:;">
                                                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("UserPermission") %>' /></a>
                                                                </td>
                                                                <td><a href="staffrating?id=<%# Eval("StaffID")%>">
                                                                    <%# GetRating(Eval("StaffID").ToString())%>
                                                                </a>
                                                                </td>
                                                                <td>
                                                                    <a href="Staff_popup.aspx?staffid=<%# Eval("StaffID")%>" data-fancybox data-type="iframe" class="iframeedit">
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
        </div>

    </div>

    <!-- ============================================================== -->
    <!-- End Container fluid  -->
    <!-- ============================================================== -->

    <asp:HiddenField ID="hdnStaffid" runat="server" ClientIDMode="Static" />

    <asp:SqlDataSource ID="sdsstaff" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        DeleteCommand="DELETE FROM [Staff] WHERE [StaffID] = @StaffID"
        InsertCommand="INSERT INTO [Staff] ([FirstName], [LastName], [Phone1], [Email], [Notes], [StartDate], [EndDate], [UserPermission], [CreateBy], [CreateDate]) VALUES (@FirstName, @LastName, @Phone1, @Email, @Notes, @StartDate, @EndDate, @UserPermission, @CreateBy, Getdate())"
        SelectCommand="SELECT *,(FirstName + ' ' + LastName) Name FROM [Staff]"
        UpdateCommand="UPDATE [Staff] SET [FirstName] = @FirstName, [LastName] = @LastName, [Phone1] = @Phone1, [Email] = @Email, [Notes] = @Notes, [StartDate] = @StartDate, [EndDate] = @EndDate, [UserPermission] = @UserPermission, [UpdatedBy] = @UpdatedBy, [UpdatedDate] = Getdate() WHERE [StaffID] = @StaffID">
        <DeleteParameters>
            <asp:Parameter Name="StaffID" Type="Int32" />
        </DeleteParameters>
        <%--<InsertParameters>
            <asp:ControlParameter Name="FirstName" Type="String" ControlID="txtFirstName" PropertyName="Text" />
            <asp:ControlParameter Name="LastName" Type="String" ControlID="txtLastName" PropertyName="Text" />
            <asp:ControlParameter Name="Phone1" Type="String" ControlID="txtPhone" PropertyName="Text" />
            <asp:ControlParameter Name="Email" Type="String" ControlID="txtEmail" PropertyName="Text" />
            <asp:ControlParameter Name="Notes" Type="String" ControlID="txtNotes" PropertyName="Text" />
            <asp:ControlParameter Name="StartDate" Type="DateTime" ControlID="txtstartDT" PropertyName="Text" />
            <asp:ControlParameter Name="EndDate" Type="DateTime" ControlID="txtEndDT" PropertyName="Text" />
            <asp:ControlParameter Name="UserPermission" Type="String" ControlID="ddlPermission" PropertyName="SelectedValue" />
            <asp:SessionParameter Name="CreateBy" SessionField="UserID" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter Name="FirstName" Type="String" ControlID="txtFirstName" PropertyName="Text" />
            <asp:ControlParameter Name="LastName" Type="String" ControlID="txtLastName" PropertyName="Text" />
            <asp:ControlParameter Name="Phone1" Type="String" ControlID="txtPhone" PropertyName="Text" />
            <asp:ControlParameter Name="Email" Type="String" ControlID="txtEmail" PropertyName="Text" />
            <asp:ControlParameter Name="Notes" Type="String" ControlID="txtNotes" PropertyName="Text" />
            <asp:ControlParameter Name="StartDate" Type="DateTime" ControlID="txtstartDT" PropertyName="Text" />
            <asp:ControlParameter Name="EndDate" Type="DateTime" ControlID="txtEndDT" PropertyName="Text" />
            <asp:ControlParameter Name="UserPermission" Type="String" ControlID="ddlPermission" PropertyName="SelectedValue" />
            <asp:SessionParameter Name="UpdatedBy" SessionField="UserID" Type="Int32" />
            <asp:Parameter Name="StaffID" Type="Int32" />
        </UpdateParameters>--%>
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="Server">
</asp:Content>
