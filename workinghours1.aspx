<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="workinghours1.aspx.vb" Inherits="workinghours1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="toppart" runat="Server">
    <!-- ============================================================== -->
    <!-- Container fluid  -->
    <!-- ============================================================== -->
    <div class="container-fluid">
        <!-- ============================================================== -->
        <!-- Bread crumb and right sidebar toggle -->
        <!-- ============================================================== -->
        <div class="row page-titles">
            <div class="col-md-5 align-self-center">
                <h3 class="text-themecolor">Working Hours</h3>
            </div>
            <div class="col-md-7 align-self-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
                    <li class="breadcrumb-item active">Working Hours</li>
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
                        <li class="nav-item"><a class="nav-link active" href="/workinghours">WORKING HOURS</a> </li>
                        <li class="nav-item"><a class="nav-link" href="/ClosedDates">CLOSED DATES</a> </li>
                        <li class="nav-item"><a class="nav-link" href="/staff">STAFF MEMBERS</a> </li>
                        <li class="nav-item"><a class="nav-link" href="/permissionlevels">PERMISSION LEVELS</a></li>
                    </ul>
                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane active" role="tabpanel">
                            <div class="card-body">
                                <div class="row">

                                    <div class="col-md-3 col-sm-3 col-12">
                                        <div class="form-group">
                                            <label>All Locations: </label>
                                            <asp:DropDownList ID="ddllocations" CssClass="form-control custom-select" data-placeholder="Choose location" ClientIDMode="Static" runat="server"
                                                DataSourceID="sdsddllocations" DataTextField="LocationName" DataValueField="LocationID">
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="sdsddllocations" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                                                SelectCommand="Select 0 [LocationID],'All Locations' [LocationName] UNION Select [LocationID], [LocationName] from Location WHERE [Status]=1  ORDER BY LocationID ASC"></asp:SqlDataSource>
                                        </div>
                                    </div>
                                    <div class="col-md-3 col-sm-3 col-12">
                                        <div class="form-group">
                                            <label>Date: </label>
                                            <div class="input-group">
                                                <asp:TextBox ID="txtsearchdate" CssClass="form-control mydatepicker" runat="server" placeholder="mm/dd/yyyy" ClientIDMode="Static"></asp:TextBox>
                                                <span class="input-group-addon"><i class="icon-calender"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3 col-sm-3 col-12">
                                        <div class="form-group">
                                            <label>Staff</label>
                                            <asp:DropDownList ID="ddlStaff" CssClass="form-control custom-select" AutoPostBack="True" data-placeholder="Choose staff" ClientIDMode="Static" runat="server"
                                                DataSourceID="SqlddlStaff" DataTextField="Name" DataValueField="StaffID">
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="SqlddlStaff" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                                                SelectCommand="Select 0 StaffID,'All Staff' Name UNION SELECT StaffID, (FirstName + ' ' + LastName) Name FROM Staff group by StaffID, FirstName, LastName"></asp:SqlDataSource>
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


                            </div>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-body">

                        <div class="row">
                            <div class="col-lg-12 col-xlg-12 col-md-12 col-12">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-striped slotTBL">
                                        <thead>
                                            <tr>
                                                <th><a href="#">Change Staff</a></th>
                                                <th width="120">
                                                    <asp:Label ID="Label1" runat="server" />
                                                    <asp:HiddenField ID="HiddenField1" runat="server" ClientIDMode="Static" />
                                                </th>
                                                <th width="120">
                                                    <asp:Label ID="Label2" runat="server" />
                                                    <asp:HiddenField ID="HiddenField2" runat="server" ClientIDMode="Static" />
                                                </th>
                                                <th width="120">
                                                    <asp:Label ID="Label3" runat="server" />
                                                    <asp:HiddenField ID="HiddenField3" runat="server" ClientIDMode="Static" />
                                                </th>
                                                <th width="120">
                                                    <asp:Label ID="Label4" runat="server" />
                                                    <asp:HiddenField ID="HiddenField4" runat="server" ClientIDMode="Static" />
                                                </th>
                                                <th width="120">
                                                    <asp:Label ID="Label5" runat="server" />
                                                    <asp:HiddenField ID="HiddenField5" runat="server" ClientIDMode="Static" />
                                                </th>
                                                <th width="120">
                                                    <asp:Label ID="Label6" runat="server" />
                                                    <asp:HiddenField ID="HiddenField6" runat="server" ClientIDMode="Static" />
                                                </th>
                                                <th width="120">
                                                    <asp:Label ID="Label7" runat="server" />
                                                    <asp:HiddenField ID="HiddenField7" runat="server" ClientIDMode="Static" />
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>

                                            <asp:Literal ID="ltlWHList" runat="server"></asp:Literal>

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



