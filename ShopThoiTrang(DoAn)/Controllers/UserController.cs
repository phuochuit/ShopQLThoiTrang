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
        public ActionResult Register(KhachHang kh)
        {
            if (string.IsNullOrWhiteSpace(kh.Email))
                ModelState.AddModelError("Email", "Email không được để trống");
            if (string.IsNullOrWhiteSpace(kh.MatKhau))
                ModelState.AddModelError("MatKhau", "Mật khẩu không được để trống");

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
        public ActionResult RegisterNhanVien(NhanVien nv)
        {
            if (string.IsNullOrWhiteSpace(nv.Email))
                ModelState.AddModelError("Email", "Email không được để trống");
            if (string.IsNullOrWhiteSpace(nv.MatKhau))
                ModelState.AddModelError("MatKhau", "Mật khẩu không được để trống");

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
    }
}