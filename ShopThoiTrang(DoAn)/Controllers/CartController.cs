using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ShopThoiTrang_DoAn_.Models;

namespace ShopThoiTrang_DoAn_.Controllers
{
    public class CartController : Controller
    {
        NHOM8_DOANEntities db = new NHOM8_DOANEntities();

        // GET: Card
        public ActionResult Index()
        {
            Cart card;
            if (Session["Cart"] == null)
            {
                card = new Cart();
            }
            else
            {
                card = (Cart)Session["Cart"];
            }
            return View(card);
        }

        public ActionResult AddToCart(int id, string size, string mau) 
        {
            if (Session["User"] == null)
            {
                return RedirectToAction("Login", "User");
            }
            Cart cart;
            if (Session["Cart"] == null)
            {
                cart = new Cart();
            }
            else
            {
                cart = (Cart)Session["Cart"];
            }
            int result = cart.Them(id, size, mau);
            if (result == -1)
            {
                ViewBag.Error = "Thêm sản phẩm vào giỏ hàng thất bại";
            }
            else
            {
                Session["Cart"] = cart;
            }
            return RedirectToAction("Index", "Home");
        }
        public ActionResult UpdateSL(int id, int type, string size, string mau)
        {
            Cart cart;
            if (Session["Cart"] == null)
            {
                cart = new Cart();
            }
            else
            {
                cart = (Cart)Session["Cart"];
            }
            int result = -1;
            if (type == 0)
            {
                result = cart.Them(id, size, mau);
            }
            else
            {
                result = cart.Giam(id, size, mau);
            }
            if (result == -1)
            {
                ViewBag.Error = "Cập nhật số lượng sản phẩm trong giỏ hàng thất bại";
            }
            else
            {
                Session["Cart"] = cart;
            }
            return RedirectToAction("Index", "Cart");
        }
        public ActionResult RemoveSP(int id, string size, string mau)
        {
            Cart cart;
            if (Session["Cart"] == null)
            {
                cart = new Cart();
            }
            else
            {
                cart = (Cart)Session["Cart"];
            }
            int result = cart.Xoa(id, size, mau);
            if (result == -1)
            {
                ViewBag.Error = "Xoá sản phẩm trong giỏ hàng thất bại";
            }
            else
            {
                Session["Cart"] = cart;
            }
            return RedirectToAction("Index", "Cart");
        }
        [HttpGet]
        public ActionResult Checkout()
        {
            if (Session["Cart"] == null) return RedirectToAction("Index", "Home");
            Cart cart = (Cart)Session["Cart"];
            if (cart.list.Count == 0) return RedirectToAction("Index", "Home");

            if (Session["User"] == null) return RedirectToAction("Login", "User");

            var user = Session["User"];

            string hoTen = "";
            string sdt = "";
            string diaChi = "";
            string email = "";

            if (user is KhachHang)
            {
                KhachHang kh = (KhachHang)user;
                hoTen = kh.TenKH;
                sdt = kh.DienThoai;
                diaChi = kh.DiaChi;
                email = kh.Email;
            }
            else if (user is NhanVien)
            {
                NhanVien nv = (NhanVien)user;
                hoTen = nv.TenNV;
                email = nv.Email;
                sdt = "";
                diaChi = "";
            }

            ViewBag.HoTen = hoTen;
            ViewBag.SDT = sdt;
            ViewBag.DiaChi = diaChi;
            ViewBag.Email = email;

            return View(cart);
        }

        [HttpPost]
        public ActionResult Payment(string shipName, string mobile, string address, string email)
        {
            Cart cart = (Cart)Session["Cart"];
            if (cart == null || cart.list.Count == 0)
            {
                TempData["Error"] = "Giỏ hàng rỗng, vui lòng chọn sản phẩm.";
                return RedirectToAction("Index", "Home");
            }

            var user = Session["User"];
            if (user == null) return RedirectToAction("Login", "User");

            HoaDon order = new HoaDon();
            order.NgayLap = DateTime.Now;
            order.TongTien = (decimal)cart.TongThanhTien();
            order.TinhTrang = 1;

            order.SDT = mobile; 

            order.DiaChiGiaoHang = address + " (Người nhận: " + shipName + ")";

            if (user is KhachHang)
            {
                KhachHang kh = (KhachHang)user;
                order.MaKH = kh.MaKH;
            }
            else
            {
                order.MaKH = null;
            }


            using (var transaction = db.Database.BeginTransaction())
            {
                try
                {
                    db.HoaDons.Add(order);
                    db.SaveChanges(); 

                    foreach (var sp in cart.list)
                    {
                        ChiTietHoaDon ct = new ChiTietHoaDon();
                        ct.MaHD = order.MaHD;
                        ct.MaSP = sp.MaSP;
                        ct.SoLuong = sp.SoLuong;
                        ct.GiaBan = sp.Gia;

                        ct.Size = sp.Size;
                        ct.Color = sp.Mau;

                        db.ChiTietHoaDons.Add(ct);
                    }
                    db.SaveChanges();

                    transaction.Commit();

                    Session["Cart"] = new Cart();

                    TempData["SuccessMessage"] = "ĐẶT HÀNG THÀNH CÔNG! Cảm ơn bạn đã ủng hộ shop.";

                    return RedirectToAction("Index", "Home");
                }
                catch (Exception ex)
                {
                    transaction.Rollback(); 

                    string errorDetail = ex.InnerException != null ? ex.InnerException.Message : ex.Message;
                    TempData["Error"] = "Lỗi thanh toán: " + errorDetail;

                    return RedirectToAction("Checkout");
                }
            }
        }
    }
}