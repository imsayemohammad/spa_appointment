<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="contact-us.aspx.vb" Inherits="contact_us" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="toppart" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="Server">

    <div class="about_heading">
        <div class="container">
            <div class="row menu_padiing">
                <h2>Contact Us <span><a href="/">Home</a>  /  Contact Us</span></h2>
            </div>
        </div>
    </div>
    <div class="login_part">
        <div class="container">
            <div class="row menu_padiing">
                <div class="login_tab">

                    <asp:Literal ID="ltrlBigDetails" runat="server"></asp:Literal>

                    <div class="tab-content detail_tab">

                        <div id="signup" class="tab-pane fade in active">
                            <div class="login_box">
                                <div class="login_bg">
                                    <h3>Contact Us</h3>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" Display="Dynamic" runat="server"
                                        ControlToValidate="txtName"
                                        ErrorMessage="RequiredFieldValidator" SetFocusOnError="True" ValidationGroup="regfull">*</asp:RequiredFieldValidator>
                                    <asp:TextBox ID="txtName" Display="Dynamic" CssClass="login_input" placeholder="Name"
                                        runat="server"></asp:TextBox>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" Display="Dynamic" runat="server" ControlToValidate="txtREmail"
                                        ErrorMessage="RequiredFieldValidator" SetFocusOnError="True" ValidationGroup="regfull">*</asp:RequiredFieldValidator>

                                    <asp:RegularExpressionValidator Display="Dynamic" ID="RegularExpressionValidator2"
                                        runat="server" ControlToValidate="txtREmail"
                                        ErrorMessage="RegularExpressionValidator" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                        ValidationGroup="regfull">Invalid Format!</asp:RegularExpressionValidator>

                                    <asp:TextBox ID="txtREmail" Display="Dynamic" CssClass="login_input" placeholder="Email Address"
                                        runat="server"></asp:TextBox>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" Display="Dynamic" runat="server"
                                        ControlToValidate="txtMobile"
                                        ErrorMessage="RequiredFieldValidator" SetFocusOnError="True" ValidationGroup="regfull">*</asp:RequiredFieldValidator>

                                    <asp:RegularExpressionValidator Display="Dynamic" ID="RegularExpressionValidator3"
                                        runat="server" ControlToValidate="txtMobile"
                                        ErrorMessage="RegularExpressionValidator" ValidationExpression="^(?:\+971|00971|0)?(?:50|51|52|55|56|2|3|4|6|7|9)\d{7}$"
                                        ValidationGroup="regfull">Invalid Phone No.</asp:RegularExpressionValidator>

                                    <asp:TextBox ID="txtMobile" Display="Dynamic" CssClass="login_input" placeholder="Phone eg(+/0097xxxxxxxxxx)"
                                        runat="server"></asp:TextBox>

                                    <asp:TextBox ID="txtAddress" Display="Dynamic" TextMode="MultiLine" placeholder="Address" CssClass="login_input" runat="server"></asp:TextBox>

                                    <asp:TextBox ID="txtMessage" Display="Dynamic" TextMode="MultiLine" placeholder="Message" CssClass="login_input" runat="server"></asp:TextBox>


                                    <asp:Button ID="btnregister" runat="server" Text="Submit" CssClass="login_bg_btn" ValidationGroup="regfull" />

                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <asp:SqlDataSource ID="sdsSave" runat="server"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        InsertCommand="INSERT INTO [Contact_Website] ([Name], [Address], [Email], [PhoneNo], [Message], [ContactDate]) VALUES (@Name, @Address, @Email, @PhoneNo, @Message, GetDate())" 
        DeleteCommand="DELETE FROM [Contact_Website] WHERE [CWebID] = @CWebID" 
        SelectCommand="SELECT * FROM [Contact_Website]" 
        UpdateCommand="UPDATE [Contact_Website] SET [ContactID] = @ContactID, [Name] = @Name, [Address] = @Address, [Email] = @Email, [PhoneNo] = @PhoneNo, [Message] = @Message, [ContactDate] = @ContactDate WHERE [CWebID] = @CWebID">

        <DeleteParameters>
            <asp:Parameter Name="CWebID" Type="Int32" />
        </DeleteParameters>

        <InsertParameters>
            <asp:ControlParameter ControlID="txtName" Name="Name" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtAddress" Name="Address" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtREmail" Name="Email" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtMobile" Name="PhoneNo" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtMessage" Name="Message" PropertyName="Text" Type="String" />
        </InsertParameters>

        <UpdateParameters>
            <asp:Parameter Name="ContactID" Type="Int32" />
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Address" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="PhoneNo" Type="String" />
            <asp:Parameter Name="Message" Type="String" />
            <asp:Parameter Name="ContactDate" Type="DateTime" />
            <asp:Parameter Name="CWebID" Type="Int32" />
        </UpdateParameters>

    </asp:SqlDataSource>

</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="Server">
</asp:Content>

