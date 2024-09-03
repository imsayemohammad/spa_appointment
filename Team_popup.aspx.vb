
Imports System.Data
Imports System.Data.SqlClient
Partial Class Team_popup
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then

            If Request.QueryString("id") <> "" Then
                LoadData(Request.QueryString("id"))
            End If
        End If




    End Sub

    Public Sub LoadData(s As String)
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

        conn.Open()

        Dim selectString = "SELECT * FROM TeamMST Where TeamID=@s"
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("@s", Data.SqlDbType.Int).Value = s

        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()


        While reader.Read()
            txtTeamName.Text = reader("TeamName").ToString()
            txtTeamDetails.Text = reader("Description").ToString()
            hidTeamID.Value = reader("TeamID").ToString()
            chkStatus.Checked = reader("Status").ToString()
            Dim color = reader("Color").ToString()

            If color.Equals("pink") Then
                radio_1.Checked = True
            End If

            If color.Equals("purple") Then
                radio_2.Checked = True
            End If

            If color.Equals("indigo") Then
                radio_3.Checked = True
            End If

            If color.Equals("blue") Then
                radio_4.Checked = True
            End If

            If color.Equals("cyan") Then
                radio_5.Checked = True
            End If

            If color.Equals("teal") Then
                radio_6.Checked = True
            End If

            If color.Equals("green") Then
                radio_7.Checked = True
            End If

            If color.Equals("lime") Then
                radio_8.Checked = True
            End If
            If color.Equals("yellow") Then
                radio_9.Checked = True
            End If

            If color.Equals("orange") Then
                radio_10.Checked = True
            End If

        End While

        reader.Close()
        conn.Close()

    End Sub


    Protected Sub SaveTeamData(sender As Object, e As EventArgs) Handles btnsave.Click


        Dim color As String = ""


        If radio_1.Checked Then
            color = "pink"
        End If

        If radio_2.Checked Then
            color = "purple"
        End If

        If radio_3.Checked Then
            color = "indigo"
        End If

        If radio_4.Checked Then
            color = "blue"
        End If

        If radio_5.Checked Then
            color = "cyan"
        End If
        If radio_6.Checked Then
            color = "teal"
        End If
        If radio_7.Checked Then
            color = "green"
        End If
        If radio_8.Checked Then
            color = "lime"
        End If
        If radio_9.Checked Then
            color = "yellow"
        End If

        If radio_10.Checked Then
            color = "orange"
        End If
        
        Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")
        Dim M As Integer

        If Not String.IsNullOrEmpty(txtTeamName.Text) Then

            Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

            Dim selectString = ""
            Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)

            If Request.QueryString("id") <> "" Then
                conn.Open()
                selectString = "UPDATE TeamMST SET   Color=@Color,Status=@Status, TeamName=@TeamName,Description=@Description,UpdatedBy=@CreateBy,UpdatedDate=GETDATE() Where TeamID=@TeamID"
                cmd.Parameters.Add("TeamID", Data.SqlDbType.BigInt).Value = Request.QueryString("id")

                cmd.Parameters.Add("TeamName", Data.SqlDbType.NVarChar).Value = txtTeamName.Text
                cmd.Parameters.Add("Description", Data.SqlDbType.NVarChar).Value = txtTeamDetails.Text
                cmd.Parameters.Add("Color", Data.SqlDbType.NVarChar).Value = color
                cmd.Parameters.Add("CreateBy", Data.SqlDbType.Int).Value = userID
                cmd.Parameters.Add("Status", Data.SqlDbType.Bit).Value = chkStatus.Checked




                cmd.CommandText = selectString
                M = cmd.ExecuteNonQuery()

                conn.Close()
            Else

                If NotExists(txtTeamName.Text) Then
                    conn.Open()
                    selectString = "INSERT INTO [TeamMST] (TeamName,Description,CreateDate,CreateBy,Color,Status) VALUES (@TeamName,@Description,GETDATE(),@CreateBy,@Color,@Status)"
                    cmd.Parameters.Add("TeamName", Data.SqlDbType.NVarChar).Value = txtTeamName.Text
                    cmd.Parameters.Add("Description", Data.SqlDbType.NVarChar).Value = txtTeamDetails.Text
                    cmd.Parameters.Add("Color", Data.SqlDbType.NVarChar).Value = color
                    cmd.Parameters.Add("CreateBy", Data.SqlDbType.Int).Value = userID
                    cmd.Parameters.Add("Status", Data.SqlDbType.Bit).Value = chkStatus.Checked


                    cmd.CommandText = selectString
                    M = cmd.ExecuteNonQuery()

                    conn.Close()
                End If

            End If


        End If

        '        Response.Redirect("/")

        If M > 0 Then

            ClientScript.RegisterStartupScript(Me.GetType, "Load", "<script type='text/javascript'>window.parent.location.href = '/team'; </script>")
        End If


    End Sub

    Private Function NotExists(text As String) As Boolean

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        conn.Open()
        Dim selectString As String

        selectString = "SELECT Count(TeamID) as totalRows  FROM TeamMST   Where TeamName  Like '%" + text + "%' "

        Dim totalRows As Integer
        Dim number As Integer = 0



        Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
        reader.Read()
        Integer.TryParse(reader("totalRows").ToString(), number)
        totalRows = number
        reader.Close()
        conn.Close()

        If totalRows > 0 Then
            Return False
        Else
            Return True
        End If
    End Function
End Class
