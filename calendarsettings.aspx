<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="calendarsettings.aspx.vb" Inherits="calendarsettings" %>

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
                    <li class="breadcrumb-item"><a href="/accounts">Account</a></li>
                    <li class="breadcrumb-item active">Calendar Settings</li>
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
                        <li class="nav-item"><a class="nav-link" href="/company">Company Details</a></li>
                        <li class="nav-item"><a class="nav-link" href="/currency">Currency</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">Resources</a></li>
                        <li class="nav-item"><a class="nav-link active" href="/calendarsettings">Calendar Settings</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">Online Booking Settings</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">Staff Notifications</a></li>
                    </ul>
                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane active" role="tabpanel">
                            <div class="card-body">
                                <div class="row company-form">
                                    <div class="col-md-12 col-12">
                                        <h4>Calendar Settings</h4>
                                        <p>Manage your calendar settings</p>
                                        <br />
                                    </div>

                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>APPOINTMENT COLORS</label>
                                            <asp:DropDownList ID="ddlappcolor" runat="server" CssClass="form-control" ClientIDMode="Static">
                                                <asp:ListItem Value="status">By booking status</asp:ListItem>
                                                <asp:ListItem Value="service_group">By service group</asp:ListItem>
                                                <asp:ListItem Value="employee">By staff booked</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ControlToValidate="ddlappcolor" SetFocusOnError="true" Display="Dynamic" ForeColor="Red"
                                                ValidationGroup="form" ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                        </div>
                                        <div class="form-group">
                                            <label>TIME SLOT INTERVAL</label>
                                            <asp:DropDownList ID="ddltimesinterval" runat="server" CssClass="form-control" ClientIDMode="Static">
                                                <asp:ListItem Value="5">5 Minutes</asp:ListItem>
                                                <asp:ListItem Value="10">10 Minutes</asp:ListItem>
                                                <asp:ListItem Value="15">15 Minutes</asp:ListItem>
                                                <asp:ListItem Value="30">30 Minutes</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ControlToValidate="ddltimesinterval" SetFocusOnError="true" Display="Dynamic" ForeColor="Red"
                                                ValidationGroup="form" ID="RequiredFieldValidator2" runat="server"
                                                ErrorMessage="*"></asp:RequiredFieldValidator>
                                        </div>
                                        <div class="form-group">
                                            <label>DEFAULT VIEW</label>
                                            <asp:DropDownList ID="ddldefview" runat="server" CssClass="form-control" ClientIDMode="Static">
                                                <asp:ListItem Value="Day">Day</asp:ListItem>
                                                <asp:ListItem Value="Week">Week</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ControlToValidate="ddldefview" SetFocusOnError="true" Display="Dynamic" ForeColor="Red"
                                                ValidationGroup="form" ID="RequiredFieldValidator3" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                        </div>
                                        <div class="form-group">
                                            <label>WEEK START DAY</label>
                                            <asp:DropDownList ID="ddlweekstart" runat="server" CssClass="form-control" ClientIDMode="Static">
                                                <asp:ListItem Value="Sunday">Sunday</asp:ListItem>
                                                <asp:ListItem Value="Monday">Monday</asp:ListItem>
                                                <asp:ListItem Value="Tuesday">Tuesday</asp:ListItem>
                                                <asp:ListItem Value="Wednesday">Wednesday</asp:ListItem>
                                                <asp:ListItem Value="Thursday">Thursday</asp:ListItem>
                                                <asp:ListItem Value="Friday">Friday</asp:ListItem>
                                                <asp:ListItem Value="Saturday">Saturday</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ControlToValidate="ddlweekstart" SetFocusOnError="true" Display="Dynamic" ForeColor="Red"
                                                ValidationGroup="form" ID="RequiredFieldValidator4" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                        </div>
                                        <div class="form-group">
                                            <asp:Button ID="btnsubmit" ValidationGroup="form" CssClass="btn btn-danger waves-effect waves-light save-category btnsubmit" runat="server" Text="Save Changes" ClientIDMode="Static" />
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

    <asp:HiddenField ID="hdncalendarsettingsid" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdnuserid" runat="server" ClientIDMode="Static" />

    <asp:SqlDataSource ID="sdscalendarsettings" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        DeleteCommand="DELETE FROM [CalendarSetting] WHERE [CalendarSettingID] = @CalendarSettingID"
        InsertCommand="INSERT INTO [CalendarSetting] ([AppointmentColor], [TimeSlotInterval], [DefaultView], [WeekStartDay], [CreatedBy], [CreatedAt]) VALUES (@AppointmentColor, @TimeSlotInterval, @DefaultView, @WeekStartDay, @CreatedBy, Getdate())"
        SelectCommand="SELECT * FROM [CalendarSetting]"
        UpdateCommand="UPDATE [CalendarSetting] SET [AppointmentColor] = @AppointmentColor, [TimeSlotInterval] = @TimeSlotInterval, [DefaultView] = @DefaultView, [WeekStartDay] = @WeekStartDay, [UpdatedBy] = @UpdatedBy, [UpdatedAt] = Getdate() WHERE [CalendarSettingID] = @CalendarSettingID">
        <DeleteParameters>
            <asp:Parameter Name="CalendarSettingID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="ddlappcolor" Name="AppointmentColor" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="ddltimesinterval" Name="TimeSlotInterval" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="ddldefview" Name="DefaultView" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="ddlweekstart" Name="WeekStartDay" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="hdnuserid" Name="CreatedBy" PropertyName="Value" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="ddlappcolor" Name="AppointmentColor" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="ddltimesinterval" Name="TimeSlotInterval" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="ddldefview" Name="DefaultView" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="ddlweekstart" Name="WeekStartDay" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="hdnuserid" Name="UpdatedBy" PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="hdncalendarsettingsid" Name="CalendarSettingID" PropertyName="Value" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>


</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="Server">
</asp:Content>

