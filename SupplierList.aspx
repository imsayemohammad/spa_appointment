<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="SupplierList.aspx.vb" Inherits="SupplierList" %>

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
                <h3 class="text-themecolor">Inventory</h3>
            </div>
            <div class="col-md-7 align-self-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
                    <li class="breadcrumb-item active">Inventory</li>
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
                        <li class="nav-item"><a class="nav-link" href="/products">PRODUCTS</a> </li>
                        <li class="nav-item"><a class="nav-link" href="orders.html">ORDERS</a> </li>
                        <li class="nav-item"><a class="nav-link" href="/brand">BRANDS</a> </li>
                        <li class="nav-item"><a class="nav-link" href="/category">CATEGORIES</a></li>
                        <li class="nav-item"><a class="nav-link active" href="/supplier">SUPPLIERS</a></li>
                    </ul>
                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane active" role="tabpanel">
                            <div class="card-body">
                                <div class="row">

                                    <div class="col-md-6 col-sm-6 col-12">
                                        <div class="form-group">
                                            <label>Search by supplier name</label>
<%--                                            <input type="text" class="form-control" placeholder="">--%>
                                            <asp:TextBox ID="txtSearch" CssClass="form-control " runat="server" ClientIDMode="Static"></asp:TextBox>

                                        </div>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-12">
                                        <div class="form-group">
                                            <label>&nbsp;</label>
                                            <div class="form-group">
<%--                                                <button type="submit" class="btn btn-danger waves-effect btn-block waves-light">Search</button>--%>
                                                <asp:Button ID="btnSearch" class="btn btn-danger waves-effect btn-block waves-light btnsubmit" runat="server" Text="Search" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-12">
                                        <div class="form-group">
                                            <label>&nbsp;</label>
                                            <div class="form-group">
                                                <button type="button"  onclick="ClearID()" class="btn btn-info waves-effect btn-block waves-light" data-toggle="modal" data-target="#editsuppliermodal">Add New</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                                                                                                                           <div class="row">
                                    <div class="col-lg-12 col-xlg-12 col-md-12 col-12">
                                        <div >
                                            <table class="table table-bordered table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>SUPPLIER NAME</th>
                                                        <th>PHONE</th>
                                                        <th>EMAIL</th>
                                                        <th>ACTION</th>
                                                        <%--                                                        <th>PRODUCTS ASSIGNED</th>--%>
                                                        <%--                                                        <th>UPDATED AT</th>--%>
                                                    </tr>
                                                </thead>
                                                <tbody>



                                                    <asp:ListView ID="lstSupplier" runat="server">
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td>
                                                                    <a href="javascript:;" onclick='GetSupplierById(<%# Eval("SupplierID")%>)' data-toggle="modal" data-target="#editsuppliermodal"><%# Eval("SupplierName")%>
                                                                    </a>
                                                                </td>

                                                                <td>
                                                                    <a href="javascript:;" onclick='GetSupplierById(<%# Eval("SupplierID")%>)' data-toggle="modal" data-target="#editsuppliermodal"><%# Eval("Phone1")%>
                                                                    </a>
                                                                </td>

                                                                <td>
                                                                    <a href="javascript:;"   onclick='GetSupplierById(<%# Eval("SupplierID")%>)' data-toggle="modal" data-target="#editsuppliermodal"><%# Eval("Email")%>
                                                                    </a>
                                                                </td>


                                                                <td>
                                                                    <a href="#" onclick='GetSupplierById(<%# Eval("SupplierID")%>)' data-toggle="modal" data-target="#editsuppliermodal"><span class="mdi mdi-pencil-box" style="font-size:20px;
                                                                    line-height:15px;"></span>
                                                                    </a>
                                                                </td>

                                                            </tr>
                                                        </ItemTemplate>
                                                    </asp:ListView>


                                                </tbody>

                                            </table>

<%--                                            <h6 class="card-subtitle">Displaying <code class="bg-light-success">1 - 25 of 3959 total </code></h6>--%>

                                            <div class="modal fade none-border editsuppliermodal" id="editsuppliermodal" aria-hidden="true" style="display: none;">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h4 class="modal-title">Add/Edit Supplier                               
                                                            </h4>
                                                            <button type="button" onclick="ClearID()" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <form role="form">
                                                                <div class="row">
                                                                    <div class="col-md-6 col-12">
                                                                        <h5 class="text-themecolor">Supplier Details</h5>
                                                                        <div class="form-group">
                                                                            <label class="control-label">SUPPLIER NAME</label>

                                                                            <%--                                                                            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>--%>
                                                                            <asp:TextBox ID="txtSupplierName" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                            <asp:RequiredFieldValidator ControlToValidate="txtSupplierName" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator8txtSupplierName" runat="server"
                                                                                ErrorMessage="*"></asp:RequiredFieldValidator>


                                                                        </div>
                                                                        <div class="form-group">



                                                                            <label class="control-label">SUPPLIER DESCRIPTION</label>
                                                                            <%--                                                                            <textarea class="form-control" ></textarea>                       --%>

                                                                            <asp:TextBox ID="txtSupplierDescription" TextMode="MultiLine" Rows="5" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
