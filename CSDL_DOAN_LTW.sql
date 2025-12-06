create database NHOM8_DOAN
go
use NHOM8_DOAN
go

create table DanhMuc
(
	MaDM int identity(1,1) primary key,
	TenDM nvarchar(50),
	MaDMChinh int foreign key references DanhMuc(MaDM) --(áo, quần, phụ kiện)
);

create table SanPham
(	
	MaSP int identity(1,1) primary key,
	MaDM int foreign key references DanhMuc(MaDM),
	TenSP nvarchar(500),
	AnhDaiDien varchar(500),
	Gia decimal(10, 2),
	DanhGia int, -- số sao
	MoTa1 nvarchar(500), 
	MoTa2 nvarchar(2500)
);

UPDATE SanPham
SET AnhDaiDien = 'ao31.png'
WHERE AnhDaiDien = 'ao31png';

create table HinhAnh
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
    MaSP INT FOREIGN KEY REFERENCES SanPham(MaSP),
    TenHinh NVARCHAR(255) -- Thay thế HinhAnh
);

CREATE TABLE KhachHang (
    MaKH INT IDENTITY(1,1) PRIMARY KEY,
    TenKH NVARCHAR(100),
    MatKhau NVARCHAR(100),
    GioiTinh NVARCHAR(10),
    NamSinh INT,
    DienThoai NVARCHAR(20),
    Email NVARCHAR(100),
    DiaChi NVARCHAR(255),
	VaiTro INT DEFAULT 3 
);

CREATE TABLE VaiTro (
    IDVaiTro INT IDENTITY(1,1) PRIMARY KEY,
    TenVaiTro NVARCHAR(50),
    MoTa NVARCHAR(255)
);

CREATE TABLE NhanVien (
    MaNV INT IDENTITY(1,1) PRIMARY KEY,
    MatKhau NVARCHAR(100),
    TenNV NVARCHAR(100),
    GioiTinh NVARCHAR(10),
    NamSinh INT,
    VaiTro INT FOREIGN KEY REFERENCES VaiTro(IDVaiTro),
	Email NVARCHAR(100)
);

SELECT * FROM HoaDon
select * from ChiTietHoaDon

delete from HoaDon
where DaThanhToan = 1

CREATE TABLE TinhTrang (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    TinhTrangHoaDon NVARCHAR(50)
);

CREATE TABLE HoaDon (
    MaHD INT IDENTITY(1,1) PRIMARY KEY,
    MaKH INT FOREIGN KEY REFERENCES KhachHang(MaKH),
    NgayLap DATETIME,
    TongTien DECIMAL(18,2),
    TinhTrang INT FOREIGN KEY REFERENCES TinhTrang(ID),
	SDT VARCHAR(14),
    DiaChiGiaoHang NVARCHAR(255)
);

CREATE TABLE ChiTietHoaDon (
    MaHD INT NOT NULL FOREIGN KEY REFERENCES HoaDon(MaHD),
    MaSP INT NOT NULL FOREIGN KEY REFERENCES SanPham(MaSP), 
	Size varchar(5),
	Color NVARCHAR(50),
    SoLuong INT,
    GiaBan DECIMAL(18,2),
    PRIMARY KEY (MaHD, MaSP, Size, Color)
);

CREATE TABLE BienTheSanPham (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    MaSP INT FOREIGN KEY REFERENCES SanPham(MaSP),
    Size NVARCHAR(10),
    Mau NVARCHAR(50),
    SoLuongTon INT
);

ALTER TABLE KhachHang
ADD CONSTRAINT FK_KhachHang_VaiTro
FOREIGN KEY (VaiTro) REFERENCES VaiTro(IDVaiTro);

insert into DanhMuc(TenDM, MaDMChinh) values
--cấp 1
(N'Áo', NULL), --1
(N'Quần', NULL),
--cấp 2
--áo
(N'ÁO THUN', 1),
(N'ÁO SƠ MI', 1), 
(N'ÁO KHOÁC', 1),
--quần
(N'QUẦN SHORT', 2),
(N'QUẦN DÀI', 2),
(N'QUẦN JEANS', 2),
(N'Quần LÓT', 2),
--áo thun
(N'Áo Thun Cổ Tròn', 3),
(N'Áo Polo', 3),
--áo sơ mi
(N'Áo Sơ Mi Tay Ngắn', 4),
(N'Áo Sơ Mi Tay Dài', 4),
--áo khoác
(N'Áo Khoác Parka', 5),
(N'Áo Khoác Sơ Mi', 5),
--quần short
(N'Quần Short Thun', 6),
(N'Quần Short Dù', 6),
--quần dài
(N'Quần Tây', 7),
(N'Quần Jogger', 7),
--quần lót
(N'Quần Lót Sợi Tự Nhiên', 8),
(N'Quần Lót Seamless', 8)