<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="Server">

    <div class="modal fade none-border slotmodal" id="slotmodal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Edit or Add Hours<br />
                        <small>
                            <asp:Label ID="lbltoday" runat="server" ClientIDMode="Static"></asp:Label></small>
                    </h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">
                    <form role="form">
                        <div class="row">
                            <div class="col-md-6 col-xs-12">
                                <div class="form-group">
                                    <label class="control-label">SHIFT START</label>
                                    <asp:DropDownList ID="ddlshiftstart" CssClass="form-control form-white" ClientIDMode="Static" runat="server"
                                        DataSourceID="sdsddlshiftstart" DataTextField="TimeShift">
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="sdsddlshiftstart" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                                        SelectCommand="SELECT TimeShift FROM WorkingHours Order By TimeShift ASC"></asp:SqlDataSource>
                                    <asp:RequiredFieldValidator ControlToValidate="ddlshiftstart" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1" runat="server"
                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-6 col-xs-12">
                                <div class="form-group">
                                    <label class="control-label">SHIFT END</label>
                                    <asp:DropDownList ID="ddlshiftend" CssClass="form-control form-white" ClientIDMode="Static" runat="server"
                                        DataSourceID="sdsddlshiftend" DataTextField="TimeShift">
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="sdsddlshiftend" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                                        SelectCommand="SELECT TimeShift FROM WorkingHours Order By TimeShift ASC"></asp:SqlDataSource>
                                    <asp:RequiredFieldValidator ControlToValidate="ddlshiftend" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator3" runat="server"
                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <%--<div class="col-md-12 col-xs-12">
                                <div class="form-group">
                                    <button type="button" class="btn btn-secondary">Add another shift</button>
                                </div>
                            </div>--%>
                            <div class="col-md-12 col-xs-12">
                                <div class="form-group">
                                    <label class="control-label">REPEATS</label>
                                    <asp:DropDownList ID="ddlrepeats" CssClass="form-control form-white" ClientIDMode="Static" runat="server">
                                        <asp:ListItem>Don't repeat</asp:ListItem>
                                        <asp:ListItem>Weekly</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-inverse">Delete</button>
                    <%--<button type="button" class="btn btn-danger waves-effect waves-light save-category" data-dismiss="modal">Save</button>--%>
                    <asp:Button ID="btnsubmit" ValidationGroup="form" CssClass="btn btn-danger waves-effect waves-light btnsubmit"
                        runat="server" Text="Save" ClientIDMode="Static" />
                    <button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <!-- END MODAL -->


    <asp:SqlDataSource ID="sdsworkinghours" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        DeleteCommand="DELETE FROM [StaffWorkingHours] WHERE [StaffWorkingHoursId] = @StaffWorkingHoursId"
        InsertCommand="INSERT INTO [StaffWorkingHours] ([StaffID], [StartTime], [EndTime], [Day], [Repeats], [CreatedBy], [CreatedAt]) VALUES (@StaffID, @StartTime, @EndTime, @Day, @Repeats, @CreatedBy, Getdate())"
        SelectCommand="SELECT StaffWorkingHoursId, s.StaffID, (FirstName + ' ' + LastName) Name, Format(StartTime,'hh:mm tt') StartTime, Format(EndTime,'hh:mm tt') EndTime, Day, Repeats FROM [StaffWorkingHours] swh Inner Join Staff s On swh.StaffID = s.StaffID"
        UpdateCommand="UPDATE [StaffWorkingHours] SET [StaffID] = @StaffID, [StartTime] = @StartTime, [EndTime] = @EndTime, [Day] = @Day, [Repeats] = @Repeats, [UpdatedBy] = @UpdatedBy, [UpdatedAt] = Getdate() WHERE [StaffWorkingHoursId] = @StaffWorkingHoursId">
        <DeleteParameters>
            <asp:Parameter Name="StaffWorkingHoursId" Type="Int64" />
        </DeleteParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="ddlStaff" Name="StaffID" PropertyName="SelectedValue" Type="Int64" />
            <asp:ControlParameter ControlID="ddlshiftstart" Name="StartTime" PropertyName="SelectedValue" Type="DateTime" />
            <asp:ControlParameter ControlID="ddlshiftend" Name="EndTime" PropertyName="SelectedValue" Type="DateTime" />
            <asp:ControlParameter ControlID="hdnday" Name="Day" PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="ddlrepeats" Name="Repeats" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="hdnuserid" Name="CreatedBy" PropertyName="Value" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="ddlStaff" Name="StaffID" PropertyName="SelectedValue" Type="Int64" />
            <asp:ControlParameter ControlID="ddlshiftstart" Name="StartTime" PropertyName="SelectedValue" Type="DateTime" />
            <asp:ControlParameter ControlID="ddlshiftend" Name="EndTime" PropertyName="SelectedValue" Type="DateTime" />
            <asp:ControlParameter ControlID="hdnday" Name="Day" PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="ddlrepeats" Name="Repeats" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="hdnuserid" Name="UpdatedBy" PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="hdnWorkingHoursId" Name="StaffWorkingHoursId" PropertyName="Value" Type="Int64" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:HiddenField ID="hdnWorkingHoursId" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdnuserid" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdnday" runat="server" ClientIDMode="Static" />
    <%--<asp:Label ID="lblday" runat="server" ClientIDMode="Static" Visible="False"></asp:Label>--%>
    <!-- ============================================================== -->
    <!-- End Container fluid  -->
    <!-- ============================================================== -->
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="Server">
    <script type="text/javascript">
        function openModalWithDate(hiddenFieldId) {
            var date = "";
            //var date = $("#" + hiddenFieldId).text();
            date = hiddenFieldId;
            //alert(date);
            $("#<%=lbltoday.ClientID %>").val(date);
            $("#<%=lbltoday.ClientID %>").text(date);
        }

        $('#btnsubmit').click(function () {
            var whid = $("#<%= hdnWorkingHoursId.ClientID%>").val();
            var staffid = $("#<%= ddlStaff.ClientID%>").val();
            var shiftstart = $("#<%= ddlshiftstart.ClientID%>").val();
            var shiftend = $("#<%= ddlshiftend.ClientID%>").val();
            var day = $("#<%= lbltoday.ClientID%>").val();
            var repeats = $("#<%= ddlrepeats.ClientID%>").val();

            if (shiftstart < shiftend) {
                if (staffid !== "") {
                    $.ajax({
                        url: 'workinghours.aspx/SaveData',
                        type: 'POST',
                        cache: false,
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify({ whid: whid, staffid: staffid, shiftstart: shiftstart, shiftend: shiftend, day: day, repeats: repeats }),
                        dataType: "json",
                        success: function (data) {

                            $("#<%= hdnWorkingHoursId.ClientID%>").val("");
                            $("#<%= ddlStaff.ClientID%>").val("0");
                            $("#<%= ddlshiftstart.ClientID%>").val("");
                            $("#<%= ddlshiftend.ClientID%>").val("");
                            $("#<%= hdnday.ClientID%>").val("");
                            $("#<%= ddlrepeats.ClientID%>").val("");
                            window.location.reload();
                        }
                    });
                }

                else {
                    //alert("work");
                }
            }

            else {
                alert("Start Shift must be greater than End Shift");
            }
        });


        function GetDataById(x) {
            var whid = x;
            //alert(closeddatesid);
            $.ajax({
                type: 'Post',
                url: 'workinghours.aspx/GetData',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ whid: whid }),
                dataType: "json",
                success: function (result) {
                    $.each(result,
                        function (key, value) {
                            document.getElementById('hdnWorkingHoursId').value = value.whid;
                            $("#<%=ddlStaff.ClientID %>").val(value.staffid);
                            $("#<%=ddlshiftstart.ClientID %>").val(value.shiftstart);
                            $("#<%=ddlshiftend.ClientID %>").val(value.shiftend);
                            document.getElementById('hdnday').value = value.day;
                            $("#<%=ddlrepeats.ClientID %>").val(value.repeats);

                        });
                }
            });
            }

            function ClearData() {

                $("#<%= hdnWorkingHoursId.ClientID%>").val("");
                $("#<%= ddlStaff.ClientID%>").val("0");
                $("#<%= ddlshiftstart.ClientID%>").val("");
                $("#<%= ddlshiftend.ClientID%>").val("");
                $("#<%= hdnday.ClientID%>").val("");
                $("#<%= ddlrepeats.ClientID%>").val("");
            }

    </script>
</asp:Content>

