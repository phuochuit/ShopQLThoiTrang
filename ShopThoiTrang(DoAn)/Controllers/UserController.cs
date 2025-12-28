using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Security.Cryptography;
using System.Text;

namespace ShopThoiTrang_DoAn_.Controllers
{
    public class UserController : Controller
    {
        NHOM8_DOANEntities db = new NHOM8_DOANEntities();
        public static string HashPassword(string password)
        {
            string salt = "huit";
            string saltedPassword = password + salt;

            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(saltedPassword));
                return Convert.ToBase64String(bytes);
            }
        }

        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult LoginOnSubmit(FormCollection collect)
        {
            string email = collect["email"];
            string password = collect["password"];
            bool remember = collect["rememberMe"] == "on";

            string passwordHash = HashPassword(password);

            KhachHang kh = db.KhachHangs.FirstOrDefault(x => x.Email == email && x.MatKhau == passwordHash);
            if (kh != null)
            {
                Session["User"] = kh;
                Session["Role"] = "KhachHang";
            }
            else
            {
                NhanVien nv = db.NhanViens.FirstOrDefault(x => x.Email == email && x.MatKhau == passwordHash);
                if (nv == null)
                {
                    ViewBag.ErrorMessage = "Thông tin đăng nhập không chính xác!";
                    return View("Login");
                }

                Session["User"] = nv;
                Session["Role"] = nv.VaiTro == 1 ? "Admin" : "NhanVien";
            }

            if (remember)
            {
                HttpCookie ckEmail = new HttpCookie("rememberEmail", email);
                ckEmail.Expires = DateTime.Now.AddDays(7);

                HttpCookie ckPass = new HttpCookie("rememberPass", password);
                ckPass.Expires = DateTime.Now.AddDays(7);

                Response.Cookies.Add(ckEmail);
                Response.Cookies.Add(ckPass);
            }

            return RedirectToAction("Index", "Home");
        }

        public ActionResult Logout()
        {
            Session["User"] = null;
            return RedirectToAction("Index", "Home");
        }

        [HttpGet]
        public ActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Register(KhachHang kh, string otpVerify)
        {
            if (string.IsNullOrWhiteSpace(kh.Email))
                ModelState.AddModelError("Email", "Email không được để trống");
            if (string.IsNullOrWhiteSpace(kh.MatKhau))
                ModelState.AddModelError("MatKhau", "Mật khẩu không được để trống");

            string sessionOtp = Session["RegisterOTP"] as string;
            string sessionEmail = Session["RegisterEmail"] as string;

            if (string.IsNullOrEmpty(sessionOtp) || sessionOtp != otpVerify)
            {
                ModelState.AddModelError("OTP", "Mã OTP không chính xác hoặc đã hết hạn.");
            }

            if (sessionEmail != kh.Email)
            {
                ModelState.AddModelError("Email", "Email đăng ký không khớp với email nhận mã.");
            }

            if (!ModelState.IsValid)
            {
                return View(kh);
            }

            var existEmail = db.KhachHangs.FirstOrDefault(x => x.Email == kh.Email);
            if (existEmail != null)
            {
                ModelState.AddModelError("", "Email đã được đăng ký trước đó.");
                return View(kh);
            }

            kh.VaiTro = 3;

            kh.MatKhau = HashPassword(kh.MatKhau);

            db.KhachHangs.Add(kh);
            db.SaveChanges();
            Session["RegisterOTP"] = null;
            Session["RegisterEmail"] = null;

            TempData["SuccessMessage"] = "Đăng ký thành công! Vui lòng đăng nhập.";

            return RedirectToAction("Login", "User");
        }

        [HttpGet]
        public ActionResult RegisterNhanVien()
        {
            if (Session["Role"] == null ||
                (Session["Role"].ToString() != "Admin" && Session["Role"].ToString() != "NhanVien"))
            {
                return RedirectToAction("Login");
            }

            return View();
        }

        [HttpPost]
        public ActionResult RegisterNhanVien(NhanVien nv, string otpVerify)
        {
            if (string.IsNullOrWhiteSpace(nv.Email))
                ModelState.AddModelError("Email", "Email không được để trống");
            if (string.IsNullOrWhiteSpace(nv.MatKhau))
                ModelState.AddModelError("MatKhau", "Mật khẩu không được để trống");

            string sessionOtp = Session["RegisterOTP"] as string;
            string sessionEmail = Session["RegisterEmail"] as string;

            if (string.IsNullOrEmpty(sessionOtp) || sessionOtp != otpVerify)
            {
                ModelState.AddModelError("OTP", "Mã OTP không chính xác hoặc đã hết hạn.");
            }

            if (sessionEmail != nv.Email)
            {
                ModelState.AddModelError("Email", "Email đăng ký không khớp với email nhận mã.");
            }


            if (!ModelState.IsValid)
                return View(nv);

            var existEmail = db.NhanViens.FirstOrDefault(x => x.Email == nv.Email);
            if (existEmail != null)
            {
                ModelState.AddModelError("", "Email đã được đăng ký trước đó.");
                return View(nv);
            }

            nv.VaiTro = 2;
            nv.VaiTro1 = db.VaiTroes.FirstOrDefault(v => v.IDVaiTro == 2);

            nv.MatKhau = HashPassword(nv.MatKhau);

            db.NhanViens.Add(nv);
            db.SaveChanges();

            Session["RegisterOTP"] = null;
            Session["RegisterEmail"] = null;

            TempData["SuccessMessage"] = "Đăng ký nhân viên thành công!";
            return View(new NhanVien());
        }

        public ActionResult LichSuDonHang()
        {
            if (Session["User"] == null)
            {
                return RedirectToAction("Login", "User");
            }

            var user = Session["User"] as KhachHang;
            if (user == null)
            {
                return RedirectToAction("Index", "Home");
            }

            var listDonHang = db.HoaDons
                                .Where(n => n.MaKH == user.MaKH)
                                .OrderByDescending(n => n.NgayLap)
                                .ToList();

            return View(listDonHang);
        }

        public ActionResult XemChiTietDonHang(int id)
        {
            if (Session["User"] == null) return RedirectToAction("Login", "User");
            var user = Session["User"] as KhachHang;

            var donHang = db.HoaDons.FirstOrDefault(n => n.MaHD == id && n.MaKH == user.MaKH);

            if (donHang == null)
            {
                TempData["Error"] = "Không tìm thấy đơn hàng hoặc bạn không có quyền xem.";
                return RedirectToAction("LichSuDonHang");
            }

            var chiTiet = db.ChiTietHoaDons.Where(n => n.MaHD == id).ToList();

            ViewBag.DonHang = donHang;

            return View(chiTiet);
        }

        [HttpGet]
        public ActionResult ForgotPassword()
        {
            return View();
        }

        [HttpPost]
        public ActionResult SendOtp(string email)
        {
            var kh = db.KhachHangs.FirstOrDefault(x => x.Email == email);
            var nv = db.NhanViens.FirstOrDefault(x => x.Email == email);

            if (kh == null && nv == null)
            {
                ViewBag.Error = "Email này chưa được đăng ký trong hệ thống!";
                return View("ForgotPassword");
            }

            if (kh != null)
            {
                Session["UserType"] = "KhanhHang";
            }
            else
            {
                Session["UserType"] = "NhanVien";
            }

            string otp = EmailHelper.GenerateOTP();
            string msgError;
            bool kq = EmailHelper.SendOTP(email, otp, out msgError);

            if (kq)
            {
                Session["OtpCode"] = otp;
                Session["ResetEmail"] = email;
                Session.Timeout = 5;

                return RedirectToAction("VerifyOtp");
            }
            else
            {
                ViewBag.Error = "Gửi mail thất bại: " + msgError;
                return View("ForgotPassword");
            }
        }

        [HttpGet]
        public ActionResult VerifyOtp()
        {
            if (Session["ResetEmail"] == null) return RedirectToAction("ForgotPassword");
            return View();
        }

        [HttpPost]
        public ActionResult VerifyOtp(string otpInput)
        {
            string sessionOtp = Session["OtpCode"] as string;

            if (sessionOtp != null && sessionOtp.Equals(otpInput))
            {
                Session["OtpCode"] = null;
                Session["IsVerified"] = true;
                return RedirectToAction("ResetPassword");
            }
            else
            {
                ViewBag.Error = "Mã OTP không đúng hoặc đã hết hạn!";
                return View();
            }
        }

        [HttpGet]
        public ActionResult ResetPassword()
        {
            if (Session["IsVerified"] == null) return RedirectToAction("ForgotPassword");
            return View();
        }

        [HttpPost]
        public ActionResult ResetPassword(string newPass, string confirmPass)
        {
            if (Session["IsVerified"] == null) return RedirectToAction("ForgotPassword");

            if (newPass != confirmPass)
            {
                ViewBag.Error = "Mật khẩu xác nhận không khớp!";
                return View();
            }

            string email = Session["ResetEmail"].ToString();
            string type = Session["UserType"] as string;


            if (type == "KhachHang")
            {
                var kh = db.KhachHangs.FirstOrDefault(x => x.Email == email);
                if (kh != null)
                {
                    kh.MatKhau = HashPassword(newPass);
                }
            }
            else if(type == "NhanVien")
            {
                var nv = db.NhanViens.FirstOrDefault(x => x.Email == email);
                if (nv != null)
                {
                    nv.MatKhau = HashPassword(newPass);
                }
            }
            db.SaveChanges();

            Session.Remove("ResetEmail");
            Session.Remove("OtpCode");
            Session.Remove("IsVerified");
            Session.Remove("UserType");

            TempData["SuccessMessage"] = "Đổi mật khẩu thành công! Hãy đăng nhập lại.";
            return RedirectToAction("Login");
        }

        [HttpPost]
        public JsonResult SendOtpAjax(string email)
        {
            var existKh = db.KhachHangs.FirstOrDefault(x => x.Email == email);
            var existNv = db.NhanViens.FirstOrDefault(x => x.Email == email);

            if (existKh != null || existNv != null)
            {
                return Json(new { success = false, message = "Email này đã được sử dụng!" });
            }

            string otp = EmailHelper.GenerateOTP();
            string msgError;
            bool sent = EmailHelper.SendOTP(email, otp, out msgError);

            if (sent)
            {
                Session["RegisterOTP"] = otp;
                Session["RegisterEmail"] = email;
                Session.Timeout = 5;
                return Json(new { success = true, message = "Mã OTP đã được gửi! Vui lòng kiểm tra email." });
            }
            else
            {
                return Json(new { success = false, message = "Lỗi gửi mail: " + msgError });
            }
        }
    }
}