<%--                                                                            <asp:RequiredFieldValidator ControlToValidate="txtSupplierDescription" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1txtSupplierDescription" runat="server"--%>
<%--                                                                                ErrorMessage="*"></asp:RequiredFieldValidator>--%>

                                                                        </div>

                                                                        <hr>

                                                                        <h5 class="text-themecolor">Contact Information</h5>

                                                                        <div class="row">
                                                                            <div class="col-md-6 col-12">
                                                                                <div class="form-group">

                                                                                    <label class="control-label">FIRST NAME</label>




                                                                                    <asp:TextBox ID="txtFirstName" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ControlToValidate="txtFirstName" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1txtFirstName" runat="server"
                                                                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-6 col-12">
                                                                                <div class="form-group">

                                                                                    <label class="control-label">LAST NAME</label>
                                                                                    <asp:TextBox ID="txtLasName" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ControlToValidate="txtLasName" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidatortxtLasName" runat="server"
                                                                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-6 col-12">
                                                                                <div class="form-group">


                                                                                    <label class="control-label">MOBILE NUMBER</label>
                                                                                    <asp:TextBox ID="txtMobile" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ControlToValidate="txtMobile" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1txtMobile" runat="server"
                                                                                        ErrorMessage="*"></asp:RequiredFieldValidator>

                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-6 col-12">
                                                                                <div class="form-group">


                                                                                    <label class="control-label">EMAIL</label>
                                                                                    <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ControlToValidate="txtEmail" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator3" runat="server"
                                                                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" Display="Dynamic" runat="server" ErrorMessage="* invalid" ValidationGroup="form"
                                                                                        ControlToValidate="txtEmail" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>



                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-6 col-12">
                                                                                <div class="form-group">

                                                                                    <label class="control-label">TELEPHONE</label>
                                                                                    <%--                                                                                    <input type="text" class="form-control" placeholder=""> --%>

                                                                                    <asp:TextBox ID="txtTelePhone" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ControlToValidate="txtTelePhone" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidatortxtTelePhone" runat="server"
                                                                                        ErrorMessage="*"></asp:RequiredFieldValidator>

                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-6 col-12">
                                                                                <div class="form-group">
                                                                                    <label class="control-label">WEBSITE</label>



                                                                                    <asp:TextBox ID="txtWebSite" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ControlToValidate="txtWebSite" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1txtWebSite" runat="server"
                                                                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                    </div>
                                                                    <div class="col-md-6 col-12">
                                                                        <h5 class="text-themecolor">Physical Address</h5>
                                                                        <div class="form-group">
                                                                            <label class="control-label">STREET</label>





                                                                            <asp:TextBox ID="txtStreet" Rows="5" TextMode="MultiLine" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                            <asp:RequiredFieldValidator ControlToValidate="txtStreet" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1txtStreet" runat="server"
                                                                                ErrorMessage="*"></asp:RequiredFieldValidator>



                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="control-label">SUBURB</label>




                                                                            <asp:TextBox ID="txtSubscribe" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
<%--                                                                            <asp:RequiredFieldValidator ControlToValidate="txtSubscribe" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1txtSubscribe" runat="server"--%>
<%--                                                                                ErrorMessage="*"></asp:RequiredFieldValidator>--%>

                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="control-label">CITY</label>


                                                                            <asp:TextBox ID="txtCity" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                            <asp:RequiredFieldValidator ControlToValidate="txtCity" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1txtCity" runat="server"
                                                                                ErrorMessage="*"></asp:RequiredFieldValidator>

                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="control-label">STATE</label>


                                                                            <asp:TextBox ID="txtState" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                            <asp:RequiredFieldValidator ControlToValidate="txtState" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1txtState" runat="server"
                                                                                ErrorMessage="*"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="control-label">ZIP/POST CODE</label>


                                                                            <asp:TextBox ID="txtZip" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                            <asp:RequiredFieldValidator ControlToValidate="txtZip" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1txtZip" runat="server"
                                                                                ErrorMessage="*"></asp:RequiredFieldValidator>

                                                                        </div>
                                                                        <div class="form-group">

                                                                            <%--                                                                            txtSupplierName  ,txtSupplierDescription ,txtFirstName,txtLasName,txtMobile,txtEmail,txtTelePhone,txtWebSite,txtStreet,txtSubscribe,txtCity,txtState,txtZip,chkPostAddress,dropDownCountryList--%>

                                                                            <label class="control-label">COUNTRY</label>


                                                                            <asp:DropDownList class="form-control"  placeholder="--Select Country--" ID="dropDownCountryList" runat="server" ClientIDMode="Static">
                                                                   
                                                                                
                                                                                             
                                                                            </asp:DropDownList>
                                                                            <asp:RequiredFieldValidator ControlToValidate="dropDownCountryList" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1dropDownCountryList" runat="server"
                                                                                                        ErrorMessage="*"></asp:RequiredFieldValidator>


                                                                        </div>
                                                                        <div class="form-group">



                                                                            <div class="checkbox checkbox-success">
                                                                                <%--<input id="checkbox1" type="checkbox">--%>
                                                                                <asp:CheckBox ID="chkPostAddress" runat="server" ClientIDMode="Static" />
                                                                                <label for="chkPostAddress">SAME AS POSTAL ADDRESS </label>
                                                                            </div>
                                                                        </div>

                                                                    </div>
                                                                </div>

                                                            </form>
                                                        </div>


                                                        <asp:HiddenField ID="hdnSupplierid" runat="server" ClientIDMode="Static" />

                                                        <div class="modal-footer">
                                                            <%--                                                            <button type="button" class="btn btn-inverse">Delete</button>--%>
                                                            <asp:Button ID="btnsave" ValidationGroup="form" CssClass="btn btn-danger waves-effect waves-light btnsubmit"
                                                                runat="server" Text="Save" ClientIDMode="Static" />
                                                            <button type="button" onclick="ClearID()" class="btn btn-secondary waves-effect" data-dismiss="modal">Close</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- END MODAL -->



