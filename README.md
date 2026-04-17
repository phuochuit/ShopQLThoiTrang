# 🛍️ Web Quản Lý Cửa Hàng Thời Trang (Fashion Store Management)

Chào mừng bạn đến với mã nguồn dự án **Web Quản Lý Cửa Hàng Thời Trang**. Đây là một ứng dụng thương mại điện tử hoàn chỉnh, hỗ trợ khách hàng mua sắm trực tuyến và cung cấp hệ thống quản trị chuyên sâu cho chủ cửa hàng để kiểm soát sản phẩm, đơn hàng và doanh thu.

## 📖 Giới thiệu dự án
Dự án được xây dựng với mục tiêu mang lại trải nghiệm mua sắm mượt mà cho người dùng cuối. Hệ thống xử lý trơn tru các luồng nghiệp vụ thực tế như ánh xạ thực thể cơ sở dữ liệu (Entity Mapping), quản lý giỏ hàng (Cart logic) phức tạp, và quy trình thanh toán an toàn.

## ✨ Các tính năng nổi bật

### 👤 Khu vực Khách hàng (Client Side)
- **Trưng bày sản phẩm:** Phân loại quần áo, phụ kiện theo danh mục, nhãn hiệu và xu hướng mới nhất.
- **Chi tiết sản phẩm:** Xem hình ảnh trực quan, chọn kích cỡ, màu sắc và kiểm tra tình trạng còn hàng.
- **Quản lý Giỏ hàng (Cart):** Thêm/bớt sản phẩm, cập nhật số lượng và tính toán tổng tiền tự động.
- **Thanh toán & Đơn hàng:** Quy trình Checkout rõ ràng, lưu trữ và theo dõi trạng thái đơn hàng cá nhân.
- **Tài khoản người dùng:** Đăng ký, đăng nhập và quản lý thông tin hồ sơ bảo mật.

### 🛡️ Khu vực Quản trị viên (Admin Dashboard)
- **Quản lý Sản phẩm & Danh mục:** Thêm mới, cập nhật giá, chỉnh sửa thông tin và hình ảnh sản phẩm.
- **Xử lý Đơn hàng:** Theo dõi các đơn đặt hàng mới, duyệt đơn và cập nhật trạng thái giao hàng.
- **Quản lý Tài khoản & Phân quyền:** Kiểm soát quyền truy cập của các tài khoản trong hệ thống (cơ chế phân quyền được xử lý chặt chẽ qua cột `VAITRO` định dạng `int` trong cơ sở dữ liệu).

## 🛠️ Công nghệ & Kiến trúc
Dự án áp dụng mô hình MVC, tách biệt rõ ràng giữa giao diện, luồng xử lý và dữ liệu:
- **Backend:** C# - ASP.NET MVC.
- **Cơ sở dữ liệu:** Microsoft SQL Server.
- **Tương tác dữ liệu:** Entity Framework (EF).
- **Frontend:** HTML5, CSS3, JavaScript, Bootstrap (đảm bảo hiển thị Responsive).

## 🚀 Hướng dẫn cài đặt (Local Setup)
Để chạy dự án này trên máy cá nhân, bạn thực hiện các bước sau:

1. **Clone repository:**
   ```bash
   git clone [https://github.com/phuochuit/ShopQLThoiTrang.git](https://github.com/phuochuit/ShopQLThoiTrang.git)
Thiết lập Cơ sở dữ liệu:

Mở SQL Server Management Studio (SSMS).

Chạy script tạo cơ sở dữ liệu (file .sql đính kèm trong thư mục dự án) để khởi tạo các bảng và dữ liệu mẫu.

Mở file Web.config, tìm đến thẻ <connectionStrings> và cập nhật lại chuỗi kết nối sao cho khớp với Tên Server (Server Name) của bạn.

Khởi chạy ứng dụng:

Mở file .sln bằng Visual Studio.

Chờ hệ thống Restore các gói NuGet cần thiết.

Nhấn F5 hoặc nút Run (IIS Express) để mở trang web trên trình duyệt.

👥 Tác giả
Trương Tô Đình Phước (GitHub: @phuochuit)
