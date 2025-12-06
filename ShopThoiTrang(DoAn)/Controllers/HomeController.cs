using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ShopThoiTrang_DoAn_.Controllers
{
    public class HomeController : Controller
    {
        NHOM8_DOANEntities db = new NHOM8_DOANEntities();

        public ActionResult Index()
        {
            return View(db.SanPhams.ToList());
        }

        public ActionResult GuDonGian()
        {
            var products = db.SanPhams.ToList();
            return View("_GuDonGian", products);
        }

        public ActionResult GuThietKe()
        {
            var products = db.SanPhams.ToList();
            return View("_GuThietKe", products);
        }

        public ActionResult GuTheThao()
        {
            var products = db.SanPhams.ToList();
            return View("_GuTheThao", products);
        }

        public ActionResult TransProduct1()
        {
            var products = db.SanPhams.ToList();
            return View("_TransProduct1", products);
        }

        public ActionResult TransProduct2()
        {
            var products = db.SanPhams.ToList();
            return View("_TransProduct2", products);
        }

        public ActionResult _MenuHeader()
        {
            var all = db.DanhMucs.ToList();

            var cap1 = all.Where(d => d.MaDMChinh == null).OrderBy(d => d.MaDM).ToList();
            var cap2 = all.Where(d => d.MaDMChinh != null && all.Any(c1 => c1.MaDM == d.MaDMChinh && c1.MaDMChinh == null))
                          .OrderBy(d => d.MaDM).ToList();
            var cap3 = all.Where(d => d.MaDMChinh != null && cap2.Any(c2 => c2.MaDM == d.MaDMChinh))
                          .OrderBy(d => d.MaDM).ToList();

            var model = new MegaMenuViewModel
            {
                Cap1 = cap1,
                Cap2 = cap2,
                Cap3 = cap3
            };

            return PartialView(model);
        }

        public ActionResult Product()
        {
            return View(db.SanPhams.ToList());
        }

        public ActionResult SanPhamTheoDanhMuc(int id)
        {
            var products = db.SanPhams.Where(sp => sp.MaDM == id).ToList();
            return View("Product", products);
        }

        public ActionResult Details(int id)
        {
            var sp = db.SanPhams.Include("BienTheSanPhams").FirstOrDefault(x => x.MaSP == id);
            if (sp == null) return HttpNotFound();

            List<SanPham> SPLienQuan = db.SanPhams.Where(x => x.MaDM == sp.MaDM && x.MaSP != sp.MaSP).ToList();
            ViewBag.SPLienQuan = SPLienQuan;

            return View(sp);
        }

        public ActionResult TimKiemTheoTuKhoa(string keyword)
        {
            List<SanPham> list;

            if (string.IsNullOrEmpty(keyword))
            {
                list = db.SanPhams.ToList();

                ViewBag.DanhSachMau = db.BienTheSanPhams
                                        .Select(bt => bt.Mau)
                                        .Distinct()
                                        .ToList();

                return View("_Search", list);
            }

            list = db.SanPhams
                     .Where(x => x.TenSP.ToLower().Contains(keyword.ToLower()))
                     .ToList();

            if (!list.Any())
            {
                TempData["ThongBao"] = "Không tìm thấy sản phẩm phù hợp.";
                list = db.SanPhams.ToList();
            }

            ViewBag.Keyword = keyword;

            ViewBag.DanhSachMau = db.BienTheSanPhams
                                    .Select(bt => bt.Mau)
                                    .Distinct()
                                    .ToList();

            return View("_Search", list);
        }


        public ActionResult LocTheoMau(string mau)
        {
            var products = db.SanPhams
                             .Where(sp => sp.BienTheSanPhams.Any(bt => bt.Mau == mau))
                             .ToList();

            ViewBag.Mau = mau;

            ViewBag.DanhSachMau = db.BienTheSanPhams
                                    .Select(bt => bt.Mau)
                                    .Distinct()
                                    .ToList();

            return View("_Search", products);
        }

        public ActionResult LocSanPham(int? mucGia, string mau)
        {
            var query = db.SanPhams.AsQueryable();

            if (mucGia.HasValue)
            {
                int min = 0, max = 0;

                switch (mucGia)
                {
                    case 1: min = 50000; max = 200000; break;
                    case 2: min = 200000; max = 400000; break;
                    case 3: min = 400000; max = 600000; break;
                    case 4: min = 600000; max = int.MaxValue; break;
                }

                query = query.Where(s => s.Gia >= min && s.Gia <= max);
            }

            if (!string.IsNullOrEmpty(mau))
            {
                query = query.Where(s => s.BienTheSanPhams.Any(bt => bt.Mau == mau));
            }

            var list = query.ToList();

            ViewBag.Mau = mau;
            ViewBag.MucGia = mucGia;

            ViewBag.DanhSachMau = db.BienTheSanPhams
                           .Select(bt => bt.Mau)
                           .Distinct()
                           .ToList();

            return View("_Search", list);
        }

    }
}