<%--                                            <nav aria-label="Page navigation example" class="m-t-40">--%>
<%--                                                <ul class="pagination">--%>
<%--                                                    <li class="page-item disabled">--%>
<%--                                                        <a class="page-link" href="#" tabindex="-1">Previous</a>--%>
<%--                                                    </li>--%>
<%--                                                    <li class="page-item"><a class="page-link" href="#">1</a></li>--%>
<%--                                                    <li class="page-item"><a class="page-link" href="#">2</a></li>--%>
<%--                                                    <li class="page-item"><a class="page-link" href="#">3</a></li>--%>
<%--                                                    <li class="page-item">--%>
<%--                                                        <a class="page-link" href="#">Next</a>--%>
<%--                                                    </li>--%>
<%--                                                </ul>--%>
<%--                                            </nav>--%>

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

    <script type="text/javascript">



        function GetSupplierById(x) {
            var SupplierId = x;
            $.ajax({
                type: 'Post',
                url: 'SupplierList.aspx/SupplierBySupplierId',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ SupplierId: SupplierId }),
                dataType: "json",
                success: function (result) {


                    $.each(result,
                        function (key, value) {
                            document.getElementById('txtSupplierName').value = value.SupplierName;
                            document.getElementById('txtFirstName').value = value.FirstName;
                            document.getElementById('txtLasName').value = value.LastName;
                            document.getElementById('txtMobile').value = value.Phone1;
                            document.getElementById('txtTelePhone').value = value.Phone2;
                            document.getElementById('txtEmail').value = value.Email;
                            document.getElementById('txtWebSite').value = value.WebSite;
                            document.getElementById('txtStreet').value = value.Street;
                            document.getElementById('txtCity').value = value.City;
                            document.getElementById('txtState').value = value.State;
                            document.getElementById('txtZip').value = value.ZipCode;
                            document.getElementById('hdnSupplierid').value = value.SupplierID;
                            $("#<%=dropDownCountryList.ClientID %>   ").val(value.CountryID);
                          //

//                            $("#<%=chkPostAddress.ClientID %>  ").val(value.SameASPostal);
                            if (value.SameASPostal !== false) {
                                //document.getElementById('chkbookings').prop('checked', true);
                                document.getElementById("chkPostAddress").checked = true;
                            } else {
                                document.getElementById("chkPostAddress").checked = false;
                                //document.getElementById('chkbookings').prop('checked', false);
                            }


                        });
                }

            });
            }


            function ClearID() {
              
                $("#<%=txtSupplierName.ClientID %>").val("");
                $("#<%=txtFirstName.ClientID %>").val("");
                $("#<%=txtLasName.ClientID %>").val("");
                $("#<%=txtMobile.ClientID %>").val("");
                $("#<%=txtTelePhone.ClientID %>").val("");
                $("#<%=txtEmail.ClientID %>").val("");
                $("#<%=txtWebSite.ClientID %>").val("");
                $("#<%=txtStreet.ClientID %>").val("");
                $("#<%=txtCity.ClientID %>").val("");
                $("#<%=txtState.ClientID %>").val("");
                $("#<%=txtZip.ClientID %>").val("");
                $("#<%=hdnSupplierid.ClientID %>").val("");
               $("#<%=txtSupplierDescription.ClientID %>").val("");
                $("#<%=txtSubscribe.ClientID %>").val("");
                document.getElementById("chkPostAddress").checked = false;
                $("#<%=dropDownCountryList.ClientID %>  ").val("");
            }


    </script>

</asp:Content>

