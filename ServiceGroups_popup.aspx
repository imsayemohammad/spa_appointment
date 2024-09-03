<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ServiceGroups_popup.aspx.vb" Inherits="ServiceGroups_popup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">
    <title>The Home Spa</title>

    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800' rel='stylesheet' type='text/css' />
    <meta charset="utf-8" />
    <meta name="description" content="Home Spa" />
    <meta name="keywords" content="Home Spa" />
    <!-- Device View -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- Bootstrap Core CSS -->
    <link href="/assets/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/assets/plugins/bootstrap-datepicker/bootstrap-datepicker.min.css" rel="stylesheet" type="text/css" />
    <link href="/assets/plugins/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet" />

    <link href="/assets/plugins/perfect-scrollbar/css/perfect-scrollbar.css" rel="stylesheet" />
    <!-- This page CSS -->
    <!-- chartist CSS -->
    <link href="/assets/plugins/chartist-js/dist/chartist.min.css" rel="stylesheet" />
    <link href="/assets/plugins/chartist-plugin-tooltip-master/dist/chartist-plugin-tooltip.css" rel="stylesheet" />
    <!--c3 CSS -->
    <link href="/assets/plugins/c3-master/c3.min.css" rel="stylesheet" />
    <!--Toaster Popup message CSS -->
    <link href="/assets/plugins/toast-master/css/jquery.toast.css" rel="stylesheet" />
    <!--fancy box-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/3.4.1/jquery.fancybox.min.css" />

    <!-- Custom CSS -->
    <link href="/css/style.css" rel="stylesheet" />
    <!-- Dashboard 1 Page CSS -->
    <link href="/css/pages/dashboard1.css" rel="stylesheet" />
    <!-- You can change the theme colors from here -->
    <link href="/css/colors/default-dark.css" id="theme" rel="stylesheet" />
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->

    <!--[if lt IE 9]>
    <script src="http://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="http://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->

    <style type="text/css">
        input[type="checkbox"] {
            margin-right: 22px;
        }

        .myGroupCheckBox {
            list-style: none;
            width: 700px;
        }

            .myGroupCheckBox li {
                display: inline;
                width: 250px;
            }
    </style>
