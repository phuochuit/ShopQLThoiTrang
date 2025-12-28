using System;
using System.Net;
using System.Net.Mail;

namespace ShopThoiTrang_DoAn_ // Cùng namespace với project của bạn
{
    public class EmailHelper
    {
        // ⚠️ Cấu hình mail (Nên để trong Web.config thực tế)
        private static string SENDER_EMAIL = "riderkamen0909@gmail.com";
        private static string SENDER_PASS = "silrjahdeqjpmjpz"; // Mật khẩu ứng dụng

        public static string GenerateOTP()
        {
            Random r = new Random();
            return r.Next(100000, 999999).ToString();
        }

        public static bool SendOTP(string toEmail, string otpCode, out string errorMessage)
        {
            errorMessage = string.Empty;
            try
            {
                ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
                MailMessage mail = new MailMessage();
                mail.From = new MailAddress(SENDER_EMAIL);
                mail.To.Add(toEmail);
                mail.Subject = "Mã xác thực lấy lại mật khẩu";
                mail.Body = $"<h3>Mã OTP của bạn là: <b style='color:red'>{otpCode}</b></h3>" +
                            $"<p>Mã có hiệu lực trong 5 phút.</p>";
                mail.IsBodyHtml = true;

                SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
                smtp.EnableSsl = true;
                smtp.Credentials = new NetworkCredential(SENDER_EMAIL, SENDER_PASS);
                smtp.Send(mail);
                return true;
            }
            catch (Exception ex)
            {
                errorMessage = ex.Message;
                return false;
            }
        }
    }
}