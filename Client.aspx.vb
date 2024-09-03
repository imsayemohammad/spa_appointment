
Imports System.Data.SqlClient

Partial Class Client
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            If Not String.IsNullOrEmpty(System.Web.HttpContext.Current.Session.SessionID) Then
                Dim userid As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By LogId DESC")

                Dim sessionid As String = System.Web.HttpContext.Current.Session.SessionID
                Dim dbsessionid As String = Utility.StringData("Select TOP 1 SessionId From UserLog_Data Where UserId =" & userid & "")
                loaddata()
                If sessionid = dbsessionid Then
                    loaddata()
                Else
                    'Response.Redirect("/login")
                End If
            Else
                Response.Redirect("/login")
            End If
        End If
    End Sub


    Protected Sub loaddata()

        Dim currentPage As String
        Dim pageSize As String
        Dim pageNumber As String
        Dim searchCriteria As String
        Dim whereclause As String = ""
        Dim conditionclause As String = ""

        If Request.QueryString("search") <> "" Then
            txtsearch.Text = Request.QueryString("search")
        End If

        If txtsearch.Text <> "" Then
            whereclause += "Where FirstName like '" & txtsearch.Text & "%' or LastName like '" & txtsearch.Text & "%' or (FirstName + ' ' + LastName) like '" & txtsearch.Text & "%' or Phone1 like'" & txtsearch.Text & "%'"
            conditionclause += "&search=" & txtsearch.Text & " "
        End If

        currentPage = If(Request.QueryString("page") <> "", Request.QueryString("page"), "1")
        pageSize = "10"
        searchCriteria = "/Client?page="

        Dim sql As String = ""
        sql = "DECLARE @PageNum AS INT;DECLARE @PageSize AS INT;SET @PageNum =" & currentPage & ";SET @PageSize = " & pageSize & "; select *  from ( select  ROW_NUMBER() over( order by ClientID desc) AS RowNum , *,(FirstName + ' ' + LastName) Name From Client " & whereclause & " )as MyTable WHERE RowNum BETWEEN (@PageNum - 1) * @PageSize + 1 AND @PageNum * @PageSize  ORDER BY MyTable.RowNum desc "
        sdsClient.SelectCommand = sql
        sdsClient.DataBind()

        pageNumber = getPageNumber(pageSize)
        ltlpag.Text = ""
        If pageNumber > 1 Then
            ltlpag.Text = Utility.GetPager(currentPage, pageNumber, 5, searchCriteria, conditionclause)
        End If

    End Sub


    Private Function getPageNumber(ByVal pageSize As Integer) As Integer

        Dim whereclause As String = ""
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        conn.Open()

        If Request.QueryString("search") <> "" Then
            txtsearch.Text = Request.QueryString("search")
        End If

        If txtsearch.Text <> "" Then
            whereclause += "Where FirstName like '" & txtsearch.Text & "%' or LastName like '" & txtsearch.Text & "%' or (FirstName + ' ' + LastName) like '" & txtsearch.Text & "%' or Phone1 like'" & txtsearch.Text & "%'"
        End If

        Dim selectString = "Select Count(*) totalRows From Client " & whereclause & " "
        Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
        reader.Read()
        Dim totalRows As Integer = reader("totalRows").ToString()
        reader.Close()
        conn.Close()
        'lblsearchresult.Text = totalRows
        Return Math.Ceiling(totalRows / pageSize)
    End Function

    Protected Sub btnsearch_Click(sender As Object, e As EventArgs) Handles btnsearch.Click

        Dim whclause As Boolean
        Dim whand As String = ""
        Dim sql1 As String = ""
        Dim querystr As String = ""
        Dim linkcar As String = ""

        If txtsearch.Text <> "" Then
            'Nothing
            If whclause = False Then
                whand = " Where "
                linkcar = "?"
            Else
                whand = " AND "
                linkcar = "&"
            End If
            querystr += linkcar & "search=" & txtsearch.Text
            whclause = True

        End If

        Response.Redirect("/Client" & querystr)
    End Sub



    <System.Web.Services.WebMethod()>
    Public Shared Sub SaveData(ByVal clientid As String, ByVal FirstName As String, ByVal LastName As String, ByVal Phone As String, ByVal Telephone As String, ByVal bookings As String,
                               ByVal Email As String, ByVal Notification As String, ByVal refsource As String, ByVal gender As String, ByVal Notes As String, ByVal dob As String,
                               ByVal address As String, ByVal City As String, ByVal state As String, ByVal zipcode As String, ByVal suburb As String, ByVal latitude As String, ByVal longitude As String)
        'Dim userID As Integer = CType(HttpContext.Current.Request.Cookies("aUserID").Value.ToString(), Integer)
        Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")

        If Not String.IsNullOrEmpty(FirstName) Then
            Dim selectString As String = ""
            Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
            conn.Open()
            Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
            If Not String.IsNullOrEmpty(clientid) Then
                selectString = "UPDATE [Client] SET [FirstName] = @FirstName, [LastName] = @LastName, [DOB]=@DOB, [Gender]= @Gender, [Phone1] = @Phone1, [Email] = @Email, [Notes] = @Notes, [Notification]= @Notification, [RefSource]= @RefSource, [Booking]=@Booking, [UpdatedBy] = @ChangeBy, [UpdatedDate] = Getdate() WHERE [ClientID] = @ClientID"
                cmd.Parameters.Add("ClientID", Data.SqlDbType.Int).Value = clientid
            Else
                selectString = "INSERT INTO [Client] ([FirstName], [LastName], [DOB], [Gender], [Phone1], [Phone2], [Email], [Notes], [Notification], [RefSource], [Booking], [CreateBy], [CreateDate]) VALUES (@FirstName, @LastName, @DOB, @Gender, @Phone1, @Phone2, @Email, @Notes, @Notification, @RefSource, @Booking, @ChangeBy, Getdate())"
            End If

            cmd.Parameters.Add("FirstName", Data.SqlDbType.NVarChar).Value = FirstName
            cmd.Parameters.Add("LastName", Data.SqlDbType.NVarChar).Value = LastName
            cmd.Parameters.Add("DOB", Data.SqlDbType.DateTime).Value = dob
            cmd.Parameters.Add("Gender", Data.SqlDbType.NVarChar).Value = gender
            cmd.Parameters.Add("Phone1", Data.SqlDbType.NVarChar).Value = Phone
            cmd.Parameters.Add("Phone2", Data.SqlDbType.NVarChar).Value = Telephone
            cmd.Parameters.Add("Email", Data.SqlDbType.NVarChar).Value = Email
            cmd.Parameters.Add("Notes", Data.SqlDbType.NVarChar).Value = Notes
            cmd.Parameters.Add("Notification", Data.SqlDbType.NVarChar).Value = Notification
            cmd.Parameters.Add("RefSource", Data.SqlDbType.NVarChar).Value = refsource
            cmd.Parameters.Add("Booking", Data.SqlDbType.NVarChar).Value = bookings
            cmd.Parameters.Add("ChangeBy", Data.SqlDbType.Int).Value = userID

            cmd.CommandText = selectString
            cmd.ExecuteNonQuery()
            conn.Close()
            InsertClientLocation(clientid, address, City, state, zipcode, suburb, latitude, longitude, userID)
        End If
    End Sub

    Private Shared Sub InsertClientLocation(ByVal clientid As String, ByVal address As String, ByVal city As String, ByVal state As String, ByVal zipcode As String, ByVal suburb As String, ByVal latitude As String, ByVal longitude As String, ByVal userID As String)
        Dim selectString As String = ""
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        conn.Open()
        Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
        'If Not String.IsNullOrEmpty(clientid) Then
        '    selectString = "UPDATE [ClientLocation] SET [Address] = @Address, [City] = @City, [State]=@State, [ZipCode]= @ZipCode, [Suburb] = @Suburb, [Latitude] = @Latitude, [Longitude] = @Longitude, [UpdatedBy] = @ChangeBy, [UpdatedDate] = Getdate() WHERE ClientLocationID=@ClientLocationID AND [ClientID] = @ClientID"
        '    cmd.Parameters.Add("ClientLocationID", Data.SqlDbType.Int).Value = clientid
        'Else
        '    selectString = "INSERT INTO [ClientLocation] ([ClientID], [Address], [City], [State], [ZipCode], [Suburb], [Latitude], [Longitude], [CreateBy], [CreateDate]) VALUES (@ClientID, @Address, @City, @State, @ZipCode, @Suburb, @Latitude, @Longitude, @ChangeBy, Getdate())"
        'End If
        selectString = "INSERT INTO [ClientLocation] ([ClientID], [Address], [City], [State], [ZipCode], [Suburb], [Latitude], [Longitude], [CreateBy], [CreateDate]) VALUES (@ClientID, @Address, @City, @State, @ZipCode, @Suburb, @Latitude, @Longitude, @ChangeBy, Getdate())"

        cmd.Parameters.Add("ClientID", Data.SqlDbType.BigInt).Value = clientid
        cmd.Parameters.Add("Address", Data.SqlDbType.NVarChar).Value = address
        cmd.Parameters.Add("City", Data.SqlDbType.NVarChar).Value = city
        cmd.Parameters.Add("State", Data.SqlDbType.NVarChar).Value = state
        cmd.Parameters.Add("ZipCode", Data.SqlDbType.NVarChar).Value = zipcode
        cmd.Parameters.Add("Suburb", Data.SqlDbType.NVarChar).Value = suburb
        cmd.Parameters.Add("Latitude", Data.SqlDbType.NVarChar).Value = latitude
        cmd.Parameters.Add("Longitude", Data.SqlDbType.NVarChar).Value = longitude
        cmd.Parameters.Add("ChangeBy", Data.SqlDbType.Int).Value = userID

        cmd.CommandText = selectString
        cmd.ExecuteNonQuery()
        conn.Close()
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function ClientByClientId(ByVal clientid As String) As Model
        Dim client As New Model
        Using conn As New SqlConnection()
            conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
            Using cmd As New SqlCommand()
                cmd.CommandText = "SELECT * FROM Client C LEFT Join ClientLocation CL ON C.ClientID = CL.ClientID Where C.ClientID=@ClientID"
                cmd.Parameters.Clear()
                cmd.Parameters.Add("@ClientID", Data.SqlDbType.Int).Value = clientid
                cmd.Connection = conn
                conn.Open()
                Using reader As SqlDataReader = cmd.ExecuteReader()
                    While reader.Read()
                        client.clientid = reader("ClientID").ToString()
                        client.FirstName = reader("FirstName").ToString()
                        client.LastName = reader("LastName").ToString()
                        client.dob = reader("DOB").ToString()
                        client.gender = reader("Gender").ToString()
                        client.Phone = reader("Phone1").ToString()
                        client.Telephone = reader("Phone2").ToString()
                        client.Email = reader("Email").ToString()
                        client.Notes = reader("Notes").ToString()
                        client.refsource = reader("RefSource").ToString()
                        client.bookings = reader("Booking").ToString()
                        client.Notification = reader("Notification").ToString()

                        client.Notification = reader("Address").ToString()
                        client.city = reader("City").ToString()
                        client.state = reader("State").ToString()
                        client.zipcode = reader("ZipCode").ToString()
                        client.suburb = reader("Suburb").ToString()
                        client.latitude = reader("Latitude").ToString()
                        client.longitude = reader("Longitude").ToString()
                    End While
                End Using
                conn.Close()
            End Using
            Return client
        End Using
    End Function

    Protected Function GetRating(ByVal clientid As Integer) As String
        Dim m As String = ""
        Dim connection = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
        Dim conn As New Data.SqlClient.SqlConnection(connection)
        conn.Open()
        Dim selectString = "Select AVG(Rating) Rating From ClientRatings Where ClientID=@ClientID"
        Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
        cmd.Parameters.Clear()
        cmd.Parameters.Add("ClientID", Data.SqlDbType.Int).Value = clientid
        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
        While reader.Read()
            Dim rating = reader("Rating").ToString()
            m += rating.TrimEnd(New String({"0", "."}))
        End While

        reader.Close()
        conn.Close()

        Return m
    End Function

    'Protected Sub btnsave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnsave.Click
    '    Dim intInsertUpdate As Integer

    '    If Request.QueryString("staffid") <> "" Then
    '        intInsertUpdate = sdsClient.Update

    '        If intInsertUpdate = 1 Then
    '            Response.Redirect("/Client", False)
    '        End If
    '    Else
    '        intInsertUpdate = sdsClient.Insert

    '        If intInsertUpdate = 1 Then
    '            Response.Redirect("/Client", False)
    '            'lblmsg.Text = "Operation Done"
    '            'lblmsg.Visible = True
    '        End If
    '    End If
    'End Sub

End Class
