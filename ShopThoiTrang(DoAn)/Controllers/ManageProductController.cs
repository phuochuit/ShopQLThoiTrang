using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.IO;
using ShopThoiTrang_DoAn_.Models;
using System.Data.Entity;

namespace ShopThoiTrang_DoAn_.Controllers
{
    public class ManageProductController : Controller
    {
        // GET: ManageProduct
        NHOM8_DOANEntities db = new NHOM8_DOANEntities();

        private bool KiemTraQuyen()
        {
            if (Session["Role"] == null) return false;
            return Session["Role"].ToString() == "Admin" || Session["Role"].ToString() == "NhanVien";
        }

        public ActionResult Index(string tuKhoa, int? maDM, string sortOrder)
        {
            if (!KiemTraQuyen()) return RedirectToAction("Login", "User");

            ViewBag.ListDM = new SelectList(db.DanhMucs, "MaDM", "TenDM");

            var products = db.SanPhams.Include(s => s.DanhMuc).AsQueryable();

            if (!string.IsNullOrEmpty(tuKhoa))
            {
                products = products.Where(s => s.TenSP.Contains(tuKhoa));
            }

            if (maDM.HasValue)
            {
                products = products.Where(s => s.MaDM == maDM);
            }

            ViewBag.NameSortParm = String.IsNullOrEmpty(sortOrder) ? "name_desc" : "";
            ViewBag.PriceSortParm = sortOrder == "Price" ? "price_desc" : "Price";

            switch (sortOrder)
            {
                case "name_desc": products = products.OrderByDescending(s => s.TenSP); break;
                case "Price": products = products.OrderBy(s => s.Gia); break;
                case "price_desc": products = products.OrderByDescending(s => s.Gia); break;
                default: products = products.OrderBy(s => s.MaSP); break; // Mặc định ID mới nhất
            }

            ViewBag.CurrentFilter = tuKhoa;
            ViewBag.CurrentMaDM = maDM;

            return View(products.ToList());
        }

