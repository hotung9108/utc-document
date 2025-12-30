use QLBanHang

CREATE DATABASE QuanLyBanHang;
GO

USE QuanLyBanHang;
GO

CREATE TABLE tblChatlieu (
    MaChatLieu NVARCHAR(50) PRIMARY KEY,
    TenChatLieu NVARCHAR(50) NOT NULL
);


CREATE TABLE tblHang (
    MaHang NVARCHAR(50) PRIMARY KEY,
    TenHang NVARCHAR(100) NOT NULL,
    MaChatLieu NVARCHAR(50) NOT NULL,
    SoLuong INT,
    DonGiaNhap MONEY,
    DonGiaBan MONEY,
    Anh NVARCHAR(200),
    GhiChu NVARCHAR(200),
    FOREIGN KEY (MaChatLieu) REFERENCES tblChatlieu(MaChatLieu)
);

CREATE TABLE tblNhanvien (
    MaNhanvien NVARCHAR(50) PRIMARY KEY,
    TenNhanvien NVARCHAR(100) NOT NULL,
    MatKhau NVARCHAR(50),
    Gioitinh NVARCHAR(50),
    Diachi NVARCHAR(200),
    Dienthoai NVARCHAR(50),
    Ngaysinh DATE
);


CREATE TABLE tblKhach (
    MaKhach NVARCHAR(50) PRIMARY KEY,
    TenKhach NVARCHAR(100) NOT NULL,
    Diachi NVARCHAR(200),
    Dienthoai NVARCHAR(50)
);

CREATE TABLE tblHDBan (
    MaHDBan NVARCHAR(50) PRIMARY KEY,
    MaNhanvien NVARCHAR(50) NOT NULL,
    Ngayban DATE,
    MaKhach NVARCHAR(50) NOT NULL,
    TongTien MONEY,
    FOREIGN KEY (MaNhanvien) REFERENCES tblNhanvien(MaNhanvien),
    FOREIGN KEY (MaKhach) REFERENCES tblKhach(MaKhach)
);

CREATE TABLE tblChitietHDBan (
    MaHDBan NVARCHAR(50) NOT NULL,
    MaHang NVARCHAR(50) NOT NULL,
    SoLuong INT NOT NULL,
    GiamGia FLOAT,
    ThanhTien MONEY,
    PRIMARY KEY (MaHDBan, MaHang),
    FOREIGN KEY (MaHDBan) REFERENCES tblHDBan(MaHDBan),
    FOREIGN KEY (MaHang) REFERENCES tblHang(MaHang)
);

INSERT INTO tblChatlieu (MaChatLieu, TenChatLieu)
VALUES
('CL01', N'Cotton'),
('CL02', N'Kaki'),
('CL03', N'Jean'),
('CL04', N'Len');

INSERT INTO tblHang (MaHang, TenHang, MaChatLieu, SoLuong, DonGiaNhap, DonGiaBan, Anh, GhiChu)
VALUES
('H01', N'Áo thun cổ tròn', 'CL01', 100, 50000, 80000, NULL, N'Hàng bán chạy'),
('H02', N'Quần jean xanh', 'CL03', 80, 150000, 220000, NULL, NULL),
('H03', N'Áo khoác kaki', 'CL02', 50, 200000, 300000, NULL, N'Mẫu mới'),
('H04', N'Áo len mùa đông', 'CL04', 60, 180000, 250000, NULL, NULL);

INSERT INTO tblNhanvien (MaNhanvien, TenNhanvien, MatKhau, Gioitinh, Diachi, Dienthoai, Ngaysinh)
VALUES
('NV01', N'Nguyễn Văn A', '123', N'Nam', N'Hà Nội', '0912345678', '1995-03-12'),
('NV02', N'Trần Thị B', '123', N'Nữ', N'Hồ Chí Minh', '0987654321', '1998-07-21'),
('NV03', N'Lê Văn C', '123', N'Nam', N'Đà Nẵng', '0933445566', '1990-11-05');

INSERT INTO tblKhach (MaKhach, TenKhach, Diachi, Dienthoai)
VALUES
('KH01', N'Phạm Minh Đức', N'Hà Nội', '0901111222'),
('KH02', N'Hoàng Lan', N'Hải Phòng', '0903333444'),
('KH03', N'Vũ Thu Hà', N'Nam Định', '0911222333');

select * from tblChitietHDBan

drop table tblChitietHDBan
drop table tblHDBan
select * from  tblHDBan

select MaHDBan from tblHDBan where 
select * from tblHang