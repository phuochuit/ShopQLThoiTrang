using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ShopThoiTrang_DoAn_.Models; // Đảm bảo namespace đúng với Model của bạn

namespace ShopThoiTrang_DoAn_.Controllers
{
    public class ManageEmployeeController : Controller
    {
        NHOM8_DOANEntities db = new NHOM8_DOANEntities(); //

        // Hàm kiểm tra quyền Admin
        private bool IsAdmin()
        {
            if (Session["User"] == null || Session["Role"] == null) return false;
            // Chỉ cho phép Admin
            return Session["Role"].ToString() == "Admin";
        }

        // 1. DANH SÁCH NHÂN VIÊN
        public ActionResult Index()
        {
            if (!IsAdmin()) return RedirectToAction("Login", "User");

            // Lấy danh sách nhân viên, sắp xếp theo ID hoặc Tên
            var listNV = db.NhanViens.Include(n => n.VaiTro1).ToList();
            return View(listNV);
        }

        // 2. THÊM NHÂN VIÊN MỚI
        [HttpGet]
        public ActionResult Create()
        {
            if (!IsAdmin()) return RedirectToAction("Login", "User");

            // Tạo dropdown chọn Quyền (VaiTro)
            ViewBag.VaiTro = new SelectList(db.VaiTroes, "IDVaiTro", "TenVaiTro");
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(NhanVien nv)
        {
            if (!IsAdmin()) return RedirectToAction("Login", "User");

            // Kiểm tra trùng Email
            if (db.NhanViens.Any(x => x.Email == nv.Email))
            {
                ModelState.AddModelError("Email", "Email này đã tồn tại.");
            }

            if (ModelState.IsValid)
            {
                // Băm mật khẩu sử dụng hàm static từ UserController của bạn
                nv.MatKhau = UserController.HashPassword(nv.MatKhau);

                db.NhanViens.Add(nv);
                db.SaveChanges();
                TempData["Success"] = "Thêm nhân viên thành công!";
                return RedirectToAction("Index");
            }

            ViewBag.VaiTro = new SelectList(db.VaiTroes, "IDVaiTro", "TenVaiTro", nv.VaiTro);
            return View(nv);
        }

        // 3. CHỈNH SỬA NHÂN VIÊN
        [HttpGet]
        public ActionResult Edit(int id)
        {
            if (!IsAdmin()) return RedirectToAction("Login", "User");

            var nv = db.NhanViens.Find(id);
            if (nv == null) return HttpNotFound();

            ViewBag.VaiTro = new SelectList(db.VaiTroes, "IDVaiTro", "TenVaiTro", nv.VaiTro);
            return View(nv);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(NhanVien nv, string NewPassword)
        {
            if (!IsAdmin()) return RedirectToAction("Login", "User");

            if (ModelState.IsValid)
            {
                var nvInDb = db.NhanViens.Find(nv.MaNV);
                if (nvInDb != null)
                {
                    nvInDb.TenNV = nv.TenNV;
                    nvInDb.Email = nv.Email;
                    nvInDb.VaiTro = nv.VaiTro;

                    // Nếu người dùng nhập mật khẩu mới thì mới đổi và băm lại
                    if (!string.IsNullOrEmpty(NewPassword))
                    {
                        nvInDb.MatKhau = UserController.HashPassword(NewPassword); //
                    }

                    db.SaveChanges();
                    TempData["Success"] = "Cập nhật thành công!";
                    return RedirectToAction("Index");
                }
            }
            ViewBag.VaiTro = new SelectList(db.VaiTroes, "IDVaiTro", "TenVaiTro", nv.VaiTro);
            return View(nv);
        }

        // 4. XÓA NHÂN VIÊN
        public ActionResult Delete(int id)
        {
            if (!IsAdmin()) return RedirectToAction("Login", "User");

            try
            {
                var nv = db.NhanViens.Find(id);
                if (nv != null)
                {
                    // Kiểm tra xem nhân viên này có đơn hàng liên quan không trước khi xóa
                    // Nếu có thì không được xóa (hoặc chỉ khóa tài khoản)
                    db.NhanViens.Remove(nv);
                    db.SaveChanges();
                    TempData["Success"] = "Đã xóa nhân viên!";
                }
            }
            catch (Exception)
            {
                TempData["Error"] = "Không thể xóa nhân viên này (có thể do ràng buộc dữ liệu).";
            }
            return RedirectToAction("Index");
        }
    }
}