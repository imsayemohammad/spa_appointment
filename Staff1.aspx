<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Staff1.aspx.vb" Inherits="Staff1" %>

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
                                        <asp:Label ID="lblmsg" runat="server"></asp:Label></strong>
                                    <div class="col-md-6 col-sm-6 col-12">
                                        <div class="form-group">
                                            <label>Search by name or mobile number</label>
                                            <input type="text" class="form-control" placeholder="" />
                                        </div>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-12">
                                        <div class="form-group">
                                            <label>&nbsp;</label>
                                            <div class="form-group">
                                                <button type="submit" class="btn btn-danger waves-effect btn-block waves-light">Search</button>
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
                                                <button type="button" class="btn btn-info waves-effect btn-block waves-light" data-toggle="modal" data-target="#staffmodal" data-backdrop="static" data-keyboard="false">Add New</button>
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
                                                                    <a href="#" data-toggle="modal" data-backdrop="static" data-keyboard="false" data-target="#staffmodal">
                                                                        <i class="fa fa-circle font-14 m-r-10 text-blue"></i>
                                                                    </a>
                                                                </td>
                                                                <td><a href="#" onclick='GetStaffById(<%# Eval("StaffID")%>)' data-toggle="modal" data-target="#staffmodal" data-backdrop="static" data-keyboard="false">
                                                                    <asp:Label ID="lblname" runat="server" Text='<%# Eval("Name") %>' /></a>

                                                                </td>
                                                                <td><a href="#" data-toggle="modal" data-target="#staffmodal" data-backdrop="static" data-keyboard="false">
                                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Phone1") %>' /></a>
                                                                </td>
                                                                <td><a href="#" data-toggle="modal" data-target="#staffmodal" data-backdrop="static" data-keyboard="false">
                                                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("Email") %>' /></a>
                                                                </td>
                                                                <td><a href="#" data-toggle="modal" data-target="#staffmodal" data-backdrop="static" data-keyboard="false">Calendar bookings enabled</a></td>
                                                                <td><a href="#" data-toggle="modal" data-target="#staffmodal" data-backdrop="static" data-keyboard="false">
                                                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("UserPermission") %>' /></a>
                                                                </td>
                                                            </tr>
                                                        </ItemTemplate>

                                                    </asp:ListView>

                                                </tbody>

                                            </table>


                                            <nav aria-label="Page navigation example" class="m-t-40">
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

    <div class="modal fade none-border staffmodal" id="staffmodal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Edit Staff                           
                    </h4>
                    <button type="button" onclick="ClearID()" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">
                    <form role="form">
                        <!-- Nav tabs -->
                        <ul class="nav nav-tabs profile-tab">
                            <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#s-DETAILS" role="tab">DETAILS</a> </li>
                            <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#s-LOCATIONS" role="tab">LOCATIONS</a> </li>
                            <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#s-SERVICES" role="tab">SERVICES</a> </li>
                            <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#s-COMMISSION" role="tab">COMMISSION</a></li>
                        </ul>
                        <!-- Tab panes -->
                        <div class="tab-content">
                            <div class="tab-pane active" role="tabpanel" id="s-DETAILS">
                                <div class="row">
                                    <div class="col-md-6 col-12">
                                        <div class="row">
                                            <div class="col-md-6 col-12">
                                                <div class="form-group">
                                                    <label class="control-label">First Name</label>
                                                    <asp:TextBox ID="txtFirstName" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ControlToValidate="txtFirstName" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator9" runat="server"
                                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-12">
                                                <div class="form-group">
                                                    <label class="control-label">Last Name</label>
                                                    <asp:TextBox ID="txtLastName" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ControlToValidate="txtLastName" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1" runat="server"
                                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>
                                            <div class="col-md-12 col-12">
                                                <div class="form-group">
                                                    <label class="control-label">Mobile Number</label>
                                                    <div class="input-group">
                                                        <div class="input-group-btn">
                                                            <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                <i class="flag-icon flag-icon-ae m-r-10" title="ae" id="ae"></i>
                                                            </button>
                                                            <div class="dropdown-menu" x-placement="bottom-start" style="position: absolute; transform: translate3d(0px, 38px, 0px); top: 0px; left: 0px; will-change: transform;">
                                                                <a class="dropdown-item" href="#">
                                                                    <i class="flag-icon flag-icon-ae m-r-10" title="ae" id="ae"></i>
                                                                    United Arab Emirates +971
                                                                </a>
                                                                <a class="dropdown-item" href="#">
                                                                    <i class="flag-icon flag-icon-us m-r-10" title="ae" id="ae"></i>
                                                                    United States +1
                                                                </a>
                                                                <a class="dropdown-item" href="#">
                                                                    <i class="flag-icon flag-icon-gb m-r-10" title="ae" id="ae"></i>
                                                                    United Kingdom +2
                                                                </a>
                                                            </div>
                                                        </div>
                                                        <asp:TextBox ID="txtPhone" CssClass="form-control" runat="server" placeholder="+971 00 123 4567" ClientIDMode="Static"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ControlToValidate="txtPhone" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator2" runat="server"
                                                            ErrorMessage="*"></asp:RequiredFieldValidator>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" Display="Dynamic" runat="server" ControlToValidate="txtPhone"
                                                            ErrorMessage="* invalid" ValidationGroup="form" ForeColor="Red" ValidationExpression="^([0-9]\d*)$" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-12 col-12">
                                                <div class="form-group">
                                                    <label class="control-label">Email</label>
                                                    <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ControlToValidate="txtEmail" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator3" runat="server"
                                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" Display="Dynamic" runat="server" ErrorMessage="* invalid" ValidationGroup="form"
                                                        ControlToValidate="txtEmail" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                                </div>
                                            </div>
                                            <div class="col-md-12 col-12">
                                                <div class="form-group">
                                                    <label class="control-label">
                                                        User Permission
                                                                	<span data-toggle="tooltip" data-placement="bottom" title=""
                                                                        data-original-title="When saved, this staff member will receive email instructions to setup their own login password" aria-describedby="">
                                                                        <i class="ti-help-alt text-danger"></i>
                                                                    </span>
                                                    </label>
                                                    <asp:DropDownList ID="ddlPermission" runat="server" CssClass="form-control custom-select" data-placeholder="Choose staff" ClientIDMode="Static">
                                                        <asp:ListItem Value="Low">Low</asp:ListItem>
                                                        <asp:ListItem Value="No Access">No Access</asp:ListItem>
                                                        <asp:ListItem Value="Medium">Medium</asp:ListItem>
                                                        <asp:ListItem Value="High">High</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>

                                            <div class="col-md-12 col-12">
                                                <div class="form-group">

                                                    <div class="switch">
                                                        <label>
                                                            <input type="checkbox" checked="" />
                                                            <%--<asp:CheckBox ID="chkstatus" runat="server" type="checkbox" ClientIDMode="Static"/>--%>
                                                            <span class="lever"></span>Enable Appointment Bookings
                                                                        <span data-toggle="tooltip" data-placement="bottom" title=""
                                                                            data-original-title="Allows this staff member to perform client bookings on the calendar, switch off for admin staff such as receptionist" aria-describedby="">
                                                                            <i class="ti-help-alt text-danger"></i>
                                                                        </span>
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="col-md-6 col-12">
                                        <div class="row">
                                            <div class="col-md-12 col-12">
                                                <div class="form-group">
                                                    <label class="control-label">Notes</label>
                                                    <asp:TextBox ID="txtNotes" CssClass="form-control" TextMode="MultiLine" Rows="5" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-12">
                                                <div class="form-group">
                                                    <label>Employment Start Date: </label>
                                                    <div class="input-group">
                                                        <asp:TextBox ID="txtstartDT" runat="server" CssClass="form-control mydatepicker" placeholder="mm/dd/yyyy" ClientIDMode="Static"></asp:TextBox>
                                                        <span class="input-group-addon"><i class="icon-calender"></i></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-12">
                                                <div class="form-group">
                                                    <label>Employment End Date: </label>
                                                    <div class="input-group">
                                                        <asp:TextBox ID="txtEndDT" runat="server" CssClass="form-control mydatepicker" placeholder="mm/dd/yyyy" ClientIDMode="Static"></asp:TextBox>
                                                        <span class="input-group-addon"><i class="icon-calender"></i></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-12 col-12">
                                                <div class="form-group">
                                                    <label>
                                                        Appointment Color: 
                                                       <span data-toggle="tooltip" data-placement="bottom" title=""
                                                           data-original-title="See your Calendar Settings page under Setup to set how colors are displayed on the calendar" aria-describedby="">
                                                           <i class="ti-help-alt text-danger"></i>
                                                       </span>

                                                    </label>
                                                    <div class="appnt-color">
                                                        <div class="pink">
                                                            <input name="group1" type="radio" class="with-gap" id="radio_1">
                                                            <label for="radio_1"></label>
                                                        </div>
                                                        <div class="purple">
                                                            <input name="group1" type="radio" class="with-gap" id="radio_2">
                                                            <label for="radio_2"></label>
                                                        </div>
                                                        <div class="indigo">
                                                            <input name="group1" type="radio" class="with-gap" id="radio_3">
                                                            <label for="radio_3"></label>
                                                        </div>
                                                        <div class="blue">
                                                            <input name="group1" type="radio" class="with-gap" id="radio_4">
                                                            <label for="radio_4"></label>
                                                        </div>
                                                        <div class="cyan">
                                                            <input name="group1" type="radio" class="with-gap" id="radio_5">
                                                            <label for="radio_5"></label>
                                                        </div>
                                                        <div class="teal">
                                                            <input name="group1" type="radio" class="with-gap" id="radio_6">
                                                            <label for="radio_6"></label>
                                                        </div>
                                                        <div class="green">
                                                            <input name="group1" type="radio" class="with-gap" id="radio_7">
                                                            <label for="radio_7"></label>
                                                        </div>
                                                        <div class="lime">
                                                            <input name="group1" type="radio" class="with-gap" id="radio_8">
                                                            <label for="radio_8"></label>
                                                        </div>
                                                        <div class="yellow">
                                                            <input name="group1" type="radio" class="with-gap" id="radio_9">
                                                            <label for="radio_9"></label>
                                                        </div>
                                                        <div class="orange">
                                                            <input name="group1" type="radio" class="with-gap" id="radio_10">
                                                            <label for="radio_10"></label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane" role="tabpanel" id="s-LOCATIONS">
                                <div class="row">
                                    <div class="col-md-12 col-12">
                                        <p>Assign locations where this staff member can be booked.</p>
                                        <br />

                                        <div class="form-group">
                                            <asp:CheckBoxList ID="ChkLocation" runat="server" ClientIDMode="Static" RepeatDirection="Vertical" CssClass="checkbox checkbox-success" DataSourceID="sdsLocation" DataTextField="LocationName" DataValueField="LocationID"></asp:CheckBoxList>

                                            <asp:SqlDataSource ID="sdsLocation" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                                                SelectCommand="Select 0 [LocationID],'All Locations' [LocationName] UNION Select [LocationID], [LocationName] from Location WHERE [Status]=1  ORDER BY LocationID ASC"></asp:SqlDataSource>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane" role="tabpanel" id="s-SERVICES">
                                <div class="row">
                                    <div class="col-md-12 col-12">

                                        <p>Assign services this staff member can perform.</p>
                                        <br>

                                        <div class="row">
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service1" type="checkbox">
                                                        <label for="service1">All </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service2" type="checkbox">
                                                        <label for="service2">Delay Charge </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service3" type="checkbox">
                                                        <label for="service3">Removal or Soak Off (without Manicure) </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service4" type="checkbox">
                                                        <label for="service4">Transportation Charges </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service5" type="checkbox">
                                                        <label for="service5">Delay Charge </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service6" type="checkbox">
                                                        <label for="service6">Removal or Soak Off (without Manicure) </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service7" type="checkbox">
                                                        <label for="service7">Transportation Charges </label>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service8" type="checkbox">
                                                        <label for="service8">Delay Charge </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service9" type="checkbox">
                                                        <label for="service9">Removal or Soak Off (without Manicure) </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service10" type="checkbox">
                                                        <label for="service10">Transportation Charges </label>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service11" type="checkbox">
                                                        <label for="service11">Delay Charge </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service12" type="checkbox">
                                                        <label for="service12">Removal or Soak Off (without Manicure) </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service13" type="checkbox">
                                                        <label for="service13">Transportation Charges </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service14" type="checkbox">
                                                        <label for="service14">Delay Charge </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service15" type="checkbox">
                                                        <label for="service15">Removal or Soak Off (without Manicure) </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service16" type="checkbox">
                                                        <label for="service16">Transportation Charges </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service17" type="checkbox">
                                                        <label for="service17">Transportation Charges </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service18" type="checkbox">
                                                        <label for="service18">Delay Charge </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service15" type="checkbox">
                                                        <label for="service15">Removal or Soak Off (without Manicure) </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service16" type="checkbox">
                                                        <label for="service16">Transportation Charges </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service17" type="checkbox">
                                                        <label for="service17">Transportation Charges </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service18" type="checkbox">
                                                        <label for="service18">Delay Charge </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service15" type="checkbox">
                                                        <label for="service15">Removal or Soak Off (without Manicure) </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service16" type="checkbox">
                                                        <label for="service16">Transportation Charges </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service17" type="checkbox">
                                                        <label for="service17">Transportation Charges </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service18" type="checkbox">
                                                        <label for="service18">Delay Charge </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service15" type="checkbox">
                                                        <label for="service15">Removal or Soak Off (without Manicure) </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service16" type="checkbox">
                                                        <label for="service16">Transportation Charges </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service17" type="checkbox">
                                                        <label for="service17">Transportation Charges </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service18" type="checkbox">
                                                        <label for="service18">Delay Charge </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service15" type="checkbox">
                                                        <label for="service15">Removal or Soak Off (without Manicure) </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service16" type="checkbox">
                                                        <label for="service16">Transportation Charges </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service17" type="checkbox">
                                                        <label for="service17">Transportation Charges </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service18" type="checkbox">
                                                        <label for="service18">Delay Charge </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service15" type="checkbox">
                                                        <label for="service15">Removal or Soak Off (without Manicure) </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service16" type="checkbox">
                                                        <label for="service16">Transportation Charges </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service17" type="checkbox">
                                                        <label for="service17">Transportation Charges </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service18" type="checkbox">
                                                        <label for="service18">Delay Charge </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service15" type="checkbox">
                                                        <label for="service15">Removal or Soak Off (without Manicure) </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service16" type="checkbox">
                                                        <label for="service16">Transportation Charges </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service17" type="checkbox">
                                                        <label for="service17">Transportation Charges </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service18" type="checkbox">
                                                        <label for="service18">Delay Charge </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service15" type="checkbox">
                                                        <label for="service15">Removal or Soak Off (without Manicure) </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service16" type="checkbox">
                                                        <label for="service16">Transportation Charges </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service17" type="checkbox">
                                                        <label for="service17">Transportation Charges </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service18" type="checkbox">
                                                        <label for="service18">Delay Charge </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service15" type="checkbox">
                                                        <label for="service15">Removal or Soak Off (without Manicure) </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service16" type="checkbox">
                                                        <label for="service16">Transportation Charges </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service17" type="checkbox">
                                                        <label for="service17">Transportation Charges </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service18" type="checkbox">
                                                        <label for="service18">Delay Charge </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service15" type="checkbox">
                                                        <label for="service15">Removal or Soak Off (without Manicure) </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service16" type="checkbox">
                                                        <label for="service16">Transportation Charges </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service17" type="checkbox">
                                                        <label for="service17">Transportation Charges </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="service18" type="checkbox">
                                                        <label for="service18">Delay Charge </label>
                                                    </div>
                                                </div>
                                            </div>


                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane" role="tabpanel" id="s-COMMISSION">
                                <div class="row">
                                    <div class="col-md-4 col-12">
                                        <div class="form-group">
                                            <label class="control-label">Service Commission</label>
                                            <div class="input-group">
                                                <span class="input-group-addon" id="basic-addon1">%</span>
                                                <input type="text" class="form-control" placeholder="Username" aria-describedby="basic-addon1">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4 col-12">
                                        <div class="form-group">
                                            <label class="control-label">Product Commission</label>
                                            <div class="input-group">
                                                <span class="input-group-addon" id="basic-addon1">%</span>
                                                <input type="text" class="form-control" placeholder="Username" aria-describedby="basic-addon1">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4 col-12">
                                        <div class="form-group">
                                            <label class="control-label">Voucher Sales Commission</label>
                                            <div class="input-group">
                                                <span class="input-group-addon" id="basic-addon1">%</span>
                                                <input type="text" class="form-control" placeholder="Username" aria-describedby="basic-addon1">
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-inverse">Delete</button>
                    <button type="button" class="btn btn-secondary waves-effect">Resend password setup email</button>
                    <%--<button id="btnsubmit" type="button" class="btn btn-danger waves-effect waves-light save-category" data-dismiss="modal">Save</button>--%>
                    <asp:Button ID="btnsubmit" ValidationGroup="form" CssClass="btn btn-danger waves-effect waves-light save-category btnsubmit"
                        runat="server" Text="Save" ClientIDMode="Static" />
                    <button type="button" onclick="ClearID()" class="btn btn-secondary waves-effect" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <!-- END MODAL -->

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
        <InsertParameters>
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
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="Server">

    <script type="text/javascript">
        $('#btnsubmit').click(function () {
            var staffid = $("#<%= hdnStaffid.ClientID%>").val();
            var FirstName = $("#<%= txtFirstName.ClientID%>").val();
            var LastName = $("#<%= txtLastName.ClientID%>").val();
            var Phone = $("#<%= txtPhone.ClientID%>").val();
            var Email = $("#<%= txtEmail.ClientID%>").val();
            var Notes = $("#<%= txtNotes.ClientID%>").val();
            var StartDate = $("#<%= txtstartDT.ClientID%>").val();
            var EndDate = $("#<%= txtEndDT.ClientID%>").val();
            var Permission = $("#<%= ddlPermission.ClientID%>").val();
            //var Permission = "1";
            if (FirstName !== "") {
                $.ajax({
                    url: 'Staff.aspx/SaveData',
                    type: 'POST',
                    cache: false,
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ staffid: staffid, FirstName: FirstName, LastName: LastName, Phone: Phone, Email: Email, Notes: Notes, StartDate: StartDate, EndDate: EndDate, Permission: Permission }),
                    dataType: "json",
                    success: function (data) {

                        $("#<%= hdnStaffid.ClientID%>").val("");
                        $("#<%= txtFirstName.ClientID%>").val("");
                        $("#<%= txtLastName.ClientID%>").val("");
                        $("#<%= txtPhone.ClientID%>").val("");
                        $("#<%= txtEmail.ClientID%>").val("");
                        $("#<%= txtNotes.ClientID%>").val("");
                        $("#<%= txtstartDT.ClientID%>").val("");
                        $("#<%= txtEndDT.ClientID%>").val("");
                        $("#<%= ddlPermission.ClientID%>").val("");

                        window.location.reload();
                    }
                });
            } else {
                //alert("work");
            }


        });

        function GetStaffById(x) {
            var StaffId = x;
            //alert(StaffId);
            $.ajax({
                type: 'Post',
                url: 'Staff.aspx/StaffByStaffId',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ StaffId: StaffId }),
                dataType: "json",
                success: function (result) {
                    $.each(result,
                        function (key, value) {
                            document.getElementById('hdnStaffid').value = value.StaffId;
                            document.getElementById('txtFirstName').value = value.FirstName;
                            document.getElementById('txtLastName').value = value.LastName;
                            document.getElementById('txtPhone').value = value.Phone;
                            document.getElementById('txtEmail').value = value.Email;
                            document.getElementById('txtNotes').value = value.Notes;
                            //document.getElementById('txtstartDT').value = value.StartDate;
                            $("#txtstartDT").val(value.StartDate);
                            document.getElementById('txtEndDT').value = value.EndDate;
                            document.getElementById('ddlPermission').value = value.Permission;
                            // console.log(value.CategoryName);
                            // console.log(value.CategoryID);
                        });
                }

            });
        }

        function ClearID() {

            document.getElementById('hdnStaffid').value = "";
            document.getElementById('txtFirstName').value = "";
            document.getElementById('txtLastName').value = "";
            document.getElementById('txtPhone').value = "";
            document.getElementById('txtEmail').value = "";
            document.getElementById('txtNotes').value = "";
            document.getElementById('txtstartDT').value = "";
            document.getElementById('txtEndDT').value = "";
            document.getElementById('ddlPermission').value = "";

            $("#<%= RequiredFieldValidator1.ClientID%>").val("");
            $("#<%= RequiredFieldValidator2.ClientID%>").val("");
            $("#<%= RequiredFieldValidator3.ClientID%>").val("");
            $("#<%= RequiredFieldValidator9.ClientID%>").val("");
        }

    </script>

</asp:Content>

