create database BanHang	
use BanHang


CREATE TABLE tblMatHang (
	MaSP   nchar(5)      NOT NULL, 
    TenSP  nvarchar(30)  NOT NULL,
    NgaySX date          NOT NULL ,
    NgayHH date          NOT NULL,
    DonVi  nvarchar(10)  NOT NULL,
    DonGia float         NOT NULL CHECK (DonGia >= 0),
    GhiChu nvarchar(200) NULL,
    CONSTRAINT PK_tblMatHang PRIMARY KEY (MaSP),
--   CONSTRAINT CHK_tblMatHang_Ngay CHECK (NgayHH >= NgaySX)    
);
-- CONSTRAINT DF_tblMatHang_NgaySX DEFAULT (CONVERT(date, GETDATE()))

-- Dữ liệu mẫu
INSERT INTO dbo.tblMatHang (MaSP, TenSP, NgaySX, NgayHH, DonVi, DonGia, GhiChu) VALUES
(N'SP001', N'Cà phê Robusta', '2024-01-01', '2026-01-01', N'gói', 12000, N'Hàng bán chạy'),
(N'SP002', N'Trà Lipton', '2023-06-15', '2025-06-15', N'hộp', 45000, N''),
(N'SP003', N'Đường trắng', '2024-03-10', '2026-03-10', N'kg', 18000, N'Bao bì mới'),
(N'SP004', N'Muối I-ốt', '2022-11-01', '2027-11-01', N'gói', 5000, N''),
(N'SP005', N'Nước suối 500ml', '2024-05-01', '2026-05-01', N'chai', 8000, N'');

select * from tblMatHang