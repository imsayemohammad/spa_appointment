Imports Microsoft.VisualBasic
Imports System.Xml

Public Class VideoModule
    Public VideoIFrame As String
    Public SmallImage As String
    Public BigImage As String
    Public Sub VideoModule()

    End Sub
    
    Public Function ProcessVideoURL(ByVal txtLink As String) As Integer

        Dim vCode As String = ""
        Dim retValue As Integer = -1

        Try
            If txtLink.Contains("www.youtube.com") Then
                txtLink = If(txtLink.Contains("http://"), txtLink, "http://" & txtLink)
                If txtLink.Contains("v=") Then
                    vCode = GetVcode(txtLink)
                    VideoIFrame = GenerateIframeCode(vCode, 447, 335)
                    SmallImage = GenerateSmallImageURL(vCode)
                    BigImage = GenetareBigImageURL(vCode)
                    retValue = 1
                Else
                    retValue = -2
                    Return retValue
                End If
            ElseIf txtLink.Contains("vimeo.com") Then
                txtLink = If(txtLink.Contains("http://"), txtLink, "http://" & txtLink)
                Try
                    vCode = txtLink.Split("/")(3)
                Catch ex As Exception
                    retValue = -3
                    Return retValue
                End Try
                Try
                    GetVimeoVideoNImage(vCode, 447, 335)
                    retValue = 1
                Catch ex As Exception
                    retValue = -4
                    Return retValue
                End Try

            Else

                retValue = -2
                Return retValue
            End If



        Catch
            retValue = -1
        End Try

        Return retValue
    End Function

    Public Function ProcessVideoURL(ByVal txtLink As String, ByVal width As String, ByVal height As String) As Integer

        Dim vCode As String = ""
        Dim retValue As Integer = -1

        Try
            If txtLink.Contains("www.youtube.com") Then
                txtLink = If(txtLink.Contains("http://"), txtLink, "http://" & txtLink)
                If txtLink.Contains("v=") Then
                    vCode = GetVcode(txtLink)
                    VideoIFrame = GenerateIframeCode(vCode, width, height)
                    SmallImage = GenerateSmallImageURL(vCode)
                    BigImage = GenetareBigImageURL(vCode)
                    retValue = 1
                Else
                    retValue = -2
                    Return retValue
                End If
            ElseIf txtLink.Contains("vimeo.com") Then
                txtLink = If(txtLink.Contains("http://"), txtLink, "http://" & txtLink)
                Try
                    vCode = txtLink.Split("/")(3)
                Catch ex As Exception
                    retValue = -3
                    Return retValue
                End Try
                Try
                    GetVimeoVideoNImage(vCode, width, height)
                    retValue = 1
                Catch ex As Exception
                    retValue = -4
                    Return retValue
                End Try

            Else

                retValue = -2
                Return retValue
            End If



        Catch
            retValue = -1
        End Try

        Return retValue
    End Function

    ''' <summary>
    ''' Youtube
    ''' </summary>
    ''' <param name="url"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Private Function GetVcode(ByVal url As String) As String
        'http://www.youtube.com/watch?v=YVOquldmUXE&feature=player_embedded
        Dim vCode As String = ""
        If url.Contains("v=") Then
            Dim vIndex As Integer = url.IndexOf("v=")
            Dim ampIndex As Integer = url.IndexOf("&", vIndex)
            If (ampIndex > 0) Then
                vCode = url.Substring(vIndex + 2, ampIndex - (vIndex + 2))
            Else
                vCode = url.Substring(vIndex + 2)
            End If
        End If

        Return vCode
    End Function
    ''' <summary>
    ''' Youtube Iframe
    ''' </summary>
    ''' <param name="vCode"></param>
    ''' <param name="width"></param>
    ''' <param name="hight"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Private Function GenerateIframeCode(ByVal vCode As String, ByVal width As String, ByVal hight As String) As String
        '<iframe title="YouTube video player" src="http://www.youtube.com/embed/-9hsl6iq-v8" allowfullscreen="" width="550" frameborder="0" height="450"></iframe>
        Dim iFrame As String = ""
        If vCode <> "" Then
            'iFrame = "<object width=""" & width & """ height=""" & hight & """><param name=""movie"" value=""http://www.youtube.com/v/" & vCode & """></param><param name=""wmode"" value=""transparent""></param><embed src=""http://www.youtube.com/v/" & vCode & """ type=""application/x-shockwave-flash"" wmode=""transparent"" width=""" & width & """ height=""" & hight & """></embed></object>"
            iFrame = "<iframe title=""YouTube video player"" src=""http://www.youtube.com/embed/" & vCode & "?wmode=opaque"" allowfullscreen="""" width=""" & width & """ frameborder=""0"" height=""" & hight & """></iframe>"

        End If
        Return iFrame

    End Function

    Private Function GenerateSmallImageURL(ByVal vCode As String) As String
        Return "http://img.youtube.com/vi/" & vCode & "/1.jpg"
    End Function

    Private Function GenetareBigImageURL(ByVal vCode As String) As String
        Return "http://img.youtube.com/vi/" & vCode & "/0.jpg"
    End Function

    ''' <summary>
    ''' Vimeo
    ''' </summary>
    ''' <param name="vCode"></param>
    ''' <param name="width"></param>
    ''' <param name="height"></param>
    ''' <remarks></remarks>
    Private Sub GetVimeoVideoNImage(ByVal vCode As String, ByVal width As String, ByVal height As String)

        Dim m_xmld As XmlDocument
        Dim m_nodelist As XmlNodeList
        Dim m_node As XmlNode
        'Create the XML Document

        m_xmld = New XmlDocument()
        'Load the Xml file

        m_xmld.Load("http://vimeo.com/api/oembed.xml?url=http://vimeo.com/" & vCode)
        'Get the list of name nodes 

        m_nodelist = m_xmld.SelectNodes("/oembed")
        'Loop through the nodes

        For Each m_node In m_nodelist


            BigImage = m_node("thumbnail_url").InnerText
            SmallImage = m_node("thumbnail_url").InnerText
            'hdnVideoURL.Value = "<object width=""" & width & """ height=""" & height & """><param name=""allowfullscreen"" value=""true"" /><param name=""allowscriptaccess"" value=""always"" /><param name=""movie"" value=""http://vimeo.com/moogaloop.swf?clip_id=" & vCode & "&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=1&amp;color=00adef&amp;fullscreen=1&amp;autoplay=0&amp;loop=0"" /><embed src=""http://vimeo.com/moogaloop.swf?clip_id=" & vCode & "&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=1&amp;color=00adef&amp;fullscreen=1&amp;autoplay=0&amp;loop=0"" type=""application/x-shockwave-flash"" allowfullscreen=""true"" allowscriptaccess=""always"" width=""" & width & """ height=""" & height & """></embed></object><p><a href=""http://vimeo.com/" & vCode & """>Ten for Grandpa</a> from <a href=""http://vimeo.com/pieface"">Pie Face Pictures</a> on <a href=""http://vimeo.com"">Vimeo</a>.</p>"
            'hdnVideoURL.Value = "<iframe src=""http://player.vimeo.com/video/" & vCode & "?title=0&amp;byline=0&amp;portrait=0"" width=""" & width & """ height=""" & height & """ frameborder=""0""></iframe>"
            'VideoIFrame = "<object width=""" & width & """ height=""" & height & """><param name=""movie"" value=""http://vimeo.com/moogaloop.swf?clip_id=" & vCode & "&amp;server=vimeo.com&amp;show_title=0&amp;show_byline=0&amp;show_portrait=0&amp;color=00adef&amp;fullscreen=1&amp;autoplay=0&amp;loop=0""></param><param name=""wmode"" value=""transparent""></param><embed src=""http://vimeo.com/moogaloop.swf?clip_id=" & vCode & "&amp;server=vimeo.com&amp;show_title=0&amp;show_byline=0&amp;show_portrait=0&amp;color=00adef&amp;fullscreen=1&amp;autoplay=0&amp;loop=0"" type=""application/x-shockwave-flash"" wmode=""transparent"" width=""" & width & """ height=""" & height & """></embed></object>"
            VideoIFrame = "<object width=""" & width & """ height=""" & height & """><param name=""movie"" value=""http://vimeo.com/moogaloop.swf?clip_id=" & vCode & "&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=0&amp;show_portrait=0&amp;color=#000&amp;fullscreen=1&amp;autoplay=0&amp;loop=0""></param><param name=""wmode"" value=""transparent""></param><embed src=""http://vimeo.com/moogaloop.swf?clip_id=" & vCode & "&amp;server=vimeo.com&amp;show_title=0&amp;show_byline=0&amp;show_portrait=0&amp;color=00adef&amp;fullscreen=1&amp;autoplay=0&amp;loop=0"" type=""application/x-shockwave-flash"" wmode=""transparent"" width=""" & width & """ height=""" & height & """></embed></object>"
        Next

    End Sub
End Class