        [HttpGet]
        public ActionResult Create()
        {
            if (!KiemTraQuyen()) return RedirectToAction("Login", "User");

            ViewBag.MaDM = new SelectList(db.DanhMucs, "MaDM", "TenDM");
            return View();
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Create(SanPham sp, HttpPostedFileBase uploadHinh, IEnumerable<HttpPostedFileBase> files)
        {
            if (!KiemTraQuyen()) return RedirectToAction("Login", "User");

            ViewBag.MaDM = new SelectList(db.DanhMucs, "MaDM", "TenDM", sp.MaDM);

            if (ModelState.IsValid)
            {
                if (uploadHinh != null && uploadHinh.ContentLength > 0)
                {
                    string filename = Path.GetFileName(uploadHinh.FileName);
                    string path = Path.Combine(Server.MapPath("~/Content/images"), filename);
                    if (System.IO.File.Exists(path))
                    {
                        filename = DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + filename;
                        path = Path.Combine(Server.MapPath("~/Content/images"), filename);
                    }
                    uploadHinh.SaveAs(path);
                    sp.AnhDaiDien = filename;
                }
                else
                {
                    sp.AnhDaiDien = "default.png";
                }

                sp.DanhGia = 0;
                db.SanPhams.Add(sp);
                db.SaveChanges(); 

                if (files != null && files.Count() > 0)
                {
                    foreach (var file in files)
                    {
                        if (file != null && file.ContentLength > 0)
                        {
                            string fname = Path.GetFileName(file.FileName);
                            string fpath = Path.Combine(Server.MapPath("~/Content/images"), fname);

                            if (System.IO.File.Exists(fpath))
                            {
                                fname = DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + fname;
                                fpath = Path.Combine(Server.MapPath("~/Content/images"), fname);
                            }

                            file.SaveAs(fpath);

                            HinhAnh newPic = new HinhAnh();
                            newPic.MaSP = sp.MaSP;
                            newPic.TenHinh = fname;
                            db.HinhAnhs.Add(newPic);
                        }
                    }
                    db.SaveChanges(); 
                }

                TempData["Success"] = "Thêm sản phẩm và hình ảnh thành công!";
                return RedirectToAction("Index");
            }

            return View(sp);
        }

        [HttpGet]
        public ActionResult Edit(int id)
        {
            if (!KiemTraQuyen()) return RedirectToAction("Login", "User");

            var sp = db.SanPhams.Find(id);
            if (sp == null) return HttpNotFound();

            ViewBag.MaDM = new SelectList(db.DanhMucs, "MaDM", "TenDM", sp.MaDM);
            return View(sp);
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Edit(SanPham sp, HttpPostedFileBase uploadHinh, IEnumerable<HttpPostedFileBase> files)
        {
            if (!KiemTraQuyen()) return RedirectToAction("Login", "User");

            if (ModelState.IsValid)
            {
                var spGoc = db.SanPhams.Find(sp.MaSP);

                spGoc.TenSP = sp.TenSP;
                spGoc.Gia = sp.Gia;
                spGoc.MoTa1 = sp.MoTa1;
                spGoc.MoTa2 = sp.MoTa2;
                spGoc.MaDM = sp.MaDM;

                if (uploadHinh != null && uploadHinh.ContentLength > 0)
                {
                    string filename = Path.GetFileName(uploadHinh.FileName);
                    string path = Path.Combine(Server.MapPath("~/Content/images"), filename);
                    uploadHinh.SaveAs(path);
                    spGoc.AnhDaiDien = filename;
                }

                if (files != null && files.Count() > 0)
                {
                    foreach (var file in files)
                    {
                        if (file != null && file.ContentLength > 0)
                        {
                            string fname = Path.GetFileName(file.FileName);
                            string fpath = Path.Combine(Server.MapPath("~/Content/images"), fname);

                            if (System.IO.File.Exists(fpath))
                            {
                                fname = DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + fname;
                                fpath = Path.Combine(Server.MapPath("~/Content/images"), fname);
                            }

                            file.SaveAs(fpath);

                            HinhAnh newPic = new HinhAnh();
                            newPic.MaSP = sp.MaSP;
                            newPic.TenHinh = fname;
                            db.HinhAnhs.Add(newPic);
                        }
                    }
                }

                db.SaveChanges();
                TempData["Success"] = "Cập nhật sản phẩm thành công!";
                return RedirectToAction("Index");
            }
            ViewBag.MaDM = new SelectList(db.DanhMucs, "MaDM", "TenDM", sp.MaDM);
            return View(sp);
        }

        [HttpPost]
        public ActionResult DeleteImage(int id)
        {
            // Kiểm tra quyền (giữ nguyên logic của bạn)
            if (!KiemTraQuyen()) return RedirectToAction("Login", "User");

            var hinh = db.HinhAnhs.Find(id);
            if (hinh != null)
            {
                // 1. QUAN TRỌNG: Lưu lại MaSP vào biến tạm TRƯỚC khi xóa.
                // .GetValueOrDefault() giúp chuyển đổi int? sang int (tránh lỗi null)
                int productId = hinh.MaSP.GetValueOrDefault();

                // 2. Thực hiện xóa
                db.HinhAnhs.Remove(hinh);
                db.SaveChanges();

                TempData["Success"] = "Đã xóa ảnh phụ!";

                // 3. Redirect về trang Edit với productId đã lưu
                return RedirectToAction("Edit", new { id = productId });
            }

            TempData["Error"] = "Không tìm thấy ảnh!";
            return RedirectToAction("Index");
        }

        public ActionResult Delete(int id)
        {
            if (!KiemTraQuyen()) return RedirectToAction("Login", "User");

            try
            {
                var sp = db.SanPhams.Find(id);
                if (sp == null) return HttpNotFound();

                var bienThe = db.BienTheSanPhams.Where(x => x.MaSP == id).ToList();
                db.BienTheSanPhams.RemoveRange(bienThe);

                var hinhAnh = db.HinhAnhs.Where(x => x.MaSP == id).ToList();
                db.HinhAnhs.RemoveRange(hinhAnh);

                db.SanPhams.Remove(sp);
                db.SaveChanges();

                TempData["Success"] = "Đã xóa sản phẩm!";
            }
            catch (Exception)
            {
                TempData["Error"] = "Không thể xóa sản phẩm này vì đã có đơn hàng liên quan!";
            }

            return RedirectToAction("Index");
        }
    }
}