</head>
<body class="iframeBG">
    <form id="form13" runat="server">
        <div class="addeditclientmodal">
            <div>
                <div>
                    <div class="modal-header">
                        <h4 class="modal-title" id="H1" runat="server">Add/Change Service Group                          
                        </h4>
                        <button type="button" onclick="ClearID();" class="close closebtn">&times;</button>
                    </div>

                    <div class="modal-body">
                        <form role="form">
                            <asp:Label ID="lblWarning" runat="server" Font-Size="Medium" ForeColor="Red" ClientIDMode="Static"></asp:Label>
                            <!-- Nav tabs -->
                            <ul class="nav nav-tabs profile-tab">
                                <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#es-DETAILS" role="tab">Details</a> </li>
                                <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#es-Arabic" role="tab">Arabic</a> </li>
                                <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#es-Media" role="tab">Media</a> </li>
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

                                        <div class="col-md-12 col-12">
                                            <div class="form-group">
                                            <label>
                                                Appointment Color: 
                                                <span data-toggle="tooltip" data-placement="bottom" title="" data-original-title="See your Calendar Settings page under Setup to set how colors are displayed on the calendar" aria-describedby="">
                                                    <i class="ti-help-alt text-danger"></i>
                                                </span>
                                            </label>
                                            <div class="appnt-color">

                                                <div class="pink">
                                                    <input id="radio_1"  value="pink" runat="server" clientidmode="Static" name="group1" type="radio" class="with-gap"/>
                                                    <label for="radio_1"></label>
                                                </div>
                                                <div class="purple">
                                                    <input id="radio_2"  value="purple" runat="server" clientidmode="Static" name="group1" type="radio" class="with-gap"/>
                                                    <label for="radio_2"></label>
                                                </div>
                                                <div class="indigo">
                                                    <input id="radio_3"  value="indigo" runat="server" clientidmode="Static" name="group1" type="radio" class="with-gap"/>
                                                    <label for="radio_3"></label>
                                                </div>
                                                <div class="blue">
                                                    <input id="radio_4"  value="blue" runat="server" clientidmode="Static" name="group1" type="radio" class="with-gap" />
                                                    <label for="radio_4"></label>
                                                </div>
                                                <div class="cyan">
                                                    <input id="radio_5"  value="cyan" runat="server" clientidmode="Static" name="group1" type="radio" class="with-gap"/>
                                                    <label for="radio_5"></label>
                                                </div>
                                                <div class="teal">
                                                    <input id="radio_6"   value="teal" runat="server" clientidmode="Static" name="group1" type="radio" class="with-gap"/>
                                                    <label for="radio_6"></label>
                                                </div>
                                                <div class="green">
                                                    <input id="radio_7" value="green"  runat="server" clientidmode="Static" name="group1" type="radio" class="with-gap"/>
                                                    <label for="radio_7"></label>
                                                </div>
                                                <div class="lime">
                                                    <input id="radio_8"  value="lime" runat="server" clientidmode="Static" name="group1" type="radio" class="with-gap" />
                                                    <label for="radio_8"></label>
                                                </div>                  `
                                                <div class="yellow">
                                                    <input id="radio_9"  value="yellow" runat="server" clientidmode="Static" name="group1" type="radio" class="with-gap"/>
                                                    <label for="radio_9"></label>
                                                </div>
                                                <div class="orange">
                                                    <input id="radio_10" value="orange" runat="server" clientidmode="Static" name="group1" type="radio" class="with-gap"/>
                                                    <label for="radio_10"></label>
                                                </div>
                                            </div>
                                        </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane" role="tabpanel" id="es-Arabic">
                                    <div class="row">
                                        <div class="col-md-12 col-12">

                                            <p>Arabic info for service Group</p>
                                            <br />
                                            <div class="form-group">
                                                <label class="control-label">GROUP NAME</label>
                                                <asp:TextBox ID="txtArName" runat="server" CssClass="form-control" placeholder="e.g. خدمات الشعر"></asp:TextBox>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label">GROUP Description</label>
                                                <asp:TextBox ID="txtArDetails" TextMode="MultiLine" Rows="5" CssClass="form-control" runat="server"></asp:TextBox>

                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="tab-pane" role="tabpanel" id="es-Media">
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

                                                                <asp:FileUpload ID="fuBigImage" accept="image/*" onchange="loadFile(event)" ClientIDMode="Static" runat="server" />
                                                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="fuSmallImage" ForeColor="Red" Display="Dynamic" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                                                                <asp:HiddenField ID="hfImageUrl" runat="server" />
                                                                <asp:HiddenField ID="hfImageUrlMain" runat="server" />
                                                                <img id="output" style="width: 50px; height: 50px; margin-left: 21%;" />

                                                                <div class="row" style="margin-top: 15px;">
                                                                    <div class="col-md-6 col-sm-6">
                                                                        <label class="control-label">Width:</label>
                                                                        <asp:TextBox ID="txtBigimWidth" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                                                    </div>
                                                                    <div class="col-md-6 col-sm-6">
                                                                        <label class="control-label">Height:</label>
                                                                        <asp:TextBox ID="txtBigimHeight" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                                                    </div>
                                                                </div>


                                                                <%--<table id="tblEqWebImage" style="margin: 10px 0px 10px 10px; border: 1px solid #373737;">
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
                                                                </div>--%>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4 col-12">
                                                    <div class="form-group">
                                                        <label>Small Icon (Active): </label>
                                                    </div>
                                                </div>
                                                <div class="col-md-8 col-12">
                                                    <div class="form-group">

                                                        <div class="upload-picture">
                                                            <div class="text-cemter image-holder">
                                                                <asp:FileUpload ID="fuSmallImage_active" accept="image/*" onchange="loadFile2(event)" ClientIDMode="Static" runat="server" />
                                                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="fuSmallImage" ForeColor="Red" Display="Dynamic" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                                                                <asp:HiddenField ID="hficonUrl_active" runat="server" />

                                                                <img id="output1" style="width: 50px; height: 50px; margin-left: 21%;" />


                                                                <%--<%Dim serviceid1 = hdServiceGroupId.Value
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

                                                                </div>--%>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4 col-12">
                                                    <div class="form-group">
                                                        <label>Small Icon: </label>
                                                    </div>
                                                </div>
                                                <div class="col-md-8 col-12">
                                                    <div class="form-group">

                                                        <div class="upload-picture">
                                                            <div class="text-cemter image-holder">
                                                                <asp:FileUpload ID="fuSmallImage" accept="image/*" onchange="loadFile3(event)" ClientIDMode="Static" runat="server" />
                                                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="fuSmallImage" ForeColor="Red" Display="Dynamic" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                                                                <asp:HiddenField ID="hficonUrl" runat="server" />

                                                                <img id="output2" style="width: 50px; height: 50px; margin-left: 21%;" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>

                    <div class="modal-footer">
                        <asp:Label ID="lblmsg" runat="server" Font-Size="Medium" ForeColor="Red"></asp:Label>
                        <asp:Button ID="btndelete" OnClientClick="return confirm('Are you sure you want to delete?')" class="btn btn-inverse" runat="server" Text="Delete" />
                        <%--<button type="button" class="btn btn-secondary waves-effect">Resend password setup email</button>--%>
                        <asp:Button ID="btnsubmit" ValidationGroup="form" CssClass="btn btn-danger waves-effect waves-light save-category btnsubmit" runat="server" Text="Save" />
                        <button type="button" onclick="ClearID()" class="btn btn-secondary waves-effect closebtn">Close</button>

                    </div>

                </div>

            </div>

        </div>

        <asp:HiddenField ID="hdServiceGroupId" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnserviceid" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnuserid" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnScopeID" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnparentid" runat="server" ClientIDMode="Static" />

    </form>


    <script type="text/javascript" src="/assets/plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap popper Core JavaScript -->
    <script type="text/javascript" src="/assets/plugins/bootstrap/js/popper.min.js"></script>
    <script type="text/javascript" src="/assets/plugins/bootstrap/js/bootstrap.min.js"></script>
    <!-- slimscrollbar scrollbar JavaScript -->
    <script type="text/javascript" src="/js/perfect-scrollbar.jquery.min.js"></script>
    <!--Wave Effects -->
    <script type="text/javascript" src="/js/waves.js"></script>
    <!--Menu sidebar -->
    <script type="text/javascript" src="/js/sidebarmenu.js"></script>
    <!--fancy box-->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/fancybox/3.4.1/jquery.fancybox.min.js"></script>

    <!--Custom JavaScript -->
    <script type="text/javascript" src="/js/custom.min.js"></script>
    <!-- ============================================================== -->
    <!-- This page plugins -->
    <!-- ============================================================== -->
    <!--sparkline JavaScript -->
    <script type="text/javascript" src="/assets/plugins/sparkline/jquery.sparkline.min.js"></script>

    <script type="text/javascript" src="/assets/plugins/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
    <script type="text/javascript" src="/assets/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#output').hide();
            $('#output1').hide();
            $('#output2').hide();
        });

        var loadFile = function (event) {
            $('#output').show();
            var output = document.getElementById('output');
            output.src = URL.createObjectURL(event.target.files[0]);
        };

        var loadFile2 = function (event) {
            $('#output1').show();
            var output = document.getElementById('output1');
            output.src = URL.createObjectURL(event.target.files[0]);
        };

        var loadFile3 = function (event) {
            $('#output2').show();
            var output = document.getElementById('output2');
            output.src = URL.createObjectURL(event.target.files[0]);
        };
    </script>


    <script type="text/javascript">
        function validation() {
            var isresult = true;
            var ServiceGroupId = $("#<%= hdServiceGroupId.ClientID%>").val();
            var ParentId = $("#<%= ddlGroup.ClientID%>").val();

            if (ServiceGroupId !== "0" && ServiceGroupId !== "") {
                if (ParentId == ServiceGroupId) {
                    $("#<%=lblWarning.ClientID %>").html("Parent can not be same as Group.").css("color", "red");
                    isresult = false;
                }
            }

            return isresult;
        }

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


        function ClearID() {

            $("#<%=txtName.ClientID %>").val("");
            $("#<%=txtArName.ClientID %>").val("");
            $("#<%=hdServiceGroupId.ClientID %>").val("");
            $("#<%=txtDetails.ClientID %>").val("");
            $("#<%=txtArDetails.ClientID %>").val("");
            $("#<%=ddlGroup.ClientID %>").val("");
            $("#<%=chkPackage.ClientID %>").val("");

            <%--$("#<%=txtSearch.ClientID %>").val("");--%>
            <%-- $("#<%=imgSmallImage.ClientID %>").val("");--%>
            <%--  $("#<%=imgIcon.ClientID %>").val("");--%>
            <%--$("#<%=lblmsg.ClientID %>").val("");--%>
            <%--  $("#<%=hdnImageUrl.ClientID %>").val("");
            $("#<%=hdnIconUrl.ClientID %>").val("");--%>

            document.getElementById('btnsubmit').value = "Save";
        }
    </script>


    <%--<script type="text/javascript">
        
        <%--$('#btnsubmit').click(function () {
            debugger;
            var ServiceGroupId = $("#<%= hdServiceGroupId.ClientID%>").val();
            var Title = $("#<%= txtName.ClientID%>").val();
            var ArTitle = $("#<%= txtArName.ClientID%>").val();
            var Description = $("#<%= txtDetails.ClientID%>").val();
            var ArDescription = $("#<%= txtArDetails.ClientID%>").val();
            var ParentId = $("#<%= ddlGroup.ClientID%>").val();
            var IsPackage = $("#<%= chkPackage.ClientID%>").prop('checked');
            var BigIconOne = $("#fuImageFile").val();
           <%-- var SmallIconOne =  $("#<%= fuIcon.ClientID%>").val();-%>
            var SmallIconOne = "";

            if (document.getElementById('chkPackage').checked == true) {
                IsPackage = "on";
            }

            Isvalid = validation();

            if (Isvalid == true) {

                if (Title !== "") {
                    $.ajax({
                        url: 'ServiceGroups.aspx/SaveData',
                        type: 'POST',
                        cache: false,
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify({ ServiceGroupId: ServiceGroupId, Title: Title, Description: Description, ParentId: ParentId, ArTitle: ArTitle, ArDescription: ArDescription, IsPackage: IsPackage, BigIconOne: BigIconOne, SmallIconOne: SmallIconOne }),
                        dataType: "json",
                        success: function (data) {

                            //if (document.getElementById("fuImageFile").value != "") {
                            //    var file = document.getElementById('fuImageFile').files[0];
                            //    G_ImageName = file.name;
                            //    var fileName = document.getElementById("fuImageFile").value;
                            //    var idxDot = fileName.lastIndexOf(".") + 1;
                            //    var extFile = fileName.substr(idxDot, fileName.length).toLowerCase();
                            //    if (extFile == "jpg" || extFile == "jpeg" || extFile == "png" || extFile == 'gif' || extFile == 'tiff') {

                            //        var reader = new FileReader();
                            //        reader.readAsDataURL(file);
                            //        reader.onload = UpdateFilesEq;
                            //    } else {

                            //        notify('danger', "Only .gif, .jpg, .png, .tiff and .jpeg are allowed!");
                            //        $("#fuImageFile").val("");
                            //    }

                            //}
                            //else {

                            //    notify('danger', "Please Choose An Image");
                            //}


                            $("#<%=txtName.ClientID %>").val("");
                            $("#<%=txtArName.ClientID %>").val("");
                            $("#<%=hdServiceGroupId.ClientID %>").val("");
                            $("#<%=txtDetails.ClientID %>").val("");
                            $("#<%=txtArDetails.ClientID %>").val("");
                            $("#<%=ddlGroup.ClientID %>").val("");
                            $("#<%=chkPackage.ClientID%>").val("");

                            window.location.reload();
                        }
                    });
                } else {
                    //alert("work");
                }
            }
        });

    function UpdateFilesEq(evt) {
            var pagePath = window.location.pathname + "/UploadSource";
            var result = evt.target.result;
            var ImageSave = result.replace("data:image/jpeg;base64,", "");
            $.ajax({
                type: "POST",
                url: pagePath,
                data: "{ 'Image':'" + ImageSave + "' , 'ImageName':'" + G_ImageName + "' }",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error:
                    function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("Error");
                        G_ImageName = "";
                    },
                success:
                    function (result) {
                        G_ImageName = "";
                        var obj = $.parseJSON(decodeURIComponent(result.d));
                        var content = "";
                        content += "<tr style='float:left;margin:15px;'>";
                        content += "<td><img style='width: 285px;height: 177px;' src='~/ContentImage/serviceIcons/" + ImageName + "' alt='" + ImageName + "'></td>";
                        content += "</tr>";
                        //$("#tblEqWebImage tbody").append(content);
                        //$("#fuImageFile").val("");
                       <%-- $("<%=imgSmallImage.ClientID %>").attr("src", "~/ContentImage/serviceIcons/" + ImageName);-%>
                        notify('success', "Big Image Upload Sucessfully");
                    }
            });
        }

    function GetById(x) {
            ClearID();
            var ServiceId = x;
            $.ajax({
                type: 'Post',
                url: 'ServiceGroups.aspx/ServiceById',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ ServiceId: ServiceId }),
                dataType: "json",
                success: function (result) {
                    $.each(result,
                        function (key, value) {
                            document.getElementById('txtName').value = value.Title;
                            document.getElementById('txtArName').value = value.ArTitle;
                            document.getElementById('txtDetails').value = value.Description;
                            document.getElementById('txtArDetails').value = value.ArDescription;
                            document.getElementById('hdServiceGroupId').value = value.ServiceId;
                            $("#<%=ddlGroup.ClientID %>").val(value.ParentId);
                            $("#<%=chkPackage.ClientID %>").val(value.IsPackage);
                            if (value.IsPackage == "on") {
                                $("#<%= chkPackage.ClientID%>").prop('checked', true);
                            }

                            document.getElementById('btnsubmit').value = "Update";
                            //document.getElementById('lblHeader').value = "Edit Service Group";
                            
                        });
                }

            });
        }

        //var _URL = window.URL || window.webkitURL;
        //$("#fuImageFile").on('change', function () {

        //    var file, img;
        //    if ((file = this.files[0])) {
        //        img = new Image();
        //        img.onload = function () {
        //            sendFile(file);
        //        };
        //        img.onerror = function () {
        //            alert("Not a valid big image file:" + file.type);
        //        };
        //        img.src = _URL.createObjectURL(file);
        //    }
        //});

            $(document).ready(function () {
            var G_ImageName, Isvalid;
            <%--  $("<%=imgSmallImage.ClientID %>").hide();-%>
            <%-- $("<%=imgIcon.ClientID %>").hide();-%>

        });

        //function sendFile(file) {
        //    var formData = new FormData();
        //    formData.append('file', $('#fuImageFile')[0].files[0]);
        //    $.ajax({
        //        type: 'post',
        //        url: 'ServiceGroups.aspx/upload',
        //        data: formData,
        //        success: function (status) {
        //            if (status != 'error') {
        //                var my_path = "ContentImage/serviceIcons/" + status;
        //                $("#imgSmallImage").attr("src", my_path);
        //            }
        //        },
        //        processData: false,
        //        contentType: false,
        //        error: function () {
        //            alert("Whoops something went wrong!");
        //        }
        //    });
        //}

        //var _URL = window.URL || window.webkitURL;
        //$("#fuImageFile").on('change', function () {

        //    var file, img;
        //    if ((file = this.files[0])) {
        //        img = new Image();
        //        img.onload = function () {
        //            sendFile(file);
        //        };
        //        img.onerror = function () {
        //            alert("Not a valid file:" + file.type);
        //        };
        //        img.src = _URL.createObjectURL(file);
        //    }
        //});

    </script>--%>
</body>
</html>
