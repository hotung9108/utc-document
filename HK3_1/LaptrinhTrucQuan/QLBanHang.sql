-- T?o database
CREATE DATABASE QLBanHang;
GO
USE QLBanHang;
GO
------------------------------------------------------------
-- 1. B?ng Ch?t li?u
------------------------------------------------------------

INSERT INTO tblChatlieu (MaChatlieu, TenChatlieu) VALUES
('CL01', N'V?i cotton'),
('CL02', N'Nh?a cao c?p'),
('CL03', N'Thép không g?');

------------------------------------------------------------
-- 2. B?ng Hàng
------------------------------------------------------------
INSERT INTO tblHang (MaHang, TenHang, MaChatlieu, SoLuong, DonGiaNhap, DonGiaBan, Anh, GhiChu) VALUES
('H01', N'Áo thun nam c? tròn', 'CL01', 100, 80000, 120000, N'ao1.jpg', N'Hàng m?i 2025'),
('H02', N'Bình n??c th? thao', 'CL02', 50, 60000, 95000, N'binh1.jpg', N'Hàng khuy?n mãi'),
('H03', N'B? dao inox 5 món', 'CL03', 30, 250000, 350000, N'dao1.jpg', N'Hàng nh?p kh?u');

------------------------------------------------------------
-- 3. B?ng Nhân viên
------------------------------------------------------------


INSERT INTO tblNhanvien (MaNhanvien, TenNhanvien, GioiTinh, DiaChi, DienThoai, NgaySinh) VALUES
('NV01', N'Nguy?n V?n A', N'Nam', N'Hà N?i', '0905123456', '1998-02-15'),
('NV02', N'Tr?n Th? B', N'N?', N'?à N?ng', '0912123456', '2000-06-25'),
('NV03', N'Lê V?n C', N'Nam', N'H? Chí Minh', '0933123456', '1995-10-10');

------------------------------------------------------------
-- 4. B?ng Khách hàng
------------------------------------------------------------

INSERT INTO tblKhach (MaKhach, TenKhach, DiaChi, DienThoai) VALUES
('KH01', N'Ph?m Minh D?ng', N'Hà N?i', '0988111222'),
('KH02', N'Ngô Th? Hoa', N'H?i Phòng', '0977665544'),
('KH03', N'Bùi ??c Long', N'H? Chí Minh', '0909777333');

------------------------------------------------------------
-- 5. B?ng Hóa ??n bán
------------------------------------------------------------

INSERT INTO tblHDBan (MaHDBan, MaNhanvien, NgayBan, MaKhach, TongTien) VALUES
('HD01', 'NV01', '2025-10-05', 'KH01', 590000),
('HD02', 'NV02', '2025-10-06', 'KH02', 240000),
('HD03', 'NV03', '2025-10-07', 'KH03', 350000);

------------------------------------------------------------
-- 6. B?ng Chi ti?t hóa ??n bán
------------------------------------------------------------

INSERT INTO tblChitietHDBan (MaHDBan, MaHang, SoLuong, DonGia, ThanhTien) VALUES
('HD01', 'H01', 2, 120000, 240000),
('HD01', 'H02', 3, 95000, 285000),
('HD02', 'H01', 1, 120000, 120000),
('HD02', 'H03', 1, 350000, 350000),
('HD03', 'H03', 1, 350000, 350000);
GO

select * from Chat