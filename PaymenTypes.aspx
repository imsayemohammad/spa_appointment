<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="PaymenTypes.aspx.vb" Inherits="BrandList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="toppart" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="Server">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="tab-content">
                    <div class="tab-pane active" role="tabpanel">
                        <div class="card-body">
                            <div class="row">

                                <div class="col-md-6 col-sm-6 col-12">
                                    <div class="form-group">
                                        <label>Search by payment type </label>
                                        <%--                                        <input type="text" class="form-control" placeholder="">--%>

                                        <asp:TextBox ID="txtSearch" runat="server" class="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-2 col-sm-2 col-12">
                                    <div class="form-group">
                                        <label>&nbsp;</label>
                                        <div class="form-group">
                                            <%--                                            <button type="submit" class="btn btn-danger waves-effect btn-block waves-light">Search</button>--%>
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
                                                    <th>Payment Type Name</th>


                                                </tr>
                                            </thead>
                                            <tbody>


                                                <asp:ListView ID="lstPaymentType" runat="server">
                                                    <ItemTemplate>
                                                        <tr>



                                                            <td>
                                                                <a href="#" onclick='GetPaymentTypeById(<%# Eval("PaymentTypeId")%>)'  data-toggle="modal" data-target="#editcategorymodal"  ><%# Eval("PaymentTypeName")%></a>
                                                            </td>

                                                            <td>





                                                                

                                                                <asp:Label Visible='<%# If(Eval("Updateable")= true , true, false) %>'
                                                                    runat="server">                                         
                                                                                             

                                                                    <a href="#" onclick='GetPaymentTypeById(<%# Eval("PaymentTypeId")%>)' data-toggle="modal" data-target="#editcategorymodal">Edit
                                                                    </a>
                                                                  
                                                                </asp:Label>
                                                                
                                                                
                                                                <asp:Label Visible='<%# If(Eval("Updateable")= true AND Eval("Deleteable")= true , true, false) %>'
                                                                           runat="server">                                         
                                                                                             
                                                                            |
                                                                  
                                                                </asp:Label>
                                                                  
                                                                
                                                                
                                                                <asp:Label Visible='<%# If(Eval("Deleteable")= true , true, false) %>'
                                                                    runat="server">                                         
                                                                                             

                                                                    <a href="#" onclick='DeletePaymentTypeById(<%# Eval("PaymentTypeId")%>)'>Delete
                                                                    </a>
                                                                  
                                                                </asp:Label>

                                                                  

                                                               
                                                              



                                                            </td>


                                                        </tr>

                                                    </ItemTemplate>
                                                </asp:ListView>

                                            </tbody>

                                        </table>

                                        <%--    <h6 class="card-subtitle">Displaying <code class="bg-light-success">1 - 25 of 3959 total </code></h6>--%>

                                        <!-- END MODAL -->

                                        <div class="modal fade none-border editcategorymodal" id="editcategorymodal">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h4 class="modal-title">Add/Edit Payment Type Name
                                                        </h4>
                                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="ClearID()">×</button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <form role="form">
                                                            <div class="row">
                                                                <div class="col-md-12 col-xs-12">
                                                                    <div class="form-group">

                                                                        <%--                                                                        <input type="hidden" class="form-control" id="hidBrandID" value="">--%>



                                                                        <asp:HiddenField ID="hidPaymentTypeID" runat="server" ClientIDMode="Static" />
                                                                        <label class="control-label">Payment Type Name</label>

                                                                        <asp:TextBox ID="txtPaymentTypeName" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ControlToValidate="txtPaymentTypeName" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidatortxtPaymentTypeName" runat="server"
                                                                            ErrorMessage="*"></asp:RequiredFieldValidator>
                                                                        <%--                                                                        <input type="text" class="form-control" placeholder="Enter Brand Name" id="txtBrand">--%>
                                                                    </div>





                                                                    <div class="form-group">

                                                                        <asp:CheckBox ID="chkEditable" runat="server" ClientIDMode="Static" />
                                                                        <label for="chkEditable">Editable </label>
                                                                    </div>





                                                                    <div class="form-group">


                                                                        <asp:CheckBox ID="chkDeletetable" runat="server" ClientIDMode="Static" />
                                                                        <label for="chkDeletetable">Deleteable</label>
                                                                    </div>


                                                                </div>

                                                            </div>
                                                        </form>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <%--                                                        <button type="button" class="btn btn-inverse">Delete</button>--%>
                                                        <%--                                                        <button type="button" class="btn btn-danger waves-effect waves-light save-brand" data-dismiss="modal">Save</button>--%>
                                                        <asp:Button ID="btnsave" ValidationGroup="form" CssClass="btn btn-danger waves-effect waves-light btnsubmit"
                                                            runat="server" Text="Save" ClientIDMode="Static" />
                                                        <button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal" onclick="ClearID()">Close</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>




                                        <%--                                        <nav aria-label="Page navigation example" class="m-t-40">--%>
                                        <%--                                            <ul class="pagination">--%>
                                        <%--                                                <li class="page-item disabled">--%>
                                        <%--                                                    <a class="page-link" href="#" tabindex="-1">Previous</a>--%>
                                        <%--                                                </li>--%>
                                        <%--                                                <li class="page-item"><a class="page-link" href="#">1</a></li>--%>
                                        <%--                                                <li class="page-item"><a class="page-link" href="#">2</a></li>--%>
                                        <%--                                                <li class="page-item"><a class="page-link" href="#">3</a></li>--%>
                                        <%--                                                <li class="page-item">--%>
                                        <%--                                                    <a class="page-link" href="#">Next</a>--%>
                                        <%--                                                </li>--%>
                                        <%--                                            </ul>--%>
                                        <%--                                        </nav>--%>
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
            //hidPaymentTypeID,txtPaymentTypeName
            document.getElementById('hidPaymentTypeID').value = "";
            document.getElementById('txtPaymentTypeName').value = "";

            //   chkEditable, chkDeletetable

            document.getElementById("chkEditable").checked = false;
            document.getElementById("chkDeletetable").checked = false;
        }


        function DeletePaymentTypeById(x) {


            var PaymentTypeID = x;


            if (confirm("Are You Sure You Want To Delete ?")) {


                $.ajax({
                    type: 'Post',
                    url: 'PaymenTypes.aspx/DeletePaymentTypeById',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ PaymentTypeID: PaymentTypeID }),
                    dataType: "json",
                    success: function () {
                        location.reload();

                    }
                });

            } else {

            }

        }

        //DeletePaymentTypeById,GetPaymentTypeById,PaymentTypeID


        function GetPaymentTypeById(x) {

            var PaymentTypeID = x;

            $.ajax({
                type: 'Post',
                url: 'PaymenTypes.aspx/GetPaymentTypeById',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ PaymentTypeID: PaymentTypeID }),
                dataType: "json",
                success: function (result) {


                    $.each(result,
                        function (key, value) {
                            document.getElementById('hidPaymentTypeID').value = value.PaymentTypeId;
                            document.getElementById('txtPaymentTypeName').value = value.PaymentTypeName;




                            //   chkEditable, chkDeletetable
                            if (value.chkEditable !== false) {
                                
                                document.getElementById("chkEditable").checked = true;
                            } else {
                                document.getElementById("chkEditable").checked = false;
                                
                            }



                            if (value.chkDeletetable !== false) {
                                document.getElementById("chkDeletetable").checked = true;
                            } else {
                                document.getElementById("chkDeletetable").checked = false;

                            }

                        });



                }

            });



        }



    </script>

</asp:Content>

