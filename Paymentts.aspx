<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Paymentts.aspx.vb" Inherits="Appointments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="toppart" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="Server">
    <div class="container-fluid">

        <div class="row page-titles">
            <div class="col-md-5 align-self-center">
                <h3 class="text-themecolor">Sales</h3>
            </div>
            <div class="col-md-7 align-self-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
                    <li class="breadcrumb-item active">Sales</li>
                </ol>
            </div>

        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="card">

                    <ul class="nav nav-tabs profile-tab">
                        <li class="nav-item"><a class="nav-link" href="sales.html">DAILY SALES</a> </li>
                        <li class="nav-item"><a class="nav-link " href="appointments.html">APPOINTMENTS</a> </li>
                        <li class="nav-item"><a class="nav-link" href="invoices.html">INVOICES</a> </li>
                        <li class="nav-item"><a class="nav-link active" href="payments.html">PAYMENTS</a></li>
                        <li class="nav-item"><a class="nav-link" href="vouchers.html">VOUCHERS</a></li>
                    </ul>

                    <div class="tab-content">
                        <div class="tab-pane active" role="tabpanel">
                            <div class="card-body">
                                <div class="row">

                                    <div class="col-md-2 col-sm-2 col-12">
                                        <div class="form-group">
                                            <label>All Locations: </label>
                                            <asp:DropDownList class="form-control " placeholder="--Select Brand--" ID="dropDownLocationList" runat="server" ClientIDMode="Static" data-placeholder="Chosse" TabIndex="1">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="col-md-3 col-sm-3 col-12">
                                        <div class="form-group">
                                            <label>Date: </label>
                                            <div class="input-group">
                                                <asp:TextBox ID="txtDatepicker" CssClass="form-control mydatepicker" runat="server" ClientIDMode="Static" placeholder="mm/dd/yyyy"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-12">
                                        <div class="form-group">
                                            <label>Staff</label>

                                            <asp:DropDownList class="form-control " placeholder="--All  Stuff--" ID="dropDownStaffList" runat="server" ClientIDMode="Static" data-placeholder="Chosse" TabIndex="1">
                                            </asp:DropDownList>

                                        </div>
                                    </div>
                                    <div class="col-md-3 col-sm-3 col-12">
                                        <div class="form-group">
                                            <label>Reference/Client</label>
                                            <asp:TextBox ID="txtClient" CssClass="form-control" runat="server" ClientIDMode="Static" placeholder=""></asp:TextBox>
        
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


                                </div>


                            </div>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-lg-10 col-xlg-10 col-md-10 col-12">
                                <h4 class="card-title">Monday, 1 Jan 2018 to Wednesday, 17 Jan 2018</h4>
                                <h6 class="card-subtitle">All staff, all locations, generated <code class="bg-light-success">Wednesday, 17 Jan 2018 at 12:50pm</code></h6>
                            </div>
                            <div class="col-lg-2 col-xlg-2 col-md-2 col-12 m-t-10">
                                <select class="form-control custom-select" data-placeholder="Export As" tabindex="1">
                                    <option>Export As</option>
                                    <option value="xlsx">Excel</option>
                                    <option value="pdf">PDF</option>
                                    <option value="csv">CSV</option>
                                </select>
                            </div>
                        </div>

                        <hr>

                        <div class="row">
                            <div class="col-lg-12 col-xlg-12 col-md-12 col-12">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>REF #</th>
                                                <th>CLIENT</th>
                                                <th>SERVICE	DATE</th>
                                                <th>TIME</th>
                                                <th>DURATION</th>
                                                <th>LOCATION</th>
                                                <th>STAFF</th>
                                                <th>PRICE</th>
                                                <th class="text-center">STATUS</th>
                                            </tr>
                                        </thead>
                                        <tbody>




                                            <asp:ListView ID="lstApointment" runat="server">
                                                <ItemTemplate>

                                                    <tr>
                                                        <td><a href="#">#</a></td>
                                                        <td><a href="#"><%# Eval("ClientName")%></a></td>
                                                        <td><a href="#"><%# Eval("Time")%></a></td>
                                                        <td><a href="#">Wednesday,<br>
                                                            17 Jan 2018,<br>
                                                            8:30pm</a></td>


                                                        <td>

                                                            <asp:Label Visible='<%# If(  NOT Eval("Duration").Equals(DBNull.value) , true, false) %>'
                                                                runat="server">                                         
                                                                <a href="#"><%# Eval("Duration")%> min</a> 
                                                            </asp:Label>

                                                        </td>

                                                        <td><a href="#"><%# Eval("ClientCity")%></a></td>
                                                        <td><a href="#"><%# Eval("StaffName")%></a></td>
                                                        <td><a href="#"><%# Eval("RetailPrice")%> <%=Utility.GetCurrencySymbol()%></a></td>
                                                        <td class="text-center">
                                                            <a href="#"><span class="label label-info text-uppercase">New</span></a>
                                                        </td>
                                                    </tr>


                                                </ItemTemplate>
                                            </asp:ListView>




                                        </tbody>

                                    </table>

                                    <%--                                    <nav aria-label="Page navigation example" class="m-t-40">
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
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="Server">
</asp:Content>

