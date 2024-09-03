<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" EnableEventValidation="false" CodeFile="ServiceGroups.aspx.vb" Inherits="ServiceGroups" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="toppart" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="Server">
    <!-- Container fluid  -->
    <!-- ============================================================== -->
    <div class="container-fluid">
        <!-- ============================================================== -->
        <!-- Bread crumb and right sidebar toggle -->
        <!-- ============================================================== -->
        <div class="row page-titles">
            <div class="col-md-5 align-self-center">
                <h3 class="text-themecolor">Groups</h3>
            </div>
            <div class="col-md-7 align-self-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
                    <li class="breadcrumb-item active">Groups</li>
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
                    <div class="tab-content">
                        <div class="tab-pane active" role="tabpanel">
                            <div class="card-body">
                                <div class="row">

                                    <div class="col-md-6 col-sm-6 col-12">
                                        <div class="form-group">
                                            <label>Search by Group Name</label>
                                            <asp:TextBox ID="txtSearch" CssClass="form-control " runat="server" ClientIDMode="Static"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-12">
                                        <div class="form-group">
                                            <label>&nbsp;</label>
                                            <div class="form-group">
                                                <asp:Button ID="btnSearch" class="btn btn-danger waves-effect btn-block waves-light btnsubmit" runat="server" Text="Search" />
                                            </div>
                                        </div>
                                    </div>
                                    <%-- <div class="col-md-2 col-sm-2 col-12">
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
                                            </div>--%>
                                    <div class="col-md-2 col-sm-2 col-12">
                                        <div class="form-group">
                                            <label>&nbsp;</label>
                                            <div class="form-group">
                                                <%--<button type="button" onclick="ClearID()" class="btn btn-info waves-effect btn-block waves-light" data-toggle="modal" data-target="#newgroupmodal">Add New</button>--%>
                                                <label id="lblbtnadd" runat="server">
                                                    <a id="btnadd" class="btn btn-info waves-effect btn-block waves-light fancySmall" href="ServiceGroups_popup.aspx" data-fancybox data-type="iframe" style="color: #fff">Add New</a>
                                                </label>
                                            </div>
                                        </div>
                                    </div>

                                </div>

                                <div class="row">
                                    <div class="col-lg-12 col-xlg-12 col-md-12 col-12">
                                        <asp:Label ID="lblmsg" runat="server" Font-Size="Medium" ForeColor="Red" ClientIDMode="Static"></asp:Label>
                                        <table class="table table-bordered table-striped">
                                            <thead>
                                                <tr>
                                                    <th>&nbsp;</th>
                                                    <th>Title </th>
                                                    <th>Arabic Title </th>
                                                    <th>Description </th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:ListView ID="lvGroup" runat="server" DataKeyNames="ServiceId">
                                                    <EmptyDataTemplate>
                                                        <table id="Table1" runat="server" style="">
                                                            <tr>
                                                                <td>Currently No Groups available.</td>
                                                            </tr>
                                                        </table>
                                                    </EmptyDataTemplate>

                                                    <ItemTemplate>
                                                        <tr style="">
                                                            <td>
                                                                <a href="ServiceGroups_popup.aspx?sgid=<%# Eval("ServiceId")%>" data-fancybox data-type="iframe" class="fancySmall">
                                                                    <%--<i class="fa fa-circle font-14 m-r-10 text-blue"></i>--%>
                                                                    <i class="fa fa-circle font-14 m-r-10 " style="color:<%# Eval("Color")%> "></i>
                                                                </a>
                                                            </td>
                                                            <td><a href="ServiceGroups_popup.aspx?sgid=<%# Eval("ServiceId")%>" data-fancybox data-type="iframe" class="fancySmall">
                                                                <asp:Label ID="lblTitle" runat="server" Text='<%# Eval("Title") %>' /></a>
                                                                <asp:HiddenField ID="hdServiceId" Visible="false" runat="server" Value='<%# Eval("ServiceId") %>' />
                                                            </td>
                                                            <td><a href="ServiceGroups_popup.aspx?sgid=<%# Eval("ServiceId")%>" data-fancybox data-type="iframe" class="fancySmall">
                                                                <asp:Label ID="lblArTitle" runat="server" Text='<%# Eval("ArTitle") %>' /></a>
                                                            </td>
                                                            <td><a href="ServiceGroups_popup.aspx?sgid=<%# Eval("ServiceId")%>" data-fancybox data-type="iframe" class="fancySmall">
                                                                <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description") %>' /></a>
                                                            </td>

                                                            <td>
                                                                <a href="ServiceGroups_popup.aspx?sgid=<%# Eval("ServiceId")%>" data-fancybox data-type="iframe" class="fancySmall">
                                                                    <img src="/images/icons/ic-edit.png" /></a>
                                                                |
                                                                    <a href="#" onclick='DeleteById(<%# Eval("ServiceId")%>)'>
                                                                        <img src="/images/icons/ic-delete.png" /></a>

                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>

                                                </asp:ListView>

                                            </tbody>

                                        </table>

                                        <h6 class="card-subtitle">Displaying <code class="bg-light-success">
                                            <asp:Label ID="lblStart" runat="server" Text=""></asp:Label>
                                            -
                                                <asp:Label ID="lblEnd" runat="server" Text=""></asp:Label>
                                            of
                                                <asp:Label ID="lblTotal" runat="server" Text=""></asp:Label>
                                            total </code></h6>

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

    <%--<div class="modal fade none-border newgroupmodal" id="newgroupmodal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="H1" runat="server">Add/Change Service Group                          
                    </h4>
                    <button onclick="ClearID()" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                </div>
                <div class="modal-body">
                    <form role="form">
                        <asp:Label ID="lblWarning" runat="server" Font-Size="Medium" ForeColor="Red" ClientIDMode="Static"></asp:Label>
                        <!-- Nav tabs -->
                        <ul class="nav nav-tabs profile-tab">
                            <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#es-DETAILS" role="tab">Details</a> </li>
                            <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#es-Arabic" role="tab">Arabic</a> </li>
                           <%-- <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#es-Media" role="tab">Media</a> </li>-%>
                        </ul>
                        <!-- Tab panes -->
                        <div class="tab-content">
                            <div class="tab-pane active" role="tabpanel" id="es-DETAILS">
                                <div class="row">
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <label class="control-label">GROUP NAME</label>
                                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="e.g. Hair Services" ClientIDMode="Static"></asp:TextBox>
                                            <span class="mand">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtName" SetFocusOnError="true"
                                                    Display="Dynamic" ValidationGroup="form" runat="server" Text="*" ErrorMessage="*"></asp:RequiredFieldValidator>
                                            </span>
                                        </div>

                                        <div class="form-group">
                                            <label class="control-label">GROUP Description</label>
                                            <asp:TextBox ID="txtDetails" TextMode="MultiLine" Rows="5" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>

                                        </div>

                                        <div class="form-group">
                                            <label class="control-label">Parent Group</label>
                                            <asp:DropDownList ID="ddlGroup" runat="server" ClientIDMode="Static" CssClass="form-control">
                                                <asp:ListItem Text="Select Service Group" Value="0"></asp:ListItem>
                                            </asp:DropDownList>

                                        </div>


                                        <div class="form-group">
                                            <div class="checkbox checkbox-success">
                                                <asp:CheckBox ID="chkPackage" TextAlign="Right" ClientIDMode="Static" Text="Is Package" runat="server" />
                                            </div>
                                        </div>

                                    </div>

                                    <%-- <div class="col-md-12 col-12">
                                            <div class="form-group">
                                                <label>
                                                    Appointment Color: 
                                    <span data-toggle="tooltip" data-placement="bottom" title="" data-original-title="See your Calendar Settings page under Setup to set how colors are displayed on the calendar" aria-describedby="">
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
                                        </div>-%>
                                </div>
                            </div>
                            <div class="tab-pane" role="tabpanel" id="es-Arabic">
                                <div class="row">
                                    <div class="col-md-12 col-12">

                                        <p>Arabic info for service Group</p>
                                        <br />
                                        <div class="form-group">
                                            <label class="control-label">GROUP NAME</label>
                                            <asp:TextBox ID="txtArName" runat="server" CssClass="form-control" placeholder="e.g. خدمات الشعر" ClientIDMode="Static"></asp:TextBox>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">GROUP Description</label>
                                            <asp:TextBox ID="txtArDetails" TextMode="MultiLine" Rows="5" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>

                                        </div>
                                    </div>
                                </div>
                            </div>

                            <%--<div class="tab-pane" role="tabpanel" id="es-Media">
                                <div class="row">
                                    <div class="col-md-12 col-12">
                                        <p>Media info for service Group</p>
                                        <div class="row">
                                            <div class="col-md-4 col-12">
                                                <div class="form-group">
                                                    <label>Big Image: </label>
                                                </div>
                                            </div>
                                            <div class="col-md-8 col-12">
                                                <div class="form-group">

                                                    <div class="upload-picture">
                                                        <div class="text-cemter image-holder">
                                                            <table id="tblEqWebImage" style="margin: 10px 0px 10px 10px; border: 1px solid #373737;">
                                                                <tbody>
                                                                </tbody>
                                                            </table>

                                                            <%Dim serviceid = hdServiceGroupId.Value
                                                                Dim hasimage = Utility.StringData("Select BigIconOne From Services Where ServiceId = " & serviceid & "")
                                                                If Not String.IsNullOrEmpty(hasimage) Then  %>
                                                            <asp:Image ID="imgSmallImage" runat="server" ClientIDMode="Static" />
                                                            <%Else %>
                                                            <img src="/images/avatar.png" width="100" alt="Upload Picture" />
                                                            <% End If %>

                                                            <div class="upload-wrapper" data-toggle="tooltip" data-placement="right" title="" data-original-title="upload picture here" aria-describedy="">
                                                                <div class="inner">
                                                                    <a href="javascript:;" class="file-upload-button"><span class="mdi mdi-upload"></span></a>
                                                                    <input id="fuImageFile" type="file" runat="server" />
                                                                    <asp:HiddenField ID="hdnImageUrl" runat="server" />
                                                                </div>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-4 col-12">
                                                <div class="form-group">
                                                    <label>Small Image: </label>
                                                </div>
                                            </div>
                                            <div class="col-md-8 col-12">
                                                <div class="form-group">

                                                    <div class="upload-picture">
                                                        <div class="text-cemter image-holder">
                                                            <%Dim serviceid1 = hdServiceGroupId.Value
                                                                Dim hasimage1 = Utility.StringData("Select SmallIconOne From Services Where ServiceId = " & serviceid1 & "")
                                                                If Not String.IsNullOrEmpty(hasimage1) Then  %>
                                                            <asp:Image ID="imgIcon" runat="server" ClientIDMode="Static" />
                                                            <%Else %>
                                                            <img src="/images/avatar.png" width="80" alt="Upload Picture" />
                                                            <% End If %>


                                                            <div class="upload-wrapper" data-toggle="tooltip" data-placement="right" title="" data-original-title="upload picture here" aria-describedy="">
                                                                <div class="inner">
                                                                    <a href="javascript:;" class="file-upload-button"><span class="mdi mdi-upload"></span></a>
                                                                    <asp:FileUpload ID="fuIcon" accept="image/*" onchange="loadFileIcon(event)" ClientIDMode="Static" runat="server" />
                                                                    <asp:HiddenField ID="hdnIconUrl" runat="server" />
                                                                </div>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>-%>

                            <asp:HiddenField ID="hdServiceGroupId" runat="server" ClientIDMode="Static" />
                        </div>
                    </form>
                </div>
                <div class="modal-footer">

                    <asp:Button ID="btnsubmit" ValidationGroup="form" CausesValidation="false" CssClass="btn btn-danger waves-effect waves-light btnsubmit"
                        runat="server" Text="Save" ClientIDMode="Static" />
                    <button type="button" onclick="ClearID()" class="btn btn-secondary waves-effect" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>--%>

    <!-- END MODAL -->

    <!-- ============================================================== -->
    <!-- End Container fluid  -->
    <!-- ============================================================== -->
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="Server">
    <script type="text/javascript">
        function DeleteById(x) {
            var ServiceId = x;
            if (confirm('Are you sure to delete?')) {
                $.ajax({
                    type: 'Post',
                    url: 'ServiceGroups.aspx/DeleteServiceById',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ ServiceId: ServiceId }),
                    dataType: "json",
                    success: onSuccess,
                    //    function (result) {
                    //    $.each(result,
                    //        function (key, value) {
                    //            window.location.reload();
                    //        });
                    //},
                    Error: onErrorCall

                });
            }
        }

        function onSuccess(response) {
            var result = response.d;
            if (result === "success") {
                $.each(response,
                        function (key, value) {
                            window.location.reload();
                        });
                $("#<%=lblmsg.ClientID %>").val("");
                $("#<%=lblmsg.ClientID %>").html("Successfully Deleted.").css("color", "green");
            }
            else if (result === "Exist") {
                $("#<%=lblmsg.ClientID %>").val("");
                $("#<%=lblmsg.ClientID %>").html("This Group is not Empty Service.").css("color", "red");
            }
    }
    function onErrorCall(response) {
        $("#<%=lblmsg.ClientID %>").val("");
        $("#<%=lblmsg.ClientID %>").html("An error occurred, please try again.").css("color", "red");
    }
    </script>
</asp:Content>

