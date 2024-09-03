
Imports System.Data
Imports System.Data.SqlClient

Partial Class BrandList
    Inherits System.Web.UI.Page



    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")

        If userID = 0 Then
            Response.Redirect("/login")


        End If
        LoadPaymentType()




    End Sub





    'DeletePaymentTypeById,GetPaymentTypeById,PaymentTypeID


    <System.Web.Services.WebMethod()>
    Public Shared Function GetPaymentTypeById(ByVal PaymentTypeID As String) As PaymentType


        'Dim m=BrandList.txtPaymentTypeName.Text

        Dim paymentType = New PaymentType()
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

        conn.Open()

        Dim selectString = "SELECT  top 1 * FROM PaymentType Where PaymentTypeId=@s"
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("@s", Data.SqlDbType.Int).Value = PaymentTypeID

        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()


        'CountryID,CountryName,MobileCode

        While reader.Read()
            paymentType.PaymentTypeId = reader("PaymentTypeId").ToString()
            paymentType.PaymentTypeName = reader("PaymentTypeName").ToString()
          
            paymentType.chkEditable = reader("Updateable").ToString()
            paymentType.chkDeletetable = reader("Deleteable").ToString()

  
        End While

        reader.Close()
        conn.Close()


        

        Return paymentType

    End Function







    <System.Web.Services.WebMethod()>
    Public Shared Function DeletePaymentTypeById(ByVal PaymentTypeID As String) As PaymentType

        Dim M As Integer

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

        conn.Open()

        Dim selectString = "DELETE PaymentType Where PaymentTypeId=@s"
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("@s", Data.SqlDbType.Int).Value = PaymentTypeID

        M = cmd.ExecuteNonQuery()
        conn.Close()

    End Function




    Public Sub LoadPaymentType()

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)


        Dim query As String




        If String.IsNullOrEmpty(txtSearch.Text) Then
            query = "SELECT *  FROM PaymentType"
        Else
            query = "SELECT *  FROM PaymentType Where PaymentTypeName  like '%" + txtSearch.Text + "%' "
        End If




        Dim da As SqlDataAdapter = New SqlDataAdapter(query, conn)
        Dim table As DataTable = New DataTable()

        da.Fill(table)

        lstPaymentType.DataSource = table
        lstPaymentType.DataBind()

        
    End Sub

    Public Class PaymentType

        

        Public Property PaymentTypeId As String
        Public Property PaymentTypeName As String


       
        Public Property chkEditable As Boolean
        Public Property chkDeletetable As Boolean

    End Class




    Protected Sub SaveCountryData(sender As Object, e As EventArgs) Handles btnsave.Click

        Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")


        If Not String.IsNullOrEmpty(txtPaymentTypeName.Text) Then

            Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

            conn.Open()

            Dim M As String = ""
            Dim selectString = ""
            Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)

            

            If Not String.IsNullOrEmpty(hidPaymentTypeID.Value) Then
                selectString = "UPDATE PaymentType SET PaymentTypeName=@PaymentTypeName,UpdatedBy=@CreateBy,UpdatedDate=GETDATE(),Updateable=@Updateable,Deleteable=@Deleteable Where PaymentTypeId=@PaymentTypeId"
                cmd.Parameters.Add("PaymentTypeId", Data.SqlDbType.Int).Value = hidPaymentTypeID.Value
            Else
                selectString = "INSERT INTO [PaymentType] (PaymentTypeName,CreateDate,CreateBy,Updateable,Deleteable) VALUES (@PaymentTypeName,GETDATE(),@CreateBy,@Updateable,@Deleteable)"
            End If

            cmd.Parameters.Add("PaymentTypeName", Data.SqlDbType.NVarChar).Value =txtPaymentTypeName.Text
            cmd.Parameters.Add("CreateBy", Data.SqlDbType.Int).Value = userID


            
            
            
            cmd.Parameters.Add("Updateable", Data.SqlDbType.Bit).Value = chkEditable.Checked
            cmd.Parameters.Add("Deleteable", Data.SqlDbType.Bit).Value = chkDeletetable.Checked

            cmd.CommandText = selectString

            M = cmd.ExecuteNonQuery

            If M > 0 Then
                LoadPaymentType()
            End If


            conn.Close()

        End If


    End Sub










End Class
