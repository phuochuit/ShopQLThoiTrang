using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ShopThoiTrang_DoAn_.Controllers
{
    public class ManageOrderController : Controller
    {
        NHOM8_DOANEntities db = new NHOM8_DOANEntities();
        // GET: ManageOrder

        private bool KiemTraQuyen()
        {
            if (Session["Role"] == null) return false;
            string role = Session["Role"].ToString();
            return role == "Admin" || role == "NhanVien";
        }

        public ActionResult Index()
        {
            if (!KiemTraQuyen()) return RedirectToAction("Login", "User");

            var listDonHang = db.HoaDons.OrderByDescending(n => n.NgayLap).ToList();
            return View(listDonHang);
        }

        public ActionResult Details(int id)
        {
            if (!KiemTraQuyen()) return RedirectToAction("Login", "User");

            var donHang = db.HoaDons.Find(id);
            if (donHang == null)
            {
                TempData["Error"] = "Không tìm thấy đơn hàng";
                return RedirectToAction("Index");
            }

            var chiTiet = db.ChiTietHoaDons.Where(n => n.MaHD == id).ToList();

            ViewBag.DonHang = donHang;
            return View(chiTiet);
        }

        [HttpPost]
        public ActionResult CapNhatTrangThai(int id, int trangThai)
        {
            if (!KiemTraQuyen()) return RedirectToAction("Login", "User");

            var donHang = db.HoaDons.Find(id);
            if (donHang != null)
            {
                donHang.TinhTrang = trangThai;
                db.SaveChanges();
                TempData["Success"] = "Cập nhật trạng thái thành công!";
            }
            return RedirectToAction("Index");
        }
    }
}