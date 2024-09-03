Imports Microsoft.VisualBasic

Public Class Encription
    Private Buffer As Byte() = New Byte(-1) {}
    'Encryption method for credit card


    Public Function EncryptTripleDES(Plaintext As String, Key As String) As String


        Dim DES As New System.Security.Cryptography.TripleDESCryptoServiceProvider()

        Dim hashMD5 As New System.Security.Cryptography.MD5CryptoServiceProvider()

        DES.Key = hashMD5.ComputeHash(System.Text.ASCIIEncoding.ASCII.GetBytes(Key))

        DES.Mode = System.Security.Cryptography.CipherMode.ECB

        Dim DESEncrypt As System.Security.Cryptography.ICryptoTransform = DES.CreateEncryptor()

        Buffer = System.Text.ASCIIEncoding.ASCII.GetBytes(Plaintext)

        Dim TripleDES As String = Convert.ToBase64String(DESEncrypt.TransformFinalBlock(Buffer, 0, Buffer.Length))

        Return TripleDES

    End Function
    'Decryption Method 

    Public Function DecryptTripleDES(base64Text As String, Key As String) As String


        Dim DES As New System.Security.Cryptography.TripleDESCryptoServiceProvider()

        Dim hashMD5 As New System.Security.Cryptography.MD5CryptoServiceProvider()

        DES.Key = hashMD5.ComputeHash(System.Text.ASCIIEncoding.ASCII.GetBytes(Key))

        DES.Mode = System.Security.Cryptography.CipherMode.ECB

        Dim DESDecrypt As System.Security.Cryptography.ICryptoTransform = DES.CreateDecryptor()

        Buffer = Convert.FromBase64String(base64Text)

        Dim DecTripleDES As String = System.Text.ASCIIEncoding.ASCII.GetString(DESDecrypt.TransformFinalBlock(Buffer, 0, Buffer.Length))

        Return DecTripleDES

    End Function
End Class
