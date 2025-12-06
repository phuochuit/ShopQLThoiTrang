using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ShopThoiTrang_DoAn_.Models;

namespace ShopThoiTrang_DoAn_.Controllers
{
    public class ThongKeController : Controller
    {
        NHOM8_DOANEntities db = new NHOM8_DOANEntities();

        // Hàm kiểm tra quyền
        private bool KiemTraQuyen()
        {
            if (Session["Role"] == null) return false;
            string role = Session["Role"].ToString();
            return role == "Admin" || role == "NhanVien";
        }

        public ActionResult Index()
        {
            if (!KiemTraQuyen()) return RedirectToAction("Login", "User");
            var donHangHopLe = db.HoaDons.Where(n => n.TinhTrang == 2 || n.TinhTrang == 3);

            decimal tongDoanhThu = donHangHopLe.Sum(n => n.TongTien) ?? 0;

            decimal doanhThuThangNay = donHangHopLe
                                        .Where(n => n.NgayLap.Value.Month == DateTime.Now.Month && n.NgayLap.Value.Year == DateTime.Now.Year)
                                        .Sum(n => n.TongTien) ?? 0;

            int donHangMoi = db.HoaDons.Count(n => n.TinhTrang == 1);

            int donHangHuy = db.HoaDons.Count(n => n.TinhTrang == 4);

            ViewBag.TongDoanhThu = tongDoanhThu;
            ViewBag.DoanhThuThang = doanhThuThangNay;
            ViewBag.DonHangMoi = donHangMoi;
            ViewBag.DonHangHuy = donHangHuy;

            var doanhThuTheoThang = donHangHopLe
                .Where(n => n.NgayLap.Value.Year == DateTime.Now.Year)
                .GroupBy(n => n.NgayLap.Value.Month)
                .Select(g => new { Thang = g.Key, TongTien = g.Sum(x => x.TongTien) })
                .ToList();

            decimal[] chartData = new decimal[12];
            foreach (var item in doanhThuTheoThang)
            {
                chartData[item.Thang - 1] = item.TongTien ?? 0;
            }
            ViewBag.ChartData = string.Join(",", chartData); 

            return View();
        }

        public ActionResult TopSanPham()
        {
            var query = from ct in db.ChiTietHoaDons
                        join hd in db.HoaDons on ct.MaHD equals hd.MaHD
                        where hd.TinhTrang == 2 || hd.TinhTrang == 3
                        group ct by new { ct.MaSP, ct.SanPham.TenSP, ct.SanPham.AnhDaiDien, ct.SanPham.Gia } into g
                        orderby g.Sum(x => x.SoLuong) descending
                        select new TopSanPhamViewModel
                        {
                            TenSP = g.Key.TenSP,
                            HinhAnh = g.Key.AnhDaiDien,
                            Gia = g.Key.Gia ?? 0,
                            TongSoLuongBan = g.Sum(x => x.SoLuong) ?? 0,
                            TongTienThu = g.Sum(x => x.SoLuong * x.GiaBan) ?? 0
                        };

            return PartialView(query.Take(5).ToList());
        }
    }

    public class TopSanPhamViewModel
    {
        public string TenSP { get; set; }
        public string HinhAnh { get; set; }
        public decimal Gia { get; set; }
        public int TongSoLuongBan { get; set; }
        public decimal TongTienThu { get; set; }
    }
}