using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ShopThoiTrang_DoAn_.Models;
using System.IO; // Thêm thư viện này để đọc dữ liệu
using Newtonsoft.Json; // Thêm thư viện này để xử lý JSON
using System.Text.RegularExpressions;

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
        public ActionResult Checkout(string dummy = null) 
        {
            try
            {
                string jsonBody;
                Request.InputStream.Position = 0;
                using (var reader = new StreamReader(Request.InputStream))
                {
                    jsonBody = reader.ReadToEnd();
                }
                var data = JsonConvert.DeserializeObject<SePayWebhookData>(jsonBody);

                if (data == null)
                {
                    return new HttpStatusCodeResult(400, "Invalid Data");
                }

                string noiDungCK = data.content;
                var match = Regex.Match(noiDungCK, @"\d+");

                if (match.Success)
                {
                    int maHD = int.Parse(match.Value);

                    // 4. Tìm đơn hàng trong Database
                    var order = db.HoaDons.FirstOrDefault(h => h.MaHD == maHD);

                    if (order != null)
                    {
                        // Kiểm tra số tiền chuyển có khớp với tổng tiền đơn hàng không
                        // Lưu ý: data.transferAmount là số tiền khách chuyển
                        if (data.transferAmount >= order.TongTien)
                        {
                            // 5. Cập nhật trạng thái đơn hàng
                            // Giả sử: 1 = Mới tạo, 2 = Đã thanh toán
                            order.TinhTrang = 2;
                            db.SaveChanges();
                        }
                    }
                }

                // 6. QUAN TRỌNG: Luôn trả về 200 OK cho SePay
                return new HttpStatusCodeResult(200, "Success");
            }
            catch (Exception ex)
            {
                return new HttpStatusCodeResult(500, ex.Message);
            }
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

            order.DiaChiGiaoHang = address ;

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

                    return RedirectToAction("PaymentWithQR", new { id = order.MaHD });
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

        [HttpGet]
        public ActionResult PaymentWithQR(int id)
        {
            var order = db.HoaDons.FirstOrDefault(n => n.MaHD == id);
            if (order == null) return RedirectToAction("Index", "Home");

            // Nếu đơn hàng đã thanh toán rồi (ví dụ reload trang) thì báo thành công luôn
            if (order.TinhTrang == 2)
            {
                TempData["SuccessMessage"] = "Đơn hàng đã được thanh toán!";
                return RedirectToAction("Index", "Home");
            }

            return View(order);
        }

        // ---------------------------------------------------------
        // 3. THÊM API ĐỂ JAVASCRIPT GỌI KIỂM TRA TRẠNG THÁI (POLLING)
        // ---------------------------------------------------------
        [HttpPost]
        public JsonResult CheckOrderStatus(int orderId)
        {
            var order = db.HoaDons.FirstOrDefault(n => n.MaHD == orderId);

            // Kiểm tra nếu TinhTrang == 2 (Đã thanh toán qua Webhook)
            if (order != null && order.TinhTrang == 2)
            {
                return Json(new { status = true, message = "Thanh toán thành công!" });
            }

            return Json(new { status = false });
        }

        public class SePayWebhookData
        {
            public long id { get; set; }            // ID giao dịch trên SePay
            public string gateway { get; set; }     // Cổng thanh toán (MB, VCB...)
            public string transactionDate { get; set; }
            public string accountNumber { get; set; }
            public string code { get; set; }        // Mã code thanh toán (nếu có)
            public string content { get; set; }     // Nội dung chuyển khoản (QUAN TRỌNG: Chứa mã đơn hàng)
            public string transferType { get; set; }
            public decimal transferAmount { get; set; } // Số tiền khách chuyển
            public string referenceCode { get; set; }
        }
    }
}