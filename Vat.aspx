<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Vat.aspx.vb" Inherits="BrandList" %>

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
                                            
                                        <h3>Vat</h3> 
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
                                                    <th>Vat Name</th>
                                                    <th>Vat Rate</th>

                                                </tr>
                                            </thead>
                                            <tbody>


                                                <asp:ListView ID="lstBrand" runat="server">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td>
                                                                <a href="#"><%# Eval("VatTitle")%></a>
                                                            </td>
                                                            <td>
                                                                <a href="#"><%# Eval("VatPercent")%></a>%
                                                            </td>

                                                            <td>
                                                                <a href="#" onclick='GetVatById(<%# Eval("VatId")%>)' data-toggle="modal" data-target="#editcategorymodal">Edit
                                                                </a>|
                                                                
                                                                
                                                                
                                                                <a href="#" onclick='DeleteVatId(<%# Eval("VatId")%>)' >Delete
                                                                </a>
                                                         
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
                                                        <h4 class="modal-title">Add/Edit Vat
                                                        </h4>
                                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="ClearID()">×</button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <form role="form">
                                                            <div class="row">
                                                                <div class="col-md-12 col-xs-12">
                                                                    <div class="form-group">

                                                                        <%--                                                                        <input type="hidden" class="form-control" id="hidBrandID" value="">--%>



                                                                        <asp:HiddenField ID="hidVatID" runat="server" ClientIDMode="Static" Value="" />
                                                                        <label class="control-label">Vat Name</label>

                                                                        <asp:TextBox ID="txtVatName" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ControlToValidate="txtVatName" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidatortxtVatName" runat="server"
                                                                            ErrorMessage="*"></asp:RequiredFieldValidator>
                                                                        <%--                                                                        <input type="text" class="form-control" placeholder="Enter Brand Name" id="txtBrand">--%>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-12 col-xs-12">
                                                                    <div class="form-group">
                                                                        <label class="control-label">Vat Rate</label>
                                                                        <%--                                                                        <textarea rows="5" class="form-control" placeholder="Enter Brand Details" id="txtBrandDetails"></textarea>--%>


                                                                        <asp:TextBox ID="txtVatRate" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ControlToValidate="txtVatRate" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidatortxtVatRate" runat="server"
                                                                            ErrorMessage="*"></asp:RequiredFieldValidator>
                                                                        <asp:RangeValidator runat="server" Type="Double" ValidationGroup="form"
                                                                            MinimumValue="0" MaximumValue="100" ControlToValidate="txtVatRate"
                                                                            ErrorMessage="Value must be a whole number between 0 and 100" />

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

            //hidVatID, txtVatName, txtVatRate
            document.getElementById('txtVatName').value = "";
            document.getElementById('txtVatRate').value = "";
            document.getElementById('hidVatID').value = "";
          //  $("#<%=hidVatID.ClientID %>").val(value.VatID);
        }









        function GetVatById(x) {

            var VatId = x;

            $.ajax({
                type: 'Post',
                url: 'Vat.aspx/GetVatById',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ VatId: VatId }),
                dataType: "json",
                success: function (result) {


                    $.each(result,
                        function (key, value) {
                            //hidVatID, txtVatName, txtVatRate
                            document.getElementById('txtVatName').value = value.VatName;
                            document.getElementById('txtVatRate').value = value.VatRate;
                            document.getElementById('hidVatID').value = value.VatID;

                           
                        });



                }

            });






        }



        function DeleteVatId(x) {


            var VatId = x;


            if (confirm("Are You Sure You Want To Delete ?")) {


                $.ajax({
                    type: 'Post',
                    url: 'Vat.aspx/DeleteVatById',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ VatId: VatId }),
                    dataType: "json",
                    success: function () {
                        location.reload();

                    }
                });

            } else {

            }

        }


    </script>

</asp:Content>