insert into SanPham(MaDM, TenSP, AnhDaiDien, Gia, DanhGia, MoTa1, MoTa2) values
--------------------------------------------Áo thun cổ tròn-------------------------------------------------------------------------------------------------------------------------------
(10, N'Áo Thun Pique Thoáng Mát Seventy Seven 013 Đen', 'ao1.png', 149150, 4, 
N'Với chất vải Pique co giãn 4 chiều, thiết kế tay raglan và nới rộng ngực, lai, giúp người mặc thoải mái vận động mà vẫn giữ được phom dáng đẹp.',
N'Áo thun raglan dáng rộng vải Pique, mềm mại, co giãn thoáng mát.

1. Kiểu sản phẩm: Áo thun cổ tròn tay ngắn raglan, phối sọc, phong cách hiện đại.
2. Ưu điểm:
-Co giãn 4 chiều, thoát ẩm tốt: Vải Pique co giãn, thoáng nhẹ, dễ chịu. Chất vải hạn chế xù lông.
-Thiết kế trẻ trung, năng động: Thiết kế trẻ trung, năng động với phần phối sọc trên cánh tay, tạo điểm nhấn nổi bật.
-Dáng rộng thoải mái: Áo dáng rộng phù hợp với mọi người, đặc biệt là những người yêu thích sự thoải mái.
3. Chất liệu: Vải Pique (95% Polyester 5% Spandex)
4. Kỹ thuật: In dẻo, phối sọc ở tay tạo điểm nhấn cho sản phẩm.
5. Phù hợp với ai: Áo dáng rộng phù hợp với mọi người, đặc biệt là những người yêu thích phong cách năng động, thoải mái và trẻ trung.
6. Thuộc Bộ Sưu Tập: Seventy Seven, một BST thời trang trung tính, dễ phối dễ lựa chọn.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo thun cổ tròn, Áo thun tay ngắn, Áo Thun Gen Z'),

(10, N'Áo Thun Waffle Thoáng Mát Non Branded 001 Đen', 'ao2.png', 120650, 4, 
N'Vải tăm gân co giãn tốt, bề mặt đẹp, được điều chỉnh gọn gàng hơn ở các số đo chính để tạo phom vừa vặn, tôn dáng mà vẫn giữ được sự thoải mái.',
N'Áo thun tay ngắn dáng vừa co giãn, bền bỉ ít nhăn, nhiều màu.

1. Kiểu sản phẩm : Áo thun tay ngắn cổ tròn
2. Ưu điểm :
-Level up với chất liệu Waffle: Bề mặt vải dệt cấu trúc tổ ong lạ mắt, thoáng khí. Ai bảo đơn giản là "đơn điệu".
-Giữ form "chuẩn nét": Độ bền của vải Poly thì khỏi bàn, đã bền form, bền màu, lại còn ít nhăn, nhanh khô, chăm sóc siêu dễ.
-T-shirt Non-branded: Thiết kế tối giản, màu sắc nhã nhặn. Cứu tinh ngày lười.
3. Chất liệu: Waffle 100% Polyester
4. Kỹ thuật : Cổ áo được hoàn thiện bằng chính chất liệu vải áo, mang đến một thiết kế tinh giản nhưng không kém phần sang trọng cho người mặc. Các đường may được gia công tỉ mỉ, đảm bảo độ bền và tính thẩm mỹ.
5. Phù hợp với ai : Thiết kế đơn giản, phù hợp với mọi đối tượng, từ phong cách năng động, trẻ trung đến phong cách tối giản, thanh lịch. Thích hợp mặc đi làm, đi chơi, tập thể thao hoặc mặc hàng ngày.
6. Thuộc Bộ Sưu Tập : NON BRANED, thời trang tối giản, tập trung vào chất liệu và thiết kế tinh tế, mang đến trải nghiệm thời trang sang trọng nhưng không quá cầu kỳ.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này : Áo thun trơn, Áo thun tổ ong, Áo thun basic , Áo thun màu'),

(10, N'Áo Thun Pique Thoáng Mát Seventy Seven 013 Trắng', 'ao3.png', 149150, 5, 
N'Với chất vải Pique co giãn 4 chiều, thiết kế tay raglan và nới rộng ngực, lai, giúp người mặc thoải mái vận động mà vẫn giữ được phom dáng đẹp.',
N'Áo thun raglan dáng rộng vải Pique, mềm mại, co giãn thoáng mát.

1. Kiểu sản phẩm: Áo thun cổ tròn tay ngắn raglan, phối sọc, phong cách hiện đại.
2. Ưu điểm:
-Co giãn 4 chiều, thoát ẩm tốt: Vải Pique co giãn, thoáng nhẹ, dễ chịu. Chất vải hạn chế xù lông.
-Thiết kế trẻ trung, năng động: Thiết kế trẻ trung, năng động với phần phối sọc trên cánh tay, tạo điểm nhấn nổi bật.
-Dáng rộng thoải mái: Áo dáng rộng phù hợp với mọi người, đặc biệt là những người yêu thích sự thoải mái.
3. Chất liệu: Vải Pique (95% Polyester 5% Spandex)
4. Kỹ thuật: In dẻo, phối sọc ở tay tạo điểm nhấn cho sản phẩm.
5. Phù hợp với ai: Áo dáng rộng phù hợp với mọi người, đặc biệt là những người yêu thích phong cách năng động, thoải mái và trẻ trung.
6. Thuộc Bộ Sưu Tập: Seventy Seven, một BST thời trang trung tính, dễ phối dễ lựa chọn.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo thun cổ tròn, Áo thun tay ngắn, Áo Thun Gen Z'),

(10, N'Áo Thun Cotton Line Art Co Giãn Seventy Seven 004 Hồng', 'ao4.png', 149150, 4,
N'Trên nền vải Siro co giãn, mát lạnh, phom dáng được giữ nguyên, chỉ thu gọn phần lai để tạo hiệu ứng tôn dáng, giúp người mặc trông cao ráo, chỉn chu hơn.',
N'Áo thun tay ngắn dáng rộng Cotton co giãn nhẹ, dễ chịu, màu sắc đa dạng.

1. Kiểu sản phẩm: Áo thun cổ tròn tay ngắn
2. Ưu điểm:
-Co giãn 4 chiều, thoải mái: Chất liệu co giãn 4 chiều, giúp dễ dàng vận động mà không bị gò bó, khó chịu.
-Thoát ẩm tốt: Giữ cho cơ thể luôn khô ráo và thoáng mát, phù hợp cho ngày hè năng động.
-Lưu ý về vải: Vải Cotton 4 chiều hơi mỏng nhằm tạo cảm giác thoáng mát nên cần cân nhắc giặt cẩn thận để giữ form áo trước khi mua.
3. Chất liệu: 92% Cotton, 8% Spandex; Cotton 4 chiều. Có 10 màu áo trung tính
4. Kỹ thuật: In cao, phối dây viền gân thun khác màu dọc vai, sử dụng bo cotton cùng màu làm cổ áo
5. Phù hợp với ai: Những người yêu thích thời trang thoải mái và phong cách, phù hợp cho cả nam và nữ
6. Thuộc Bộ Sưu Tập nào: Seventy Seven, thời trang trung tính, dễ phối dễ lựa chọn
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo thun cổ tròn, Áo thun co giãn, Áo thun Gen Z, Áo thun unisex'),

(10, N'Áo Thun Tay Ngắn Waffle Thoáng Khí Seventy Seven 010 Đen', 'ao5.png', 149150, 3,
N'Vải Waffle đứng phom, bền bỉ là cơ sở để tăng thông số vai và chiều dài, tạo nên phom áo rộng rãi, che khuyết điểm tốt và không bị chảy xệ.', 
N'Áo thun tay ngắn Waffle ít nhăn, bền màu, co giãn tốt.

1. Kiểu sản phẩm: Áo Thun Cổ Tròn Tay Ngắn Form rộng mang lại cảm giác thoải mái.
2. Ưu điểm:
-Level Up với chất liệu Waffle: Bề mặt vải waffle tạo hiệu ứng thị giác. Đơn giản nhưng không hề đơn điệu.
-Giặt máy OK: Độ bền của vải Poly thì khỏi bàn, đã bền form, bền màu, lại còn ít nhăn, nhanh khô, chăm sóc siêu dễ.
-Item "must-have" của tủ đồ: Dáng rộng, màu trung tính. Cân mọi outfit khi xuống phố.
3. Chất liệu: Vải Waffle sợi nhân tạo 100% Polyester
4. Kỹ thuật: Họa tiết thêu 2D tạo điểm nhấn
5. Phù hợp với ai: Phù hợp với mọi người, đặc biệt là những ai yêu thích phong cách đơn giản, thoải mái.
6. Thuộc Bộ Sưu Tập nào: Seventy Seven, một BST thời trang trung tính, dễ phối dễ lựa chọn.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo Thun Cổ Tròn, Áo Thun Tay Ngắn, Áo thun basic'),

(10, N'Áo Thun Cotton Line Art Co Giãn Seventy Seven 004 Trắng', 'ao6.png', 149150, 4, 
N'Trên nền vải Cotton 4 chiều co giãn và mềm mại, các thông số được giảm nhẹ để tạo phom áo ôm vừa vặn, tôn lên vóc dáng người mặc một cách tự nhiên.', 
N'Áo thun tay ngắn dáng rộng Cotton co giãn nhẹ, dễ chịu, màu sắc đa dạng.

1. Kiểu sản phẩm: Áo thun cổ tròn tay ngắn
2. Ưu điểm:
-Co giãn 4 chiều, thoải mái: Chất liệu co giãn 4 chiều, giúp dễ dàng vận động mà không bị gò bó, khó chịu.
-Thoát ẩm tốt: Giữ cho cơ thể luôn khô ráo và thoáng mát, phù hợp cho ngày hè năng động.
-Lưu ý về vải: Vải Cotton 4 chiều hơi mỏng nhằm tạo cảm giác thoáng mát nên cần cân nhắc giặt cẩn thận để giữ form áo trước khi mua.
3. Chất liệu: 92% Cotton, 8% Spandex; Cotton 4 chiều. Có 10 màu áo trung tính
4. Kỹ thuật: In cao, phối dây viền gân thun khác màu dọc vai, sử dụng bo cotton cùng màu làm cổ áo
5. Phù hợp với ai: Những người yêu thích thời trang thoải mái và phong cách, phù hợp cho cả nam và nữ
6. Thuộc Bộ Sưu Tập nào: Seventy Seven, thời trang trung tính, dễ phối dễ lựa chọn
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo thun cổ tròn, Áo thun co giãn, Áo thun Gen Z, Áo thun unisex'),

(10, N'Áo Thun Thể Thao Ultra Thin The Beginner 001 Đỏ Đậm', 'ao7.png', 149150, 4, 
N'Chất liệu Polyester siêu nhẹ, thoáng khí được thiết kế tay raglan và giảm nhẹ các thông số để tạo phom dáng thể thao, ôm gọn, tối ưu cho vận động.', 
N'Áo thun thể thao dáng vừa, siêu nhẹ, thoáng khí, nhanh khô

1. Kiểu sản phẩm: Áo Thun Thể Thao Tay Ngắn
2. Ưu điểm nổi bật:
Công nghệ Ultra Thin mang đến trải nghiệm Nhẹ nhàng như không khí với chiếc áo trọng lượng siêu mỏng nhẹ. Cấu trúc dệt kim cương độc đáo của chất liệu tạo nên những lỗ thoáng khí siêu nhỏ, giúp không khí lưu thông tối đa, loại bỏ cảm giác ẩm ướt, khó chịu ngay cả khi vận động mạnh. Đây chính là lựa chọn lý tưởng cho những buổi tập luyện, giúp bạn luôn khô ráo và dễ chịu để chinh phục mọi mục tiêu.
3. Chất liệu:
Diamond Pique Polyester, 100% Polyester
Chất liệu Polyester ít nhăn, bền màu, không xù lông, giúp bạn tiết kiệm thời gian chăm sóc. Lưu ý : Không ủi nóng với nhiệt độ >100°C
4. Kỹ thuật nổi bật:
Ép nhiệt Heat-transfer label hiệu ứng phản quang không chỉ làm chiếc áo thêm phong cách mà còn phát sáng khi có ánh đèn chiếu vào, giúp bạn an toàn hơn khi hoạt động vào ban đêm.
Thân sau lạ mắt với đường chiết pence được tính toán kỹ lưỡng ôm nhẹ và làm nổi bật các đường nét khỏe khoắn ở phần vai, mang đến hiệu ứng vóc dáng cân đối và mạnh mẽ hơn.
Thiết kế tay raglan và đường rã dưới cánh tay hạn chế tối đa các đường may giao nhau tạo cảm giác thoải mái tránh bị cọ xát khi vận động.
Đường sườn chòm ra thân trước giúp tôn lên vòng eo tạo hiệu ứng vóc dáng cân đối, chi tiết xẻ lai thông minh giúp áo không bị bó sát hay cản trở cử động ở vùng hông trong các động tác.
5. Phù hợp với: Nam giới có nhu cầu tập luyện thể thao cường độ nhẹ (tập gym,chạy bộ, leo núi, đánh cầu...). Những người tìm kiếm sự thoải mái, thoáng mát cho trang phục hàng ngày.
6. Phong cách: Thể Thao năng động
7. Tìm kiếm sản phẩm theo từ khóa: Áo thun thể thao nam, áo tập gym nam, áo chạy bộ nam, áo siêu nhẹ, áo thoáng khí, áo nhanh khô, áo phản quang, áo tay raglan, áo thun polyester, áo tập gym cao cấp'),

(10, N'Áo Thun Cotton Line Art Co Giãn Seventy Seven 004 Xám Nhạt', 'ao8.png', 149150, 4,
N'Trên nền vải Cotton 4 chiều co giãn và mềm mại, các thông số được giảm nhẹ để tạo phom áo ôm vừa vặn, tôn lên vóc dáng người mặc một cách tự nhiên.',
N'Áo thun tay ngắn dáng rộng Cotton co giãn nhẹ, dễ chịu, màu sắc đa dạng.

1. Kiểu sản phẩm: Áo thun cổ tròn tay ngắn
2. Ưu điểm:
-Co giãn 4 chiều, thoải mái: Chất liệu co giãn 4 chiều, giúp dễ dàng vận động mà không bị gò bó, khó chịu.
-Thoát ẩm tốt: Giữ cho cơ thể luôn khô ráo và thoáng mát, phù hợp cho ngày hè năng động.
-Lưu ý về vải: Vải Cotton 4 chiều hơi mỏng nhằm tạo cảm giác thoáng mát nên cần cân nhắc giặt cẩn thận để giữ form áo trước khi mua.
3. Chất liệu: 92% Cotton, 8% Spandex; Cotton 4 chiều. Có 10 màu áo trung tính
4. Kỹ thuật: In cao, phối dây viền gân thun khác màu dọc vai, sử dụng bo cotton cùng màu làm cổ áo
5. Phù hợp với ai: Những người yêu thích thời trang thoải mái và phong cách, phù hợp cho cả nam và nữ
6. Thuộc Bộ Sưu Tập nào: Seventy Seven, thời trang trung tính, dễ phối dễ lựa chọn
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo thun cổ tròn, Áo thun co giãn, Áo thun Gen Z, Áo thun unisex'),

(10, N'Áo Thun Pique Thoáng Mát Seventy Seven 013 Nâu Nhạt','ao9.png', 149150, 4,
N'Với chất vải Pique co giãn 4 chiều, thiết kế tay raglan và nới rộng ngực, lai, giúp người mặc thoải mái vận động mà vẫn giữ được phom dáng đẹp.',
N'Áo thun raglan dáng rộng vải Pique, mềm mại, co giãn thoáng mát.

1. Kiểu sản phẩm: Áo thun cổ tròn tay ngắn raglan, phối sọc, phong cách hiện đại.
2. Ưu điểm:
-Co giãn 4 chiều, thoát ẩm tốt: Vải Pique co giãn, thoáng nhẹ, dễ chịu. Chất vải hạn chế xù lông.
-Thiết kế trẻ trung, năng động: Thiết kế trẻ trung, năng động với phần phối sọc trên cánh tay, tạo điểm nhấn nổi bật.
-Dáng rộng thoải mái: Áo dáng rộng phù hợp với mọi người, đặc biệt là những người yêu thích sự thoải mái.
3. Chất liệu: Vải Pique (95% Polyester 5% Spandex)
4. Kỹ thuật: In dẻo, phối sọc ở tay tạo điểm nhấn cho sản phẩm.
5. Phù hợp với ai: Áo dáng rộng phù hợp với mọi người, đặc biệt là những người yêu thích phong cách năng động, thoải mái và trẻ trung.
6. Thuộc Bộ Sưu Tập: Seventy Seven, một BST thời trang trung tính, dễ phối dễ lựa chọn.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo thun cổ tròn, Áo thun tay ngắn, Áo Thun Gen Z'),

(10, N'Áo Thun Pique Thoáng Mát Seventy Seven 013 Xám', 'ao10.png', 149150, 4, 
N'Với chất vải Pique co giãn 4 chiều, thiết kế tay raglan và nới rộng ngực, lai, giúp người mặc thoải mái vận động mà vẫn giữ được phom dáng đẹp.',
N'Áo thun raglan dáng rộng vải Pique, mềm mại, co giãn thoáng mát.

1. Kiểu sản phẩm: Áo thun cổ tròn tay ngắn raglan, phối sọc, phong cách hiện đại.
2. Ưu điểm:
-Co giãn 4 chiều, thoát ẩm tốt: Vải Pique co giãn, thoáng nhẹ, dễ chịu. Chất vải hạn chế xù lông.
-Thiết kế trẻ trung, năng động: Thiết kế trẻ trung, năng động với phần phối sọc trên cánh tay, tạo điểm nhấn nổi bật.
-Dáng rộng thoải mái: Áo dáng rộng phù hợp với mọi người, đặc biệt là những người yêu thích sự thoải mái.
3. Chất liệu: Vải Pique (95% Polyester 5% Spandex)
4. Kỹ thuật: In dẻo, phối sọc ở tay tạo điểm nhấn cho sản phẩm.
5. Phù hợp với ai: Áo dáng rộng phù hợp với mọi người, đặc biệt là những người yêu thích phong cách năng động, thoải mái và trẻ trung.
6. Thuộc Bộ Sưu Tập: Seventy Seven, một BST thời trang trung tính, dễ phối dễ lựa chọn.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo thun cổ tròn, Áo thun tay ngắn, Áo Thun Gen Z'),

--------------------------------------------Áo Polo-------------------------------------------------------------------------------------------------------------------------------
(11, N'Áo Polo Pique Thoáng Mát Non Branded 003 Đen', 'ao11.png', 158150, 4,
N'Vải Pique Poly bền phom, được điều chỉnh gọn gàng hơn ở mọi thông số, tạo nên phom áo vừa vặn, tôn dáng mà vẫn thoải mái khi mặc.',
N'Áo Polo vải Pique co giãn tốt, mềm mại, thoáng mát.

1. Kiểu sản phẩm: Áo Polo Nam Tay Ngắn
2. Ưu điểm:
-Thoải mái là chân ái: Vải Pique thoáng mát, co giãn tốt, giúp bạn cảm thấy luôn khô ráo và "chill" cả ngày.
-Form áo thách thức máy giặt: Giặt máy thoải mái, không lo bai dão hay xù lông. Màu sắc giữ như mới sau hàng chục lần giặt.
-Polo Non-branded: Thiết kế tối giản, màu sắc nhã nhặn. "Cứu tinh" cho những ngày lười, mặc đại cũng auto-thanh lịch.
3. Chất liệu: Vải Pique 95% Polyester 5% Spandex
4. Kỹ thuật: Đường may tỉ mỉ đảm bảo sản phẩm có độ bền cao và tính thẩm mỹ. Cổ áo cứng cáp được gia cố chắc chắn, giữ form dáng chuẩn chỉnh, giúp bạn luôn tự tin trong mọi hoàn cảnh.
5. Phù hợp với ai: Nam giới yêu thích phong cách thời trang đơn giản, lịch lãm. Những người hoạt động thường xuyên và cần một chiếc áo thoải mái hoặc các chàng trai muốn có một item cơ bản nhưng không kém phần thời thượng trong tủ đồ.
6. Thuộc Bộ Sưu Tập: NON BRANDED - Mang đến sự sang trọng tinh tế nhưng không quá phô trương.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo polo nam vải pique, Áo polo co giãn 4 chiều, Áo polo basic, Áo polo màu pastel, Áo polo nam cao cấp, Áo polo nam công sở'),

(11, N'Áo Polo Pique Thoáng Mát Non Branded 003 Trắng', 'ao12.png', 158150, 4, 
N'Vải Pique Poly bền phom, được điều chỉnh gọn gàng hơn ở mọi thông số, tạo nên phom áo vừa vặn, tôn dáng mà vẫn thoải mái khi mặc.',
N'Áo Polo vải Pique co giãn tốt, mềm mại, thoáng mát.

1. Kiểu sản phẩm: Áo Polo Nam Tay Ngắn
2. Ưu điểm:
-Thoải mái là chân ái: Vải Pique thoáng mát, co giãn tốt, giúp bạn cảm thấy luôn khô ráo và "chill" cả ngày.
-Form áo thách thức máy giặt: Giặt máy thoải mái, không lo bai dão hay xù lông. Màu sắc giữ như mới sau hàng chục lần giặt.
-Polo Non-branded: Thiết kế tối giản, màu sắc nhã nhặn. "Cứu tinh" cho những ngày lười, mặc đại cũng auto-thanh lịch.
3. Chất liệu: Vải Pique 95% Polyester 5% Spandex
4. Kỹ thuật: Đường may tỉ mỉ đảm bảo sản phẩm có độ bền cao và tính thẩm mỹ. Cổ áo cứng cáp được gia cố chắc chắn, giữ form dáng chuẩn chỉnh, giúp bạn luôn tự tin trong mọi hoàn cảnh.
5. Phù hợp với ai: Nam giới yêu thích phong cách thời trang đơn giản, lịch lãm. Những người hoạt động thường xuyên và cần một chiếc áo thoải mái hoặc các chàng trai muốn có một item cơ bản nhưng không kém phần thời thượng trong tủ đồ.
6. Thuộc Bộ Sưu Tập: NON BRANDED - Mang đến sự sang trọng tinh tế nhưng không quá phô trương.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo polo nam vải pique, Áo polo co giãn 4 chiều, Áo polo basic, Áo polo màu pastel, Áo polo nam cao cấp, Áo polo nam công sở'),

(11, N'Áo Polo Pique Thoáng Mát Non Branded 003 Xám', 'ao13.png', 158150, 4, 
N'Vải Pique Poly bền phom, được điều chỉnh gọn gàng hơn ở mọi thông số, tạo nên phom áo vừa vặn, tôn dáng mà vẫn thoải mái khi mặc.',
N'Áo Polo vải Pique co giãn tốt, mềm mại, thoáng mát.

1. Kiểu sản phẩm: Áo Polo Nam Tay Ngắn
2. Ưu điểm:
-Thoải mái là chân ái: Vải Pique thoáng mát, co giãn tốt, giúp bạn cảm thấy luôn khô ráo và "chill" cả ngày.
-Form áo thách thức máy giặt: Giặt máy thoải mái, không lo bai dão hay xù lông. Màu sắc giữ như mới sau hàng chục lần giặt.
-Polo Non-branded: Thiết kế tối giản, màu sắc nhã nhặn. "Cứu tinh" cho những ngày lười, mặc đại cũng auto-thanh lịch.
3. Chất liệu: Vải Pique 95% Polyester 5% Spandex
4. Kỹ thuật: Đường may tỉ mỉ đảm bảo sản phẩm có độ bền cao và tính thẩm mỹ. Cổ áo cứng cáp được gia cố chắc chắn, giữ form dáng chuẩn chỉnh, giúp bạn luôn tự tin trong mọi hoàn cảnh.
5. Phù hợp với ai: Nam giới yêu thích phong cách thời trang đơn giản, lịch lãm. Những người hoạt động thường xuyên và cần một chiếc áo thoải mái hoặc các chàng trai muốn có một item cơ bản nhưng không kém phần thời thượng trong tủ đồ.
6. Thuộc Bộ Sưu Tập: NON BRANDED - Mang đến sự sang trọng tinh tế nhưng không quá phô trương.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo polo nam vải pique, Áo polo co giãn 4 chiều, Áo polo basic, Áo polo màu pastel, Áo polo nam cao cấp, Áo polo nam công sở'),

(11, N'Áo Polo Pique Thoáng Mát Non Branded 003 Xanh Dương Nhạt', 'ao14.png', 158150, 3,
N'Vải Pique Poly bền phom, được điều chỉnh gọn gàng hơn ở mọi thông số, tạo nên phom áo vừa vặn, tôn dáng mà vẫn thoải mái khi mặc.',
N'Áo Polo vải Pique co giãn tốt, mềm mại, thoáng mát.

1. Kiểu sản phẩm: Áo Polo Nam Tay Ngắn
2. Ưu điểm:
-Thoải mái là chân ái: Vải Pique thoáng mát, co giãn tốt, giúp bạn cảm thấy luôn khô ráo và "chill" cả ngày.
-Form áo thách thức máy giặt: Giặt máy thoải mái, không lo bai dão hay xù lông. Màu sắc giữ như mới sau hàng chục lần giặt.
-Polo Non-branded: Thiết kế tối giản, màu sắc nhã nhặn. "Cứu tinh" cho những ngày lười, mặc đại cũng auto-thanh lịch.
3. Chất liệu: Vải Pique 95% Polyester 5% Spandex
4. Kỹ thuật: Đường may tỉ mỉ đảm bảo sản phẩm có độ bền cao và tính thẩm mỹ. Cổ áo cứng cáp được gia cố chắc chắn, giữ form dáng chuẩn chỉnh, giúp bạn luôn tự tin trong mọi hoàn cảnh.
5. Phù hợp với ai: Nam giới yêu thích phong cách thời trang đơn giản, lịch lãm. Những người hoạt động thường xuyên và cần một chiếc áo thoải mái hoặc các chàng trai muốn có một item cơ bản nhưng không kém phần thời thượng trong tủ đồ.
6. Thuộc Bộ Sưu Tập: NON BRANDED - Mang đến sự sang trọng tinh tế nhưng không quá phô trương.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo polo nam vải pique, Áo polo co giãn 4 chiều, Áo polo basic, Áo polo màu pastel, Áo polo nam cao cấp, Áo polo nam công sở'),

(11, N'Áo Polo Pique Thoáng Mát Non Branded 003 Xanh Lá Đậm', 'ao15.png', 158150, 5,
N'Vải Pique Poly bền phom, được điều chỉnh gọn gàng hơn ở mọi thông số, tạo nên phom áo vừa vặn, tôn dáng mà vẫn thoải mái khi mặc.',
N'Áo Polo vải Pique co giãn tốt, mềm mại, thoáng mát.

1. Kiểu sản phẩm: Áo Polo Nam Tay Ngắn
2. Ưu điểm:
-Thoải mái là chân ái: Vải Pique thoáng mát, co giãn tốt, giúp bạn cảm thấy luôn khô ráo và "chill" cả ngày.
-Form áo thách thức máy giặt: Giặt máy thoải mái, không lo bai dão hay xù lông. Màu sắc giữ như mới sau hàng chục lần giặt.
-Polo Non-branded: Thiết kế tối giản, màu sắc nhã nhặn. "Cứu tinh" cho những ngày lười, mặc đại cũng auto-thanh lịch.
3. Chất liệu: Vải Pique 95% Polyester 5% Spandex
4. Kỹ thuật: Đường may tỉ mỉ đảm bảo sản phẩm có độ bền cao và tính thẩm mỹ. Cổ áo cứng cáp được gia cố chắc chắn, giữ form dáng chuẩn chỉnh, giúp bạn luôn tự tin trong mọi hoàn cảnh.
5. Phù hợp với ai: Nam giới yêu thích phong cách thời trang đơn giản, lịch lãm. Những người hoạt động thường xuyên và cần một chiếc áo thoải mái hoặc các chàng trai muốn có một item cơ bản nhưng không kém phần thời thượng trong tủ đồ.
6. Thuộc Bộ Sưu Tập: NON BRANDED - Mang đến sự sang trọng tinh tế nhưng không quá phô trương.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo polo nam vải pique, Áo polo co giãn 4 chiều, Áo polo basic, Áo polo màu pastel, Áo polo nam cao cấp, Áo polo nam công sở'),

(11, N'Áo Polo Phối Màu Pique Thoáng Mát Seventy Seven 019 Đen Trắng', 'ao16.png', 215650, 4,
N'Dựa trên chất vải Pique Poly đứng phom, các thông số được giảm nhẹ để tạo nên dáng polo vừa vặn, tôn body, mang lại vẻ ngoài thanh lịch, gọn gàng.',
N'Áo Polo vải Pique co giãn tốt, mềm mại, thoáng mát.

1. Kiểu sản phẩm: Áo Thun Polo cổ bẻ, tay ngắn và dáng vừa.
2. Ưu điểm:
-Polo hack dáng: Phối màu basic, rã phối ngang eo hack dáng siêu đỉnh, giúp bạn trông cao ráo hơn.
-Dáng chuẩn không cần chỉnh: Form polo ôm vừa vặn, tôn body, thoải mái vận động.
-Chất liệu đỉnh cao: Vải Pique co giãn 4 chiều, không xù lông. In Rubber bền màu, bo cổ tay "form chuẩn từng milimet".
3. Chất liệu: Sản phẩm được làm từ vải Pique (cá sấu 4 chiều), có thành phần 95% Polyester và 5% Spandex.
4. Kỹ thuật: Áo có họa tiết in dẻo trên bề mặt kết hợp chi tiết rã phối, tạo điểm nhấn thú vị.
5. Phù hợp với ai: Áo Polo phù hợp với mọi người, đặc biệt là trong các hoạt động thể thao, dạo phố, hay khi bạn muốn trang nhã và thoải mái.
6. Thuộc Bộ Sưu Tập: Bộ sưu tập Seventy Seven - thời trang trung tính, dễ phối dễ lựa chọn
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo thun Polo cổ bẻ, áo thun Polo cá sấu, áo thun Polo dáng rộng, Áo thun Polo Seventy Seven, Áo thun Polo màu, Áo pique.'),

(11, N'Áo Polo Pique Thoáng Mát Non Branded 003 Be', 'ao17.png', 168150, 4,
N'Vải Pique Poly bền phom, được điều chỉnh gọn gàng hơn ở mọi thông số, tạo nên phom áo vừa vặn, tôn dáng mà vẫn thoải mái khi mặc.',
N'Áo Polo vải Pique co giãn tốt, mềm mại, thoáng mát.

1. Kiểu sản phẩm: Áo Polo Nam Tay Ngắn
2. Ưu điểm:
-Thoải mái là chân ái: Vải Pique thoáng mát, co giãn tốt, giúp bạn cảm thấy luôn khô ráo và "chill" cả ngày.
-Form áo thách thức máy giặt: Giặt máy thoải mái, không lo bai dão hay xù lông. Màu sắc giữ như mới sau hàng chục lần giặt.
-Polo Non-branded: Thiết kế tối giản, màu sắc nhã nhặn. "Cứu tinh" cho những ngày lười, mặc đại cũng auto-thanh lịch.
3. Chất liệu: Vải Pique 95% Polyester 5% Spandex
4. Kỹ thuật: Đường may tỉ mỉ đảm bảo sản phẩm có độ bền cao và tính thẩm mỹ. Cổ áo cứng cáp được gia cố chắc chắn, giữ form dáng chuẩn chỉnh, giúp bạn luôn tự tin trong mọi hoàn cảnh.
5. Phù hợp với ai: Nam giới yêu thích phong cách thời trang đơn giản, lịch lãm. Những người hoạt động thường xuyên và cần một chiếc áo thoải mái hoặc các chàng trai muốn có một item cơ bản nhưng không kém phần thời thượng trong tủ đồ.
6. Thuộc Bộ Sưu Tập: NON BRANDED - Mang đến sự sang trọng tinh tế nhưng không quá phô trương.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo polo nam vải pique, Áo polo co giãn 4 chiều, Áo polo basic, Áo polo màu pastel, Áo polo nam cao cấp, Áo polo nam công sở'),

(11, N'Áo Polo Pique Thoáng Mát Non Branded 003 Hồng', 'ao18.png', 158150, 4,
N'Vải Pique Poly bền phom, được điều chỉnh gọn gàng hơn ở mọi thông số, tạo nên phom áo vừa vặn, tôn dáng mà vẫn thoải mái khi mặc.',
N'Áo Polo vải Pique co giãn tốt, mềm mại, thoáng mát.

1. Kiểu sản phẩm: Áo Polo Nam Tay Ngắn
2. Ưu điểm:
-Thoải mái là chân ái: Vải Pique thoáng mát, co giãn tốt, giúp bạn cảm thấy luôn khô ráo và "chill" cả ngày.
-Form áo thách thức máy giặt: Giặt máy thoải mái, không lo bai dão hay xù lông. Màu sắc giữ như mới sau hàng chục lần giặt.
-Polo Non-branded: Thiết kế tối giản, màu sắc nhã nhặn. "Cứu tinh" cho những ngày lười, mặc đại cũng auto-thanh lịch.
3. Chất liệu: Vải Pique 95% Polyester 5% Spandex
4. Kỹ thuật: Đường may tỉ mỉ đảm bảo sản phẩm có độ bền cao và tính thẩm mỹ. Cổ áo cứng cáp được gia cố chắc chắn, giữ form dáng chuẩn chỉnh, giúp bạn luôn tự tin trong mọi hoàn cảnh.
5. Phù hợp với ai: Nam giới yêu thích phong cách thời trang đơn giản, lịch lãm. Những người hoạt động thường xuyên và cần một chiếc áo thoải mái hoặc các chàng trai muốn có một item cơ bản nhưng không kém phần thời thượng trong tủ đồ.
6. Thuộc Bộ Sưu Tập: NON BRANDED - Mang đến sự sang trọng tinh tế nhưng không quá phô trương.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo polo nam vải pique, Áo polo co giãn 4 chiều, Áo polo basic, Áo polo màu pastel, Áo polo nam cao cấp, Áo polo nam công sở'),

(11, N'Áo Polo Pique Mềm Mại Thoáng Mát The No Style 078 Đen', 'ao19.png', 187150, 4,
N'Chất vải Pique "cá sấu" đứng phom, được tinh chỉnh gọn gàng hơn ở các số đo chính, tạo dáng vẻ thanh lịch, chỉn chu, giúp người mặc trông cao ráo hơn.', 
N'Áo thun dáng vừa, vải Bird’s Eye Pique, thoáng nhẹ, dễ chịu, ít nhăn.

1. Kiểu sản phẩm: Áo Thun Cổ Polo Tay Ngắn
2. Ưu điểm:
-Chất vải " cá sấu" , chill cả ngày : Vải Pique xịn, mềm, thoát ẩm tốt. Tạm biệt nỗi lo "ẩm ương" khó chịu.
-Form áo thách thức máy giặt : Flex nhẹ độ bền: Bo cổ và tay áo nói không với bai nhão, bền vững vibes.
-Polo phối bo khác biệt: Chút nhấn nhá màu sắc ở cổ và tay áo cũng đủ làm bạn trông hay ho hơn hẳn rồi đó!
3. Chất liệu: Vải Pique, 61% Polyester, 33% Cotton, 6% Spandex.
4. Kỹ thuật: Bo cổ, bo tay dệt sợi poly phối khác màu tạo điểm nhấn cho áo.
5. Phù hợp với ai: Dành cho những ai yêu thích phong cách trẻ trung, năng động, thoải mái, và muốn thể hiện cá tính mà vẫn lịch sự. Thích hợp cho mọi hoạt động từ ngoài trời, thể thao đến đi làm, đi học, đi chơi.
6. Thuộc Bộ Sưu Tập: No Style, phù hợp với mọi phong cách, từ thanh lịch đến cá tính, luôn thời trang và hiện đại.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo polo cổ bẻ, Áo polo đen, Áo polo tay ngắn, Áo polo dáng vừa, Áo polo công sở'),

(11, N'Áo Polo Pique Thoáng Mát Non Branded 003 Nâu', 'ao20.png', 158150, 4, 
N'Vải Pique Poly bền phom, được điều chỉnh gọn gàng hơn ở mọi thông số, tạo nên phom áo vừa vặn, tôn dáng mà vẫn thoải mái khi mặc.', 
N'Áo Polo vải Pique co giãn tốt, mềm mại, thoáng mát.

1. Kiểu sản phẩm: Áo Polo Nam Tay Ngắn
2. Ưu điểm:
-Thoải mái là chân ái: Vải Pique thoáng mát, co giãn tốt, giúp bạn cảm thấy luôn khô ráo và "chill" cả ngày.
-Form áo thách thức máy giặt: Giặt máy thoải mái, không lo bai dão hay xù lông. Màu sắc giữ như mới sau hàng chục lần giặt.
-Polo Non-branded: Thiết kế tối giản, màu sắc nhã nhặn. "Cứu tinh" cho những ngày lười, mặc đại cũng auto-thanh lịch.
3. Chất liệu: Vải Pique 95% Polyester 5% Spandex
4. Kỹ thuật: Đường may tỉ mỉ đảm bảo sản phẩm có độ bền cao và tính thẩm mỹ. Cổ áo cứng cáp được gia cố chắc chắn, giữ form dáng chuẩn chỉnh, giúp bạn luôn tự tin trong mọi hoàn cảnh.
5. Phù hợp với ai: Nam giới yêu thích phong cách thời trang đơn giản, lịch lãm. Những người hoạt động thường xuyên và cần một chiếc áo thoải mái hoặc các chàng trai muốn có một item cơ bản nhưng không kém phần thời thượng trong tủ đồ.
6. Thuộc Bộ Sưu Tập: NON BRANDED - Mang đến sự sang trọng tinh tế nhưng không quá phô trương.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo polo nam vải pique, Áo polo co giãn 4 chiều, Áo polo basic, Áo polo màu pastel, Áo polo nam cao cấp, Áo polo nam công sở'),

--------------------------------------------Ao so mi tay ngan-------------------------------------------------------------------------------------------------------------------------------
(12, N'Áo Sơ Mi Modal Mềm Mịn Ít Nhăn Non Branded 033 Trắng', 'ao21.png', 187150, 4,
N'Vải modal mỏng nhẹ, nhanh khô được giữ nguyên phom dáng rộng rãi, đảm bảo sự thoải mái tuyệt đối, "cân" mọi hoạt động trong ngày hè nóng bức.',
N'Áo sơ mi Modal Fabric, mềm mỏng, nhanh khô, ít vón cục

1. Kiểu sản phẩm: Áo sơ mi cổ bẻ tay ngắn dáng rộng.
2. Ưu điểm
-Friendzone của làn da: Áo mặc nhẹ tênh, "chill" cả ngày dài.
-Bay hơi trong 1 nốt nhạc: Vải mỏng nhẹ, nhanh khô. Giặt buổi tối, sáng có đồ mặc, "cân" mọi kèo gấp.
-Bảng màu "cân" mọi gu: Bảy màu tha hồ lựa, là "cứu tinh" cho những ngày lười, auto-đẹp trai.
3. Chất liệu: Modal Fabric, 12% Modal 88% Polyester.
4. Kỹ thuật: Dáng rộng tạo cảm giác thoải mái, năng động. Thiết kế cổ bẻ cổ điển, thanh lịch.
5. Phù hợp với ai: Phù hợp cho người trẻ yêu phong cách đơn giản, năng động. Những người bận rộn cần áo thoải mái dễ chăm sóc và những ai yêu thích thiết kế tối giản, tinh tế, không quá cầu kỳ.
6. Thuộc Bộ Sưu Tập: Non Branded, thời trang tối giản, chất lượng cao nhưng giá thành phải chăng.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo sơ mi dáng rộng, áo sơ mi cổ bẻ tay ngắn, áo sơ mi nam, áo sơ mi modal.'),

(12, N'Áo Sơ Mi Modal Mềm Mịn Ít Nhăn Non Branded 033 Xanh Dương Nhạt', 'ao22.png', 187150, 4,
N'Vải modal mỏng nhẹ, nhanh khô được giữ nguyên phom dáng rộng rãi, đảm bảo sự thoải mái tuyệt đối, "cân" mọi hoạt động trong ngày hè nóng bức.',
N'Áo sơ mi Modal Fabric, mềm mỏng, nhanh khô, ít vón cục

1. Kiểu sản phẩm: Áo sơ mi cổ bẻ tay ngắn dáng rộng.
2. Ưu điểm
-Friendzone của làn da: Áo mặc nhẹ tênh, "chill" cả ngày dài.
-Bay hơi trong 1 nốt nhạc: Vải mỏng nhẹ, nhanh khô. Giặt buổi tối, sáng có đồ mặc, "cân" mọi kèo gấp.
-Bảng màu "cân" mọi gu: Bảy màu tha hồ lựa, là "cứu tinh" cho những ngày lười, auto-đẹp trai.
3. Chất liệu: Modal Fabric, 12% Modal 88% Polyester.
4. Kỹ thuật: Dáng rộng tạo cảm giác thoải mái, năng động. Thiết kế cổ bẻ cổ điển, thanh lịch.
5. Phù hợp với ai: Phù hợp cho người trẻ yêu phong cách đơn giản, năng động. Những người bận rộn cần áo thoải mái dễ chăm sóc và những ai yêu thích thiết kế tối giản, tinh tế, không quá cầu kỳ.
6. Thuộc Bộ Sưu Tập: Non Branded, thời trang tối giản, chất lượng cao nhưng giá thành phải chăng.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo sơ mi dáng rộng, áo sơ mi cổ bẻ tay ngắn, áo sơ mi nam, áo sơ mi modal.'),

(12, N'Áo Sơ Mi Modal Mềm Mịn Ít Nhăn Non Branded 033 Đen', 'ao23.png', 187150, 4,
N'Vải modal mỏng nhẹ, nhanh khô được giữ nguyên phom dáng rộng rãi, đảm bảo sự thoải mái tuyệt đối, "cân" mọi hoạt động trong ngày hè nóng bức.',
N'Áo sơ mi Modal Fabric, mềm mỏng, nhanh khô, ít vón cục

1. Kiểu sản phẩm: Áo sơ mi cổ bẻ tay ngắn dáng rộng.
2. Ưu điểm
-Friendzone của làn da: Áo mặc nhẹ tênh, "chill" cả ngày dài.
-Bay hơi trong 1 nốt nhạc: Vải mỏng nhẹ, nhanh khô. Giặt buổi tối, sáng có đồ mặc, "cân" mọi kèo gấp.
-Bảng màu "cân" mọi gu: Bảy màu tha hồ lựa, là "cứu tinh" cho những ngày lười, auto-đẹp trai.
3. Chất liệu: Modal Fabric, 12% Modal 88% Polyester.
4. Kỹ thuật: Dáng rộng tạo cảm giác thoải mái, năng động. Thiết kế cổ bẻ cổ điển, thanh lịch.
5. Phù hợp với ai: Phù hợp cho người trẻ yêu phong cách đơn giản, năng động. Những người bận rộn cần áo thoải mái dễ chăm sóc và những ai yêu thích thiết kế tối giản, tinh tế, không quá cầu kỳ.
6. Thuộc Bộ Sưu Tập: Non Branded, thời trang tối giản, chất lượng cao nhưng giá thành phải chăng.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo sơ mi dáng rộng, áo sơ mi cổ bẻ tay ngắn, áo sơ mi nam, áo sơ mi modal.'),

(12, N'Áo Sơ Mi Tay Ngắn Vải Nhung Corduroy Retro Ít Nhăn Seventy Seven 022 Nâu Nhạt', 'ao24.png', 187150, 4,
N'Vải nhung tăm dày dặn, ấm áp là cơ sở để mở rộng phom ở ngực và vai, tạo nên dáng áo rộng rãi, đậm chất retro và che khuyết điểm hoàn hảo.',
N'Áo Sơ Mi dáng rộng Vải Corduroy, họa tiết sọc nhung tăm, ít nhăn, bền bỉ.

1. Kiểu sản phẩm: Áo sơ mi tay ngắn phối màu
2. Ưu điểm:
-Vải Corduroy, Retro Vibe: Vải Corduroy 100% Polyester ít nhăn, đứng form, mang vẻ đẹp retro và ấm áp.
-Phối màu bắt mắt, tinh tế: Thiết kế phối màu hài hòa giữa các tông màu trầm, tạo vẻ đẹp cổ điển, sang trọng.
-Điểm nhấn thêu 2D sắc nét: Họa tiết thêu 2D tạo dấu ấn nổi bật, tăng thêm tính thẩm mỹ cho sản phẩm.
3. Chất liệu: Corduroy,100% Polyester
4. Kỹ thuật: Kỹ thuật thêu 2D chỉ polyester tạo dấu ấn nổi bật cho sản phẩm, thiết kế phối màu kết hợp hài hòa giữa các màu sắc trầm, tạo nên vẻ đẹp cổ điển và sang trọng.
5. Phù hợp với ai: Phù hợp cho cả nam và nữ, từ công sở đến dạo phố, người yêu thích phong cách cổ điển.
6. Thuộc Bộ Sưu Tập: Seventy Seven - thời trang với gam màu dễ phối đồ
7. Các tên thường gọi hoặc tìm kiếm: Áo sơ mi Corduroy, Áo sơ mi phối màu, Áo Sơ Mi, Áo sơ mi nhung, Áo sơ mi unisex dáng rộng, Áo sơ mi màu trầm.'),

(12, N'Áo Sơ Mi Modal Mềm Mịn Ít Nhăn Non Branded 033 Nâu Nhạt', 'ao25.png', 187150, 4,
N'Vải modal mỏng nhẹ, nhanh khô được giữ nguyên phom dáng rộng rãi, đảm bảo sự thoải mái tuyệt đối, "cân" mọi hoạt động trong ngày hè nóng bức.',
N'Áo sơ mi Modal Fabric, mềm mỏng, nhanh khô, ít vón cục

1. Kiểu sản phẩm: Áo sơ mi cổ bẻ tay ngắn dáng rộng.
2. Ưu điểm
-Friendzone của làn da: Áo mặc nhẹ tênh, "chill" cả ngày dài.
-Bay hơi trong 1 nốt nhạc: Vải mỏng nhẹ, nhanh khô. Giặt buổi tối, sáng có đồ mặc, "cân" mọi kèo gấp.
-Bảng màu "cân" mọi gu: Bảy màu tha hồ lựa, là "cứu tinh" cho những ngày lười, auto-đẹp trai.
3. Chất liệu: Modal Fabric, 12% Modal 88% Polyester.
4. Kỹ thuật: Dáng rộng tạo cảm giác thoải mái, năng động. Thiết kế cổ bẻ cổ điển, thanh lịch.
5. Phù hợp với ai: Phù hợp cho người trẻ yêu phong cách đơn giản, năng động. Những người bận rộn cần áo thoải mái dễ chăm sóc và những ai yêu thích thiết kế tối giản, tinh tế, không quá cầu kỳ.
6. Thuộc Bộ Sưu Tập: Non Branded, thời trang tối giản, chất lượng cao nhưng giá thành phải chăng.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo sơ mi dáng rộng, áo sơ mi cổ bẻ tay ngắn, áo sơ mi nam, áo sơ mi modal.'),

(12, N'Áo Sơ Mi Cổ Trụ Linen Thoáng mát Seventy Seven 024 Trắng', 'ao26.png', 187150, 4,
N'Với chất vải Linen thoáng nhẹ, phom dáng rộng được giữ nguyên, mang lại cảm giác thoải mái, mát mẻ tối đa, là lựa chọn hoàn hảo cho mùa hè.',
N'Áo sơ mi cổ trụ dáng rộng vải hiệu ứng Linen, mềm mát, thoáng da, ít nhăn.

1. Kiểu sản phẩm: Áo Sơ Mi Tay Ngắn
2. Ưu điểm:
-Vải Linen, thoáng mát dễ chịu: Chất vải Linen kết hợp Rayon, Nylon, Polyester, thoáng nhẹ, dễ chịu , và ít nhăn.
-Cổ trụ tinh tế, thanh lịch: Thiết kế cổ trụ (cổ lãnh tụ) mang đến vẻ ngoài tối giản, thanh lịch.
-Điểm nhấn thêu 2D tinh tế: Họa tiết thêu 2D cùng tông màu, tạo điểm nhấn tinh tế mà không quá nổi bật.
3. Chất liệu: Vải Hiệu Ứng Linen với thành phần 49% Rayon, 17% Nylon và 34% Polyester.
4. Kỹ thuật: Họa tiết thêu 2D cùng tone màu tạo điểm nhấn tinh tế, không quá nổi bật nhưng vẫn đủ ấn tượng.
5. Phù hợp với ai: Phù hợp cho người làm công sở yêu thích sự thoải mái, mặc khi đi học, đi chơi, người ưa thích phong cách đơn giản ít cầu kỳ và những người đặc biệt quan tâm đến bảo vệ môi trường.
6. Thuộc Bộ Sưu Tập nào: Seventy Seven - trung tính tinh tế
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo sơ mi basic, Áo sơ mi cổ trụ , Áo sơ mi công sở, Áo sơ mi cổ lãnh tụ, Áo sơ mi cổ đứng, Áo sơ mi cổ tàu, Áo sơ mi cổ mandarin, Áo sơ mi cổ grandad'),

(12, N'Áo Sơ Mi Cổ Trụ Linen Thoáng mát Seventy Seven 024 Nâu Nhạt', 'ao27.png', 231300, 4,
N'Với chất vải Linen thoáng nhẹ, phom dáng rộng được giữ nguyên, mang lại cảm giác thoải mái, mát mẻ tối đa, là lựa chọn hoàn hảo cho mùa hè.',
N'Áo sơ mi cổ trụ dáng rộng vải hiệu ứng Linen, mềm mát, thoáng da, ít nhăn.

1. Kiểu sản phẩm: Áo Sơ Mi Tay Ngắn
2. Ưu điểm:
-Vải Linen, thoáng mát dễ chịu: Chất vải Linen kết hợp Rayon, Nylon, Polyester, thoáng nhẹ, dễ chịu , và ít nhăn.
-Cổ trụ tinh tế, thanh lịch: Thiết kế cổ trụ (cổ lãnh tụ) mang đến vẻ ngoài tối giản, thanh lịch.
-Điểm nhấn thêu 2D tinh tế: Họa tiết thêu 2D cùng tông màu, tạo điểm nhấn tinh tế mà không quá nổi bật.
3. Chất liệu: Vải Hiệu Ứng Linen với thành phần 49% Rayon, 17% Nylon và 34% Polyester.
4. Kỹ thuật: Họa tiết thêu 2D cùng tone màu tạo điểm nhấn tinh tế, không quá nổi bật nhưng vẫn đủ ấn tượng.
5. Phù hợp với ai: Phù hợp cho người làm công sở yêu thích sự thoải mái, mặc khi đi học, đi chơi, người ưa thích phong cách đơn giản ít cầu kỳ và những người đặc biệt quan tâm đến bảo vệ môi trường.
6. Thuộc Bộ Sưu Tập nào: Seventy Seven - trung tính tinh tế
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo sơ mi basic, Áo sơ mi cổ trụ , Áo sơ mi công sở, Áo sơ mi cổ lãnh tụ, Áo sơ mi cổ đứng, Áo sơ mi cổ tàu, Áo sơ mi cổ mandarin, Áo sơ mi cổ grandad'),

(12, N'Áo Sơ Mi Modal Mềm Mịn Ít Nhăn Non Branded 033 Xám Nhạt', 'ao28.png', 187150, 4,
N'Vải modal mỏng nhẹ, nhanh khô được giữ nguyên phom dáng rộng rãi, đảm bảo sự thoải mái tuyệt đối, "cân" mọi hoạt động trong ngày hè nóng bức.',
N'Áo sơ mi Modal Fabric, mềm mỏng, nhanh khô, ít vón cục

1. Kiểu sản phẩm: Áo sơ mi cổ bẻ tay ngắn dáng rộng.
2. Ưu điểm
-Friendzone của làn da: Áo mặc nhẹ tênh, "chill" cả ngày dài.
-Bay hơi trong 1 nốt nhạc: Vải mỏng nhẹ, nhanh khô. Giặt buổi tối, sáng có đồ mặc, "cân" mọi kèo gấp.
-Bảng màu "cân" mọi gu: Bảy màu tha hồ lựa, là "cứu tinh" cho những ngày lười, auto-đẹp trai.
3. Chất liệu: Modal Fabric, 12% Modal 88% Polyester.
4. Kỹ thuật: Dáng rộng tạo cảm giác thoải mái, năng động. Thiết kế cổ bẻ cổ điển, thanh lịch.
5. Phù hợp với ai: Phù hợp cho người trẻ yêu phong cách đơn giản, năng động. Những người bận rộn cần áo thoải mái dễ chăm sóc và những ai yêu thích thiết kế tối giản, tinh tế, không quá cầu kỳ.
6. Thuộc Bộ Sưu Tập: Non Branded, thời trang tối giản, chất lượng cao nhưng giá thành phải chăng.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo sơ mi dáng rộng, áo sơ mi cổ bẻ tay ngắn, áo sơ mi nam, áo sơ mi modal.'),

(12, N'Áo Sơ Mi Tay Ngắn Vải Nhung Corduroy Retro Ít Nhăn Seventy Seven 022 Đen', 'ao29.png', 187150, 4,
N'Vải nhung tăm dày dặn, ấm áp là cơ sở để mở rộng phom ở ngực và vai, tạo nên dáng áo rộng rãi, đậm chất retro và che khuyết điểm hoàn hảo.',
N'Áo Sơ Mi dáng rộng Vải Corduroy, họa tiết sọc nhung tăm, ít nhăn, bền bỉ.

1. Kiểu sản phẩm: Áo sơ mi tay ngắn phối màu
2. Ưu điểm:
-Vải Corduroy, Retro Vibe: Vải Corduroy 100% Polyester ít nhăn, đứng form, mang vẻ đẹp retro và ấm áp.
-Phối màu bắt mắt, tinh tế: Thiết kế phối màu hài hòa giữa các tông màu trầm, tạo vẻ đẹp cổ điển, sang trọng.
-Điểm nhấn thêu 2D sắc nét: Họa tiết thêu 2D tạo dấu ấn nổi bật, tăng thêm tính thẩm mỹ cho sản phẩm.
3. Chất liệu: Corduroy,100% Polyester
4. Kỹ thuật: Kỹ thuật thêu 2D chỉ polyester tạo dấu ấn nổi bật cho sản phẩm, thiết kế phối màu kết hợp hài hòa giữa các màu sắc trầm, tạo nên vẻ đẹp cổ điển và sang trọng.
5. Phù hợp với ai: Phù hợp cho cả nam và nữ, từ công sở đến dạo phố, người yêu thích phong cách cổ điển.
6. Thuộc Bộ Sưu Tập: Seventy Seven - thời trang với gam màu dễ phối đồ
7. Các tên thường gọi hoặc tìm kiếm: Áo sơ mi Corduroy, Áo sơ mi phối màu, Áo Sơ Mi, Áo sơ mi nhung, Áo sơ mi unisex dáng rộng, Áo sơ mi màu trầm.'),

(12, N'Áo Sơ Mi Cổ Trụ Linen Thoáng mát Seventy Seven 024 Xám', 'ao30.png', 231300, 4,
N'Với chất vải Linen thoáng nhẹ, phom dáng rộng được giữ nguyên, mang lại cảm giác thoải mái, mát mẻ tối đa, là lựa chọn hoàn hảo cho mùa hè.',
N'Áo sơ mi cổ trụ dáng rộng vải hiệu ứng Linen, mềm mát, thoáng da, ít nhăn.

1. Kiểu sản phẩm: Áo Sơ Mi Tay Ngắn
2. Ưu điểm:
-Vải Linen, thoáng mát dễ chịu: Chất vải Linen kết hợp Rayon, Nylon, Polyester, thoáng nhẹ, dễ chịu , và ít nhăn.
-Cổ trụ tinh tế, thanh lịch: Thiết kế cổ trụ (cổ lãnh tụ) mang đến vẻ ngoài tối giản, thanh lịch.
-Điểm nhấn thêu 2D tinh tế: Họa tiết thêu 2D cùng tông màu, tạo điểm nhấn tinh tế mà không quá nổi bật.
3. Chất liệu: Vải Hiệu Ứng Linen với thành phần 49% Rayon, 17% Nylon và 34% Polyester.
4. Kỹ thuật: Họa tiết thêu 2D cùng tone màu tạo điểm nhấn tinh tế, không quá nổi bật nhưng vẫn đủ ấn tượng.
5. Phù hợp với ai: Phù hợp cho người làm công sở yêu thích sự thoải mái, mặc khi đi học, đi chơi, người ưa thích phong cách đơn giản ít cầu kỳ và những người đặc biệt quan tâm đến bảo vệ môi trường.
6. Thuộc Bộ Sưu Tập nào: Seventy Seven - trung tính tinh tế
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo sơ mi basic, Áo sơ mi cổ trụ , Áo sơ mi công sở, Áo sơ mi cổ lãnh tụ, Áo sơ mi cổ đứng, Áo sơ mi cổ tàu, Áo sơ mi cổ mandarin, Áo sơ mi cổ grandad'),

--------------------------------------------Ao so mi tay dai-------------------------------------------------------------------------------------------------------------------------------

(13, N'Áo Sơ Mi Tay Dài Modal Ít Nhăn Non Branded 019 Trắng', 'ao31.png', 187150, 4,
N'Dựa trên chất vải modal mỏng nhẹ, phom áo được tinh chỉnh gọn gàng hơn, tạo nên dáng vẻ thanh lịch, chỉn chu mà vẫn đảm bảo sự thoáng mát tối đa.',
N'Áo sơ mi Modal, mềm mịn, mỏng nhẹ, ít vón cục.

1. Kiểu sản phẩm: Áo sơ mi cổ bẻ tay dài.
2. Ưu điểm:
-Friendzone của làn da: Áo mặc nhẹ tênh, "chill" cả ngày dài.
-Bay hơi trong 1 nốt nhạc: Vải mỏng nhẹ, nhanh khô. Giặt buổi tối, sáng có đồ mặc, "cân" mọi kèo gấp.
-Bảng màu "cân" mọi gu: Bảy màu tha hồ lựa chọn. "Cứu tinh" cho những ngày lười, auto đẹp trai.
3. Chất liệu: Modal Fabric, thành phần 12% Modal 88% Polyester.
4. Kỹ thuật: Thiết kế form vừa thanh lịch, đơn giản basic nhất có thể, giúp dễ dàng chọn lựa và phối đồ, đường may tỉ mỉ và bảng màu đa dạng.
5. Phù hợp với ai: Phái mạnh có cá tính thời trang đa dạng và phá cách đầy táo bạo hoặc tinh tế và đơn giản trong phong cách thời trang của họ.
6. Thuộc Bộ Sưu Tập nào: Non Branded - Thời trang tối giản, phong cách hiện đại, giá cả hợp lý.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: sơ mi nam tay dài, sơ mi nam màu đen, sơ mi nam công sở.'),

(13, N'Áo Sơ Mi Tay Dài Modal Ít Nhăn Non Branded 019 Đen', 'ao32.png', 187150, 4,
N'Dựa trên chất vải modal mỏng nhẹ, phom áo được tinh chỉnh gọn gàng hơn, tạo nên dáng vẻ thanh lịch, chỉn chu mà vẫn đảm bảo sự thoáng mát tối đa.',
N'Áo sơ mi Modal, mềm mịn, mỏng nhẹ, ít vón cục.

1. Kiểu sản phẩm: Áo sơ mi cổ bẻ tay dài.
2. Ưu điểm:
-Friendzone của làn da: Áo mặc nhẹ tênh, "chill" cả ngày dài.
-Bay hơi trong 1 nốt nhạc: Vải mỏng nhẹ, nhanh khô. Giặt buổi tối, sáng có đồ mặc, "cân" mọi kèo gấp.
-Bảng màu "cân" mọi gu: Bảy màu tha hồ lựa chọn. "Cứu tinh" cho những ngày lười, auto đẹp trai.
3. Chất liệu: Modal Fabric, thành phần 12% Modal 88% Polyester.
4. Kỹ thuật: Thiết kế form vừa thanh lịch, đơn giản basic nhất có thể, giúp dễ dàng chọn lựa và phối đồ, đường may tỉ mỉ và bảng màu đa dạng.
5. Phù hợp với ai: Phái mạnh có cá tính thời trang đa dạng và phá cách đầy táo bạo hoặc tinh tế và đơn giản trong phong cách thời trang của họ.
6. Thuộc Bộ Sưu Tập nào: Non Branded - Thời trang tối giản, phong cách hiện đại, giá cả hợp lý.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: sơ mi nam tay dài, sơ mi nam màu đen, sơ mi nam công sở.'),

(13, N'Áo Sơ Mi Tay Dài Modal Ít Nhăn Non Branded 019 Xanh Dương Nhạt', 'ao33.png', 187150, 4,
N'Dựa trên chất vải modal mỏng nhẹ, phom áo được tinh chỉnh gọn gàng hơn, tạo nên dáng vẻ thanh lịch, chỉn chu mà vẫn đảm bảo sự thoáng mát tối đa.',
N'Áo sơ mi Modal, mềm mịn, mỏng nhẹ, ít vón cục.

1. Kiểu sản phẩm: Áo sơ mi cổ bẻ tay dài.
2. Ưu điểm:
-Friendzone của làn da: Áo mặc nhẹ tênh, "chill" cả ngày dài.
-Bay hơi trong 1 nốt nhạc: Vải mỏng nhẹ, nhanh khô. Giặt buổi tối, sáng có đồ mặc, "cân" mọi kèo gấp.
-Bảng màu "cân" mọi gu: Bảy màu tha hồ lựa chọn. "Cứu tinh" cho những ngày lười, auto đẹp trai.
3. Chất liệu: Modal Fabric, thành phần 12% Modal 88% Polyester.
4. Kỹ thuật: Thiết kế form vừa thanh lịch, đơn giản basic nhất có thể, giúp dễ dàng chọn lựa và phối đồ, đường may tỉ mỉ và bảng màu đa dạng.
5. Phù hợp với ai: Phái mạnh có cá tính thời trang đa dạng và phá cách đầy táo bạo hoặc tinh tế và đơn giản trong phong cách thời trang của họ.
6. Thuộc Bộ Sưu Tập nào: Non Branded - Thời trang tối giản, phong cách hiện đại, giá cả hợp lý.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: sơ mi nam tay dài, sơ mi nam màu đen, sơ mi nam công sở.'),

(13, N'Áo Sơ Mi Tay Dài Modal Ít Nhăn Non Branded 019 Nâu Nhạt', 'ao34.png', 187150, 4,
N'Dựa trên chất vải modal mỏng nhẹ, phom áo được tinh chỉnh gọn gàng hơn, tạo nên dáng vẻ thanh lịch, chỉn chu mà vẫn đảm bảo sự thoáng mát tối đa.',
N'Áo sơ mi Modal, mềm mịn, mỏng nhẹ, ít vón cục.

1. Kiểu sản phẩm: Áo sơ mi cổ bẻ tay dài.
2. Ưu điểm:
-Friendzone của làn da: Áo mặc nhẹ tênh, "chill" cả ngày dài.
-Bay hơi trong 1 nốt nhạc: Vải mỏng nhẹ, nhanh khô. Giặt buổi tối, sáng có đồ mặc, "cân" mọi kèo gấp.
-Bảng màu "cân" mọi gu: Bảy màu tha hồ lựa chọn. "Cứu tinh" cho những ngày lười, auto đẹp trai.
3. Chất liệu: Modal Fabric, thành phần 12% Modal 88% Polyester.
4. Kỹ thuật: Thiết kế form vừa thanh lịch, đơn giản basic nhất có thể, giúp dễ dàng chọn lựa và phối đồ, đường may tỉ mỉ và bảng màu đa dạng.
5. Phù hợp với ai: Phái mạnh có cá tính thời trang đa dạng và phá cách đầy táo bạo hoặc tinh tế và đơn giản trong phong cách thời trang của họ.
6. Thuộc Bộ Sưu Tập nào: Non Branded - Thời trang tối giản, phong cách hiện đại, giá cả hợp lý.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: sơ mi nam tay dài, sơ mi nam màu đen, sơ mi nam công sở.'),

(13, N'Áo Sơ Mi Cổ Trụ Tay Dài Vải Modal Mềm Mịn Seventy Seven 026', 'ao35.png', 235450, 4,
N'Chất liệu Modal Poly mềm mại, lý tưởng cho phom rộng nguyên bản. Thiết kế giữ trọn sự thoải mái, phóng khoáng, đậm chất đường phố và thời thượng.',
N'Áo sơ mi cổ trụ Modal Poly mềm mại , ít nhăn dễ ủi, nhanh khô.

1. Kiểu sản phẩm: Áo sơ mi cổ trụ tay dài
2. Ưu điểm : Form dáng rộng thoải mái, kiểu dáng trẻ trung với chất liệu không cần ủi, chống co rút và giữ form sau nhiều lần sử dụng.
3. Chất liệu: Sợi Modal và Polyester (12% Modal, 88% Polyester) co giãn.
4. Kỹ thuật: Họa tiết in dẻo và in phối màu tạo nên sự độc đáo và thú vị cho thiết kế.
5. Phù hợp với ai: Áo sơ mi này phù hợp với những người làm việc trong môi trường công sở, văn phòng, và thích phong cách trung tính, dễ phối đồ và không muốn ủi.
6. Thuộc Bộ Sưu Tập: Seventy Seven - thời trang trung tính.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo Sơ Mi Công Sở, Áo Công Sở Dáng Rộng, Áo sơ mi không cần ủi, áo sơ mi Modal, áo sơ mi đi tiệc, áo sơ mi dự sự kiện ,Áo sơ mi cổ trụ, Áo sơ mi cổ lãnh tụ, Áo sơ mi cổ đứng, Áo sơ mi cổ tàu, Áo sơ mi cổ mandarin, Áo sơ mi cổ grandad, Áo sơ mi cổ tàu, Áo sơ mi cổ đứng, Áo sơ mi cổ côn'),

(13, N'Áo Sơ Mi Tay Dài Vải Ngải Cứu Kháng Khuẩn The CEO 002 Trắng', 'ao36.png', 384300, 4,
N'Với vải Ngải Cứu mềm mại và ít nhăn, phom áo được thu gọn lại để tôn dáng, mang đến vẻ ngoài chỉn chu, lịch sự đúng chuẩn công sở hiện đại.',
N'Áo sơ mi dáng vừa sợi ngải cứu kháng khuẩn, kháng côn trùng, 12 Màu Lựa Chọn.

1. Kiểu sản phẩm: Áo sơ mi cổ bẻ tay dài.
2. Ưu điểm
-Vải ngải cứu, kháng khuẩn: Vải Mugwort Twill độc đáo, có khả năng kháng khuẩn, mềm mại và thân thiện với môi trường.
-Chỉn chu mà không cần ủi: Công nghệ Non-Iron hạn chế nếp nhăn, giúp bạn luôn chỉn chu và tiết kiệm thời gian.
-Thiết kế tối giản, lịch sự: Thiết kế classic, có vòng treo ẩn tiện lợi, với bảng màu đa dạng, dễ dàng phối đồ.
3. Chất liệu: Mugwort twill 58% Polyester 39% Rayon (Mugwort) 3% Spandex
4. Kỹ thuật: Đường may tỉ mỉ tạo nên sản phẩm bền đẹp và tinh tế. Màu sắc đa dạng dễ dàng phối đồ với nhiều phong cách khác nhau.
5. Phù hợp với ai: Người làm việc văn phòng mang lại vẻ ngoài lịch sự, chuyên nghiệp. Nam giới yêu thích phong cách đơn giản, thanh lịch. Những người quan tâm đến sức khỏe và thời trang bền vững.
6. Thuộc Bộ Sưu Tập: NON IRON , Bộ sưu tập tập trung vào các sản phẩm chống nhăn, giúp bạn luôn chỉn chu.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo sơ mi vải ngải cứu, Áo sơ mi công sở, Áo sơ mi nhiều màu, Áo sơ mi kháng khuẩn, Áo sơ mi ít nhăn, Áo sơ mi basic'),

(13, N'Áo Sơ Mi Tay Dài Modal Ít Nhăn Non Branded 019 Xám Nhạt', 'ao37.png', 187150, 4,
N'Dựa trên chất vải modal mỏng nhẹ, phom áo được tinh chỉnh gọn gàng hơn, tạo nên dáng vẻ thanh lịch, chỉn chu mà vẫn đảm bảo sự thoáng mát tối đa.',
N'Áo sơ mi Modal, mềm mịn, mỏng nhẹ, ít vón cục.

1. Kiểu sản phẩm: Áo sơ mi cổ bẻ tay dài.
2. Ưu điểm:
-Friendzone của làn da: Áo mặc nhẹ tênh, "chill" cả ngày dài.
-Bay hơi trong 1 nốt nhạc: Vải mỏng nhẹ, nhanh khô. Giặt buổi tối, sáng có đồ mặc, "cân" mọi kèo gấp.
-Bảng màu "cân" mọi gu: Bảy màu tha hồ lựa chọn. "Cứu tinh" cho những ngày lười, auto đẹp trai.
3. Chất liệu: Modal Fabric, thành phần 12% Modal 88% Polyester.
4. Kỹ thuật: Thiết kế form vừa thanh lịch, đơn giản basic nhất có thể, giúp dễ dàng chọn lựa và phối đồ, đường may tỉ mỉ và bảng màu đa dạng.
5. Phù hợp với ai: Phái mạnh có cá tính thời trang đa dạng và phá cách đầy táo bạo hoặc tinh tế và đơn giản trong phong cách thời trang của họ.
6. Thuộc Bộ Sưu Tập nào: Non Branded - Thời trang tối giản, phong cách hiện đại, giá cả hợp lý.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: sơ mi nam tay dài, sơ mi nam màu đen, sơ mi nam công sở.'),


(13, N'Áo Sơ Mi Tay Dài Vải Ngải Cứu Kháng Khuẩn The CEO 002 Đen', 'ao38.png', 384300, 4,
N'Với vải Ngải Cứu mềm mại và ít nhăn, phom áo được thu gọn lại để tôn dáng, mang đến vẻ ngoài chỉn chu, lịch sự đúng chuẩn công sở hiện đại.',
N'Áo sơ mi dáng vừa sợi ngải cứu kháng khuẩn, kháng côn trùng, 12 Màu Lựa Chọn.

1. Kiểu sản phẩm: Áo sơ mi cổ bẻ tay dài.
2. Ưu điểm
-Vải ngải cứu, kháng khuẩn: Vải Mugwort Twill độc đáo, có khả năng kháng khuẩn, mềm mại và thân thiện với môi trường.
-Chỉn chu mà không cần ủi: Công nghệ Non-Iron hạn chế nếp nhăn, giúp bạn luôn chỉn chu và tiết kiệm thời gian.
-Thiết kế tối giản, lịch sự: Thiết kế classic, có vòng treo ẩn tiện lợi, với bảng màu đa dạng, dễ dàng phối đồ.
3. Chất liệu: Mugwort twill 58% Polyester 39% Rayon (Mugwort) 3% Spandex
4. Kỹ thuật: Đường may tỉ mỉ tạo nên sản phẩm bền đẹp và tinh tế. Màu sắc đa dạng dễ dàng phối đồ với nhiều phong cách khác nhau.
5. Phù hợp với ai: Người làm việc văn phòng mang lại vẻ ngoài lịch sự, chuyên nghiệp. Nam giới yêu thích phong cách đơn giản, thanh lịch. Những người quan tâm đến sức khỏe và thời trang bền vững.
6. Thuộc Bộ Sưu Tập: NON IRON , Bộ sưu tập tập trung vào các sản phẩm chống nhăn, giúp bạn luôn chỉn chu.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo sơ mi vải ngải cứu, Áo sơ mi công sở, Áo sơ mi nhiều màu, Áo sơ mi kháng khuẩn, Áo sơ mi ít nhăn, Áo sơ mi basic'),

(13, N'Áo Sơ Mi Caro Tay Dài Mềm Mịn The No Style 062 Xanh Dương Nâu', 'ao39.png', 310650, 4,
N'Chất Cotton mịn, ít nhăn, đứng phom, được nới rộng ở ngực và vai nhưng giảm dài tay, tạo phom shacket (sơ mi khoác) rộng rãi, cân đối và hiện đại.',
N'Áo sơ mi Caro mịn tay, bền bỉ, đứng form.

1. Kiểu sản phẩm: Áo sơ mi caro tay dài
2. Ưu điểm:
-Chất Cotton "chill" cả ngày: Vải mịn tay, mềm mại, ít nhăn, cho bạn cảm giác thoải mái, "chill" cả ngày.
-Phom dáng "bất biến": Luôn giữ phom chuẩn, màu bền đẹp, thách thức cả máy giặt và thời gian.
-Caro "bất tử", cân mọi outfit: Họa tiết caro, là item không thể thiếu, dễ dàng nâng tầm mọi outfit.
3. Chất liệu: Vải Cotton Blend, 60% Cotton 40% Polyester
4. Kỹ thuật: Kỹ thuật dệt hiện đại tạo nên họa tiết caro sắc nét, tinh tế. Form áo chuẩn, tôn dáng người mặc.
5. Phù hợp với: nhiều phong cách cho các dịp đi làm, đi chơi, dạo phố.
6. Thuộc bộ sưu tập: The No Style, thời trang đa phong cách
7. Tìm kiếm sản phẩm: áo sơ mi nam, áo sơ mi tay dài, áo sơ mi caro, áo sơ mi kẻ sọc'),


(13, N'Áo Sơ Mi Cổ Trụ Tay Dài Vải Modal Mềm Mịn Seventy Seven 026 Xanh Dương Nhạt', 'ao40.png', 235450, 4,
N'Chất liệu Modal Poly mềm mại, lý tưởng cho phom rộng nguyên bản. Thiết kế giữ trọn sự thoải mái, phóng khoáng, đậm chất đường phố và thời thượng.',
N'Áo sơ mi cổ trụ Modal Poly mềm mại , ít nhăn dễ ủi, nhanh khô.

1. Kiểu sản phẩm: Áo sơ mi cổ trụ tay dài
2. Ưu điểm : Form dáng rộng thoải mái, kiểu dáng trẻ trung với chất liệu không cần ủi, chống co rút và giữ form sau nhiều lần sử dụng.
3. Chất liệu: Sợi Modal và Polyester (12% Modal, 88% Polyester) co giãn.
4. Kỹ thuật: Họa tiết in dẻo và in phối màu tạo nên sự độc đáo và thú vị cho thiết kế.
5. Phù hợp với ai: Áo sơ mi này phù hợp với những người làm việc trong môi trường công sở, văn phòng, và thích phong cách trung tính, dễ phối đồ và không muốn ủi.
6. Thuộc Bộ Sưu Tập: Seventy Seven - thời trang trung tính.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo Sơ Mi Công Sở, Áo Công Sở Dáng Rộng, Áo sơ mi không cần ủi, áo sơ mi Modal, áo sơ mi đi tiệc, áo sơ mi dự sự kiện ,Áo sơ mi cổ trụ, Áo sơ mi cổ lãnh tụ, Áo sơ mi cổ đứng, Áo sơ mi cổ tàu, Áo sơ mi cổ mandarin, Áo sơ mi cổ grandad, Áo sơ mi cổ tàu, Áo sơ mi cổ đứng, Áo sơ mi cổ côn'),

--------------------------------------------Ao khoac parka-------------------------------------------------------------------------------------------------------------------------------
(14, N'Áo Khoác Gió Trượt Nước Mỏng Nhẹ Nhiều Màu Non Branded 004 Đen', 'ao41.png', 310650, 4,
N'Vải dù Parachute 100% Nylon siêu nhẹ, trượt nước tốt, được thiết kế tay raglan và nới rộng ở ngực, lai, tạo sự thoải mái và dễ dàng gấp gọn.',
N'Áo khoác gió dáng vừa mỏng nhẹ, nhanh khô, trượt nước.

1. Kiểu sản phẩm: Áo khoác có nón.
2. Ưu điểm:
-Siêu nhẹ, gấp gọn dễ dàng: Chất dù Parachute 100% Nylon mỏng nhẹ, dễ dàng gấp gọn và mang theo mọi lúc mọi nơi.
-Bất chấp mưa phùn: Công nghệ trượt nước hiệu quả, bảo vệ bạn khỏi những cơn mưa nhỏ bất chợt.
-"Nhức đầu" khi chọn màu: Màu nào cũng dễ ưa, khiến bạn "nhức đầu" vì không biết nên chọn màu nào.
3. Chất liệu: Parachute , 100% Nylon
4. Kỹ thuật:
• Rã ở vai và sườn: Tạo điểm nhấn, tăng độ bền và thoải mái.
• Bọc viền đường may: Giúp áo bền hơn, thoải mái hơn khi mặc, trông gọn gàng và ít bị mài mòn.
• Tay áo bo thun: Giữ form áo và tạo sự ôm sát vừa vặn.
• Dây kéo phao: Cùng màu vải tạo sự đồng bộ và dễ dàng sử dụng.
• Nút bấm nón: Giúp điều chỉnh độ rộng của nón linh hoạt.
5. Phù hợp với ai: Thiết kế đơn giản, không logo, phù hợp với những người ưa chuộng sự tinh tế. Những người hoạt động ngoài trời và cần một chiếc áo khoác đa năng có thể mặc đi làm, đi chơi hoặc tập thể thao.
6. Thuộc Bộ Sưu Tập: NON BRANDED - Thời trang tối giản này dành cho những ai yêu thích sự tối giản và tinh tế, không rườm rà, nhưng vẫn đảm bảo tính năng động và tiện dụng.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo khoác gió, Áo khoác trượt nước, Áo khoác unisex, Áo khoác trơn basic, Áo khoác dù mỏng nhẹ.'),

(14, N'Áo Khoác Gió Trượt Nước Mỏng Nhẹ Nhiều Màu Non Branded 004 Xanh Lá Đậm', 'ao41.png', 310650, 4,
N'Vải dù Parachute 100% Nylon siêu nhẹ, trượt nước tốt, được thiết kế tay raglan và nới rộng ở ngực, lai, tạo sự thoải mái và dễ dàng gấp gọn.',
N'Áo khoác gió dáng vừa mỏng nhẹ, nhanh khô, trượt nước.

1. Kiểu sản phẩm: Áo khoác có nón.
2. Ưu điểm:
-Siêu nhẹ, gấp gọn dễ dàng: Chất dù Parachute 100% Nylon mỏng nhẹ, dễ dàng gấp gọn và mang theo mọi lúc mọi nơi.
-Bất chấp mưa phùn: Công nghệ trượt nước hiệu quả, bảo vệ bạn khỏi những cơn mưa nhỏ bất chợt.
-"Nhức đầu" khi chọn màu: Màu nào cũng dễ ưa, khiến bạn "nhức đầu" vì không biết nên chọn màu nào.
3. Chất liệu: Parachute , 100% Nylon
4. Kỹ thuật:
• Rã ở vai và sườn: Tạo điểm nhấn, tăng độ bền và thoải mái.
• Bọc viền đường may: Giúp áo bền hơn, thoải mái hơn khi mặc, trông gọn gàng và ít bị mài mòn.
• Tay áo bo thun: Giữ form áo và tạo sự ôm sát vừa vặn.
• Dây kéo phao: Cùng màu vải tạo sự đồng bộ và dễ dàng sử dụng.
• Nút bấm nón: Giúp điều chỉnh độ rộng của nón linh hoạt.
5. Phù hợp với ai: Thiết kế đơn giản, không logo, phù hợp với những người ưa chuộng sự tinh tế. Những người hoạt động ngoài trời và cần một chiếc áo khoác đa năng có thể mặc đi làm, đi chơi hoặc tập thể thao.
6. Thuộc Bộ Sưu Tập: NON BRANDED - Thời trang tối giản này dành cho những ai yêu thích sự tối giản và tinh tế, không rườm rà, nhưng vẫn đảm bảo tính năng động và tiện dụng.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo khoác gió, Áo khoác trượt nước, Áo khoác unisex, Áo khoác trơn basic, Áo khoác dù mỏng nhẹ.'),

(14, N'Áo Khoác Gió Trượt Nước Mỏng Nhẹ Nhiều Màu Non Branded 004 Xám', 'ao41.png', 310650, 4,
N'Vải dù Parachute 100% Nylon siêu nhẹ, trượt nước tốt, được thiết kế tay raglan và nới rộng ở ngực, lai, tạo sự thoải mái và dễ dàng gấp gọn.',
N'Áo khoác gió dáng vừa mỏng nhẹ, nhanh khô, trượt nước.

1. Kiểu sản phẩm: Áo khoác có nón.
2. Ưu điểm:
-Siêu nhẹ, gấp gọn dễ dàng: Chất dù Parachute 100% Nylon mỏng nhẹ, dễ dàng gấp gọn và mang theo mọi lúc mọi nơi.
-Bất chấp mưa phùn: Công nghệ trượt nước hiệu quả, bảo vệ bạn khỏi những cơn mưa nhỏ bất chợt.
-"Nhức đầu" khi chọn màu: Màu nào cũng dễ ưa, khiến bạn "nhức đầu" vì không biết nên chọn màu nào.
3. Chất liệu: Parachute , 100% Nylon
4. Kỹ thuật:
• Rã ở vai và sườn: Tạo điểm nhấn, tăng độ bền và thoải mái.
• Bọc viền đường may: Giúp áo bền hơn, thoải mái hơn khi mặc, trông gọn gàng và ít bị mài mòn.
• Tay áo bo thun: Giữ form áo và tạo sự ôm sát vừa vặn.
• Dây kéo phao: Cùng màu vải tạo sự đồng bộ và dễ dàng sử dụng.
• Nút bấm nón: Giúp điều chỉnh độ rộng của nón linh hoạt.
5. Phù hợp với ai: Thiết kế đơn giản, không logo, phù hợp với những người ưa chuộng sự tinh tế. Những người hoạt động ngoài trời và cần một chiếc áo khoác đa năng có thể mặc đi làm, đi chơi hoặc tập thể thao.
6. Thuộc Bộ Sưu Tập: NON BRANDED - Thời trang tối giản này dành cho những ai yêu thích sự tối giản và tinh tế, không rườm rà, nhưng vẫn đảm bảo tính năng động và tiện dụng.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo khoác gió, Áo khoác trượt nước, Áo khoác unisex, Áo khoác trơn basic, Áo khoác dù mỏng nhẹ.'),

(14, N'Áo Khoác Gió Trượt Nước Mỏng Nhẹ Nhiều Màu Non Branded 004 Hồng', 'ao41.png', 310650, 4,
N'Vải dù Parachute 100% Nylon siêu nhẹ, trượt nước tốt, được thiết kế tay raglan và nới rộng ở ngực, lai, tạo sự thoải mái và dễ dàng gấp gọn.',
N'Áo khoác gió dáng vừa mỏng nhẹ, nhanh khô, trượt nước.

1. Kiểu sản phẩm: Áo khoác có nón.
2. Ưu điểm:
-Siêu nhẹ, gấp gọn dễ dàng: Chất dù Parachute 100% Nylon mỏng nhẹ, dễ dàng gấp gọn và mang theo mọi lúc mọi nơi.
-Bất chấp mưa phùn: Công nghệ trượt nước hiệu quả, bảo vệ bạn khỏi những cơn mưa nhỏ bất chợt.
-"Nhức đầu" khi chọn màu: Màu nào cũng dễ ưa, khiến bạn "nhức đầu" vì không biết nên chọn màu nào.
3. Chất liệu: Parachute , 100% Nylon
4. Kỹ thuật:
• Rã ở vai và sườn: Tạo điểm nhấn, tăng độ bền và thoải mái.
• Bọc viền đường may: Giúp áo bền hơn, thoải mái hơn khi mặc, trông gọn gàng và ít bị mài mòn.
• Tay áo bo thun: Giữ form áo và tạo sự ôm sát vừa vặn.
• Dây kéo phao: Cùng màu vải tạo sự đồng bộ và dễ dàng sử dụng.
• Nút bấm nón: Giúp điều chỉnh độ rộng của nón linh hoạt.
5. Phù hợp với ai: Thiết kế đơn giản, không logo, phù hợp với những người ưa chuộng sự tinh tế. Những người hoạt động ngoài trời và cần một chiếc áo khoác đa năng có thể mặc đi làm, đi chơi hoặc tập thể thao.
6. Thuộc Bộ Sưu Tập: NON BRANDED - Thời trang tối giản này dành cho những ai yêu thích sự tối giản và tinh tế, không rườm rà, nhưng vẫn đảm bảo tính năng động và tiện dụng.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo khoác gió, Áo khoác trượt nước, Áo khoác unisex, Áo khoác trơn basic, Áo khoác dù mỏng nhẹ.'),

(14, N'Áo Khoác Gió Trượt Nước Mỏng Nhẹ Nhiều Màu Non Branded 004 Xám Nhạt', 'ao41.png', 310650, 4,
N'Vải dù Parachute 100% Nylon siêu nhẹ, trượt nước tốt, được thiết kế tay raglan và nới rộng ở ngực, lai, tạo sự thoải mái và dễ dàng gấp gọn.',
N'Áo khoác gió dáng vừa mỏng nhẹ, nhanh khô, trượt nước.

1. Kiểu sản phẩm: Áo khoác có nón.
2. Ưu điểm:
-Siêu nhẹ, gấp gọn dễ dàng: Chất dù Parachute 100% Nylon mỏng nhẹ, dễ dàng gấp gọn và mang theo mọi lúc mọi nơi.
-Bất chấp mưa phùn: Công nghệ trượt nước hiệu quả, bảo vệ bạn khỏi những cơn mưa nhỏ bất chợt.
-"Nhức đầu" khi chọn màu: Màu nào cũng dễ ưa, khiến bạn "nhức đầu" vì không biết nên chọn màu nào.
3. Chất liệu: Parachute , 100% Nylon
4. Kỹ thuật:
• Rã ở vai và sườn: Tạo điểm nhấn, tăng độ bền và thoải mái.
• Bọc viền đường may: Giúp áo bền hơn, thoải mái hơn khi mặc, trông gọn gàng và ít bị mài mòn.
• Tay áo bo thun: Giữ form áo và tạo sự ôm sát vừa vặn.
• Dây kéo phao: Cùng màu vải tạo sự đồng bộ và dễ dàng sử dụng.
• Nút bấm nón: Giúp điều chỉnh độ rộng của nón linh hoạt.
5. Phù hợp với ai: Thiết kế đơn giản, không logo, phù hợp với những người ưa chuộng sự tinh tế. Những người hoạt động ngoài trời và cần một chiếc áo khoác đa năng có thể mặc đi làm, đi chơi hoặc tập thể thao.
6. Thuộc Bộ Sưu Tập: NON BRANDED - Thời trang tối giản này dành cho những ai yêu thích sự tối giản và tinh tế, không rườm rà, nhưng vẫn đảm bảo tính năng động và tiện dụng.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo khoác gió, Áo khoác trượt nước, Áo khoác unisex, Áo khoác trơn basic, Áo khoác dù mỏng nhẹ.'),

(14, N'Áo Khoác Gió Trượt Nước Mỏng Nhẹ Nhiều Màu Non Branded 004 Be', 'ao41.png', 310650, 4,
N'Vải dù Parachute 100% Nylon siêu nhẹ, trượt nước tốt, được thiết kế tay raglan và nới rộng ở ngực, lai, tạo sự thoải mái và dễ dàng gấp gọn.',
N'Áo khoác gió dáng vừa mỏng nhẹ, nhanh khô, trượt nước.

1. Kiểu sản phẩm: Áo khoác có nón.
2. Ưu điểm:
-Siêu nhẹ, gấp gọn dễ dàng: Chất dù Parachute 100% Nylon mỏng nhẹ, dễ dàng gấp gọn và mang theo mọi lúc mọi nơi.
-Bất chấp mưa phùn: Công nghệ trượt nước hiệu quả, bảo vệ bạn khỏi những cơn mưa nhỏ bất chợt.
-"Nhức đầu" khi chọn màu: Màu nào cũng dễ ưa, khiến bạn "nhức đầu" vì không biết nên chọn màu nào.
3. Chất liệu: Parachute , 100% Nylon
4. Kỹ thuật:
• Rã ở vai và sườn: Tạo điểm nhấn, tăng độ bền và thoải mái.
• Bọc viền đường may: Giúp áo bền hơn, thoải mái hơn khi mặc, trông gọn gàng và ít bị mài mòn.
• Tay áo bo thun: Giữ form áo và tạo sự ôm sát vừa vặn.
• Dây kéo phao: Cùng màu vải tạo sự đồng bộ và dễ dàng sử dụng.
• Nút bấm nón: Giúp điều chỉnh độ rộng của nón linh hoạt.
5. Phù hợp với ai: Thiết kế đơn giản, không logo, phù hợp với những người ưa chuộng sự tinh tế. Những người hoạt động ngoài trời và cần một chiếc áo khoác đa năng có thể mặc đi làm, đi chơi hoặc tập thể thao.
6. Thuộc Bộ Sưu Tập: NON BRANDED - Thời trang tối giản này dành cho những ai yêu thích sự tối giản và tinh tế, không rườm rà, nhưng vẫn đảm bảo tính năng động và tiện dụng.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo khoác gió, Áo khoác trượt nước, Áo khoác unisex, Áo khoác trơn basic, Áo khoác dù mỏng nhẹ.'),

(14, N'Áo Khoác Gió Trượt Nước Mỏng Nhẹ Nhiều Màu Non Branded 004 Cam Đậm', 'ao41.png', 310650, 4,
N'Vải dù Parachute 100% Nylon siêu nhẹ, trượt nước tốt, được thiết kế tay raglan và nới rộng ở ngực, lai, tạo sự thoải mái và dễ dàng gấp gọn.',
N'Áo khoác gió dáng vừa mỏng nhẹ, nhanh khô, trượt nước.

1. Kiểu sản phẩm: Áo khoác có nón.
2. Ưu điểm:
-Siêu nhẹ, gấp gọn dễ dàng: Chất dù Parachute 100% Nylon mỏng nhẹ, dễ dàng gấp gọn và mang theo mọi lúc mọi nơi.
-Bất chấp mưa phùn: Công nghệ trượt nước hiệu quả, bảo vệ bạn khỏi những cơn mưa nhỏ bất chợt.
-"Nhức đầu" khi chọn màu: Màu nào cũng dễ ưa, khiến bạn "nhức đầu" vì không biết nên chọn màu nào.
3. Chất liệu: Parachute , 100% Nylon
4. Kỹ thuật:
• Rã ở vai và sườn: Tạo điểm nhấn, tăng độ bền và thoải mái.
• Bọc viền đường may: Giúp áo bền hơn, thoải mái hơn khi mặc, trông gọn gàng và ít bị mài mòn.
• Tay áo bo thun: Giữ form áo và tạo sự ôm sát vừa vặn.
• Dây kéo phao: Cùng màu vải tạo sự đồng bộ và dễ dàng sử dụng.
• Nút bấm nón: Giúp điều chỉnh độ rộng của nón linh hoạt.
5. Phù hợp với ai: Thiết kế đơn giản, không logo, phù hợp với những người ưa chuộng sự tinh tế. Những người hoạt động ngoài trời và cần một chiếc áo khoác đa năng có thể mặc đi làm, đi chơi hoặc tập thể thao.
6. Thuộc Bộ Sưu Tập: NON BRANDED - Thời trang tối giản này dành cho những ai yêu thích sự tối giản và tinh tế, không rườm rà, nhưng vẫn đảm bảo tính năng động và tiện dụng.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo khoác gió, Áo khoác trượt nước, Áo khoác unisex, Áo khoác trơn basic, Áo khoác dù mỏng nhẹ.'),

(14, N'Áo Khoác Gió Trượt Nước Mỏng Nhẹ Nhiều Màu Non Branded 004 Trắng', 'ao41.png', 310650, 4,
N'Vải dù Parachute 100% Nylon siêu nhẹ, trượt nước tốt, được thiết kế tay raglan và nới rộng ở ngực, lai, tạo sự thoải mái và dễ dàng gấp gọn.',
N'Áo khoác gió dáng vừa mỏng nhẹ, nhanh khô, trượt nước.

1. Kiểu sản phẩm: Áo khoác có nón.
2. Ưu điểm:
-Siêu nhẹ, gấp gọn dễ dàng: Chất dù Parachute 100% Nylon mỏng nhẹ, dễ dàng gấp gọn và mang theo mọi lúc mọi nơi.
-Bất chấp mưa phùn: Công nghệ trượt nước hiệu quả, bảo vệ bạn khỏi những cơn mưa nhỏ bất chợt.
-"Nhức đầu" khi chọn màu: Màu nào cũng dễ ưa, khiến bạn "nhức đầu" vì không biết nên chọn màu nào.
3. Chất liệu: Parachute , 100% Nylon
4. Kỹ thuật:
• Rã ở vai và sườn: Tạo điểm nhấn, tăng độ bền và thoải mái.
• Bọc viền đường may: Giúp áo bền hơn, thoải mái hơn khi mặc, trông gọn gàng và ít bị mài mòn.
• Tay áo bo thun: Giữ form áo và tạo sự ôm sát vừa vặn.
• Dây kéo phao: Cùng màu vải tạo sự đồng bộ và dễ dàng sử dụng.
• Nút bấm nón: Giúp điều chỉnh độ rộng của nón linh hoạt.
5. Phù hợp với ai: Thiết kế đơn giản, không logo, phù hợp với những người ưa chuộng sự tinh tế. Những người hoạt động ngoài trời và cần một chiếc áo khoác đa năng có thể mặc đi làm, đi chơi hoặc tập thể thao.
6. Thuộc Bộ Sưu Tập: NON BRANDED - Thời trang tối giản này dành cho những ai yêu thích sự tối giản và tinh tế, không rườm rà, nhưng vẫn đảm bảo tính năng động và tiện dụng.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo khoác gió, Áo khoác trượt nước, Áo khoác unisex, Áo khoác trơn basic, Áo khoác dù mỏng nhẹ.'),

(14, N'Áo Khoác Kaki Chống Nắng Seventy Seven 007 Đen', 'ao41.png', 339150, 4,
N'Vải Kaki dày dặn, chống nắng tốt, được tăng nhẹ chiều dài để tối ưu khả năng che phủ, bảo vệ cơ thể tốt hơn dưới thời tiết nắng gắt.',
N'Áo Khoác dáng rộng basic chống nắng, bền bỉ, ấm áp.

1. Kiểu sản phẩm: Áo khoác có nón.
2. Ưu điểm:
-Kaki "hệ bền", chống nắng tốt: Vải Kaki (87% Polyester, 13% Cotton) bền bỉ, vừa giữ ấm vừa chống nắng hiệu quả.
-Điều chỉnh dễ dàng: Nón và lai áo có dây rút điều chỉnh, dễ dàng tùy chỉnh độ rộng cho vừa vặn.
-Thiết kế tinh tế, tiện dụng: Dây kéo có nẹp che thẩm mỹ, túi trong tiện lợi, an toàn cho vật dụng cá nhân.
3. Chất liệu: Vải Khaki, 87% Polyester 13% Cotton
4. Kỹ thuật:
May đắp nhãn dệt thiết kế riêng BST.
Túi trong tiện dụng, lai luồn dây thun rút có nút chặn, nón luồn dây điều chỉnh kích thước.
Dây kéo đầu kim loại bọc nhựa an toàn với nẹp che thẩm mỹ.
5. Phù hợp với ai: Người tìm kiếm sự tiện lợi và thoải mái trong form dáng rộng lớn và muốn bảo vệ khỏi ánh nắng mặt trời.
6. Thuộc Bộ Sưu Tập: Seventy Seven, thời trang trung tính, dễ phối dễ lựa chọn.
7. Các tên thường gọi hoặc tìm kiếm: Áo khoác kaki, Áo khoác form rộng, Áo khoác có nón, Áo khoác đi nắng, Áo khoác basic'),

(14, N'Áo Khoác Thun Nam Chống Nắng Cool Touch 002 Đen', 'ao41.png', 473450, 4,
N'Với vải High TPI co giãn tốt, siêu mát, phom áo được thu gọn toàn diện, tạo dáng thể thao ôm vừa vặn, tối ưu khả năng làm mát và linh hoạt.',
N'Áo khoác chống nắng vải Cool Touch siêu mềm mướt, mịn mát co giãn tốt.

1. Kiểu sản phẩm: Áo Khoác có nón, áo khoác thun
2. Ưu điểm:
Siêu mềm mướt, mịn mát thoáng da
Sợi Cotton High TPI có chỉ số vòng xoắn cao hơn 25% so với sợi thông thường. Điều này giúp vải có độ co giãn tốt và thoải mái khi mặc
Nhiều màu sắc để bạn lựa chọn
3. Chất liệu: Mini Zurry 4 chiều với thành phần 94% Cotton và 6% Spandex
4. Kỹ thuật:
Dây kéo chính và 2 dây kéo túi chắc chắn, đầu khóa kim loại được bọc nhựa an toàn.
Có túi trong tiện lợi.
5. Phù hợp với ai: Những người tìm kiếm sự thoải mái và mát mẻ trong trang phục hàng ngày, đặc biệt bạn có thể tự tin mặc áo khoác này trong những ngày nắng nóng.
6. Thuộc Bộ Sưu Tập: Cool Touch nổi bật với các sản phẩm mang lại cảm giác mát mẻ và thoải mái.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Áo khoác thun, áo khoác có nón, áo khoác nhẹ, áo khoác nam, áo khoác đi nắng, áo khoác vải Cool Touch'),


--------------------------------------------Ao khoac so mi-------------------------------------------------------------------------------------------------------------------------------
(15, N'Áo Khoác Sơ Mi The Original 050 Xanh Dương Nhạt', 'ao41.png', 388450, 4,
N'Chất vải Denim dày dặn, đứng phom được điều chỉnh dài hơn và vai gọn lại, tạo nên phom áo khoác sơ mi (shacket) cứng cáp, cân đối và nam tính.',
N'Áo Sơ Mi Cổ Bé Tây Dài The Original 50

1. Kiểu sản phẩm: Áo Sơ Mi Cổ Bẻ Tay Dài
2. Ưu điểm: Chất liệu denim cao cấp, bền bỉ, giữ form dáng hoàn hảo, cho bạn vẻ ngoài lịch lãm. Kiểu dáng basic, dễ dàng phối đồ, biến hóa phong cách từ casual năng động đến thanh lịch tinh tế. Nút áo hợp kim siêu bền, được gia công tỉ mỉ, cho bạn an tâm tuyệt đối về chất lượng sản phẩm.
3. Chất liệu: Jean (75,6% Cotton, 24,4% Polyester)
4. Kỹ thuật: Túi đắp kích thước lớn trước ngực, tiện lợi cho việc đựng đồ cá nhân. Nút áo hợp kim cá tính chắc chắn, được gắn kết cẩn thận, đảm bảo độ bền cao.
5. Phù hợp với: Phù hợp để mặc hàng ngày, đi chơi, dạo phố, cà phê cùng bạn bè.
Dễ dàng phối hợp với nhiều trang phục khác nhau, từ quần jeans, quần chinos đến quần short. Có thể mặc riêng hoặc khoác ngoài, tạo nên nhiều layer phong cách.
6. Phong cách: Phong cách không giới hạn cùng chiếc áo sơ mi denim! Từ casual năng động, basic lịch lãm, đến streetwear cá tính và vintage hoài cổ.
7. Tìm kiếm sản phẩm: Áo sơ mi denim nam, Áo sơ mi nam dáng rộng, Áo sơ mi nam tay dài, Áo sơ mi nam basic, Áo sơ mi denim túi hộp'),

(15, N'Áo Khoác Sơ Mi The Original 050 Xanh Dương', 'ao42.png', 388450, 4,
N'Chất vải Denim dày dặn, đứng phom được điều chỉnh dài hơn và vai gọn lại, tạo nên phom áo khoác sơ mi (shacket) cứng cáp, cân đối và nam tính.',
N'Áo Sơ Mi Mi Cổ Bé Tây Dài The Original 50
Kiểu sản phẩm: Áo Sơ Mi Cổ Bẻ Tay Dài
2. Ưu điểm: Chất liệu denim cao cấp, bền bỉ, giữ form dáng hoàn hảo, cho bạn vẻ ngoài lịch lãm. Kiểu dáng basic, dễ dàng phối đồ, biến hóa phong cách từ casual năng động đến thanh lịch tinh tế. Nút áo hợp kim siêu bền, được gia công tỉ mỉ, cho bạn an tâm tuyệt đối về chất lượng sản phẩm.
3. Chất liệu: Jean (75,6% Cotton, 24,4% Polyester)
4. Kỹ thuật: Túi đắp kích thước lớn trước ngực, tiện lợi cho việc đựng đồ cá nhân. Nút áo hợp kim cá tính chắc chắn, được gắn kết cẩn thận, đảm bảo độ bền cao.
5. Phù hợp với: Phù hợp để mặc hàng ngày, đi chơi, dạo phố, cà phê cùng bạn bè.
Dễ dàng phối hợp với nhiều trang phục khác nhau, từ quần jeans, quần chinos đến quần short. Có thể mặc riêng hoặc khoác ngoài, tạo nên nhiều layer phong cách.
6. Phong cách: Phong cách không giới hạn cùng chiếc áo sơ mi denim! Từ casual năng động, basic lịch lãm, đến streetwear cá tính và vintage hoài cổ.
7. Tìm kiếm sản phẩm: Áo sơ mi denim nam, Áo sơ mi nam dáng rộng, Áo sơ mi nam tay dài, Áo sơ mi nam basic, Áo sơ mi denim túi hộp'),

(15, N'Áo Khoác Sơ Mi OXFORD Thoáng Khí Ít Nhăn The No Style 223 Trắng', 'ao43.png', 282150, 4,
N'Vải Ford ít nhăn đứng phom. Được thiết kế dài hơn và vai gọn lại, tạo nên phom shacket (sơ mi khoác) chỉn chu, thanh lịch, phù hợp nhiều phong cách.',
N'Áo khoác sơ mi regular fit, bền màu, ít nhăn, thoáng khí.

1. Kiểu sản phẩm: Áo Sơ Mi Tay dài
2. Ưu điểm:
-Thoáng mát, dễ chịu : Nhờ thành phần 60% cotton, vải có khả năng thoáng khí tốt, thoát ẩm nhanh chóng.
-Ít nhăn, dễ là ủi : Polyester giúp giảm nhăn và giữ form vải tốt hơn, luôn phẳng phiu và gọn gàng.
-Bền màu, ít co rút : Vải được dệt từ sợi nhuộm (yarn-dyed) nên màu sắc bền hơn, ít bị co rút.
3. Chất liệu: Oxford, 60% Cotton 40% Polyester
4. Kỹ thuật: Đô sau có thêm xếp ly vừa tạo độ phồng tự nhiên, vừa giúp người mặc cử động thoải mái, không bị gò bó. Kỹ thuật may 3 kim giúp áo chắc chắn và bền bỉ hơn gấp nhiều lần.
5. Phù hợp với ai: Nhân viên văn phòng, giới công sở cần trang phục lịch sự nhưng vẫn thoải mái.
6. Thuộc bộ sưu tập : BST The No Style - BST đa phong cách, tự do mix & match
7. Tìm kiếm sản phẩm: Áo sơ mi nam, Áo sơ mi dài tay, Áo sơ mi công sở, Áo sơ mi Oxford, Áo sơ mi ít nhăn, Áo sơ mi lịch sự'),

(15, N'Áo Khoác Sơ Mi OXFORD Thoáng Khí Ít Nhăn The No Style 223 Xanh Dương Nhạt', 'ao44.png', 282150, 4,
N'Vải Ford ít nhăn đứng phom. Được thiết kế dài hơn và vai gọn lại, tạo nên phom shacket (sơ mi khoác) chỉn chu, thanh lịch, phù hợp nhiều phong cách.',
N'Áo khoác sơ mi regular fit, bền màu, ít nhăn, thoáng khí.

1. Kiểu sản phẩm: Áo Sơ Mi Tay dài
2. Ưu điểm:
-Thoáng mát, dễ chịu : Nhờ thành phần 60% cotton, vải có khả năng thoáng khí tốt, thoát ẩm nhanh chóng.
-Ít nhăn, dễ là ủi : Polyester giúp giảm nhăn và giữ form vải tốt hơn, luôn phẳng phiu và gọn gàng.
-Bền màu, ít co rút : Vải được dệt từ sợi nhuộm (yarn-dyed) nên màu sắc bền hơn, ít bị co rút.
3. Chất liệu: Oxford, 60% Cotton 40% Polyester
4. Kỹ thuật: Đô sau có thêm xếp ly vừa tạo độ phồng tự nhiên, vừa giúp người mặc cử động thoải mái, không bị gò bó. Kỹ thuật may 3 kim giúp áo chắc chắn và bền bỉ hơn gấp nhiều lần.
5. Phù hợp với ai: Nhân viên văn phòng, giới công sở cần trang phục lịch sự nhưng vẫn thoải mái.
6. Thuộc bộ sưu tập : BST The No Style - BST đa phong cách, tự do mix & match
7. Tìm kiếm sản phẩm: Áo sơ mi nam, Áo sơ mi dài tay, Áo sơ mi công sở, Áo sơ mi Oxford, Áo sơ mi ít nhăn, Áo sơ mi lịch sự'),

(15, N'Áo Khoác Sơ Mi Thoáng Khí Ngăn Mùi The No Style 222 Đen', 'ao45.png', 301150, 4,
N'Chất vải Cotton-Polyester thoáng khí, bền bỉ được thiết kế dài hơn, vai gọn lại, tạo phom shacket (sơ mi khoác) đa năng, vừa vặn và nam tính.',
N'Áo khoác sơ mi Loose fit, thiết kế 2 in 1 , bền, ít nhăn.

1. Kiểu sản phẩm: Áo Khoác Sơ Mi
2. Ưu điểm: 
-Thiết kế đa năng 2 trong 1 : Vừa là sơ mi lịch sự, vừa là áo khoác ngoài (shacket), dễ dàng biến hóa phong cách.
-Vải thông minh, thoáng khí : Chất liệu Cotton-Polyester thoáng khíÁo , ngăn mùi hiệu quả.
-Bền bỉ, ít nhăn : Giữ phom dáng hoàn hảo, chống nhăn. Độ bền vượt trội với kỹ thuật may 3 kim.
3. Chất liệu: Oxford, 57% Cotton 43% Polyester
4. Kỹ thuật: May 3 kim và rã đô sau, chiếc quần được gia cố đặc biệt ở phần lưng, giúp quần chắc chắn, không lo bị rách khi bạn cúi người, ngồi xuống hay vận động. 
5. Phù hợp với ai: Phù hợp cho cả Nam và Nữ yêu thích phong cách tối giản, thích hợp từ văn phòng ra đường phố, từ một cuộc họp nghiêm túc đến một buổi cà phê thư giãn.
6. Thuộc bộ sưu tập : BST The No Style - Tự do sáng tạo, không ngại thể hiện cái tôi.
7. Tìm kiếm sản phẩm: Áo sơ mi khoác ngoài, Áo khoác sơ mi, Áo shacket unisex, Áo sơ mi khoác, Áo khoác 2 trong 1'),

(15, N'Áo Khoác Sơ Mi The Original 050 Xanh Dương Đậm', 'ao46.png', 388450, 4,
N'Chất vải Denim dày dặn, đứng phom được điều chỉnh dài hơn và vai gọn lại, tạo nên phom áo khoác sơ mi (shacket) cứng cáp, cân đối và nam tính.',
N'Áo Sơ Mi Cổ Bé Tây Dài The Original 50

1. Kiểu sản phẩm: Áo Sơ Mi Cổ Bẻ Tay Dài
2. Ưu điểm: Chất liệu denim cao cấp, bền bỉ, giữ form dáng hoàn hảo, cho bạn vẻ ngoài lịch lãm. Kiểu dáng basic, dễ dàng phối đồ, biến hóa phong cách từ casual năng động đến thanh lịch tinh tế. Nút áo hợp kim siêu bền, được gia công tỉ mỉ, cho bạn an tâm tuyệt đối về chất lượng sản phẩm.
3. Chất liệu: Jean (75,6% Cotton, 24,4% Polyester)
4. Kỹ thuật: Túi đắp kích thước lớn trước ngực, tiện lợi cho việc đựng đồ cá nhân. Nút áo hợp kim cá tính chắc chắn, được gắn kết cẩn thận, đảm bảo độ bền cao.
5. Phù hợp với: Phù hợp để mặc hàng ngày, đi chơi, dạo phố, cà phê cùng bạn bè.
Dễ dàng phối hợp với nhiều trang phục khác nhau, từ quần jeans, quần chinos đến quần short. Có thể mặc riêng hoặc khoác ngoài, tạo nên nhiều layer phong cách.
6. Phong cách: Phong cách không giới hạn cùng chiếc áo sơ mi denim! Từ casual năng động, basic lịch lãm, đến streetwear cá tính và vintage hoài cổ.
7. Tìm kiếm sản phẩm: Áo sơ mi denim nam, Áo sơ mi nam dáng rộng, Áo sơ mi nam tay dài, Áo sơ mi nam basic, Áo sơ mi denim túi hộp'),

(15, N'Áo Khoác Sơ Mi OXFORD Thoáng Khí Ít Nhăn The No Style 223 Xám', 'ao47.png', 282150, 4,
N'Vải Ford ít nhăn đứng phom. Được thiết kế dài hơn và vai gọn lại, tạo nên phom shacket (sơ mi khoác) chỉn chu, thanh lịch, phù hợp nhiều phong cách.',
N'Áo khoác sơ mi regular fit, bền màu, ít nhăn, thoáng khí.

1. Kiểu sản phẩm: Áo Sơ Mi Tay dài
2. Ưu điểm:
-Thoáng mát, dễ chịu : Nhờ thành phần 60% cotton, vải có khả năng thoáng khí tốt, thoát ẩm nhanh chóng.
-Ít nhăn, dễ là ủi : Polyester giúp giảm nhăn và giữ form vải tốt hơn, luôn phẳng phiu và gọn gàng.
-Bền màu, ít co rút : Vải được dệt từ sợi nhuộm (yarn-dyed) nên màu sắc bền hơn, ít bị co rút.
3. Chất liệu: Oxford, 60% Cotton 40% Polyester
4. Kỹ thuật: Đô sau có thêm xếp ly vừa tạo độ phồng tự nhiên, vừa giúp người mặc cử động thoải mái, không bị gò bó. Kỹ thuật may 3 kim giúp áo chắc chắn và bền bỉ hơn gấp nhiều lần.
5. Phù hợp với ai: Nhân viên văn phòng, giới công sở cần trang phục lịch sự nhưng vẫn thoải mái.
6. Thuộc bộ sưu tập : BST The No Style - BST đa phong cách, tự do mix & match
7. Tìm kiếm sản phẩm: Áo sơ mi nam, Áo sơ mi dài tay, Áo sơ mi công sở, Áo sơ mi Oxford, Áo sơ mi ít nhăn, Áo sơ mi lịch sự'),

(15, N'Áo Khoác Sơ Mi OXFORD Thoáng Khí Ít Nhăn The No Style 223 Xám Nhạt', 'ao48.png', 282150, 4,
N'Vải Ford ít nhăn đứng phom. Được thiết kế dài hơn và vai gọn lại, tạo nên phom shacket (sơ mi khoác) chỉn chu, thanh lịch, phù hợp nhiều phong cách.',
N'Áo khoác sơ mi regular fit, bền màu, ít nhăn, thoáng khí.

1. Kiểu sản phẩm: Áo Sơ Mi Tay dài
2. Ưu điểm:
-Thoáng mát, dễ chịu : Nhờ thành phần 60% cotton, vải có khả năng thoáng khí tốt, thoát ẩm nhanh chóng.
-Ít nhăn, dễ là ủi : Polyester giúp giảm nhăn và giữ form vải tốt hơn, luôn phẳng phiu và gọn gàng.
-Bền màu, ít co rút : Vải được dệt từ sợi nhuộm (yarn-dyed) nên màu sắc bền hơn, ít bị co rút.
3. Chất liệu: Oxford, 60% Cotton 40% Polyester
4. Kỹ thuật: Đô sau có thêm xếp ly vừa tạo độ phồng tự nhiên, vừa giúp người mặc cử động thoải mái, không bị gò bó. Kỹ thuật may 3 kim giúp áo chắc chắn và bền bỉ hơn gấp nhiều lần.
5. Phù hợp với ai: Nhân viên văn phòng, giới công sở cần trang phục lịch sự nhưng vẫn thoải mái.
6. Thuộc bộ sưu tập : BST The No Style - BST đa phong cách, tự do mix & match
7. Tìm kiếm sản phẩm: Áo sơ mi nam, Áo sơ mi dài tay, Áo sơ mi công sở, Áo sơ mi Oxford, Áo sơ mi ít nhăn, Áo sơ mi lịch sự'),

(15, N'Áo Khoác Sơ Mi OXFORD Thoáng Khí Ít Nhăn The No Style 223 Xanh Dương', 'ao49.png', 282150, 4,
N'Vải Ford ít nhăn đứng phom. Được thiết kế dài hơn và vai gọn lại, tạo nên phom shacket (sơ mi khoác) chỉn chu, thanh lịch, phù hợp nhiều phong cách.',
N'Áo khoác sơ mi regular fit, bền màu, ít nhăn, thoáng khí.

1. Kiểu sản phẩm: Áo Sơ Mi Tay dài
2. Ưu điểm:
-Thoáng mát, dễ chịu : Nhờ thành phần 60% cotton, vải có khả năng thoáng khí tốt, thoát ẩm nhanh chóng.
-Ít nhăn, dễ là ủi : Polyester giúp giảm nhăn và giữ form vải tốt hơn, luôn phẳng phiu và gọn gàng.
-Bền màu, ít co rút : Vải được dệt từ sợi nhuộm (yarn-dyed) nên màu sắc bền hơn, ít bị co rút.
3. Chất liệu: Oxford, 60% Cotton 40% Polyester
4. Kỹ thuật: Đô sau có thêm xếp ly vừa tạo độ phồng tự nhiên, vừa giúp người mặc cử động thoải mái, không bị gò bó. Kỹ thuật may 3 kim giúp áo chắc chắn và bền bỉ hơn gấp nhiều lần.
5. Phù hợp với ai: Nhân viên văn phòng, giới công sở cần trang phục lịch sự nhưng vẫn thoải mái.
6. Thuộc bộ sưu tập : BST The No Style - BST đa phong cách, tự do mix & match
7. Tìm kiếm sản phẩm: Áo sơ mi nam, Áo sơ mi dài tay, Áo sơ mi công sở, Áo sơ mi Oxford, Áo sơ mi ít nhăn, Áo sơ mi lịch sự'),






--------------------------------------------Quần short thun-------------------------------------------------------------------------------------------------------------------------------
(16, N'Quần Short Thun 9 Inch Thoáng Mát Non Branded 005 Xanh Dương Đậm', 'quan1.png', 158650, 4,
N'Dáng Vừa được tăng dài 2cm nhưng thu gọn ống 2cm, tạo phom "suông nhẹ". Chất vải "Cool Touch" mỏng mát, giúp quần đứng dáng, mang lại cảm giác thoáng mát.',
N'Quần Short 9 Inch Bird Eye Mesh thoáng mát, nhanh khô, thoáng khí.

1. Kiểu sản phẩm: Quần Short Thun
2. Ưu điểm:
-Thoáng mát, nhanh khô: Chất liệu Bird Eye Mesh dệt lưới với các lỗ nhỏ li ti giúp thoáng khí và nhanh khô.
-Bền bỉ, ít nhăn: Sợi 100% Polyester có độ bền cao, chống mài mòn và ít nhăn, thách thức các loại máy giặt.
-Thiết kế tối giản: Dễ dàng phối đồ với nhiều kiểu áo khác nhau, tạo nên phong cách đa dạng.
3. Chất liệu: Polyester Bird Eye Mesh Fabric, 100% Polyester.
4. Kỹ thuật: Lưng thun co giãn đảm bảo sự thoải mái và vừa vặn cho người mặc. Túi lót lưới tăng tính tiện dụng và thoáng khí.
5. Phù hợp với ai: Phù hợp với các hoạt động như chạy bộ, tập gym, đi biển, những bạn thích phong cách năng động, trẻ trung.
6. Thuộc Bộ Sưu Tập nào: NON BRANDED , Thời trang tối giản, không dấu ấn thương hiệu. Đúng tinh thần Quiet Luxury, mang đến những sản phẩm và phụ kiện thời trang đẳng cấp với mức giá hợp lý.
7. Các tên thường gọi hoặc tìm kiếm: Quần short nam, Quần short thể thao, Quần short lưng thun, Quần short thun nhiều màu'),

(16, N'Quần Short Thun 9 Inch Thoáng Mát Non Branded 005 Be', 'quan2.png', 158650, 4,
N'Dáng Vừa được tăng dài 2cm nhưng thu gọn ống 2cm, tạo phom "suông nhẹ". Chất vải "Cool Touch" mỏng mát, giúp quần đứng dáng, mang lại cảm giác thoáng mát.',
N'Quần Short 9 Inch Bird Eye Mesh thoáng mát, nhanh khô, thoáng khí.

1. Kiểu sản phẩm: Quần Short Thun
2. Ưu điểm:
-Thoáng mát, nhanh khô: Chất liệu Bird Eye Mesh dệt lưới với các lỗ nhỏ li ti giúp thoáng khí và nhanh khô.
-Bền bỉ, ít nhăn: Sợi 100% Polyester có độ bền cao, chống mài mòn và ít nhăn, thách thức các loại máy giặt.
-Thiết kế tối giản: Dễ dàng phối đồ với nhiều kiểu áo khác nhau, tạo nên phong cách đa dạng.
3. Chất liệu: Polyester Bird Eye Mesh Fabric, 100% Polyester.
4. Kỹ thuật: Lưng thun co giãn đảm bảo sự thoải mái và vừa vặn cho người mặc. Túi lót lưới tăng tính tiện dụng và thoáng khí.
5. Phù hợp với ai: Phù hợp với các hoạt động như chạy bộ, tập gym, đi biển, những bạn thích phong cách năng động, trẻ trung.
6. Thuộc Bộ Sưu Tập nào: NON BRANDED , Thời trang tối giản, không dấu ấn thương hiệu. Đúng tinh thần Quiet Luxury, mang đến những sản phẩm và phụ kiện thời trang đẳng cấp với mức giá hợp lý.
7. Các tên thường gọi hoặc tìm kiếm: Quần short nam, Quần short thể thao, Quần short lưng thun, Quần short thun nhiều màu'),

(16, N'Quần Short Thun 9 Inch Thoáng Mát Non Branded 005 Nâu Đậm', 'quan3.png', 158650, 5,
N'Quần Short Thun 9 Inch Thoáng Mát Non Branded 005 Nâu Đậm',
N'Quần Short 9 Inch Bird Eye Mesh thoáng mát, nhanh khô, thoáng khí.

1. Kiểu sản phẩm: Quần Short Thun
2. Ưu điểm:
-Thoáng mát, nhanh khô: Chất liệu Bird Eye Mesh dệt lưới với các lỗ nhỏ li ti giúp thoáng khí và nhanh khô.
-Bền bỉ, ít nhăn: Sợi 100% Polyester có độ bền cao, chống mài mòn và ít nhăn, thách thức các loại máy giặt.
-Thiết kế tối giản: Dễ dàng phối đồ với nhiều kiểu áo khác nhau, tạo nên phong cách đa dạng.
3. Chất liệu: Polyester Bird Eye Mesh Fabric, 100% Polyester.
4. Kỹ thuật: Lưng thun co giãn đảm bảo sự thoải mái và vừa vặn cho người mặc. Túi lót lưới tăng tính tiện dụng và thoáng khí.
5. Phù hợp với ai: Phù hợp với các hoạt động như chạy bộ, tập gym, đi biển, những bạn thích phong cách năng động, trẻ trung.
6. Thuộc Bộ Sưu Tập nào: NON BRANDED , Thời trang tối giản, không dấu ấn thương hiệu. Đúng tinh thần Quiet Luxury, mang đến những sản phẩm và phụ kiện thời trang đẳng cấp với mức giá hợp lý.
7. Các tên thường gọi hoặc tìm kiếm: Quần short nam, Quần short thể thao, Quần short lưng thun, Quần short thun nhiều màu'),

(16, N'Quần Short Thun 9 Inch Thoáng Mát Non Branded 005 Xanh Dương', 'quan4.png', 158650, 4,
N'Dáng Vừa được tăng dài 2cm nhưng thu gọn ống 2cm, tạo phom "suông nhẹ". Chất vải "Cool Touch" mỏng mát, giúp quần đứng dáng, mang lại cảm giác thoáng mát.',
N'Quần Short 9 Inch Bird Eye Mesh thoáng mát, nhanh khô, thoáng khí.

1. Kiểu sản phẩm: Quần Short Thun
2. Ưu điểm:
-Thoáng mát, nhanh khô: Chất liệu Bird Eye Mesh dệt lưới với các lỗ nhỏ li ti giúp thoáng khí và nhanh khô.
-Bền bỉ, ít nhăn: Sợi 100% Polyester có độ bền cao, chống mài mòn và ít nhăn, thách thức các loại máy giặt.
-Thiết kế tối giản: Dễ dàng phối đồ với nhiều kiểu áo khác nhau, tạo nên phong cách đa dạng.
3. Chất liệu: Polyester Bird Eye Mesh Fabric, 100% Polyester.
4. Kỹ thuật: Lưng thun co giãn đảm bảo sự thoải mái và vừa vặn cho người mặc. Túi lót lưới tăng tính tiện dụng và thoáng khí.
5. Phù hợp với ai: Phù hợp với các hoạt động như chạy bộ, tập gym, đi biển, những bạn thích phong cách năng động, trẻ trung.
6. Thuộc Bộ Sưu Tập nào: NON BRANDED , Thời trang tối giản, không dấu ấn thương hiệu. Đúng tinh thần Quiet Luxury, mang đến những sản phẩm và phụ kiện thời trang đẳng cấp với mức giá hợp lý.
7. Các tên thường gọi hoặc tìm kiếm: Quần short nam, Quần short thể thao, Quần short lưng thun, Quần short thun nhiều màu'),

(16, N'Quần Short Thun 9 Inch Thoáng Mát Non Branded 005 Xanh Lá Đậm', 'quan5.png', 158650, 4,
N'Dáng Vừa được tăng dài 2cm nhưng thu gọn ống 2cm, tạo phom "suông nhẹ". Chất vải "Cool Touch" mỏng mát, giúp quần đứng dáng, mang lại cảm giác thoáng mát.',
N'Quần Short 9 Inch Bird Eye Mesh thoáng mát, nhanh khô, thoáng khí.

1. Kiểu sản phẩm: Quần Short Thun
2. Ưu điểm:
-Thoáng mát, nhanh khô: Chất liệu Bird Eye Mesh dệt lưới với các lỗ nhỏ li ti giúp thoáng khí và nhanh khô.
-Bền bỉ, ít nhăn: Sợi 100% Polyester có độ bền cao, chống mài mòn và ít nhăn, thách thức các loại máy giặt.
-Thiết kế tối giản: Dễ dàng phối đồ với nhiều kiểu áo khác nhau, tạo nên phong cách đa dạng.
3. Chất liệu: Polyester Bird Eye Mesh Fabric, 100% Polyester.
4. Kỹ thuật: Lưng thun co giãn đảm bảo sự thoải mái và vừa vặn cho người mặc. Túi lót lưới tăng tính tiện dụng và thoáng khí.
5. Phù hợp với ai: Phù hợp với các hoạt động như chạy bộ, tập gym, đi biển, những bạn thích phong cách năng động, trẻ trung.
6. Thuộc Bộ Sưu Tập nào: NON BRANDED , Thời trang tối giản, không dấu ấn thương hiệu. Đúng tinh thần Quiet Luxury, mang đến những sản phẩm và phụ kiện thời trang đẳng cấp với mức giá hợp lý.
7. Các tên thường gọi hoặc tìm kiếm: Quần short nam, Quần short thể thao, Quần short lưng thun, Quần short thun nhiều màu'),

(16, N'Quần Short Thun 9 Inch Thoáng Mát Non Branded 005 Hồng', 'quan6.png', 158650, 4,
N'Dáng Vừa được tăng dài 2cm nhưng thu gọn ống 2cm, tạo phom "suông nhẹ". Chất vải "Cool Touch" mỏng mát, giúp quần đứng dáng, mang lại cảm giác thoáng mát.',
N'Quần Short 9 Inch Bird Eye Mesh thoáng mát, nhanh khô, thoáng khí.

1. Kiểu sản phẩm: Quần Short Thun
2. Ưu điểm:
-Thoáng mát, nhanh khô: Chất liệu Bird Eye Mesh dệt lưới với các lỗ nhỏ li ti giúp thoáng khí và nhanh khô.
-Bền bỉ, ít nhăn: Sợi 100% Polyester có độ bền cao, chống mài mòn và ít nhăn, thách thức các loại máy giặt.
-Thiết kế tối giản: Dễ dàng phối đồ với nhiều kiểu áo khác nhau, tạo nên phong cách đa dạng.
3. Chất liệu: Polyester Bird Eye Mesh Fabric, 100% Polyester.
4. Kỹ thuật: Lưng thun co giãn đảm bảo sự thoải mái và vừa vặn cho người mặc. Túi lót lưới tăng tính tiện dụng và thoáng khí.
5. Phù hợp với ai: Phù hợp với các hoạt động như chạy bộ, tập gym, đi biển, những bạn thích phong cách năng động, trẻ trung.
6. Thuộc Bộ Sưu Tập nào: NON BRANDED , Thời trang tối giản, không dấu ấn thương hiệu. Đúng tinh thần Quiet Luxury, mang đến những sản phẩm và phụ kiện thời trang đẳng cấp với mức giá hợp lý.
7. Các tên thường gọi hoặc tìm kiếm: Quần short nam, Quần short thể thao, Quần short lưng thun, Quần short thun nhiều màu'),

(16, N'Quần Short 5 Inch Vải Mesh Thoáng Khí The No Style 153 Đen', 'quan7.png', 218450, 5,
N'Phom Rộng được nới rộng ống 6cm, tối ưu cho chất vải lưới thoáng khí. Thiết kế này giúp không khí lưu thông tối đa, mang lại cảm giác mát mẻ, "giải nhiệt".',
N'Quần Short 5 Inch lưới thông khí thoáng mát.

1. Kiểu sản phẩm: Quần Short 5 Inch Dáng Vừa
2. Ưu điểm:
“Thoáng khí như không khí" - đó là những gì bạn sẽ cảm nhận được khi khoác lên mình chiếc quần short này. Với cấu trúc lưới đặc biệt tạo ra hàng ngàn lỗ thông khí siêu nhỏ, giúp không khí lưu thông tối đa, mang lại cảm giác mát mẻ và thông thoáng suốt cả ngày dài.Túi quần trang bị thêm dây kéo giúp giữ các vật dụng cá nhân như điện thoại, ví, chìa khóa... an toàn hơn, tránh bị rơi rớt khi vận động mạnh.
3. Chất liệu: Mesh Fabric, 100% Polyester
4. Kỹ thuật: Quần có cạp chun và dây rút giúp dễ dàng điều chỉnh độ vừa vặn theo ý muốn, phù hợp với mọi dáng người. Nhãn ép Heat Transfer với công nghệ tiên tiến hiệu ứng 3D chân thực, giúp họa tiết nổi bật trên bề mặt vải.
5. Phù hợp với: Chất liệu lưới thoáng mát và thiết kế thoải mái rất phù hợp cho các hoạt động thể thao như bóng rổ, chạy bộ, tập gym, hoặc các hoạt động ngoài trời khác. Phong cách trẻ trung và hiện đại của quần short này rất phù hợp với những người trẻ tuổi, đặc biệt là những người yêu thích phong cách streetwear hoặc mặc ở nhà, đi chơi dạo phố trong những ngày hè nóng bức.
6. Phong cách: Chiếc quần short này mang đến sự kết hợp linh hoạt giữa phong cách thể thao, thường ngày và streetwear. Bạn có thể mặc nó để tập luyện, đi chơi hoặc dạo phố, tùy thuộc vào cách phối đồ.'),

(16, N'Quần Short Thun 9 Inch Thoáng Mát Non Branded 005 Nâu', 'quan8.png', 158650, 4,
N'Dáng Vừa được tăng dài 2cm nhưng thu gọn ống 2cm, tạo phom "suông nhẹ". Chất vải "Cool Touch" mỏng mát, giúp quần đứng dáng, mang lại cảm giác thoáng mát.',
N'Quần Short 9 Inch Bird Eye Mesh thoáng mát, nhanh khô, thoáng khí.

1. Kiểu sản phẩm: Quần Short Thun
2. Ưu điểm:
-Thoáng mát, nhanh khô: Chất liệu Bird Eye Mesh dệt lưới với các lỗ nhỏ li ti giúp thoáng khí và nhanh khô.
-Bền bỉ, ít nhăn: Sợi 100% Polyester có độ bền cao, chống mài mòn và ít nhăn, thách thức các loại máy giặt.
-Thiết kế tối giản: Dễ dàng phối đồ với nhiều kiểu áo khác nhau, tạo nên phong cách đa dạng.
3. Chất liệu: Polyester Bird Eye Mesh Fabric, 100% Polyester.
4. Kỹ thuật: Lưng thun co giãn đảm bảo sự thoải mái và vừa vặn cho người mặc. Túi lót lưới tăng tính tiện dụng và thoáng khí.
5. Phù hợp với ai: Phù hợp với các hoạt động như chạy bộ, tập gym, đi biển, những bạn thích phong cách năng động, trẻ trung.
6. Thuộc Bộ Sưu Tập nào: NON BRANDED , Thời trang tối giản, không dấu ấn thương hiệu. Đúng tinh thần Quiet Luxury, mang đến những sản phẩm và phụ kiện thời trang đẳng cấp với mức giá hợp lý.
7. Các tên thường gọi hoặc tìm kiếm: Quần short nam, Quần short thể thao, Quần short lưng thun, Quần short thun nhiều màu'),

(16, N'Quần Short Thun Mềm Mịn Mát The Minimalist 020 Xám Đậm', 'quan9.png', 258350, 3,
N'Dáng Vừa được tăng dài 2cm nhưng thu gọn ống 2cm, tạo phom "suông nhẹ". Chất vải "Cool Touch" mỏng mát, giúp quần đứng dáng, mang lại cảm giác thoáng mát.',
N'Quần Short Thun dáng vừa, 9 Inch , mát lạnh, mềm mịn, co giãn tốt.

1. Kiểu sản phẩm: Quần Short Thun
2. Ưu điểm:
-Công nghệ COOL TOUCH mặc mát
Vải Mini Zurry High TPI Cool Touch mang đến cảm giác mềm mại, mịn màng và mát lạnh.
-Vải mềm mịn, co giãn tốt : Sự kết hợp giữa cotton và spandex tạo nên chất liệu vải vừa thoáng mát, mềm mịn.
-Thiết kế tiện lợi : Lưng quần sử dụng chất liệu thun và có dây luồn bên trong eo, dễ dàng điều chỉnh.
3. Chất liệu: Vải Thun 4 chiều, thành phần 94% Cotton, 6% Spandex. Sự kết hợp giữa cotton và spandex tạo nên một chất liệu vải vừa thoáng mát, mềm mịn và co giãn tốt
4. Kỹ thuật:
Lưng quần may luồn thun co giãn và có dây luồn điều chỉnh bên trong giúp dễ dàng điều chỉnh kích cỡ .
5. Phù hợp với ai: Những người yêu thích sự thoải mái, mát mẻ và phong cách năng động, hoặc thường xuyên hoạt động trong môi trường nhiều vận động hay thời tiết nóng nực.
6. Thuộc Bộ Sưu Tập nào: BST Cool Touch, nổi bật với các sản phẩm được làm từ chất liệu vải mềm, mịn và mát, mang lại cảm giác dễ chịu và thoải mái cho người mặc
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Quần short lưng thun, Quần short thun, Quần short thoáng mát, Quần short casual,...'),

(16, N'Quần Short Thun Mềm Mịn Mát The Minimalist 020 Đen', 'quan10.png', 258300, 4,
N'Dáng Vừa được tăng dài 2cm nhưng thu gọn ống 2cm, tạo phom "suông nhẹ". Chất vải "Cool Touch" mỏng mát, giúp quần đứng dáng, mang lại cảm giác thoáng mát.',
N'Quần Short Thun dáng vừa, 9 Inch , mát lạnh, mềm mịn, co giãn tốt.

1. Kiểu sản phẩm: Quần Short Thun
2. Ưu điểm:
-Công nghệ COOL TOUCH mặc mát
Vải Mini Zurry High TPI Cool Touch mang đến cảm giác mềm mại, mịn màng và mát lạnh.
-Vải mềm mịn, co giãn tốt : Sự kết hợp giữa cotton và spandex tạo nên chất liệu vải vừa thoáng mát, mềm mịn.
-Thiết kế tiện lợi : Lưng quần sử dụng chất liệu thun và có dây luồn bên trong eo, dễ dàng điều chỉnh.
3. Chất liệu: Vải Thun 4 chiều, thành phần 94% Cotton, 6% Spandex. Sự kết hợp giữa cotton và spandex tạo nên một chất liệu vải vừa thoáng mát, mềm mịn và co giãn tốt
4. Kỹ thuật:
Lưng quần may luồn thun co giãn và có dây luồn điều chỉnh bên trong giúp dễ dàng điều chỉnh kích cỡ .
5. Phù hợp với ai: Những người yêu thích sự thoải mái, mát mẻ và phong cách năng động, hoặc thường xuyên hoạt động trong môi trường nhiều vận động hay thời tiết nóng nực.
6. Thuộc Bộ Sưu Tập nào: BST Cool Touch, nổi bật với các sản phẩm được làm từ chất liệu vải mềm, mịn và mát, mang lại cảm giác dễ chịu và thoải mái cho người mặc
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Quần short lưng thun, Quần short thun, Quần short thoáng mát, Quần short casual,...'),


--------------------------------------------Quần short dù-------------------------------------------------------------------------------------------------------------------------------
(17, N'Quần Short 5 Inch Dù Mỏng Nhẹ Non Branded 006 Xám Nhạt', 'quan11.png', 158650, 4,
N'Dáng Vừa được rút ngắn 8cm, tạo dáng short ngắn cực kỳ năng động. Chất thun vải mềm mại, co giãn, mang lại cảm giác thoải mái, mát mẻ.',
N'Quần Short 5 Inch, thoáng mát, nhanh khô, co giãn 4 chiều.

1. Kiểu sản phẩm: Quần Short Dù
2. Ưu điểm:
-Thoáng mát, nhanh khô: Chất liệu dù (parachute) nhẹ, mỏng, có khả năng thoát ẩm tốt và nhanh khô.
-Co giãn 4 chiều, thoải mái: Tăng độ thoải mái khi vận động, giúp bạn tự tin hơn trong mọi hoạt động.
-Thiết kế tiện dụng: Túi lót lưới giúp đồ vật bên trong luôn khô ráo. Lưng thun co giãn thoải mái.
3. Chất liệu: Parachute thành phần 90% Nylon, 10% Spandex
4. Kỹ thuật: Lưng thun co giãn đảm bảo sự thoải mái và vừa vặn cho người mặc. Túi lót lưới tăng tính tiện dụng và thoáng khí.
5. Phù hợp với ai: Người yêu thích thể thao phù hợp với các hoạt động như chạy bộ, tập gym, đi biển. Người trẻ tuổi thích phong cách năng động, trẻ trung.
6. Thuộc Bộ Sưu Tập nào: NON BRANDED , Sản phẩm thuộc bộ sưu tập thời trang đa phong cách, đáp ứng nhu cầu của những người trẻ năng động.
7. Các tên thường gọi hoặc tìm kiếm: Quần short dù nam, Quần short thể thao nam, Quần short lưng thun, Quần short mỏng nhẹ'),

(17, N'Quần Short 5 Inch Dù Mỏng Nhẹ Non Branded 006 Đen', 'quan12.png', 158650, 4,
N'Dáng Vừa được rút ngắn 8cm, tạo dáng short ngắn cực kỳ năng động. Chất thun vải mềm mại, co giãn, mang lại cảm giác thoải mái, mát mẻ.',
N'Quần Short 5 Inch, thoáng mát, nhanh khô, co giãn 4 chiều.

1. Kiểu sản phẩm: Quần Short Dù
2. Ưu điểm:
-Thoáng mát, nhanh khô: Chất liệu dù (parachute) nhẹ, mỏng, có khả năng thoát ẩm tốt và nhanh khô.
-Co giãn 4 chiều, thoải mái: Tăng độ thoải mái khi vận động, giúp bạn tự tin hơn trong mọi hoạt động.
-Thiết kế tiện dụng: Túi lót lưới giúp đồ vật bên trong luôn khô ráo. Lưng thun co giãn thoải mái.
3. Chất liệu: Parachute thành phần 90% Nylon, 10% Spandex
4. Kỹ thuật: Lưng thun co giãn đảm bảo sự thoải mái và vừa vặn cho người mặc. Túi lót lưới tăng tính tiện dụng và thoáng khí.
5. Phù hợp với ai: Người yêu thích thể thao phù hợp với các hoạt động như chạy bộ, tập gym, đi biển. Người trẻ tuổi thích phong cách năng động, trẻ trung.
6. Thuộc Bộ Sưu Tập nào: NON BRANDED , Sản phẩm thuộc bộ sưu tập thời trang đa phong cách, đáp ứng nhu cầu của những người trẻ năng động.
7. Các tên thường gọi hoặc tìm kiếm: Quần short dù nam, Quần short thể thao nam, Quần short lưng thun, Quần short mỏng nhẹ'),
(17, N'Quần Short 5 Inch Dù Mỏng Nhẹ Non Branded 006 Vàng', 'quan13.png', 158650, 4,
N'Dáng Vừa được rút ngắn 8cm, tạo dáng short ngắn cực kỳ năng động. Chất thun vải mềm mại, co giãn, mang lại cảm giác thoải mái, mát mẻ.',
N'Quần Short 5 Inch, thoáng mát, nhanh khô, co giãn 4 chiều.

1. Kiểu sản phẩm: Quần Short Dù
2. Ưu điểm:
-Thoáng mát, nhanh khô: Chất liệu dù (parachute) nhẹ, mỏng, có khả năng thoát ẩm tốt và nhanh khô.
-Co giãn 4 chiều, thoải mái: Tăng độ thoải mái khi vận động, giúp bạn tự tin hơn trong mọi hoạt động.
-Thiết kế tiện dụng: Túi lót lưới giúp đồ vật bên trong luôn khô ráo. Lưng thun co giãn thoải mái.
3. Chất liệu: Parachute thành phần 90% Nylon, 10% Spandex
4. Kỹ thuật: Lưng thun co giãn đảm bảo sự thoải mái và vừa vặn cho người mặc. Túi lót lưới tăng tính tiện dụng và thoáng khí.
5. Phù hợp với ai: Người yêu thích thể thao phù hợp với các hoạt động như chạy bộ, tập gym, đi biển. Người trẻ tuổi thích phong cách năng động, trẻ trung.
6. Thuộc Bộ Sưu Tập nào: NON BRANDED , Sản phẩm thuộc bộ sưu tập thời trang đa phong cách, đáp ứng nhu cầu của những người trẻ năng động.
7. Các tên thường gọi hoặc tìm kiếm: Quần short dù nam, Quần short thể thao nam, Quần short lưng thun, Quần short mỏng nhẹ'),

(17, N'Quần Short 5 Inch Dù Mỏng Nhẹ Non Branded 006 Xám', 'quan14.png', 158650, 4,
N'Dáng Vừa được rút ngắn 8cm, tạo dáng short ngắn cực kỳ năng động. Chất thun vải mềm mại, co giãn, mang lại cảm giác thoải mái, mát mẻ.',
N'Quần Short 5 Inch, thoáng mát, nhanh khô, co giãn 4 chiều.

1. Kiểu sản phẩm: Quần Short Dù
2. Ưu điểm:
-Thoáng mát, nhanh khô: Chất liệu dù (parachute) nhẹ, mỏng, có khả năng thoát ẩm tốt và nhanh khô.
-Co giãn 4 chiều, thoải mái: Tăng độ thoải mái khi vận động, giúp bạn tự tin hơn trong mọi hoạt động.
-Thiết kế tiện dụng: Túi lót lưới giúp đồ vật bên trong luôn khô ráo. Lưng thun co giãn thoải mái.
3. Chất liệu: Parachute thành phần 90% Nylon, 10% Spandex
4. Kỹ thuật: Lưng thun co giãn đảm bảo sự thoải mái và vừa vặn cho người mặc. Túi lót lưới tăng tính tiện dụng và thoáng khí.
5. Phù hợp với ai: Người yêu thích thể thao phù hợp với các hoạt động như chạy bộ, tập gym, đi biển. Người trẻ tuổi thích phong cách năng động, trẻ trung.
6. Thuộc Bộ Sưu Tập nào: NON BRANDED , Sản phẩm thuộc bộ sưu tập thời trang đa phong cách, đáp ứng nhu cầu của những người trẻ năng động.
7. Các tên thường gọi hoặc tìm kiếm: Quần short dù nam, Quần short thể thao nam, Quần short lưng thun, Quần short mỏng nhẹ'),

(17, N'Quần Short 5 Inch Dù Mỏng Nhẹ Non Branded 006 Xanh Dương Đậm', 'quan15.png', 158650, 4,
N'Dáng Vừa được rút ngắn 8cm, tạo dáng short ngắn cực kỳ năng động. Chất thun vải mềm mại, co giãn, mang lại cảm giác thoải mái, mát mẻ.',
N'Quần Short 5 Inch, thoáng mát, nhanh khô, co giãn 4 chiều.

1. Kiểu sản phẩm: Quần Short Dù
2. Ưu điểm:
-Thoáng mát, nhanh khô: Chất liệu dù (parachute) nhẹ, mỏng, có khả năng thoát ẩm tốt và nhanh khô.
-Co giãn 4 chiều, thoải mái: Tăng độ thoải mái khi vận động, giúp bạn tự tin hơn trong mọi hoạt động.
-Thiết kế tiện dụng: Túi lót lưới giúp đồ vật bên trong luôn khô ráo. Lưng thun co giãn thoải mái.
3. Chất liệu: Parachute thành phần 90% Nylon, 10% Spandex
4. Kỹ thuật: Lưng thun co giãn đảm bảo sự thoải mái và vừa vặn cho người mặc. Túi lót lưới tăng tính tiện dụng và thoáng khí.
5. Phù hợp với ai: Người yêu thích thể thao phù hợp với các hoạt động như chạy bộ, tập gym, đi biển. Người trẻ tuổi thích phong cách năng động, trẻ trung.
6. Thuộc Bộ Sưu Tập nào: NON BRANDED , Sản phẩm thuộc bộ sưu tập thời trang đa phong cách, đáp ứng nhu cầu của những người trẻ năng động.
7. Các tên thường gọi hoặc tìm kiếm: Quần short dù nam, Quần short thể thao nam, Quần short lưng thun, Quần short mỏng nhẹ'),

(17, N'Quần Short 5 Inch Dù Mỏng Nhẹ Non Branded 006 Xanh Lá Đậm', 'quan16.png', 158650, 4,
N'Dáng Vừa được rút ngắn 8cm, tạo dáng short ngắn cực kỳ năng động. Chất thun vải mềm mại, co giãn, mang lại cảm giác thoải mái, mát mẻ.',
N'Quần Short 5 Inch, thoáng mát, nhanh khô, co giãn 4 chiều.

1. Kiểu sản phẩm: Quần Short Dù
2. Ưu điểm:
-Thoáng mát, nhanh khô: Chất liệu dù (parachute) nhẹ, mỏng, có khả năng thoát ẩm tốt và nhanh khô.
-Co giãn 4 chiều, thoải mái: Tăng độ thoải mái khi vận động, giúp bạn tự tin hơn trong mọi hoạt động.
-Thiết kế tiện dụng: Túi lót lưới giúp đồ vật bên trong luôn khô ráo. Lưng thun co giãn thoải mái.
3. Chất liệu: Parachute thành phần 90% Nylon, 10% Spandex
4. Kỹ thuật: Lưng thun co giãn đảm bảo sự thoải mái và vừa vặn cho người mặc. Túi lót lưới tăng tính tiện dụng và thoáng khí.
5. Phù hợp với ai: Người yêu thích thể thao phù hợp với các hoạt động như chạy bộ, tập gym, đi biển. Người trẻ tuổi thích phong cách năng động, trẻ trung.
6. Thuộc Bộ Sưu Tập nào: NON BRANDED , Sản phẩm thuộc bộ sưu tập thời trang đa phong cách, đáp ứng nhu cầu của những người trẻ năng động.
7. Các tên thường gọi hoặc tìm kiếm: Quần short dù nam, Quần short thể thao nam, Quần short lưng thun, Quần short mỏng nhẹ'),

(17, N'Quần Short 5 Inch Dù Mỏng Nhẹ Non Branded 006 Cam Đậm', 'quan17.png', 158650, 4,
N'Dáng Vừa được rút ngắn 8cm, tạo dáng short ngắn cực kỳ năng động. Chất thun vải mềm mại, co giãn, mang lại cảm giác thoải mái, mát mẻ.',
N'Quần Short 5 Inch, thoáng mát, nhanh khô, co giãn 4 chiều.

1. Kiểu sản phẩm: Quần Short Dù
2. Ưu điểm:
-Thoáng mát, nhanh khô: Chất liệu dù (parachute) nhẹ, mỏng, có khả năng thoát ẩm tốt và nhanh khô.
-Co giãn 4 chiều, thoải mái: Tăng độ thoải mái khi vận động, giúp bạn tự tin hơn trong mọi hoạt động.
-Thiết kế tiện dụng: Túi lót lưới giúp đồ vật bên trong luôn khô ráo. Lưng thun co giãn thoải mái.
3. Chất liệu: Parachute thành phần 90% Nylon, 10% Spandex
4. Kỹ thuật: Lưng thun co giãn đảm bảo sự thoải mái và vừa vặn cho người mặc. Túi lót lưới tăng tính tiện dụng và thoáng khí.
5. Phù hợp với ai: Người yêu thích thể thao phù hợp với các hoạt động như chạy bộ, tập gym, đi biển. Người trẻ tuổi thích phong cách năng động, trẻ trung.
6. Thuộc Bộ Sưu Tập nào: NON BRANDED , Sản phẩm thuộc bộ sưu tập thời trang đa phong cách, đáp ứng nhu cầu của những người trẻ năng động.
7. Các tên thường gọi hoặc tìm kiếm: Quần short dù nam, Quần short thể thao nam, Quần short lưng thun, Quần short mỏng nhẹ'),

(17, N'Quần Short 5 Inch Dù Mỏng Nhẹ Non Branded 006 Đỏ', 'quan18.png', 158650, 4,
N'Dáng Vừa được rút ngắn 8cm, tạo dáng short ngắn cực kỳ năng động. Chất thun vải mềm mại, co giãn, mang lại cảm giác thoải mái, mát mẻ.',
N'Quần Short 5 Inch, thoáng mát, nhanh khô, co giãn 4 chiều.

1. Kiểu sản phẩm: Quần Short Dù
2. Ưu điểm:
-Thoáng mát, nhanh khô: Chất liệu dù (parachute) nhẹ, mỏng, có khả năng thoát ẩm tốt và nhanh khô.
-Co giãn 4 chiều, thoải mái: Tăng độ thoải mái khi vận động, giúp bạn tự tin hơn trong mọi hoạt động.
-Thiết kế tiện dụng: Túi lót lưới giúp đồ vật bên trong luôn khô ráo. Lưng thun co giãn thoải mái.
3. Chất liệu: Parachute thành phần 90% Nylon, 10% Spandex
4. Kỹ thuật: Lưng thun co giãn đảm bảo sự thoải mái và vừa vặn cho người mặc. Túi lót lưới tăng tính tiện dụng và thoáng khí.
5. Phù hợp với ai: Người yêu thích thể thao phù hợp với các hoạt động như chạy bộ, tập gym, đi biển. Người trẻ tuổi thích phong cách năng động, trẻ trung.
6. Thuộc Bộ Sưu Tập nào: NON BRANDED , Sản phẩm thuộc bộ sưu tập thời trang đa phong cách, đáp ứng nhu cầu của những người trẻ năng động.
7. Các tên thường gọi hoặc tìm kiếm: Quần short dù nam, Quần short thể thao nam, Quần short lưng thun, Quần short mỏng nhẹ'),

(17, N'Quần Short Cargo 7 Inch Dù Trượt Nước Seventy Seven 031 Đen', 'quan19.png', 158650, 4,
N'Phom Rộng được rút ngắn 1cm, tạo nét trẻ trung. Chất vải mềm mại, nới rộng mông 3cm, tối ưu sự thoải mái, mang lại cảm giác dễ chịu cả ngày.',
N'Quần Short cargo, trượt nước, thoáng mát, nhiều túi tiện dụng.

1. Kiểu sản phẩm: Quần Short Cargo
2. Ưu điểm: 
-Vải dù chống thấm tốt: Vải Parachute (vải dù) có khả năng chống thấm nước tốt, phù hợp cho các hoạt động ngoài trời.
-Dáng rộng thoải mái: Quần short lưng thun dài trên gối dáng rộng, giúp bạn thoải mái vận động mà không gây gò bó.
-Thiết kế bền bỉ: Đánh bọ tại các vị trí miệng túi để tăng cường độ bền và giúp quần thêm chắc chắn.
3. Chất liệu: Vải Parachute (vải dù) - 100% polyester.
4. Kỹ thuật: Đánh bọ tại các vị trí miệng túi để tăng cường độ bền và giúp quần thêm chắc chắn.
5. Phù hợp với ai: Phù hợp cho cả nam và nữ, đặc biệt là những người yêu thích vận động và các hoạt động ngoài trời.
6. Thuộc Bộ Sưu Tập: Seventy Seven,Thời trang trung tính, dễ dàng kết hợp và lựa chọn, phù hợp với mọi hoàn cảnh và phong cách sống của bạn.
7. Các tên thường gọi hoặc tìm kiếm: Quần short dù, Quần short dù lưng thun, Quần short trượt nước, Quần short dáng rộng, Quần short nhanh khô, Quần short cargo'),

(17, N'Quần Short Cargo 7 Inch Dù Trượt Nước Seventy Seven 031 Xanh Dương Đậm', 'quan20.png', 158650, 4,
N'Phom Rộng được rút ngắn 1cm, tạo nét trẻ trung. Chất vải mềm mại, nới rộng mông 3cm, tối ưu sự thoải mái, mang lại cảm giác dễ chịu cả ngày.',
N'Quần Short cargo, trượt nước, thoáng mát, nhiều túi tiện dụng.

1. Kiểu sản phẩm: Quần Short Cargo
2. Ưu điểm: 
-Vải dù chống thấm tốt: Vải Parachute (vải dù) có khả năng chống thấm nước tốt, phù hợp cho các hoạt động ngoài trời.
-Dáng rộng thoải mái: Quần short lưng thun dài trên gối dáng rộng, giúp bạn thoải mái vận động mà không gây gò bó.
-Thiết kế bền bỉ: Đánh bọ tại các vị trí miệng túi để tăng cường độ bền và giúp quần thêm chắc chắn.
3. Chất liệu: Vải Parachute (vải dù) - 100% polyester.
4. Kỹ thuật: Đánh bọ tại các vị trí miệng túi để tăng cường độ bền và giúp quần thêm chắc chắn.
5. Phù hợp với ai: Phù hợp cho cả nam và nữ, đặc biệt là những người yêu thích vận động và các hoạt động ngoài trời.
6. Thuộc Bộ Sưu Tập: Seventy Seven,Thời trang trung tính, dễ dàng kết hợp và lựa chọn, phù hợp với mọi hoàn cảnh và phong cách sống của bạn.
7. Các tên thường gọi hoặc tìm kiếm: Quần short dù, Quần short dù lưng thun, Quần short trượt nước, Quần short dáng rộng, Quần short nhanh khô, Quần short cargo'),



--------------------------------------------------------quan tay-------------------------------------------------------------------------------------------------------------------------------
(18, N'Quần Tây Nam Co giãn Ít Nhăn Non Iron 019 Đen', 'quan21.png', 329650, 4,
N'Lựa chọn Dáng Vừa để tạo sự thanh lịch. Chất vải non-iron giữ phom quần luôn phẳng phiu, giúp người mặc có vẻ ngoài gọn gàng, chuyên nghiệp.',
N'Quần Tây Casual dáng vừa vải Twill mềm mại, thoáng mát co giãn nhẹ, ít nhăn.

1. Kiểu sản phẩm: Quần Tây Dáng Vừa.
2. Ưu điểm:
-Phom dáng vừa vặn, thanh lịch: Thiết kế vừa vặn, phù hợp với nhiều lứa tuổi và môi trường khác nhau, dễ mặc.
-Ít nhăn, dễ chăm sóc: Chất liệu vải ít nhăn, dễ dàng ủi phẳng, giúp bạn tiết kiệm thời gian chăm sóc.
-Co giãn, kháng khuẩn: Vải có độ co giãn trung bình, giữ được phom dáng, đồng thời kháng khuẩn, mềm mịn và bền màu.
3. Chất liệu: Vải Twill, 82% Polyester, 14% Rayon, 4% Spandex
4. Kỹ thuật: Thiết kế túi đồng hồ nhỏ gọn tạo điểm nhấn và tiện lợi.
5. Phù hợp với ai: Những người đam mê phong cách thời trang trung tính, dễ dàng phối hợp với nhiều trang phục khác nhau
6. Thuộc Bộ Sưu Tập: NON IRON, bộ sưu tập với chất liệu vải ít nhăn, dễ dàng ủi phẳng, giúp bạn tiết kiệm thời gian chăm sóc trang phục mà vẫn luôn giữ được vẻ ngoài hoàn hảo.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Quần tây đen, Quần âu đen, Quần tây co giãn, Quần tây đơn giản , Quần tây công sở.'),

(18, N'Quần Tây Casual Co Giãn Ít Nhăn Non Branded 030 Đen', 'quan22.png', 357300, 4,
N'Dáng Vừa được chọn vì sự thoải mái. Chất thun co giãn kết hợp ống nới rộng 7.5cm, tạo phom suông năng động, giúp người mặc tự do vận động.',
N'Quần tây casual, co giãn, ít nhăn, bền màu.

1. Kiểu sản phẩm: Quần tây nam lưng gài.
2. Ưu điểm:
• Vừa vặn, thoải mái form dáng vừa vặn, ống quần không quá ôm hoặc quá rộng, kết hợp với chất liệu co giãn giúp bạn thoải mái khi vận động.
• Dễ dàng phối đồ với nhiều loại áo khác nhau, từ áo sơ mi đến áo thun, phù hợp với nhiều phong cách.
3. Chất liệu: Trouser fabric bền màu, ít nhăn, dễ dàng chăm sóc, thành phần 96% Polyester, 4% Spandex
4. Kỹ thuật:
• Lưng gài: Thiết kế truyền thống, tạo nên vẻ ngoài lịch lãm.
• Ống đứng tôn dáng chân và phù hợp với nhiều vóc dáng.
5. Phù hợp với ai: Nam giới công sở cần một chiếc quần tây lịch lãm, thoải mái để đi làm. Những người yêu thích phong cách đơn giản muốn có một chiếc quần dễ phối đồ và phù hợp với nhiều hoàn cảnh.
6. Thuộc Bộ Sưu Tập nào: Non Branded - thời trang tối giản, tập trung vào chất lượng và thiết kế tinh tế.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này : Quần tây nam, Quần âu nam, Quần tây nam công sở, Quần tây ít nhăn'),

(18, N'Quần Tây Casual Mềm Mại Non Iron 001 Đen', 'quan23.png', 377150, 4,
N'Phom Dáng Vừa được nới rộng ống 7.5cm, tối ưu cho chất thun co giãn. Thiết kế tạo độ rũ tự nhiên, mang lại cảm giác thoải mái tối đa, che khuyết điểm chân.',
N'Quần Tây lưng thun mềm mại, thoáng mát, độ bền cao, ít nhăn, kháng khuẩn.

1. Kiểu sản phẩm: Quần Tây Casual
2. Ưu điểm:
-Phong cách đa năng: Kết hợp hài hòa giữa phong cách công sở và thời trang đường phố, phù hợp với nhiều hoàn cảnh.
-Chất liệu cao cấp: Vải Twill mềm mại, thoáng mát, có độ bền cao và ít nhăn, giúp bạn tự tin.
-Thiết kế thoải mái: Lưng thun tăng cường độ co giãn, giúp bạn thoải mái vận động, ống đứng tôn dáng.
3. Chất liệu: Vải Twill, 70% Polyester, 27% Rayon, 3% Spandex.
4. Kỹ thuật: Thêu 2D thân trước logo nhãn hiệu. Thiết kế lưng thun tăng cường độ co giãn, giúp bạn thoải mái vận động, ống đứng tôn dáng chân, tạo cảm giác thon gọn.
5. Phù hợp với ai: Nam giới văn phòng muốn tìm kiếm sự thoải mái và thanh lịch trong môi trường làm việc, sinh viên và học sinh thích phong cách trẻ trung, năng động. Những người yêu thích thời trang muốn sở hữu một chiếc quần vừa thời trang vừa tiện dụng.
6. Thuộc Bộ Sưu Tập nào: No Style , thời trang đa phong cách, không giới hạn, phù hợp với nhiều đối tượng khách hàng.
7. Các tên thường gọi hoặc tìm kiếm: Quần tây nam lưng thun, Quần tây nam công sở, Quần tây nam thời trang, Quần tây co giãn, Quần tây casual'),

(18, N'Quần Tây Smart Casual Ít Nhăn The CEO 018 Đen', 'quan24.png', 529150, 4,
N'Dáng Vừa là lựa chọn hoàn hảo cho sự thoải mái nơi công sở. Chất Kaki co giãn nhẹ, giúp quần đứng phom mà vẫn dễ chịu, mang lại vẻ ngoài lịch sự.',
N'Quần lót tây đáy, eo suối, dây rút, co giãn, ít nhăn.

1. Kiểu sản phẩm: Quần Tây Smart Casual
2. Ưu điểm:
-Thoải mái đỉnh cao: Thiết kế rã đáy quần thông minh, tạo không gian rộng rãi, giúp bạn tự do vận động.
-Vừa vặn hoàn hảo: Bản lưng được trang bị khuy luồn dây tinh chỉnh, dễ dàng điều chỉnh độ rộng.
-Ít nhăn, lịch lãm: Luôn giữ form dáng phẳng phiu, lịch lãm, tiết kiệm thời gian ủi đồ, tiện lợi. chỉn chu.
3. Chất liệu: Warp Knit Fabric, 100% Polyester
4. Kỹ thuật:
Đáy quần may rã phối tăng cường không gian vận động, giảm thiểu sự gò bó. Chú trọng đến từng chi tiết nhỏ bản lưng quần tây được trang bị viền thun mềm mại bên trong, ôm sát vòng eo một cách nhẹ nhàng, không còn lo lắng về việc quần bị cấn hay khó chịu .
5. Phù hợp với: Nam giới công sở, Nam giới trẻ trung, năng động, Nam giới trung niên .
6. Thuộc Bộ Sưu Tập: The Minimalist, phong cách tối giản cao cấp
7. Các tên thường gọi hoặc tìm kiếm : Quần tây nam, Quần âu, Quần tây công sở, Quần âu thanh lịch'),

(18, N'Quần Tây Casual Co Giãn Ít Nhăn Non Branded 030 Xanh Dương Đậm', 'quan25.png', 357300, 4,
N'Dáng Vừa được chọn vì sự thoải mái. Chất thun co giãn kết hợp ống nới rộng 7.5cm, tạo phom suông năng động, giúp người mặc tự do vận động.',
N'Quần tây casual, co giãn, ít nhăn, bền màu.

1. Kiểu sản phẩm: Quần tây nam lưng gài.
2. Ưu điểm:
• Vừa vặn, thoải mái form dáng vừa vặn, ống quần không quá ôm hoặc quá rộng, kết hợp với chất liệu co giãn giúp bạn thoải mái khi vận động.
• Dễ dàng phối đồ với nhiều loại áo khác nhau, từ áo sơ mi đến áo thun, phù hợp với nhiều phong cách.
3. Chất liệu: Trouser fabric bền màu, ít nhăn, dễ dàng chăm sóc, thành phần 96% Polyester, 4% Spandex
4. Kỹ thuật:
• Lưng gài: Thiết kế truyền thống, tạo nên vẻ ngoài lịch lãm.
• Ống đứng tôn dáng chân và phù hợp với nhiều vóc dáng.
5. Phù hợp với ai: Nam giới công sở cần một chiếc quần tây lịch lãm, thoải mái để đi làm. Những người yêu thích phong cách đơn giản muốn có một chiếc quần dễ phối đồ và phù hợp với nhiều hoàn cảnh.
6. Thuộc Bộ Sưu Tập nào: Non Branded - thời trang tối giản, tập trung vào chất lượng và thiết kế tinh tế.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này : Quần tây nam, Quần âu nam, Quần tây nam công sở, Quần tây ít nhăn'),

(18, N'Quần Tây Casual Co giãn Non Iron 002 Đen', 'quan26.png', 377150, 4,
N'Phom Dáng Vừa được chọn để cân bằng giữa công việc và sự thoải mái. Chất Kaki co giãn 4 chiều giúp quần giữ phom, mang lại cảm giác dễ chịu suốt ngày dài.',
N'Quần lót tây Rayon ứng dụng thoáng mát, co giãn nhẹ, ít nhăn.

1. Kiểu sản phẩm: Quần Tây nam lưng gài.
2. Ưu điểm
-Thoải mái, vừa vặn cơ thể: Chất liệu co giãn giúp thoải mái vận động, không gây cảm giác gò bó, khó chịu.
-Bền đẹp, ít nhăn: Chất liệu woven fabric cao cấp, ít nhăn, bền màu, dễ dàng chăm sóc, tiết kiệm thời gian.
-Thiết kế tinh tế: Thiết kế đơn giản nhưng tinh tế, phù hợp với nhiều hoàn cảnh, từ công sở đến dạo phố.
3. Chất liệu: woven fabric, 70% Polyester 27% Rayon 3% Spandex,
4. Kỹ thuật:
• Bản lưng dày dặn: Tăng độ bền, giữ dáng quần tốt hơn.
• Khóa gài kim loại: Chắc chắn, bền bỉ.
• Túi sau đột chỉ: Tạo điểm nhấn, tăng tính thẩm mỹ.
5. Phù hợp với ai: Nam giới công sở cần quần tây lịch lãm, thoải mái, những người yêu thích phong cách hiện đại tìm kiếm sản phẩm thời trang, tiện dụng và những người thường xuyên di chuyển muốn quần ít nhăn, dễ bảo quản.
6. Thuộc Bộ Sưu Tập: Non Iron - Thời trang cho người bận rộn
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này : Quần tây nam dáng vừa, Quần tây công sở, Quần tây co giãn, Quần tây văn phòng, Quần Tây Casual'),

(18, N'Quần Tây Nam Co giãn Ít Nhăn Non Iron 019 Xám Đậm', 'quan27.png', 329650, 4,
N'Lựa chọn Dáng Vừa để tạo sự thanh lịch. Chất vải non-iron giữ phom quần luôn phẳng phiu, giúp người mặc có vẻ ngoài gọn gàng, chuyên nghiệp.',
N'Quần Tây Casual dáng vừa vải Twill mềm mại, thoáng mát co giãn nhẹ, ít nhăn.

1. Kiểu sản phẩm: Quần Tây Dáng Vừa.
2. Ưu điểm:
-Phom dáng vừa vặn, thanh lịch: Thiết kế vừa vặn, phù hợp với nhiều lứa tuổi và môi trường khác nhau, dễ mặc.
-Ít nhăn, dễ chăm sóc: Chất liệu vải ít nhăn, dễ dàng ủi phẳng, giúp bạn tiết kiệm thời gian chăm sóc.
-Co giãn, kháng khuẩn: Vải có độ co giãn trung bình, giữ được phom dáng, đồng thời kháng khuẩn, mềm mịn và bền màu.
3. Chất liệu: Vải Twill, 82% Polyester, 14% Rayon, 4% Spandex
4. Kỹ thuật: Thiết kế túi đồng hồ nhỏ gọn tạo điểm nhấn và tiện lợi.
5. Phù hợp với ai: Những người đam mê phong cách thời trang trung tính, dễ dàng phối hợp với nhiều trang phục khác nhau
6. Thuộc Bộ Sưu Tập: NON IRON, bộ sưu tập với chất liệu vải ít nhăn, dễ dàng ủi phẳng, giúp bạn tiết kiệm thời gian chăm sóc trang phục mà vẫn luôn giữ được vẻ ngoài hoàn hảo.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Quần tây đen, Quần âu đen, Quần tây co giãn, Quần tây đơn giản , Quần tây công sở.'),

(18, N'Quần Tây Casual Co giãn Non Iron 005 Đen', 'quan28.png', 377150, 4,
N'Phom Dáng Vừa được chọn cho môi trường công sở. Chất vải non-iron đứng phom, giữ dáng quần thẳng thớm, mang lại vẻ ngoài chỉn chu, thanh lịch.',
N'Quần Tây Casual Rayon Mềm Mại, Giảm Mát Co Giãn Giảm, Ít Nhăn.

1. Kiểu sản phẩm: Quần Tây Casual
2. Ưu điểm:
-Co giãn, kháng khuẩn, mềm mịn: Ít nhăn và bền màu tương đối tốt. Form slimfit tôn dáng, hiện đại và thanh lịch.
-Bản lưng dày dặn, chắc chắn: Đảm bảo giữ dáng quần, không lo bai dão sau nhiều lần giặt, luôn như mới.
-Khóa gài kim loại bền bỉ: Chắc chắn, tăng cường nút gài bên trong. Túi sau đánh khuy gài nút tinh tế.
3. Chất liệu: Woven fabric, 76% Polyester, 22% Rayon, 2% Spandex
4. Kỹ thuật:
• Kết hợp Poly và Spandex tạo độ co dãn và bền chắc.
• Khóa gài kim loại chắc chắn, tăng cường nút gài bên trong.
• Túi sau đánh khuy gài nút, 2 túi trước đột chỉ tỉ mỉ với điểm nhấn chỉ đỏ.
5. Phù hợp với ai: Thiết kế dành riêng cho những quý ông hiện đại, ưa chuộng phong cách thanh lịch và thoải mái.
6. Thuộc Bộ Sưu Tập nào: Non-Iron, Thời Trang Cho Người Bận Rộn – Luôn chỉn chu, sẵn sàng cho mọi thử thách.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này : Quần tây nam dáng vừa, Quần tây công sở, Quần tây co giãn, Quần tây văn phòng, Quần Tây Casual'),

(18, N'Quần Tây Casual Mềm Mại Non Iron 001 Xám Nhạt', 'quan29.png', 377150, 4,
N'Phom Dáng Vừa được nới rộng ống 7.5cm, tối ưu cho chất thun co giãn. Thiết kế tạo độ rũ tự nhiên, mang lại cảm giác thoải mái tối đa, che khuyết điểm chân.',
N'Quần Tây lưng thun mềm mại, thoáng mát, độ bền cao, ít nhăn, kháng khuẩn.

1. Kiểu sản phẩm: Quần Tây Casual
2. Ưu điểm:
-Phong cách đa năng: Kết hợp hài hòa giữa phong cách công sở và thời trang đường phố, phù hợp với nhiều hoàn cảnh.
-Chất liệu cao cấp: Vải Twill mềm mại, thoáng mát, có độ bền cao và ít nhăn, giúp bạn tự tin.
-Thiết kế thoải mái: Lưng thun tăng cường độ co giãn, giúp bạn thoải mái vận động, ống đứng tôn dáng.
3. Chất liệu: Vải Twill, 70% Polyester, 27% Rayon, 3% Spandex.
4. Kỹ thuật: Thêu 2D thân trước logo nhãn hiệu. Thiết kế lưng thun tăng cường độ co giãn, giúp bạn thoải mái vận động, ống đứng tôn dáng chân, tạo cảm giác thon gọn.
5. Phù hợp với ai: Nam giới văn phòng muốn tìm kiếm sự thoải mái và thanh lịch trong môi trường làm việc, sinh viên và học sinh thích phong cách trẻ trung, năng động. Những người yêu thích thời trang muốn sở hữu một chiếc quần vừa thời trang vừa tiện dụng.
6. Thuộc Bộ Sưu Tập nào: No Style , thời trang đa phong cách, không giới hạn, phù hợp với nhiều đối tượng khách hàng.
7. Các tên thường gọi hoặc tìm kiếm: Quần tây nam lưng thun, Quần tây nam công sở, Quần tây nam thời trang, Quần tây co giãn, Quần tây casual'),

(18, N'Quần Tây Casual Mềm Mại Non Iron 001 Nâu', 'quan30.png', 377150, 4,
N'Phom Dáng Vừa được nới rộng ống 7.5cm, tối ưu cho chất thun co giãn. Thiết kế tạo độ rũ tự nhiên, mang lại cảm giác thoải mái tối đa, che khuyết điểm chân.',
N'Quần Tây lưng thun mềm mại, thoáng mát, độ bền cao, ít nhăn, kháng khuẩn.

1. Kiểu sản phẩm: Quần Tây Casual
2. Ưu điểm:
-Phong cách đa năng: Kết hợp hài hòa giữa phong cách công sở và thời trang đường phố, phù hợp với nhiều hoàn cảnh.
-Chất liệu cao cấp: Vải Twill mềm mại, thoáng mát, có độ bền cao và ít nhăn, giúp bạn tự tin.
-Thiết kế thoải mái: Lưng thun tăng cường độ co giãn, giúp bạn thoải mái vận động, ống đứng tôn dáng.
3. Chất liệu: Vải Twill, 70% Polyester, 27% Rayon, 3% Spandex.
4. Kỹ thuật: Thêu 2D thân trước logo nhãn hiệu. Thiết kế lưng thun tăng cường độ co giãn, giúp bạn thoải mái vận động, ống đứng tôn dáng chân, tạo cảm giác thon gọn.
5. Phù hợp với ai: Nam giới văn phòng muốn tìm kiếm sự thoải mái và thanh lịch trong môi trường làm việc, sinh viên và học sinh thích phong cách trẻ trung, năng động. Những người yêu thích thời trang muốn sở hữu một chiếc quần vừa thời trang vừa tiện dụng.
6. Thuộc Bộ Sưu Tập nào: No Style , thời trang đa phong cách, không giới hạn, phù hợp với nhiều đối tượng khách hàng.
7. Các tên thường gọi hoặc tìm kiếm: Quần tây nam lưng thun, Quần tây nam công sở, Quần tây nam thời trang, Quần tây co giãn, Quần tây casual'),




--------------------------------------------------------quan jogger-------------------------------------------------------------------------------------------------------------------------------

(19, N'Quần Jogger Mềm Mịn Mát The Minimalist 019 Đen', 'quan31.png', 377150, 4,
N'Để tôn dáng, Dáng Vừa được rút ngắn 2cm và thu gọn ống 3cm. Chất vải "Cool Touch" mỏng nhẹ, co giãn, giúp quần ôm gọn gàng, mang lại cảm giác mát lạnh.',
N'Quần Jogger Cool Touch mềm mịn, mát, co giãn thoải mái, thoát ẩm tốt.

1. Kiểu sản phẩm: Quần Jogger
2. Ưu điểm: 
-Công nghệ COOL TOUCH : Giúp vải luôn mát mẻ, mang lại cảm giác dễ chịu và thoải mái cho người mặc.
-Vải mềm mịn , co giãn tốt : Sợi Cotton cao cấp mang lại cảm giác mềm mại khi chạm vào, co giãn tốt, thoải mái.
-Thiết kế tôn dáng : Đường rã phối làm tăng độ bền khu vực đầu gối, giúp quần ôm dáng, tôn dáng.

3. Chất liệu: Mini Zurry 4 chiều với thành phần 94% Cotton và 6% Spandex.Sợi Cotton High TPI có chỉ số vòng xoắn cao giúp tăng độ bền và độ mềm mại của vải.
4. Kỹ thuật: Đường rã phối làm tăng độ bền khu vực đầu gối giúp quần bền hơn, co giãn tốt, dễ dàng di chuyển và vận động.
5. Phù hợp với ai: Những người tìm kiếm sự thoải mái và mát mẻ trong trang phục hàng ngày, đặc biệt lý tưởng cho những ngày nóng bức.
6. Thuộc Bộ Sưu Tập nào: Cool Touch,  nổi bật với các sản phẩm mang lại cảm giác mát mẻ và thoải mái.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Quần thun jogger, Quần thun dài, Quần cotton co giãn, Quần lưng thun ống ôm, Quần thun thể thao.'),

(19, N'Quần Jogger Corduroy Ít Nhăn Seventy Seven 033 Đen', 'quan32.png', 282150, 4,
N'Để tạo sự phóng khoáng, phom Rộng được nới ống 10cm. Chất vải mỏng nhẹ giúp quần có độ rũ đẹp, che khuyết điểm đùi mà vẫn thoáng mát.',
N'Quần Jogger ống rộng, ít nhăn, rã phối sườn.

1. Kiểu sản phẩm: Quần Jogger
2. Ưu điểm:
-Vải Corduroy ít nhăn: Vải Corduroy ít nhăn, giữ dáng tốt, bền màu lâu, không tốn nhiều công chăm sóc.
-Thoát ẩm tốt, thoải mái: Thành phần Polyester thoáng nhẹ, dễ chịu phù hợp với mọi hoạt động.
-Thiết kế trẻ trung: Phối viền hai bên tạo cảm giác tăng chiều dài chân, thêu 2D tinh tế, độc đáo.
3. Chất liệu: Vải Corduroy làm từ 100% Polyester.
4. Kỹ thuật: Thêu 2D tinh tế độc đáo và sang trọng cho sản phẩm.Phối viền 2 bên tạo cảm giác tăng chiều dài chân.
5. Phù hợp với ai: Những người yêu thích phong cách trẻ trung và năng động.
6. Thuộc Bộ Sưu Tập: Seventy Seven, mang đến sự phong phú và đa dạng về sản phẩm, kiểu dáng đơn giản mà không bao giờ lỗi mốt.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Quần dài lưng thun, Quần ống đứng, Quần dáng ôm, Quần Kaki, Quần Corduroy.'),

(19, N'Quần Dù Cargo Nhẹ Co Giãn The No Style 098 Đen', 'quan33.png', 367650, 4,
N'Lựa chọn Dáng Rộng để tối ưu sự thoáng mát. Chất vải mỏng nhẹ, kết hợp nới rộng ống 5cm, tạo phom quần rộng rãi, thoải mái, lý tưởng cho mùa hè.',
N'Quần Jogger dù mỏng nhẹ, co giãn 2 chiều.

1. Kiểu sản phẩm: Quần Jogger
2. Ưu điểm:
-Vải dù thun co giãn: Vải co giãn 2 chiều, chất liệu nhẹ, giúp người mặc thoải mái vận động cả ngày dài.
-Thoát ẩm, khô thoáng: Vải dù thun có khả năng thoát ẩm tốt, tạo cảm giác khô thoáng, dễ chịu.
-Thiết kế tiện lợi: Túi hộp lớn hai bên, dây rút điều chỉnh vòng eo linh hoạt, vị trí gối may xếp ly.
3. Chất liệu: Parachute, 90% Nylon 10% Spandex.
4. Kỹ thuật: Vị trí gối may xếp ly giúp tăng độ co giãn và tạo điểm nhấn cho quần.
5. Phù hợp với ai: Người trẻ tuổi năng động, phù hợp với phong cách thời trang hiện đại, những người yêu thích sự thoải mái, thoáng mát, form rộng tạo cảm giác thoải mái khi vận động.
6. Thuộc Bộ Sưu Tập nào: NoStyle ,Một bộ sưu tập thời trang đa dạng, đáp ứng nhiều phong cách khác nhau, từ tối giản đến phá cách.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Quần dài lưng thun, Quần dù xám, Quần jogger , Quần unisex, Quần Basic'),

(19, N'Quần Jogger Sorona Mềm Mại Non Branded 041 Xám Đậm', 'quan34.png', 310650, 4,
N'Dáng Vừa được thu gọn ống 1cm, giúp dáng quần gọn gàng, tôn dáng. Chất vải co giãn, mỏng nhẹ, đảm bảo sự thoải mái khi vận động.',
N'Quần Jogger dáng vừa vải sợi Sorona, may rã , dây kéo ẩn.

1.Kiểu sản phẩm: Quần jogger
2.Ưu điểm:
-Sợi Sorona mềm mại, thoáng khí: Trải nghiệm thoải mái tuyệt đối với chất liệu sợi Sorona mềm mại, thoáng khí, dễ chịu.
-Co giãn, đàn hồi vượt trội: Mang đến cảm giác thoải mái tối đa trong mọi hoạt động, không gây gò bó.
-Nhanh khô, thoát ẩm tốt: Giúp bạn luôn khô ráo và dễ chịu, ngay cả khi vận động cường độ cao, siêu tiện lợi.
3.Chất liệu: Sorona100% Polyester
4.Kỹ thuật:
Thiết kế tối ưu hóa thoải mái, được thiết kế với kỹ thuật rã thân sau và thân trước, tạo dáng quần vừa vặn, mang lại cảm giác thoải mái tối đa trong mọi cử động.
Thiết kế túi ẩn tinh tế an toàn và tiện lợi với khóa kéo chắc chắn, đảm bảo an toàn cho các vật dụng cá nhân.
5.Phù hợp với: Hoạt động thể thao: chạy bộ, tập gym, yoga, mặc hàng ngày,đi chơi, đi dạo, mặc nhà,...
6. Thuộc bộ sưu tập : Non Branded, Thời trang tối giản không logo.
7.Tìm kiếm sản phẩm: Quần jogger thể thao unisex, Quần thể thao polyester, Quần tập gym,Quần chạy bộ,Quần nhanh khô'),

(19, N'Quần Jogger Dù Thể Thao Nhanh Khô Beginner 015 Xanh Dương Đậm', 'quan35.png', 218450, 4,
N'Để tối ưu sự linh hoạt, Dáng Vừa được thu gọn ống 1cm. Chất vải Parachute "biết thở" siêu co giãn, giúp quần ôm gọn gàng mà vẫn thoải mái vận động.',
N'Quần Jogger Dáng Vừa Vải Parachute, chất liệu "Biết thở" Thông thoáng vượt trội, Co giãn 4 chiều, mỏng nhẹ thoải mái, đa dạng màu sắc trung tính. 

1. Kiểu sản phẩm : Quần dài lưng thun ống ôm
2. Ưu điểm:
● Co giãn nhẹ nhàng giúp thoải mái trong việc vận động
● Nhanh khô và thấm hút mồ hôi .
● Đa dạng màu sắc dễ phối đồ và lựa chọn.
3. Chất liệu : Vải Parachute làm từ 100% Polyester.
4. Kỹ thuật : In nhũ sử dụng mực có hạt nhũ bám vào bề mặt vải, tạo hiệu ứng ánh kim thời trang. Đường rã thông minh không ảnh hưởng việc đến di chuyển khớp gối.
5. Phù hợp với ai : Dành cho những người thích quần nhẹ, tiện dụng, dễ dàng vận động.
6. Thuộc bộ sưu tập nào : Beginner bộ sưu tập có thiết kế đơn giản, tiện dụng và phù hợp cho việc chơi thể thao, tập thể dục hoặc tập gym.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Quần Parachute, Quần dài lưng thun, Quần ôm vừa, Quần nhẹ nhanh khô.'),

(19, N'Quần Jogger Sorona Mềm Mại Non Branded 041 Xanh Dương Đậm', 'quan36.png', 310650, 4,
N'Dáng Vừa được thu gọn ống 1cm, giúp dáng quần gọn gàng, tôn dáng. Chất vải co giãn, mỏng nhẹ, đảm bảo sự thoải mái khi vận động.',
N'Quần Jogger dáng vừa vải sợi Sorona, may rã , dây kéo ẩn.

1.Kiểu sản phẩm: Quần jogger
2.Ưu điểm:
-Sợi Sorona mềm mại, thoáng khí: Trải nghiệm thoải mái tuyệt đối với chất liệu sợi Sorona mềm mại, thoáng khí, dễ chịu.
-Co giãn, đàn hồi vượt trội: Mang đến cảm giác thoải mái tối đa trong mọi hoạt động, không gây gò bó.
-Nhanh khô, thoát ẩm tốt: Giúp bạn luôn khô ráo và dễ chịu, ngay cả khi vận động cường độ cao, siêu tiện lợi.
3.Chất liệu: Sorona100% Polyester
4.Kỹ thuật:
Thiết kế tối ưu hóa thoải mái, được thiết kế với kỹ thuật rã thân sau và thân trước, tạo dáng quần vừa vặn, mang lại cảm giác thoải mái tối đa trong mọi cử động.
Thiết kế túi ẩn tinh tế an toàn và tiện lợi với khóa kéo chắc chắn, đảm bảo an toàn cho các vật dụng cá nhân.
5.Phù hợp với: Hoạt động thể thao: chạy bộ, tập gym, yoga, mặc hàng ngày,đi chơi, đi dạo, mặc nhà,...
6. Thuộc bộ sưu tập : Non Branded, Thời trang tối giản không logo.
7.Tìm kiếm sản phẩm: Quần jogger thể thao unisex, Quần thể thao polyester, Quần tập gym,Quần chạy bộ,Quần nhanh khô'),

(19, N'Quần Jogger Thun Vải Bird Eye Mesh Non Branded 007 Be', 'quan37.png', 167450, 4,
N'Dáng Vừa được thu gọn mông 3cm và rút ngắn 2cm. Thiết kế này giúp "hack" dáng, tạo cảm giác gọn gàng, năng động, phù hợp vải vải.',
N'Quần Jogger Dáng Vừa Bird Eye Mesh thoáng khí, co giãn 2 chiều, nhiều túi tiện lợi, bảng màu đa dạng.

1. Kiểu sản phẩm: Quần dài lưng thun.
2. Ưu điểm:
• Thoải mái, dễ chịu: Chất liệu thun mềm mại, co giãn tốt, tạo cảm giác thoải mái khi vận động.
• Phong cách trẻ trung: Thiết kế đơn giản, hiện đại, phù hợp với nhiều phong cách thời trang.
• Đa năng: Có thể kết hợp với nhiều loại áo khác nhau.
3. Chất liệu: Polyester Bird Eye Mesh Fabric, 100% Polyester.
4. Kỹ thuật: Cạp chun co giãn đảm bảo sự thoải mái và vừa vặn cho người mặc, ống quần bo tạo điểm nhấn và giúp quần giữ form tốt hơn, túi bên tiện lợi để đựng các vật dụng nhỏ.
5. Phù hợp với ai: Người yêu thích sự thoải mái và năng động, muốn thể hiện cá tính riêng, người thường xuyên vận động cần một chiếc quần thoải mái và bền bỉ.
6. Thuộc Bộ Sưu Tập nào: Non Branded - Chất lượng bền bỉ, thiết kế tối giản, giá trị vượt thời gian.
7. Các tên thường gọi hoặc tìm kiếm: Quần jogger nam, quần dài lưng thun, quần thể thao nam ống suông.'),

(19, N'Quần Jogger Thun Vải Bird Eye Mesh Non Branded 007 Xanh Dương Đậm', 'quan38.png', 167450, 4,
N'Dáng Vừa được thu gọn mông 3cm và rút ngắn 2cm. Thiết kế này giúp "hack" dáng, tạo cảm giác gọn gàng, năng động, phù hợp vải vải.',
N'Quần Jogger Dáng Vừa Bird Eye Mesh thoáng khí, co giãn 2 chiều, nhiều túi tiện lợi, bảng màu đa dạng.

1. Kiểu sản phẩm: Quần dài lưng thun.
2. Ưu điểm:
• Thoải mái, dễ chịu: Chất liệu thun mềm mại, co giãn tốt, tạo cảm giác thoải mái khi vận động.
• Phong cách trẻ trung: Thiết kế đơn giản, hiện đại, phù hợp với nhiều phong cách thời trang.
• Đa năng: Có thể kết hợp với nhiều loại áo khác nhau.
3. Chất liệu: Polyester Bird Eye Mesh Fabric, 100% Polyester.
4. Kỹ thuật: Cạp chun co giãn đảm bảo sự thoải mái và vừa vặn cho người mặc, ống quần bo tạo điểm nhấn và giúp quần giữ form tốt hơn, túi bên tiện lợi để đựng các vật dụng nhỏ.
5. Phù hợp với ai: Người yêu thích sự thoải mái và năng động, muốn thể hiện cá tính riêng, người thường xuyên vận động cần một chiếc quần thoải mái và bền bỉ.
6. Thuộc Bộ Sưu Tập nào: Non Branded - Chất lượng bền bỉ, thiết kế tối giản, giá trị vượt thời gian.
7. Các tên thường gọi hoặc tìm kiếm: Quần jogger nam, quần dài lưng thun, quần thể thao nam ống suông.'),

(19, N'Quần Jeans Jogger Mềm Mại Co Giãn Tek Black Jean 005 Đen', 'quan39.png', 453150, 4,
N'Dáng Vừa được nới ống 1cm, tạo dáng suông nhẹ. Chất vải mềm mại, thoáng khí, mang lại cảm giác thoải mái, dễ chịu suốt cả ngày dài.',
N'Quần Jeans jogger Tek Black , mềm , bền màu , công nghệ nhuộm sợi.

1. Kiểu sản phẩm: Quần Jean Jogger
2. Ưu điểm:
-Công nghệ "5 không" độc đáo: Không bạc màu, không rách, không cũ, không dây màu, không khô cứng. Siêu bền bỉ.
-Mềm mại, thoáng khí: Nhờ vào sợi Modal, vải mang lại cảm giác mềm mại vượt trội .
-Co giãn linh hoạt: Vải có khả năng co giãn linh hoạt, giúp giữ được phom dáng, giảm thiểu tình trạng giãn.
3. Chất liệu: Jean, 49% Polyester 49% Modal 2% Spandex
4. Kỹ thuật:
Công nghệ Nhuộm Sợi (Yarn-Dyed): Thay vì nhuộm cả tấm vải, chúng tôi nhuộm từng sợi vải riêng lẻ trước khi dệt. Điều này cho phép màu đen thấm sâu và khóa chặt vào lõi sợi, tạo nên sắc độ đồng đều và khả năng giữ màu ưu việt, thách thức sự phai màu sau nhiều lần giặt.
Công nghệ Dệt Cân Bằng: Tỷ lệ "vàng" giữa các loại sợi được tính toán chính xác để tạo ra một chất liệu độc đáo: vừa co giãn linh hoạt theo từng cử động, vừa đủ cứng cáp để giữ phom dáng chuẩn suốt ngày dài, đồng thời vẫn đảm bảo sự mềm mại tối đa khi tiếp xúc với da.
5. Phù hợp với: Những người tìm kiếm sự thoải mái tối đa cho cả ngày dài hoạt động, từ đi làm, đi học đến đi chơi.
6. Thuộc Bộ Sưu Tập: Tek Black Jean, Jean đen bền màu.
7. Tìm kiếm sản phẩm: Quần Jeans Jogger, Tek Black Jean, Quần Jean YaMe, Quần Jean Mặc Bền, quần jean nam co giãn, quần jean đen, quần jean mềm , quần jean ít nhăn, quần jean modal, quần jean không phai màu.'),

(19, N'Quần Dù Cargo Nhẹ Co Giãn The No Style 098 Nâu Nhạt', 'quan40.png', 367650, 4,
N'Lựa chọn Dáng Rộng để tối ưu sự thoáng mát. Chất vải mỏng nhẹ, kết hợp nới rộng ống 5cm, tạo phom quần rộng rãi, thoải mái, lý tưởng cho mùa hè.',
N'Quần Jogger dù mỏng nhẹ, co giãn 2 chiều.

1. Kiểu sản phẩm: Quần Jogger
2. Ưu điểm:
-Vải dù thun co giãn: Vải co giãn 2 chiều, chất liệu nhẹ, giúp người mặc thoải mái vận động cả ngày dài.
-Thoát ẩm, khô thoáng: Vải dù thun có khả năng thoát ẩm tốt, tạo cảm giác khô thoáng, dễ chịu.
-Thiết kế tiện lợi: Túi hộp lớn hai bên, dây rút điều chỉnh vòng eo linh hoạt, vị trí gối may xếp ly.
3. Chất liệu: Parachute, 90% Nylon 10% Spandex.
4. Kỹ thuật: Vị trí gối may xếp ly giúp tăng độ co giãn và tạo điểm nhấn cho quần.
5. Phù hợp với ai: Người trẻ tuổi năng động, phù hợp với phong cách thời trang hiện đại, những người yêu thích sự thoải mái, thoáng mát, form rộng tạo cảm giác thoải mái khi vận động.
6. Thuộc Bộ Sưu Tập nào: NoStyle ,Một bộ sưu tập thời trang đa dạng, đáp ứng nhiều phong cách khác nhau, từ tối giản đến phá cách.
7. Các tên thường gọi hoặc tìm kiếm về sản phẩm này: Quần dài lưng thun, Quần dù xám, Quần jogger , Quần unisex, Quần Basic'),

--------------------------------------------------------quan lot soi tu  nhien-------------------------------------------------------------------------------------------------------------------------------
(20, N'Quần Lót Nam Tam Giác Bamboo Mềm Mại Kháng Khuẩn #Y2010 079 Combo 3 Đen', 'quan41.png', 243000, 4,
N'',
N'Quần lót Boxer sợi tre mềm mại, thoáng mát, co giãn 4 chiều, kháng khuẩn. Combo 3 chiếc tiết kiệm chi phí.

1. Kiểu sản phẩm: Quần lót Boxer ngắn.
2. Ưu điểm:
● Combo tiết kiệm: Mua 3 chiếc với giá ưu đãi, tiết kiệm hơn khi mua lẻ.
● Vải sợi tre cao cấp: Mang đến cảm giác mềm mại, thoáng mát.
● Co giãn 4 chiều: Tăng cường sự thoải mái khi vận động.
● Hạn chế kích ứng da: An toàn cho làn da nhạy cảm.
3. Chất liệu: 95% bamboo 5% spandex, kháng khuẩn hạn chế kích ứng da và thân thiện môi trường.
4. Kỹ thuật: Thiết kế ôm sát cơ thể vừa phải, tạo cảm giác thoải mái và tự tin.
5. Phù hợp với ai: Sản phẩm phù hợp cho những người hoạt động nhiều, cần sự thoải mái tối đa, người có làn da nhạy cảm, những người quan tâm đến sức khỏe và môi trường.
6. Thuộc Bộ Sưu Tập: #Y2010
7. Các tên thường gọi hoặc tìm kiếm: Quần lót nam sợi tre, boxer nam kháng khuẩn, đồ lót nam cao cấp, quần lót nam thoáng mát.'),

(20, N'Quần Lót Nam Tam Giác Bamboo Mềm Mại Kháng Khuẩn #Y2010 079 Combo 3 Xám Đậm', 'quan42.png', 243000, 4,
N'',
N'Quần lót Boxer sợi tre mềm mại, thoáng mát, co giãn 4 chiều, kháng khuẩn. Combo 3 chiếc tiết kiệm chi phí.

1. Kiểu sản phẩm: Quần lót Boxer ngắn.
2. Ưu điểm:
● Combo tiết kiệm: Mua 3 chiếc với giá ưu đãi, tiết kiệm hơn khi mua lẻ.
● Vải sợi tre cao cấp: Mang đến cảm giác mềm mại, thoáng mát.
● Co giãn 4 chiều: Tăng cường sự thoải mái khi vận động.
● Hạn chế kích ứng da: An toàn cho làn da nhạy cảm.
3. Chất liệu: 95% bamboo 5% spandex, kháng khuẩn hạn chế kích ứng da và thân thiện môi trường.
4. Kỹ thuật: Thiết kế ôm sát cơ thể vừa phải, tạo cảm giác thoải mái và tự tin.
5. Phù hợp với ai: Sản phẩm phù hợp cho những người hoạt động nhiều, cần sự thoải mái tối đa, người có làn da nhạy cảm, những người quan tâm đến sức khỏe và môi trường.
6. Thuộc Bộ Sưu Tập: #Y2010
7. Các tên thường gọi hoặc tìm kiếm: Quần lót nam sợi tre, boxer nam kháng khuẩn, đồ lót nam cao cấp, quần lót nam thoáng mát.'),

(20, N'Quần Lót Nam Boxer Bamboo Mềm Mại Kháng Khuẩn #Y2010 080 Đen', 'quan43.png', 89100, 4,
N'',
N'Quần lót Boxer sợi tre mềm mại, thoáng mát, co giãn 4 chiều, kháng khuẩn.

1. Kiểu sản phẩm: Quần lót Boxer ngắn..
2. Ưu điểm: Mang đến cảm giác mềm mại, thoáng mát, tăng cường sự thoải mái khi vận động.
3. Chất liệu: 95% bamboo 5% spandex, kháng khuẩn hạn chế kích ứng da và thân thiện môi trường.
4. Kỹ thuật: Thiết kế ôm sát cơ thể vừa phải, tạo cảm giác thoải mái và tự tin.
5. Phù hợp với ai: Sản phẩm phù hợp cho những người hoạt động nhiều, cần sự thoải mái tối đa, người có làn da nhạy cảm, những người quan tâm đến sức khỏe và môi trường.
6. Thuộc Bộ Sưu Tập: #Y2010
7. Các tên thường gọi hoặc tìm kiếm: Quần lót nam sợi tre, boxer nam kháng khuẩn, đồ lót nam cao cấp, quần lót nam thoáng mát.'),

(20, N'Quần Lót Nam Tam Giác Bamboo Mềm Mại Kháng Khuẩn #Y2010 083 Đen', 'quan43.png', 87300, 4,
N'',
N'Quần lót tam giác sợi tre mềm mại, thoáng mát, co giãn 4 chiều, kháng khuẩn.

1. Kiểu sản phẩm: Quần lót Hip Brief dáng vừa.
2. Ưu điểm:
○ Sản phẩm mềm mát vô cùng thoải mái cho người thích vận động.
○ Giảm nguy cơ gây dị ứng cho làn da.
○ Co giãn 4 chiều, ôm sát cơ thể, không gây cảm giác bí bách.
3. Chất liệu: Vải Bamboo với thành phần 95% bamboo, 5% spandex là một loại chất liệu thân thiện với người dùng lẫn môi trường, có độ co giãn đàn hồi tốt.
4. Kỹ thuật: Thiết kế đơn giản và màu sắc trung tính, dệt logo thương hiệu chìm ngay giữa bản lưng làm sản phẩm thêm hài hòa.
5. Phù hợp với ai: Đặc biệt phù hợp cho những người có làn da nhạy cảm và đang tìm kiếm sự thoải mái. Người bận rộn không cần quá nhiều thời gian chọn lựa để sử dụng hàng ngày.
6. Thuộc Bộ Sưu Tập: #Y2010, một bộ sưu tập ấn tượng và phong phú về logo của thương hiệu. Các logo được thiết kế và biến tấu theo nhiều ý tưởng khác nhau.
7. Các tên thường gọi hoặc tìm kiếm: Quần lót nam basic, quần lót nam đơn giản, quần lót nam thời trang, quần lót nam màu tối.'),

(20, N'Quần Lót Nam Boxer Bamboo Mềm Mại Kháng Khuẩn #Y2010 080 Xám Đậm', 'quan44.png', 89100, 4,
N'',
N'Quần lót Boxer sợi tre mềm mại, thoáng mát, co giãn 4 chiều, kháng khuẩn.

1. Kiểu sản phẩm: Quần lót Boxer ngắn..
2. Ưu điểm: Mang đến cảm giác mềm mại, thoáng mát, tăng cường sự thoải mái khi vận động.
3. Chất liệu: 95% bamboo 5% spandex, kháng khuẩn hạn chế kích ứng da và thân thiện môi trường.
4. Kỹ thuật: Thiết kế ôm sát cơ thể vừa phải, tạo cảm giác thoải mái và tự tin.
5. Phù hợp với ai: Sản phẩm phù hợp cho những người hoạt động nhiều, cần sự thoải mái tối đa, người có làn da nhạy cảm, những người quan tâm đến sức khỏe và môi trường.
6. Thuộc Bộ Sưu Tập: #Y2010
7. Các tên thường gọi hoặc tìm kiếm: Quần lót nam sợi tre, boxer nam kháng khuẩn, đồ lót nam cao cấp, quần lót nam thoáng mát.'),

(20, N'Quần Lót Nam Tam Giác Bamboo Mềm Mại Kháng Khuẩn #Y2010 083 Xám Đậm', 'quan45.png', 87300, 4,
N'',
N'Quần lót tam giác sợi tre mềm mại, thoáng mát, co giãn 4 chiều, kháng khuẩn.

1. Kiểu sản phẩm: Quần lót Hip Brief dáng vừa.
2. Ưu điểm:
○ Sản phẩm mềm mát vô cùng thoải mái cho người thích vận động.
○ Giảm nguy cơ gây dị ứng cho làn da.
○ Co giãn 4 chiều, ôm sát cơ thể, không gây cảm giác bí bách.
3. Chất liệu: Vải Bamboo với thành phần 95% bamboo, 5% spandex là một loại chất liệu thân thiện với người dùng lẫn môi trường, có độ co giãn đàn hồi tốt.
4. Kỹ thuật: Thiết kế đơn giản và màu sắc trung tính, dệt logo thương hiệu chìm ngay giữa bản lưng làm sản phẩm thêm hài hòa.
5. Phù hợp với ai: Đặc biệt phù hợp cho những người có làn da nhạy cảm và đang tìm kiếm sự thoải mái. Người bận rộn không cần quá nhiều thời gian chọn lựa để sử dụng hàng ngày.
6. Thuộc Bộ Sưu Tập: #Y2010, một bộ sưu tập ấn tượng và phong phú về logo của thương hiệu. Các logo được thiết kế và biến tấu theo nhiều ý tưởng khác nhau.
7. Các tên thường gọi hoặc tìm kiếm: Quần lót nam basic, quần lót nam đơn giản, quần lót nam thời trang, quần lót nam màu tối.'),

(20, N'Quần Lót Nam Tam Giác Bamboo Mềm Mại Kháng Khuẩn #Y2010 084 Combo 3 Đen', 'quan46.png', 249300, 4,
N'',
N'Quần lót tam giác sợi tre mềm mại, thoáng mát, co giãn 4 chiều, kháng khuẩn. Combo 3 chiếc tiết kiệm chi phí.

1. Kiểu sản phẩm: Quần Lót Nam Hip Brief, dáng tam giác vừa vặn..
2. Ưu điểm nổi bật:
● Kiểm soát mùi hiệu quả: Nhờ chất liệu sợi tre có khả năng kháng khuẩn tự nhiên, giúp bạn luôn tự tin suốt cả ngày.
● Mềm mại, thoáng mát: Chất liệu sợi tre mềm mịn, thoát ẩm tốt, mang đến cảm giác dễ chịu.
● Co giãn tốt: Nhờ sự kết hợp của sợi tre và spandex, quần lót co giãn 4 chiều, thoải mái vận động.
● Đóng gói combo giúp tiết kiệm hiệu quả và đa dạng màu sắc.
3. Chất liệu: Sợi tre tự nhiên 95% bamboo 5%spandex, thân thiện với môi trường và làn da, đặc biệt là da nhạy cảm.
4. Kỹ thuật: Công nghệ dệt kim hiện đại: Tạo ra sản phẩm với đường may tinh tế, bền đẹp, hạn chế tối đa sự ma sát gây khó chịu.
5. Phù hợp với ai:
● Nam giới: Đặc biệt phù hợp với những người hoạt động nhiều, cần sự thoải mái và thoáng mát.
● Người có làn da nhạy cảm: Chất liệu sợi tre dịu nhẹ, giảm thiểu nguy cơ kích ứng da.
6. Thuộc Bộ Sưu Tập:
● Y2010: Đây là một bộ sưu tập nổi bật của thương hiệu, tập trung vào sự thoải mái và chất lượng.
7. Các tên thường gọi hoặc tìm kiếm: quần lót nam sợi tre, quần lót hip brief, quần lót nam khử mùi, quần lót nam combo, quần lót nam mềm mát.'),

(20, N'Quần Lót Nam Tam Giác Bamboo Mềm Mại Kháng Khuẩn #Y2010 084 Combo 3 Xám Đậm', 'quan47.png', 249300, 4,
N'',
N'Quần lót tam giác sợi tre mềm mại, thoáng mát, co giãn 4 chiều, kháng khuẩn. Combo 3 chiếc tiết kiệm chi phí.

1. Kiểu sản phẩm: Quần Lót Nam Hip Brief, dáng tam giác vừa vặn..
2. Ưu điểm nổi bật:
● Kiểm soát mùi hiệu quả: Nhờ chất liệu sợi tre có khả năng kháng khuẩn tự nhiên, giúp bạn luôn tự tin suốt cả ngày.
● Mềm mại, thoáng mát: Chất liệu sợi tre mềm mịn, thoát ẩm tốt, mang đến cảm giác dễ chịu.
● Co giãn tốt: Nhờ sự kết hợp của sợi tre và spandex, quần lót co giãn 4 chiều, thoải mái vận động.
● Đóng gói combo giúp tiết kiệm hiệu quả và đa dạng màu sắc.
3. Chất liệu: Sợi tre tự nhiên 95% bamboo 5%spandex, thân thiện với môi trường và làn da, đặc biệt là da nhạy cảm.
4. Kỹ thuật: Công nghệ dệt kim hiện đại: Tạo ra sản phẩm với đường may tinh tế, bền đẹp, hạn chế tối đa sự ma sát gây khó chịu.
5. Phù hợp với ai:
● Nam giới: Đặc biệt phù hợp với những người hoạt động nhiều, cần sự thoải mái và thoáng mát.
● Người có làn da nhạy cảm: Chất liệu sợi tre dịu nhẹ, giảm thiểu nguy cơ kích ứng da.
6. Thuộc Bộ Sưu Tập:
● Y2010: Đây là một bộ sưu tập nổi bật của thương hiệu, tập trung vào sự thoải mái và chất lượng.
7. Các tên thường gọi hoặc tìm kiếm: quần lót nam sợi tre, quần lót hip brief, quần lót nam khử mùi, quần lót nam combo, quần lót nam mềm mát.'),

(20, N'Quần Lót Nam Tam Giác Bamboo Mềm Mại Kháng Khuẩn #Y2010 083 Đen', 'quan48.png', 87300, 4,
N'',
N'Quần lót tam giác sợi tre mềm mại, thoáng mát, co giãn 4 chiều, kháng khuẩn.

1. Kiểu sản phẩm: Quần lót Hip Brief dáng vừa.
2. Ưu điểm:
○ Sản phẩm mềm mát vô cùng thoải mái cho người thích vận động.
○ Giảm nguy cơ gây dị ứng cho làn da.
○ Co giãn 4 chiều, ôm sát cơ thể, không gây cảm giác bí bách.
3. Chất liệu: Vải Bamboo với thành phần 95% bamboo, 5% spandex là một loại chất liệu thân thiện với người dùng lẫn môi trường, có độ co giãn đàn hồi tốt.
4. Kỹ thuật: Thiết kế đơn giản và màu sắc trung tính, dệt logo thương hiệu chìm ngay giữa bản lưng làm sản phẩm thêm hài hòa.
5. Phù hợp với ai: Đặc biệt phù hợp cho những người có làn da nhạy cảm và đang tìm kiếm sự thoải mái. Người bận rộn không cần quá nhiều thời gian chọn lựa để sử dụng hàng ngày.
6. Thuộc Bộ Sưu Tập: #Y2010, một bộ sưu tập ấn tượng và phong phú về logo của thương hiệu. Các logo được thiết kế và biến tấu theo nhiều ý tưởng khác nhau.
7. Các tên thường gọi hoặc tìm kiếm: Quần lót nam basic, quần lót nam đơn giản, quần lót nam thời trang, quần lót nam màu tối.'),

(20, N'Quần Lót Nam Boxer Bamboo Mềm Mại Kháng Khuẩn #Y2010 080 Xám Đậm', 'quan49.png', 89100, 4,
N'',
N'Quần lót Boxer sợi tre mềm mại, thoáng mát, co giãn 4 chiều, kháng khuẩn.

1. Kiểu sản phẩm: Quần lót Boxer ngắn..
2. Ưu điểm: Mang đến cảm giác mềm mại, thoáng mát, tăng cường sự thoải mái khi vận động.
3. Chất liệu: 95% bamboo 5% spandex, kháng khuẩn hạn chế kích ứng da và thân thiện môi trường.
4. Kỹ thuật: Thiết kế ôm sát cơ thể vừa phải, tạo cảm giác thoải mái và tự tin.
5. Phù hợp với ai: Sản phẩm phù hợp cho những người hoạt động nhiều, cần sự thoải mái tối đa, người có làn da nhạy cảm, những người quan tâm đến sức khỏe và môi trường.
6. Thuộc Bộ Sưu Tập: #Y2010
7. Các tên thường gọi hoặc tìm kiếm: Quần lót nam sợi tre, boxer nam kháng khuẩn, đồ lót nam cao cấp, quần lót nam thoáng mát.'),

(20, N'Quần Lót Nam Boxer Bamboo Mềm Mại Kháng Khuẩn #Y2010 080 Đen', 'quan50.png', 89100, 4,
N'',
N'Quần lót Boxer sợi tre mềm mại, thoáng mát, co giãn 4 chiều, kháng khuẩn.

1. Kiểu sản phẩm: Quần lót Boxer ngắn..
2. Ưu điểm: Mang đến cảm giác mềm mại, thoáng mát, tăng cường sự thoải mái khi vận động.
3. Chất liệu: 95% bamboo 5% spandex, kháng khuẩn hạn chế kích ứng da và thân thiện môi trường.
4. Kỹ thuật: Thiết kế ôm sát cơ thể vừa phải, tạo cảm giác thoải mái và tự tin.
5. Phù hợp với ai: Sản phẩm phù hợp cho những người hoạt động nhiều, cần sự thoải mái tối đa, người có làn da nhạy cảm, những người quan tâm đến sức khỏe và môi trường.
6. Thuộc Bộ Sưu Tập: #Y2010
7. Các tên thường gọi hoặc tìm kiếm: Quần lót nam sợi tre, boxer nam kháng khuẩn, đồ lót nam cao cấp, quần lót nam thoáng mát.'),
--------------------------------------------------------quan lot seamless-------------------------------------------------------------------------------------------------------------------------------
(21, N'Quần Lót Nam Boxer Seamless Mềm Siêu Co Giãn #Y2010 078 Combo 3 Free Color', 'quan51.png', 243000, 4,
N'',
N'Quần lót Boxer Seamless, giảm ma sát, co giãn 4 chiều, thoát hơi nhanh, mềm mượt, combo 3 tiết kiệm chi phí.

1. Kiểu sản phẩm: Quần lót nam Boxer ngắn (Low Rise Trunk)
2. Ưu điểm:
● Chất liệu co giãn 4 chiều, ôm sát cơ thể, tạo cảm giác thoải mái khi vận động.
● Sản phẩm liền mạch, hạn chế tối đa đường may, giảm ma sát, không gây kích ứng da.
● Khả năng thoát ẩm tốt giúp bạn luôn khô thoáng, tự tin trong mọi hoạt động.
● Chất liệu cao cấp, bền màu, không bị nhàu sau nhiều lần giặt.
● Combo 3 với nhiều màu sắc khác nhau, giúp bạn thay đổi phong cách mỗi ngày với chi phí rẻ hơn.
3. Chất liệu: 90% Polyamide, 10% Spandex.
4. Kỹ thuật:
● Công nghệ Seamless
● Cắt may chuẩn xác tạo form quần ôm sát, tôn dáng.
5. Phù hợp với ai: Mọi đối tượng là nam giới.
6. Thuộc Bộ sưu tập: Bộ sưu tập #Y2010 được thiết kế với phong cách hiện đại, trẻ trung, phù hợp với phái nam.
7. Các tên thường gọi hoặc tìm kiếm: Quần lót nam, Quần lót boxer ngắn, Quần lót co giãn,
Quần lót seamless, Quần lót Y2010 Poly M2, Underwear co giãn,
Underwear Combo 3,..'),

(21, N'Quần lót nam Tam Giác Seamless Mềm Siêu Co Giãn #Y2010 082 Combo 3 Free Color', 'quan52.png', 243000, 4,
N'',
N'Quần lót tam giác Seamless, giảm ma sát, co giãn 4 chiều, thoát hơi nhanh, mềm mượt . Combo 3 chiếc tiết kiệm chi phí.

1. Kiểu sản phẩm: Quần lót Hip Brief kiểu dáng tam giác.
2. Ưu điểm:
○ Siêu co giãn: Sản phẩm có khả năng co giãn 4 chiều.
○ Form dáng vừa vặn, ôm sát cơ thể.
○ Khả năng chống ma sát cao: Thích hợp cho các hoạt động vận động mạnh.
○ Thân thiện và không gây kích ứng cho da.
○ Đóng gói combo giúp mua sắm thêm đa dạng và tiết kiệm chi phí.
3. Chất liệu: Sản phẩm được làm từ Polyamide, một loại sợi nhân tạo có tính năng co giãn và thoáng khí. Bề mặt vải êm mượt khi chạm vào.
4. Kỹ thuật: Công nghệ Seamless: Quần lót liền mạch, tối thiểu đường may, tạo cảm giác thoải mái khi mặc. Dệt logo thương hiệu trên lưng tạo điểm nhấn 1 cách độc đáo.
5. Phù hợp với ai:
○ Quần lót này phù hợp với các quý ông thích sự thoải mái và mạnh mẽ.
○ Người đi lại, vận động nhiều.
○ Đa dạng độ tuổi sử dụng.
6. Thuộc Bộ Sưu Tập:
○ Sản phẩm thuộc bộ sưu tập #Y2010, thỏa sức sáng tạo, đáp ứng mọi nhu cầu của bạn.
7. Các tên thường gọi hoặc tìm kiếm: quần lót nam combo, quần lót nam thời trang, quần lót nam cá tính.'),

(21, N'Quần lót nam Tam Giác Seamless Mềm Siêu Co Giãn #Y2010 081 Đen', 'quan53.png', 89100, 4,
N'',
N'Quần lót tam giác Seamless, giảm ma sát, co giãn 4 chiều, thoát hơi nhanh, mềm mượt.

1. Kiểu sản phẩm: Quần lót Hip Brief kiểu dáng tam giác.
2. Ưu điểm:
○ Siêu co giãn: có khả năng co giãn 4 chiều, ôm sát cơ thể.
○ Khả năng chống ma sát cao: Thích hợp cho các hoạt động vận động mạnh.
○ Mềm mượt, thân thiện với da và không gây kích ứng.
3. Chất liệu: Sản phẩm được làm từ Polyamide, một loại sợi nhân tạo có tính năng co giãn và thoáng khí. Pha trộn sợi Spandex giúp sản phẩm có độ đàn hồi cao.
4. Kỹ thuật: Công nghệ Seamless: Quần lót liền mạch, tối thiểu đường may, tạo cảm giác thoải mái khi mặc. Ngoài ra còn giúp sản phẩm mỏng nhẹ.
5. Phù hợp với ai:
○ Quần lót này phù hợp với các quý ông thích sự thoải mái, đặc biệt là trong vận động ngoài trời..
○ Phù hợp với người hoạt động cả ngày dài cần sự khô thoáng, không bí bách.
6. Sản phẩm thuộc bộ sưu tập: #Y2010, nơi hội tụ phong cách thời trang đa dạng, nhiều màu sắc và nhiều cấp độ cá tính.
7. Các tên thường gọi hoặc tìm kiếm: quần lót nam khô thoáng, quần lót nam thời trang, quần lót nam mỏng nhẹ, quần su nam, quần lót giá rẻ, quần lót đen.'),

(21, N'Quần lót nam Tam Giác Seamless Mềm Siêu Co Giãn #Y2010 081 Xám Nhạt', 'quan54.png', 89100, 4,
N'',
N'Quần lót tam giác Seamless, giảm ma sát, co giãn 4 chiều, thoát hơi nhanh, mềm mượt.

1. Kiểu sản phẩm: Quần lót Hip Brief kiểu dáng tam giác.
2. Ưu điểm:
○ Siêu co giãn: có khả năng co giãn 4 chiều, ôm sát cơ thể.
○ Khả năng chống ma sát cao: Thích hợp cho các hoạt động vận động mạnh.
○ Mềm mượt, thân thiện với da và không gây kích ứng.
3. Chất liệu: Sản phẩm được làm từ Polyamide, một loại sợi nhân tạo có tính năng co giãn và thoáng khí. Pha trộn sợi Spandex giúp sản phẩm có độ đàn hồi cao.
4. Kỹ thuật: Công nghệ Seamless: Quần lót liền mạch, tối thiểu đường may, tạo cảm giác thoải mái khi mặc. Ngoài ra còn giúp sản phẩm mỏng nhẹ.
5. Phù hợp với ai:
○ Quần lót này phù hợp với các quý ông thích sự thoải mái, đặc biệt là trong vận động ngoài trời..
○ Phù hợp với người hoạt động cả ngày dài cần sự khô thoáng, không bí bách.
6. Sản phẩm thuộc bộ sưu tập: #Y2010, nơi hội tụ phong cách thời trang đa dạng, nhiều màu sắc và nhiều cấp độ cá tính.
7. Các tên thường gọi hoặc tìm kiếm: quần lót nam khô thoáng, quần lót nam thời trang, quần lót nam mỏng nhẹ, quần su nam, quần lót giá rẻ, quần lót đen.'),

(21, N'Quần Lót Nam Boxer Seamless Mềm Siêu Co Giãn #Y2010 075 Đen', 'quan55.png', 89100, 4,
N'',
N'Quần lót Boxer Seamless, giảm ma sát, co giãn 4 chiều, thoát hơi nhanh, mềm mượt.

1. Kiểu sản phẩm: Quần lót nam boxer, tiêu chuẩn, kiểu dáng truyền thống.
2. Ưu điểm:
● Siêu co giãn, ôm sát: Nhấn mạnh tính năng chính của sản phẩm.
● Thoải mái, không gây kích ứng: Nhờ chất liệu mềm mịn và công nghệ seamless.
● Thoát ẩm nhanh chóng: Giúp cơ thể luôn khô thoáng.
● Bền màu, giữ form: Nhờ chất liệu cao cấp và công nghệ sản xuất hiện đại.
3. Chất liệu: 90% Polyamide 10% Spandex, sợi nhân tạo cao cấp dệt nên sản phẩm với bề mặt mềm mát, độ bền cao, thân thiện cho da khi sử dụng.
4. Kỹ thuật: Seamless là công nghệ sản xuất liền mạch, không đường may, giúp giảm thiểu vết hằn trên da khi mặc vận động.
5. Phù hợp với ai:
● Những người yêu thích thể thao, thường xuyên vận động.
● Người thích sự co giãn nhưng thoải mái, không bị gò bó khi mặc..
● Người quan tâm đến thời trang: chuộng kiểu dáng đơn giản nhưng lịch lãm.
6. Thuộc Bộ Sưu Tập nào: #Y2010 đơn giản mà tinh tế, đôi khi tối giản nhất lại là lúc chúng ta thấy thật sự đủ.
7. Các tên thường gọi hoặc tìm kiếm: Quần lót nam thời trang, Quần lót nam Seamless, Quần lót Polyamide, quần ngủ, quần lót nam kín đáo, quần lót nam thể thao.'),

(21, N'Quần Lót Nam Boxer Seamless Mềm Siêu Co Giãn #Y2010 075 Xám', 'quan56.png', 89100, 4,
N'',
N'Quần lót Boxer Seamless, giảm ma sát, co giãn 4 chiều, thoát hơi nhanh, mềm mượt.

1. Kiểu sản phẩm: Quần lót nam boxer, tiêu chuẩn, kiểu dáng truyền thống.
2. Ưu điểm:
● Siêu co giãn, ôm sát: Nhấn mạnh tính năng chính của sản phẩm.
● Thoải mái, không gây kích ứng: Nhờ chất liệu mềm mịn và công nghệ seamless.
● Thoát ẩm nhanh chóng: Giúp cơ thể luôn khô thoáng.
● Bền màu, giữ form: Nhờ chất liệu cao cấp và công nghệ sản xuất hiện đại.
3. Chất liệu: 90% Polyamide 10% Spandex, sợi nhân tạo cao cấp dệt nên sản phẩm với bề mặt mềm mát, độ bền cao, thân thiện cho da khi sử dụng.
4. Kỹ thuật: Seamless là công nghệ sản xuất liền mạch, không đường may, giúp giảm thiểu vết hằn trên da khi mặc vận động.
5. Phù hợp với ai:
● Những người yêu thích thể thao, thường xuyên vận động.
● Người thích sự co giãn nhưng thoải mái, không bị gò bó khi mặc..
● Người quan tâm đến thời trang: chuộng kiểu dáng đơn giản nhưng lịch lãm.
6. Thuộc Bộ Sưu Tập nào: #Y2010 đơn giản mà tinh tế, đôi khi tối giản nhất lại là lúc chúng ta thấy thật sự đủ.
7. Các tên thường gọi hoặc tìm kiếm: Quần lót nam thời trang, Quần lót nam Seamless, Quần lót Polyamide, quần ngủ, quần lót nam kín đáo, quần lót nam thể thao.'),

(21, N'Quần lót nam Tam Giác Seamless Mềm Siêu Co Giãn #Y2010 081 Xám Đậm', 'quan57.png', 89100, 4,
N'',
N'Quần lót tam giác Seamless, giảm ma sát, co giãn 4 chiều, thoát hơi nhanh, mềm mượt.

1. Kiểu sản phẩm: Quần lót Hip Brief kiểu dáng tam giác.
2. Ưu điểm:
○ Siêu co giãn: có khả năng co giãn 4 chiều, ôm sát cơ thể.
○ Khả năng chống ma sát cao: Thích hợp cho các hoạt động vận động mạnh.
○ Mềm mượt, thân thiện với da và không gây kích ứng.
3. Chất liệu: Sản phẩm được làm từ Polyamide, một loại sợi nhân tạo có tính năng co giãn và thoáng khí. Pha trộn sợi Spandex giúp sản phẩm có độ đàn hồi cao.
4. Kỹ thuật: Công nghệ Seamless: Quần lót liền mạch, tối thiểu đường may, tạo cảm giác thoải mái khi mặc. Ngoài ra còn giúp sản phẩm mỏng nhẹ.
5. Phù hợp với ai:
○ Quần lót này phù hợp với các quý ông thích sự thoải mái, đặc biệt là trong vận động ngoài trời..
○ Phù hợp với người hoạt động cả ngày dài cần sự khô thoáng, không bí bách.
6. Sản phẩm thuộc bộ sưu tập: #Y2010, nơi hội tụ phong cách thời trang đa dạng, nhiều màu sắc và nhiều cấp độ cá tính.
7. Các tên thường gọi hoặc tìm kiếm: quần lót nam khô thoáng, quần lót nam thời trang, quần lót nam mỏng nhẹ, quần su nam, quần lót giá rẻ, quần lót đen.'),

(21, N'Quần Lót Nam Boxer Seamless Mềm Siêu Co Giãn #Y2010 075 Xám Nhạt', 'quan58.png', 89100, 4,
N'',
N'Quần lót Boxer Seamless, giảm ma sát, co giãn 4 chiều, thoát hơi nhanh, mềm mượt.

1. Kiểu sản phẩm: Quần lót nam boxer, tiêu chuẩn, kiểu dáng truyền thống.
2. Ưu điểm:
● Siêu co giãn, ôm sát: Nhấn mạnh tính năng chính của sản phẩm.
● Thoải mái, không gây kích ứng: Nhờ chất liệu mềm mịn và công nghệ seamless.
● Thoát ẩm nhanh chóng: Giúp cơ thể luôn khô thoáng.
● Bền màu, giữ form: Nhờ chất liệu cao cấp và công nghệ sản xuất hiện đại.
3. Chất liệu: 90% Polyamide 10% Spandex, sợi nhân tạo cao cấp dệt nên sản phẩm với bề mặt mềm mát, độ bền cao, thân thiện cho da khi sử dụng.
4. Kỹ thuật: Seamless là công nghệ sản xuất liền mạch, không đường may, giúp giảm thiểu vết hằn trên da khi mặc vận động.
5. Phù hợp với ai:
● Những người yêu thích thể thao, thường xuyên vận động.
● Người thích sự co giãn nhưng thoải mái, không bị gò bó khi mặc..
● Người quan tâm đến thời trang: chuộng kiểu dáng đơn giản nhưng lịch lãm.
6. Thuộc Bộ Sưu Tập nào: #Y2010 đơn giản mà tinh tế, đôi khi tối giản nhất lại là lúc chúng ta thấy thật sự đủ.
7. Các tên thường gọi hoặc tìm kiếm: Quần lót nam thời trang, Quần lót nam Seamless, Quần lót Polyamide, quần ngủ, quần lót nam kín đáo, quần lót nam thể thao.'),

(21, N'Quần Lót Nam Boxer Seamless Mềm Siêu Co Giãn Beginner 082 Đen', 'quan59.png', 87300, 4,
N'',
N'Quần lót Boxer Seamless, giảm ma sát, co giãn 4 chiều, thoát hơi nhanh, mềm mượt.

1. Kiểu sản phẩm: Quần lót loại Boxer Brief (kiểu dáng ôm sát), dáng dài.
2. Ưu điểm:
○ Siêu co giãn: Co giãn 4 chiều, ôm sát cơ thể, khả năng chống ma sát cao kể cả khi vận động mạnh.
○Thoát hơi tốt: Giúp bạn luôn cảm thấy thoải mái.
○ Chất liệu Polyamide: Mềm mượt và thân thiện với da.
○ Đóng gói combo nhiều màu tiện lợi khi lựa chọn.
3. Chất liệu: 95% Polyamide và 5% Spandex.
4. Kỹ thuật: Công nghệ dệt Seamless tạo ra sản phẩm liền mạch, giảm thiểu đường may và không bị cấn khi mặc. Dệt logo thương hiệu phần giữa lưng, tạo điểm nhấn tinh tế cho người mặc.
5. Phù hợp với ai: Dành cho những người yêu thích kiểu dáng ôm sát, đặc biệt là trong vận động thời gian dài. Cũng có thể dùng mặc ngủ.
6. Thuộc Bộ Sưu Tập: Beginner, một bộ sưu tập mang phong cách đơn giản nhưng đầy tinh tế được vận dụng vào các hoạt động thể dục, thể thao và gym. Được ưa chuộng vì tính thẩm mỹ và chất lượng cao.
7. Các tên thường gọi hoặc tìm kiếm: Quần lót Boxer Brief, Quần lót Seamless, Quần lót Polyamide, quần ngủ, quần lót nam kín đáo.'),

(21, N'Quần Lót Nam Boxer Seamless Mềm Siêu Co Giãn Beginner 083 Combo 3 Free Color', 'quan60.png', 249300, 4,
N'',
N'Quần lót Boxer Seamless, giảm ma sát, co giãn 4 chiều, thoát hơi nhanh, mềm mượt, combo 3 tiết kiệm chi phí.

1. Kiểu sản phẩm: Quần lót loại Boxer Brief (kiểu dáng ôm sát), dáng dài.
2. Ưu điểm:
○ Siêu co giãn: Co giãn 4 chiều, ôm sát cơ thể, khả năng chống ma sát cao kể cả khi vận động mạnh.
○Thoát hơi tốt: Giúp bạn luôn cảm thấy thoải mái.
○ Chất liệu Polyamide: Mềm mượt và thân thiện với da.
○ Đóng gói combo nhiều màu tiện lợi khi lựa chọn.
3. Chất liệu: 95% Polyamide và 5% Spandex.
4. Kỹ thuật: Công nghệ dệt Seamless tạo ra sản phẩm liền mạch, giảm thiểu đường may và không bị cấn khi mặc. Dệt logo thương hiệu phần giữa lưng, tạo điểm nhấn tinh tế cho người mặc.
5. Phù hợp với ai: Dành cho những người yêu thích kiểu dáng ôm sát, đặc biệt là trong vận động thời gian dài. Cũng có thể dùng mặc ngủ.
6. Thuộc Bộ Sưu Tập: Beginner, một bộ sưu tập mang phong cách đơn giản nhưng đầy tinh tế được vận dụng vào các hoạt động thể dục, thể thao và gym. Được ưa chuộng vì tính thẩm mỹ và chất lượng cao.
7. Các tên thường gọi hoặc tìm kiếm: Quần lót Boxer Brief, Quần lót Seamless, Quần lót Polyamide, quần ngủ, quần lót nam kín đáo.')

insert into HinhAnh(MaSP, TenHinh) values
----------------------------------------------------------------ao------------------------------------------------------------------------
(1, 'ao1.png'),
(1, 'ao1_1.png'),
(1, 'ao1_2.png'),
(1, 'ao1_3.png'),
(1, 'ao1_4.png'),
(1, 'ao1_5.png'),

(2, 'ao2.png'),
(2, 'ao2_1.png'),
(2, 'ao2_2.png'),
(2, 'ao2_3.png'),
(2, 'ao2_4.png'),
(2, 'ao2_5.png'),

(3, 'ao3.png'),
(3, 'ao3_1.png'),
(3, 'ao3_2.png'),
(3, 'ao3_3.png'),
(3, 'ao3_4.png'),
(3, 'ao3_5.png'),

(4, 'ao4.png'),
(4, 'ao4_1.png'),
(4, 'ao4_2.png'),
(4, 'ao4_3.png'),
(4, 'ao4_4.png'),
(4, 'ao4_5.png'),

(5, 'ao5.png'),
(5, 'ao5_1.png'),
(5, 'ao5_2.png'),
(5, 'ao5_3.png'),
(5, 'ao5_4.png'),
(5, 'ao5_5.png'),

(6, 'ao6.png'),
(6, 'ao6_1.png'),
(6, 'ao6_2.png'),
(6, 'ao6_3.png'),
(6, 'ao6_4.png'),
(6, 'ao6_5.png'),

(7, 'ao7.png'),
(7, 'ao7_1.png'),
(7, 'ao7_2.png'),
(7, 'ao7_3.png'),
(7, 'ao7_4.png'),
(7, 'ao7_5.png'),

(8, 'ao8.png'),
(8, 'ao8_1.png'),
(8, 'ao8_2.png'),
(8, 'ao8_3.png'),
(8, 'ao8_4.png'),
(8, 'ao8_5.png'),

(9, 'ao9.png'),
(9, 'ao9_1.png'),
(9, 'ao9_2.png'),
(9, 'ao9_3.png'),
(9, 'ao9_4.png'),
(9, 'ao9_5.png'),

(10, 'ao10.png'),
(10, 'ao10_1.png'),
(10, 'ao10_2.png'),
(10, 'ao10_3.png'),
(10, 'ao10_4.png'),
(10, 'ao10_5.png'),

(11, 'ao11.png'),
(11, 'ao11_1.png'),
(11, 'ao11_2.png'),
(11, 'ao11_3.png'),
(11, 'ao11_4.png'),
(11, 'ao11_5.png'),

(12, 'ao12.png'),
(12, 'ao12_1.png'),
(12, 'ao12_2.png'),
(12, 'ao12_3.png'),
(12, 'ao12_4.png'),
(12, 'ao12_5.png'),

(13, 'ao13.png'),
(13, 'ao13_1.png'),
(13, 'ao13_2.png'),
(13, 'ao13_3.png'),
(13, 'ao13_4.png'),
(13, 'ao13_5.png'),

(14, 'ao14.png'),
(14, 'ao14_1.png'),
(14, 'ao14_2.png'),
(14, 'ao14_3.png'),
(14, 'ao14_4.png'),
(14, 'ao14_5.png'),

(15, 'ao15.png'),
(15, 'ao15_1.png'),
(15, 'ao15_2.png'),
(15, 'ao15_3.png'),
(15, 'ao15_4.png'),
(15, 'ao15_5.png'),

(16, 'ao16.png'),
(16, 'ao16_1.png'),
(16, 'ao16_2.png'),
(16, 'ao16_3.png'),
(16, 'ao16_4.png'),
(16, 'ao16_5.png'),

(17, 'ao17.png'),
(17, 'ao17_1.png'),
(17, 'ao17_2.png'),
(17, 'ao17_3.png'),
(17, 'ao17_4.png'),
(17, 'ao17_5.png'),

(18, 'ao18.png'),
(18, 'ao18_1.png'),
(18, 'ao18_2.png'),
(18, 'ao18_3.png'),
(18, 'ao18_4.png'),
(18, 'ao18_5.png'),

(19, 'ao19.png'),
(19, 'ao19_1.png'),
(19, 'ao19_2.png'),
(19, 'ao19_3.png'),
(19, 'ao19_4.png'),
(19, 'ao19_5.png'),

(20, 'ao20.png'),
(20, 'ao20_1.png'),
(20, 'ao20_2.png'),
(20, 'ao20_3.png'),
(20, 'ao20_4.png'),
(20, 'ao20_5.png'),

(21, 'ao21.png'),
(21, 'ao21_1.png'),
(21, 'ao21_2.png'),
(21, 'ao21_3.png'),
(21, 'ao21_4.png'),
(21, 'ao21_5.png'),

(22, 'ao22.png'),
(22, 'ao22_1.png'),
(22, 'ao22_2.png'),
(22, 'ao22_3.png'),
(22, 'ao22_4.png'),
(22, 'ao22_5.png'),

(23, 'ao23.png'),
(23, 'ao23_1.png'),
(23, 'ao23_2.png'),
(23, 'ao23_3.png'),
(23, 'ao23_4.png'),
(23, 'ao23_5.png'),

(24, 'ao24.png'),
(24, 'ao24_1.png'),
(24, 'ao24_2.png'),
(24, 'ao24_3.png'),
(24, 'ao24_4.png'),
(24, 'ao24_5.png'),

(25, 'ao25.png'),
(25, 'ao25_1.png'),
(25, 'ao25_2.png'),
(25, 'ao25_3.png'),
(25, 'ao25_4.png'),
(25, 'ao25_5.png'),

(26, 'ao26.png'),
(26, 'ao26_1.png'),
(26, 'ao26_2.png'),
(26, 'ao26_3.png'),
(26, 'ao26_4.png'),
(26, 'ao26_5.png'),

(27, 'ao27.png'),
(27, 'ao27_1.png'),
(27, 'ao27_2.png'),
(27, 'ao27_3.png'),
(27, 'ao27_4.png'),
(27, 'ao27_5.png'),

(28, 'ao28.png'),
(28, 'ao28_1.png'),
(28, 'ao28_2.png'),
(28, 'ao28_3.png'),
(28, 'ao28_4.png'),
(28, 'ao28_5.png'),

(29, 'ao29.png'),
(29, 'ao29_1.png'),
(29, 'ao29_2.png'),
(29, 'ao29_3.png'),
(29, 'ao29_4.png'),
(29, 'ao29_5.png'),

(30, 'ao30.png'),
(30, 'ao30_1.png'),
(30, 'ao30_2.png'),
(30, 'ao30_3.png'),
(30, 'ao30_4.png'),
(30, 'ao30_5.png'),

(31, 'ao31.png'),
(31, 'ao31_1.png'),
(31, 'ao31_2.png'),
(31, 'ao31_3.png'),
(31, 'ao31_4.png'),
(31, 'ao31_5.png'),

(32, 'ao32.png'),
(32, 'ao32_1.png'),
(32, 'ao32_2.png'),
(32, 'ao32_3.png'),
(32, 'ao32_4.png'),
(32, 'ao32_5.png'),

(33, 'ao33.png'),
(33, 'ao33_1.png'),
(33, 'ao33_2.png'),
(33, 'ao33_3.png'),
(33, 'ao33_4.png'),
(33, 'ao33_5.png'),

(34, 'ao34.png'),
(34, 'ao34_1.png'),
(34, 'ao34_2.png'),
(34, 'ao34_3.png'),
(34, 'ao34_4.png'),
(34, 'ao34_5.png'),

(35, 'ao35.png'),
(35, 'ao35_1.png'),
(35, 'ao35_2.png'),
(35, 'ao35_3.png'),
(35, 'ao35_4.png'),
(35, 'ao35_5.png'),

(36, 'ao36.png'),
(36, 'ao36_1.png'),
(36, 'ao36_2.png'),
(36, 'ao36_3.png'),
(36, 'ao36_4.png'),
(36, 'ao36_5.png'),

(37, 'ao37.png'),
(37, 'ao37_1.png'),
(37, 'ao37_2.png'),
(37, 'ao37_3.png'),
(37, 'ao37_4.png'),
(37, 'ao37_5.png'),

(38, 'ao38.png'),
(38, 'ao38_1.png'),
(38, 'ao38_2.png'),
(38, 'ao38_3.png'),
(38, 'ao38_4.png'),
(38, 'ao38_5.png'),

(39, 'ao39.png'),
(39, 'ao39_1.png'),
(39, 'ao39_2.png'),
(39, 'ao39_3.png'),
(39, 'ao39_4.png'),
(39, 'ao39_5.png'),

(40, 'ao40.png'),
(40, 'ao40_1.png'),
(40, 'ao40_2.png'),
(40, 'ao40_3.png'),
(40, 'ao40_4.png'),
(40, 'ao40_5.png'),

(41, 'ao41.png'),
(41, 'ao41_1.png'),
(41, 'ao41_2.png'),
(41, 'ao41_3.png'),
(41, 'ao41_4.png'),
(41, 'ao41_5.png'),

(42, 'ao42.png'),
(42, 'ao42_1.png'),
(42, 'ao42_2.png'),
(42, 'ao42_3.png'),
(42, 'ao42_4.png'),
(42, 'ao42_5.png'),

(43, 'ao43.png'),
(43, 'ao43_1.png'),
(43, 'ao43_2.png'),
(43, 'ao43_3.png'),
(43, 'ao43_4.png'),
(43, 'ao43_5.png'),

(44, 'ao44.png'),
(44, 'ao44_1.png'),
(44, 'ao44_2.png'),
(44, 'ao44_3.png'),
(44, 'ao44_4.png'),
(44, 'ao44_5.png'),

(45, 'ao45.png'),
(45, 'ao45_1.png'),
(45, 'ao45_2.png'),
(45, 'ao45_3.png'),
(45, 'ao45_4.png'),
(45, 'ao45_5.png'),

(46, 'ao46.png'),
(46, 'ao46_1.png'),
(46, 'ao46_2.png'),
(46, 'ao46_3.png'),
(46, 'ao46_4.png'),
(46, 'ao46_5.png'),

(47, 'ao47.png'),
(47, 'ao47_1.png'),
(47, 'ao47_2.png'),
(47, 'ao47_3.png'),
(47, 'ao47_4.png'),
(47, 'ao47_5.png'),

(48, 'ao48.png'),
(48, 'ao48_1.png'),
(48, 'ao48_2.png'),
(48, 'ao48_3.png'),
(48, 'ao48_4.png'),
(48, 'ao48_5.png'),

(49, 'ao49.png'),
(49, 'ao49_1.png'),
(49, 'ao49_2.png'),
(49, 'ao49_3.png'),
(49, 'ao49_4.png'),
(49, 'ao49_5.png'),

(50, 'ao50.png'),
(50, 'ao50_1.png'),
(50, 'ao50_2.png'),
(50, 'ao50_3.png'),
(50, 'ao50_4.png'),
(50, 'ao50_5.png'),

(51, 'ao51.png'),
(51, 'ao51_1.png'),
(51, 'ao51_2.png'),
(51, 'ao51_3.png'),
(51, 'ao51_4.png'),
(51, 'ao51_5.png'),

(52, 'ao52.png'),
(52, 'ao52_1.png'),
(52, 'ao52_2.png'),
(52, 'ao52_3.png'),
(52, 'ao52_4.png'),
(52, 'ao52_5.png'),

(53, 'ao53.png'),
(53, 'ao53_1.png'),
(53, 'ao53_2.png'),
(53, 'ao53_3.png'),
(53, 'ao53_4.png'),
(53, 'ao53_5.png'),

(54, 'ao54.png'),
(54, 'ao54_1.png'),
(54, 'ao54_2.png'),
(54, 'ao54_3.png'),
(54, 'ao54_4.png'),
(54, 'ao54_5.png'),

(55, 'ao55.png'),
(55, 'ao55_1.png'),
(55, 'ao55_2.png'),
(55, 'ao55_3.png'),
(55, 'ao55_4.png'),
(55, 'ao55_5.png'),

(56, 'ao56.png'),
(56, 'ao56_1.png'),
(56, 'ao56_2.png'),
(56, 'ao56_3.png'),
(56, 'ao56_4.png'),
(56, 'ao56_5.png'),

(57, 'ao57.png'),
(57, 'ao57_1.png'),
(57, 'ao57_2.png'),
(57, 'ao57_3.png'),
(57, 'ao57_4.png'),
(57, 'ao57_5.png'),

(58, 'ao58.png'),
(58, 'ao58_1.png'),
(58, 'ao58_2.png'),
(58, 'ao58_3.png'),
(58, 'ao58_4.png'),
(58, 'ao58_5.png'),

(59, 'ao59.png'),
(59, 'ao59_1.png'),
(59, 'ao59_2.png'),
(59, 'ao59_3.png'),
(59, 'ao59_4.png'),
(59, 'ao59_5.png'),

(60, 'quan1.png'),
(60, 'quan1_1.png'),
(60, 'quan1_2.png'),
(60, 'quan1_3.png'),
(60, 'quan1_4.png'),
(60, 'quan1_5.png'),

(61, 'quan2.png'),
(61, 'quan2_1.png'),
(61, 'quan2_2.png'),
(61, 'quan2_3.png'),
(61, 'quan2_4.png'),
(61, 'quan2_5.png'),

(62, 'quan3.png'),
(62, 'quan3_1.png'),
(62, 'quan3_2.png'),
(62, 'quan3_3.png'),
(62, 'quan3_4.png'),
(62, 'quan3_5.png'),

(63, 'quan4.png'),
(63, 'quan4_1.png'),
(63, 'quan4_2.png'),
(63, 'quan4_3.png'),
(63, 'quan4_4.png'),
(63, 'quan4_5.png'),

(64, 'quan5.png'),
(64, 'quan5_1.png'),
(64, 'quan5_2.png'),
(64, 'quan5_3.png'),
(64, 'quan5_4.png'),
(64, 'quan5_5.png'),

(65, 'quan6.png'),
(65, 'quan6_1.png'),
(65, 'quan6_2.png'),
(65, 'quan6_3.png'),
(65, 'quan6_4.png'),
(65, 'quan6_5.png'),

(66, 'quan7.png'),
(66, 'quan7_1.png'),
(66, 'quan7_2.png'),
(66, 'quan7_3.png'),
(66, 'quan7_4.png'),
(66, 'quan7_5.png'),

(67, 'quan8.png'),
(67, 'quan8_1.png'),
(67, 'quan8_2.png'),
(67, 'quan8_3.png'),
(67, 'quan8_4.png'),
(67, 'quan8_5.png'),

(68, 'quan9.png'),
(68, 'quan9_1.png'),
(68, 'quan9_2.png'),
(68, 'quan9_3.png'),
(68, 'quan9_4.png'),
(68, 'quan9_5.png'),

(69, 'quan10.png'),
(69, 'quan10_1.png'),
(69, 'quan10_2.png'),
(69, 'quan10_3.png'),
(69, 'quan10_4.png'),
(69, 'quan10_5.png'),

(70, 'quan11.png'),
(70, 'quan11_1.png'),
(70, 'quan11_2.png'),
(70, 'quan11_3.png'),
(70, 'quan11_4.png'),
(70, 'quan11_5.png'),

(71, 'quan12.png'),
(71, 'quan12_1.png'),
(71, 'quan12_2.png'),
(71, 'quan12_3.png'),
(71, 'quan12_4.png'),
(71, 'quan12_5.png'),

(72, 'quan13.png'),
(72, 'quan13_1.png'),
(72, 'quan13_2.png'),
(72, 'quan13_3.png'),
(72, 'quan13_4.png'),
(72, 'quan13_5.png'),

(73, 'quan14.png'),
(73, 'quan14_1.png'),
(73, 'quan14_2.png'),
(73, 'quan14_3.png'),
(73, 'quan14_4.png'),
(73, 'quan14_5.png'),

(74, 'quan15.png'),
(74, 'quan15_1.png'),
(74, 'quan15_2.png'),
(74, 'quan15_3.png'),
(74, 'quan15_4.png'),
(74, 'quan15_5.png'),

(75, 'quan16.png'),
(75, 'quan16_1.png'),
(75, 'quan16_2.png'),
(75, 'quan16_3.png'),
(75, 'quan16_4.png'),
(75, 'quan16_5.png'),

(76, 'quan17.png'),
(76, 'quan17_1.png'),
(76, 'quan17_2.png'),
(76, 'quan17_3.png'),
(76, 'quan17_4.png'),
(76, 'quan17_5.png'),

(77, 'quan18.png'),
(77, 'quan18_1.png'),
(77, 'quan18_2.png'),
(77, 'quan18_3.png'),
(77, 'quan18_4.png'),
(77, 'quan18_5.png'),

(78, 'quan19.png'),
(78, 'quan19_1.png'),
(78, 'quan19_2.png'),
(78, 'quan19_3.png'),
(78, 'quan19_4.png'),
(78, 'quan19_5.png'),

(79, 'quan20.png'),
(79, 'quan20_1.png'),
(79, 'quan20_2.png'),
(79, 'quan20_3.png'),
(79, 'quan20_4.png'),
(79, 'quan20_5.png'),

(80, 'quan21.png'),
(80, 'quan21_1.png'),
(80, 'quan21_2.png'),
(80, 'quan21_3.png'),
(80, 'quan21_4.png'),
(80, 'quan21_5.png'),

(81, 'quan22.png'),
(81, 'quan22_1.png'),
(81, 'quan22_2.png'),
(81, 'quan22_3.png'),
(81, 'quan22_4.png'),
(81, 'quan22_5.png'),

(82, 'quan23.png'),
(82, 'quan23_1.png'),
(82, 'quan23_2.png'),
(82, 'quan23_3.png'),
(82, 'quan23_4.png'),
(82, 'quan23_5.png'),

(83, 'quan24.png'),
(83, 'quan24_1.png'),
(83, 'quan24_2.png'),
(83, 'quan24_3.png'),
(83, 'quan24_4.png'),
(83, 'quan24_5.png'),

(84, 'quan25.png'),
(84, 'quan25_1.png'),
(84, 'quan25_2.png'),
(84, 'quan25_3.png'),
(84, 'quan25_4.png'),
(84, 'quan25_5.png'),

(85, 'quan26.png'),
(85, 'quan26_1.png'),
(85, 'quan26_2.png'),
(85, 'quan26_3.png'),
(85, 'quan26_4.png'),
(85, 'quan26_5.png'),

(86, 'quan27.png'),
(86, 'quan27_1.png'),
(86, 'quan27_2.png'),
(86, 'quan27_3.png'),
(86, 'quan27_4.png'),
(86, 'quan27_5.png'),

(87, 'quan28.png'),
(87, 'quan28_1.png'),
(87, 'quan28_2.png'),
(87, 'quan28_3.png'),
(87, 'quan28_4.png'),
(87, 'quan28_5.png'),

(88, 'quan29.png'),
(88, 'quan29_1.png'),
(88, 'quan29_2.png'),
(88, 'quan29_3.png'),
(88, 'quan29_4.png'),
(88, 'quan29_5.png'),

(89, 'quan30.png'),
(89, 'quan30_1.png'),
(89, 'quan30_2.png'),
(89, 'quan30_3.png'),
(89, 'quan30_4.png'),
(89, 'quan30_5.png'),

(90, 'quan31.png'),
(90, 'quan31_1.png'),
(90, 'quan31_2.png'),
(90, 'quan31_3.png'),
(90, 'quan31_4.png'),
(90, 'quan31_5.png'),

(91, 'quan32.png'),
(91, 'quan32_1.png'),
(91, 'quan32_2.png'),
(91, 'quan32_3.png'),
(91, 'quan32_4.png'),
(91, 'quan32_5.png'),

(92, 'quan33.png'),
(92, 'quan33_1.png'),
(92, 'quan33_2.png'),
(92, 'quan33_3.png'),
(92, 'quan33_4.png'),
(92, 'quan33_5.png'),

(93, 'quan34.png'),
(93, 'quan34_1.png'),
(93, 'quan34_2.png'),
(93, 'quan34_3.png'),
(93, 'quan34_4.png'),
(93, 'quan34_5.png'),

(94, 'quan35.png'),
(94, 'quan35_1.png'),
(94, 'quan35_2.png'),
(94, 'quan35_3.png'),
(94, 'quan35_4.png'),
(94, 'quan35_5.png'),

(95, 'quan36.png'),
(95, 'quan36_1.png'),
(95, 'quan36_2.png'),
(95, 'quan36_3.png'),
(95, 'quan36_4.png'),
(95, 'quan36_5.png'),

(96, 'quan37.png'),
(96, 'quan37_1.png'),
(96, 'quan37_2.png'),
(96, 'quan37_3.png'),
(96, 'quan37_4.png'),
(96, 'quan37_5.png'),

(97, 'quan38.png'),
(97, 'quan38_1.png'),
(97, 'quan38_2.png'),
(97, 'quan38_3.png'),
(97, 'quan38_4.png'),
(97, 'quan38_5.png'),

(98, 'quan39.png'),
(98, 'quan39_1.png'),
(98, 'quan39_2.png'),
(98, 'quan39_3.png'),
(98, 'quan39_4.png'),
(98, 'quan39_5.png'),

(99, 'quan40.png'),
(99, 'quan40_1.png'),
(99, 'quan40_2.png'),
(99, 'quan40_3.png'),
(99, 'quan40_4.png'),
(99, 'quan40_5.png'),

(100, 'quan41.png'),
(100, 'quan41_1.png'),
(100, 'quan41_2.png'),
(100, 'quan41_3.png'),
(100, 'quan41_4.png'),
(100, 'quan41_5.png'),

(101, 'quan42.png'),
(101, 'quan42_1.png'),
(101, 'quan42_2.png'),
(101, 'quan42_3.png'),
(101, 'quan42_4.png'),
(101, 'quan42_5.png'),

(102, 'quan43.png'),
(102, 'quan43_1.png'),
(102, 'quan43_2.png'),
(102, 'quan43_3.png'),
(102, 'quan43_4.png'),
(102, 'quan43_5.png'),

(103, 'quan44.png'),
(103, 'quan44_1.png'),
(103, 'quan44_2.png'),
(103, 'quan44_3.png'),
(103, 'quan44_4.png'),
(103, 'quan44_5.png'),

(104, 'quan45.png'),
(104, 'quan45_1.png'),
(104, 'quan45_2.png'),
(104, 'quan45_3.png'),
(104, 'quan45_4.png'),
(104, 'quan45_5.png'),

(105, 'quan46.png'),
(105, 'quan46_1.png'),
(105, 'quan46_2.png'),
(105, 'quan46_3.png'),
(105, 'quan46_4.png'),
(105, 'quan46_5.png'),

(106, 'quan47.png'),
(106, 'quan47_1.png'),
(106, 'quan47_2.png'),
(106, 'quan47_3.png'),
(106, 'quan47_4.png'),
(106, 'quan47_5.png'),

(107, 'quan48.png'),
(107, 'quan48_1.png'),
(107, 'quan48_2.png'),
(107, 'quan48_3.png'),
(107, 'quan48_4.png'),
(107, 'quan48_5.png'),

(108, 'quan49.png'),
(108, 'quan49_1.png'),
(108, 'quan49_2.png'),
(108, 'quan49_3.png'),
(108, 'quan49_4.png'),
(108, 'quan49_5.png'),

(109, 'quan50.png'),
(109, 'quan50_1.png'),
(109, 'quan50_2.png'),
(109, 'quan50_3.png'),
(109, 'quan50_4.png'),
(109, 'quan50_5.png'),

(110, 'quan51.png'),
(110, 'quan51_1.png'),
(110, 'quan51_2.png'),
(110, 'quan51_3.png'),
(110, 'quan51_4.png'),
(110, 'quan51_5.png'),

(111, 'quan52.png'),
(111, 'quan52_1.png'),
(111, 'quan52_2.png'),
(111, 'quan52_3.png'),
(111, 'quan52_4.png'),
(111, 'quan52_5.png'),

(112, 'quan53.png'),
(112, 'quan53_1.png'),
(112, 'quan53_2.png'),
(112, 'quan53_3.png'),
(112, 'quan53_4.png'),
(112, 'quan53_5.png'),

(113, 'quan54.png'),
(113, 'quan54_1.png'),
(113, 'quan54_2.png'),
(113, 'quan54_3.png'),
(113, 'quan54_4.png'),
(113, 'quan54_5.png'),

(114, 'quan55.png'),
(114, 'quan55_1.png'),
(114, 'quan55_2.png'),
(114, 'quan55_3.png'),
(114, 'quan55_4.png'),
(114, 'quan55_5.png'),

(115, 'quan56.png'),
(115, 'quan56_1.png'),
(115, 'quan56_2.png'),
(115, 'quan56_3.png'),
(115, 'quan56_4.png'),
(115, 'quan56_5.png'),

(116, 'quan57.png'),
(116, 'quan57_1.png'),
(116, 'quan57_2.png'),
(116, 'quan57_3.png'),
(116, 'quan57_4.png'),
(116, 'quan57_5.png'),

(117, 'quan58.png'),
(117, 'quan58_1.png'),
(117, 'quan58_2.png'),
(117, 'quan58_3.png'),
(117, 'quan58_4.png'),
(117, 'quan58_5.png'),

(118, 'quan59.png'),
(118, 'quan59_1.png'),
(118, 'quan59_2.png'),
(118, 'quan59_3.png'),
(118, 'quan59_4.png'),
(118, 'quan59_5.png'),

(119, 'quan60.png'),
(119, 'quan60_1.png'),
(119, 'quan60_2.png'),
(119, 'quan60_3.png'),
(119, 'quan60_4.png'),
(119, 'quan60_5.png')

INSERT INTO VaiTro (TenVaiTro, MoTa)
VALUES (N'Admin', N'Quản lý hệ thống'),
(N'Khách hàng', N'Tài khoản khách hàng thường'),
(N'Nhân viên', N'Quản lý bán hàng');

INSERT INTO NhanVien (MatKhau, TenNV, GioiTinh, NamSinh, VaiTro)
VALUES (N'admin123', N'Phạm Văn C', N'Nam', 1990, 1),
(N'nv123', N'Trần Thị D', N'Nữ', 1992, 2),
(N'nv456', N'Đỗ Hoài E', N'Nữ', 1995, 2);

INSERT INTO KhachHang(TenKH, MatKhau, GioiTinh, NamSinh, DienThoai, Email, DiaChi)
VALUES
(N'Ngô Uyên Đan', 'user123', N'Nữ', 2000, '0987654321', 'uyen@example.com', N'123 Đường A, HCM');

INSERT INTO TinhTrang (TinhTrangHoaDon)
VALUES (N'Đang chờ xử lý'); -- ID = 1
INSERT INTO TinhTrang (TinhTrangHoaDon)
VALUES (N'Đã thanh toán'); -- ID = 2
INSERT INTO TinhTrang (TinhTrangHoaDon)
VALUES (N'Đã giao hàng'); -- ID = 3
INSERT INTO TinhTrang (TinhTrangHoaDon)
VALUES (N'Đã hủy'); -- ID = 4

INSERT INTO BienTheSanPham(MaSP, Size, Mau, SoLuongTon) VALUES
(1, 'S', N'Đen', 10),
(1, 'M', N'Đen', 15),
(1, 'L', N'Đen', 8),
(1, 'M', N'Trắng', 12),
(1, 'L', N'Trắng', 5),
(2, 'S', N'Đen', 10),
(2, 'M', N'Đen', 10),
(2, 'L', N'Đen', 7),
(2, 'S', N'Trắng', 8),
(2, 'M', N'Trắng', 6);

INSERT INTO HoaDon (MaKH, NgayLap, TongTien, TinhTrang, SDT, DiaChiGiaoHang)
VALUES 
(1,  GETDATE(), 1500000, 2, '0909123456', N'123 Đường ABC, Quận 1'),
(1,  GETDATE(), 2500000, 1, '0909123777', N'456 Đường XYZ, Quận 5');

insert into ChiTietHoaDon(MaHD, MaSP, SoLuong, GiaBan, Size, Color) values
(1, 1, 1, 149150, 'L', N'Đen'),
(2, 11, 1, 158150, 'S', N'Trắng'),
(1, 3, 1, 149150, 'S', N'Xanh'),
(2, 67, 1, 158650, 'XL', N'Be'),
(1, 36, 1, 384300,'XXL', 'Xám')

delete from KhachHang
where TenKH is null

select * from [dbo].[BienTheSanPham]
select * from [dbo].[DanhMuc]
select * from [dbo].[HinhAnh]
select * from [dbo].[HoaDon]
select * from [dbo].[KhachHang]
select * from [dbo].[NhanVien]
 select * from [dbo].[SanPham]
select * from [dbo].[TinhTrang]
select * from [dbo].[VaiTro]
select * from ChiTietHoaDon
UPDATE DanhMuc
SET MaDMChinh = 9
WHERE MaDM IN (20, 21);

CREATE TRIGGER trg_UpdateSoLuongTon
ON ChiTietHoaDon
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE b
    SET b.SoLuongTon = b.SoLuongTon - i.SoLuong
    FROM BienTheSanPham b
    INNER JOIN INSERTED i
        ON b.MaSP = i.MaSP
        AND b.Size = i.Size
        AND b.Mau = i.Color;
END;

CREATE TRIGGER trg_CheckSoLuongTon
ON ChiTietHoaDon
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM INSERTED i
        JOIN BienTheSanPham b
        ON i.MaSP = b.MaSP AND i.Size = b.Size AND b.Mau = i.Color
        WHERE b.SoLuongTon < i.SoLuong
    )
    BEGIN
        RAISERROR (N'Số lượng tồn không đủ để bán!', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    INSERT INTO ChiTietHoaDon (MaHD, MaSP, Size, Color, SoLuong, GiaBan)
    SELECT MaHD, MaSP, Size, Color, SoLuong, GiaBan FROM INSERTED;
END;

CREATE OR ALTER TRIGGER trg_AutoAddVariants
ON SanPham
AFTER INSERT
AS
BEGIN
    DECLARE @MaSP INT, @TenSP NVARCHAR(500), @Color NVARCHAR(50);

    SELECT @MaSP = MaSP, @TenSP = TenSP 
    FROM INSERTED;

    IF @TenSP LIKE N'%Xám Nhạt%' OR @TenSP LIKE N'%Xám Đậm%' 
        SET @Color = N'Xám';
    ELSE IF @TenSP LIKE N'%Cam Đậm%' OR @TenSP LIKE N'%Cam Nhạt%' 
        SET @Color = N'Cam';
    ELSE IF @TenSP LIKE N'%Nâu Nhạt%' OR @TenSP LIKE N'%Nâu Đậm%' 
        SET @Color = N'Nâu';
    ELSE IF @TenSP LIKE N'%Đỏ Đậm%' OR @TenSP LIKE N'%Đỏ Tươi%' 
        SET @Color = N'Đỏ';
    ELSE IF @TenSP LIKE N'%Xanh Dương Nhạt%' OR @TenSP LIKE N'%Xanh Dương Đậm%' 
        SET @Color = N'Xanh Dương';
    ELSE IF @TenSP LIKE N'%Xanh Lá Đậm%' OR @TenSP LIKE N'%Xanh Lá Nhạt%' 
        SET @Color = N'Xanh Lá';

    -- Basic colors
    ELSE IF @TenSP LIKE N'%Xám%' 
        SET @Color = N'Xám';
    ELSE IF @TenSP LIKE N'%Cam%' 
        SET @Color = N'Cam';
    ELSE IF @TenSP LIKE N'%Nâu%' 
        SET @Color = N'Nâu';
    ELSE IF @TenSP LIKE N'%Đỏ%' 
        SET @Color = N'Đỏ';
    ELSE IF @TenSP LIKE N'%Xanh Dương%' 
        SET @Color = N'Xanh Dương';
    ELSE IF @TenSP LIKE N'%Xanh Lá%' 
        SET @Color = N'Xanh Lá';
    ELSE IF @TenSP LIKE N'%Đen%' 
        SET @Color = N'Đen';
    ELSE IF @TenSP LIKE N'%Trắng%' 
        SET @Color = N'Trắng';
    ELSE IF @TenSP LIKE N'%Be%' 
        SET @Color = N'Be';
    ELSE IF @TenSP LIKE N'%Hồng%' 
        SET @Color = N'Hồng';
    ELSE IF @TenSP LIKE N'%Vàng%' 
        SET @Color = N'Vàng';
    ELSE 
        SET @Color = N'Đen'; 

    INSERT INTO BienTheSanPham(MaSP, Size, Mau, SoLuongTon)
    VALUES (@MaSP, 'S', @Color, 10),
           (@MaSP, 'M', @Color, 10),
           (@MaSP, 'L', @Color, 10),
           (@MaSP, 'XL', @Color, 10);

END;


UPDATE BienTheSanPham
SET Mau = CASE
    WHEN Mau LIKE N'%Xám%' THEN N'Xám'
    WHEN Mau LIKE N'%Cam%' THEN N'Cam'
    WHEN Mau LIKE N'%Nâu%' THEN N'Nâu'
    WHEN Mau LIKE N'%Đỏ%' THEN N'Đỏ'
    WHEN Mau LIKE N'%Xanh Dương%' THEN N'Xanh Dương'
    WHEN Mau LIKE N'%Xanh Lá%' THEN N'Xanh Lá'
    ELSE Mau
END;

select * from HoaDon

update NhanVien
set Email = 'nv456@gmail.com'
where MaNV = 3

SELECT sp.TenSP, sp.Gia, bts.Size, bts.Mau
FROM SanPham sp
LEFT JOIN BienTheSanPham bts ON sp.MaSP = bts.MaSP

-- Thêm cột Đã Thanh Toán (kiểu bit: 0 là chưa, 1 là rồi)
ALTER TABLE HoaDon
ADD DaThanhToan BIT DEFAULT 0;

-- Thêm cột Mã Nhân Viên (kiểu int, cho phép null vì đơn hàng online có thể chưa có NV duyệt)
ALTER TABLE HoaDon
ADD MaNV INT;

-- Tạo khóa ngoại cho MaNV liên kết với bảng NhanVien
ALTER TABLE HoaDon
ADD CONSTRAINT FK_HoaDon_NhanVien
FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV);



USE NHOM8_DOAN
GO

-- 1. Tạo bảng tạm chứa các Size chuẩn
WITH StandardSizes AS (
    SELECT 'S' AS Size UNION ALL
    SELECT 'M' UNION ALL
    SELECT 'L' UNION ALL
    SELECT 'XL'
),
-- 2. Xác định Màu sắc dựa trên Tên Sản Phẩm
ProductColors AS (
    SELECT 
        MaSP, 
        TenSP,
        CASE 
            WHEN TenSP LIKE N'%Đen%' THEN N'Đen'
            WHEN TenSP LIKE N'%Trắng%' THEN N'Trắng'
            WHEN TenSP LIKE N'%Xanh Dương%' THEN N'Xanh Dương'
            WHEN TenSP LIKE N'%Xanh Lá%' THEN N'Xanh Lá'
            WHEN TenSP LIKE N'%Hồng%' THEN N'Hồng'
            WHEN TenSP LIKE N'%Be%' THEN N'Be'
            WHEN TenSP LIKE N'%Nâu%' THEN N'Nâu'
            WHEN TenSP LIKE N'%Xám%' THEN N'Xám'
            WHEN TenSP LIKE N'%Cam%' THEN N'Cam'
            WHEN TenSP LIKE N'%Vàng%' THEN N'Vàng'
            WHEN TenSP LIKE N'%Đỏ%' THEN N'Đỏ'
            WHEN TenSP LIKE N'%Free Color%' THEN N'Nhiều màu'
            WHEN TenSP LIKE N'%Combo%' THEN N'Nhiều màu'
            ELSE N'Đen' -- Mặc định nếu không tìm thấy màu
        END AS MauSac
    FROM SanPham
)
-- 3. Thực hiện INSERT dữ liệu vào bảng BienTheSanPham
INSERT INTO BienTheSanPham (MaSP, Size, Mau, SoLuongTon)
SELECT 
    pc.MaSP,
    ss.Size,
    pc.MauSac,
    50 -- Số lượng tồn kho mặc định (bạn có thể sửa số này)
FROM ProductColors pc
CROSS JOIN StandardSizes ss
WHERE NOT EXISTS (
    -- Kiểm tra để không thêm trùng lặp nếu sản phẩm đã có biến thể đó rồi
    SELECT 1 
    FROM BienTheSanPham bts 
    WHERE bts.MaSP = pc.MaSP 
      AND bts.Size = ss.Size 
      AND bts.Mau = pc.MauSac
);

GO

-- 4. Kiểm tra lại kết quả sau khi thêm
SELECT sp.TenSP, sp.Gia, bts.Size, bts.Mau, bts.SoLuongTon
FROM SanPham sp
JOIN BienTheSanPham bts ON sp.MaSP = bts.MaSP
ORDER BY sp.MaSP, bts.Size;

select * from SanPham

update BienTheSanPham
set Mau = N'Đỏ'
where MaSP = 7

-- 1. Cập nhật cho Admin (Phạm Văn C - admin123)
UPDATE NhanVien
SET MatKhau = '2vZTx8hhsVg1iQQJjptBYI+lrHUHkospH3iWSwZHps4='
WHERE MatKhau = 'admin123' OR TenNV = N'Phạm Văn C';

-- 2. Cập nhật cho Nhân viên (Trần Thị D - nv123)
UPDATE NhanVien
SET MatKhau = 'alpJD9nKlmmtABm7DB7ix+eQOSYgzhx3jMPeYvK2qoc='
WHERE MatKhau = 'nv123' OR TenNV = N'Trần Thị D';

-- 3. Cập nhật cho Nhân viên (Đỗ Hoài E - nv456)
UPDATE NhanVien
SET MatKhau = 'efCrOL1fDoyIoUUPf0dpkLA2h4e5IgxCW5hg+iJIz9I='
WHERE MatKhau = 'nv456' OR TenNV = N'Đỗ Hoài E';

-- 4. Cập nhật cho Khách hàng (Ngô Uyên Đan - user123)
UPDATE KhachHang
SET MatKhau = '+Ccf5+hA/vM2V/RU/DAtXkANVtxWZsvSJeDnwlm3V54='
WHERE MatKhau = 'user123' OR TenKH = N'Ngô Uyên Đan';

update DanhMuc
set MaDMChinh = 2
where TenDM = N'Quần Lót'
select * from DanhMuc