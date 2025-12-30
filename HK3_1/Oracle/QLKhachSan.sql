-- ***** Bảng: tChiTietKH *****
CREATE TABLE tChiTietKH (
    MaDK      NVARCHAR2(3),
    LoaiKH    NVARCHAR2(1),
    TenKH     NVARCHAR2(25),
    NgaySinh  DATE,
    Phai      NUMBER(1) NOT NULL,
    DiaChi    NVARCHAR2(50),
    DienThoai NVARCHAR2(7),
    CONSTRAINT chk_Phai CHECK (Phai IN (0, 1)) -- 0: Nam, 1: Nữ
);

-- ***** Bảng: tDangKy *****
CREATE TABLE tDangKy (
    MaDK       NVARCHAR2(3) NOT NULL,
    SoPhong    NVARCHAR2(50),
    LoaiPhong  NVARCHAR2(2),
    NgayVao    DATE,
    NgayRa     DATE,
    CONSTRAINT PK_tDangKy PRIMARY KEY (MaDK)
);

-- ***** Bảng: tDoanhThu *****
CREATE TABLE tDoanhThu (
    MaDK       NVARCHAR2(3) NOT NULL,
    LoaiPhong  NVARCHAR2(2),
    SoNgayO    NUMBER(10),
    ThucThu    NUMBER(18),
    CONSTRAINT PK_tDoanhThu PRIMARY KEY (MaDK)
);

-- ***** Bảng: tKhachHang *****
CREATE TABLE tKhachHang (
    LoaiKH   NVARCHAR2(1),
    DienGiai NVARCHAR2(50)
);

-- ***** Bảng: tLoaiPhong *****
CREATE TABLE tLoaiPhong (
    LoaiPhong  NVARCHAR2(1),
    GiaiThich  NVARCHAR2(50),
    DonGia     NUMBER(10)
);

-- ***** Bảng: tPhong *****
CREATE TABLE tPhong (
    SoPhong   NVARCHAR2(50) NOT NULL,
    LoaiPhong NVARCHAR2(2),
    GhiChu    NVARCHAR2(50),
    CONSTRAINT PK_tPhong PRIMARY KEY (SoPhong)
);

-- ***** Chèn dữ liệu vào bảng tChiTietKH *****
INSERT INTO tChiTietKH (MaDK, LoaiKH, TenKH, NgaySinh, Phai, DiaChi, DienThoai) VALUES ('001', '1', 'Trần Hồng Hà', TO_DATE('1980-12-12 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0, '34A Trần phú', NULL);
INSERT INTO tChiTietKH (MaDK, LoaiKH, TenKH, NgaySinh, Phai, DiaChi, DienThoai) VALUES ('002', '1', 'Nguyễn Thế Anh', TO_DATE('1968-03-22 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0, '123 Trần Hưng Đạo', NULL);
INSERT INTO tChiTietKH (MaDK, LoaiKH, TenKH, NgaySinh, Phai, DiaChi, DienThoai) VALUES ('003', '1', 'Lê Gia Linh', TO_DATE('1981-04-12 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, '564 Nguyễn Trãi', '8445563');
INSERT INTO tChiTietKH (MaDK, LoaiKH, TenKH, NgaySinh, Phai, DiaChi, DienThoai) VALUES ('004', '3', 'Nguyễn Thị Minh tâm', TO_DATE('1975-05-23 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, '56/12 Đặng văn Ngữ', NULL);
INSERT INTO tChiTietKH (MaDK, LoaiKH, TenKH, NgaySinh, Phai, DiaChi, DienThoai) VALUES ('005', '1', 'Nguyễn Kim Sơn', TO_DATE('1969-09-12 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0, '78/9 Nguyễn Thị Minh Khai', '8355647');
INSERT INTO tChiTietKH (MaDK, LoaiKH, TenKH, NgaySinh, Phai, DiaChi, DienThoai) VALUES ('006', '1', 'Trần Hạnh Dung', TO_DATE('1952-12-15 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, '34 Lê Duẩn', NULL);
INSERT INTO tChiTietKH (MaDK, LoaiKH, TenKH, NgaySinh, Phai, DiaChi, DienThoai) VALUES ('007', '2', 'Lý Mỹ Lệ', TO_DATE('1980-01-16 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, '14/2 Vũ Trọng Phụng', '8679456');
INSERT INTO tChiTietKH (MaDK, LoaiKH, TenKH, NgaySinh, Phai, DiaChi, DienThoai) VALUES ('008', '2', 'Nguyễn Kim An', TO_DATE('1963-03-12 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0, '23 Trần Bình Trọng', NULL);
INSERT INTO tChiTietKH (MaDK, LoaiKH, TenKH, NgaySinh, Phai, DiaChi, DienThoai) VALUES ('009', '1', 'Nguyễn Phương Dung', TO_DATE('1982-06-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, '67 Hoàng Hoa Thám', '8767752');
INSERT INTO tChiTietKH (MaDK, LoaiKH, TenKH, NgaySinh, Phai, DiaChi, DienThoai) VALUES ('010', '1', 'Lê Thị Kim thảo', TO_DATE('1969-09-03 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, '56 Nguyễn Tuân', NULL);

-- ***** Chèn dữ liệu vào bảng tDangKy *****
INSERT INTO tDangKy (MaDK, SoPhong, LoaiPhong, NgayVao, NgayRa) VALUES ('001', '201', 'A', TO_DATE('1998-04-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1998-04-28 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO tDangKy (MaDK, SoPhong, LoaiPhong, NgayVao, NgayRa) VALUES ('002', '202', 'B', TO_DATE('1998-04-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1998-05-03 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO tDangKy (MaDK, SoPhong, LoaiPhong, NgayVao, NgayRa) VALUES ('003', '101', 'A', TO_DATE('1998-05-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1998-06-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO tDangKy (MaDK, SoPhong, LoaiPhong, NgayVao, NgayRa) VALUES ('004', '102', 'A', TO_DATE('1998-05-02 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1998-05-15 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO tDangKy (MaDK, SoPhong, LoaiPhong, NgayVao, NgayRa) VALUES ('005', '405', 'B', TO_DATE('1998-05-03 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1998-05-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO tDangKy (MaDK, SoPhong, LoaiPhong, NgayVao, NgayRa) VALUES ('006', '608', 'C', TO_DATE('1998-06-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1998-07-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO tDangKy (MaDK, SoPhong, LoaiPhong, NgayVao, NgayRa) VALUES ('007', '304', 'C', TO_DATE('1998-06-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1998-06-08 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO tDangKy (MaDK, SoPhong, LoaiPhong, NgayVao, NgayRa) VALUES ('008', '201', 'B', TO_DATE('1998-06-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1998-07-15 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO tDangKy (MaDK, SoPhong, LoaiPhong, NgayVao, NgayRa) VALUES ('009', '205', 'A', TO_DATE('1999-07-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1999-07-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO tDangKy (MaDK, SoPhong, LoaiPhong, NgayVao, NgayRa) VALUES ('010', '601', 'B', TO_DATE('1999-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1999-01-12 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO tDangKy (MaDK, SoPhong, LoaiPhong, NgayVao, NgayRa) VALUES ('011', '202', 'B', TO_DATE('2019-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-01-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO tDangKy (MaDK, SoPhong, LoaiPhong, NgayVao, NgayRa) VALUES ('012', '601', 'A', TO_DATE('2019-04-03 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-04-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO tDangKy (MaDK, SoPhong, LoaiPhong, NgayVao, NgayRa) VALUES ('013', '601', 'A', TO_DATE('2019-04-03 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-04-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO tDangKy (MaDK, SoPhong, LoaiPhong, NgayVao, NgayRa) VALUES ('014', '601', 'A', TO_DATE('2019-04-03 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-04-03 00:01:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO tDangKy (MaDK, SoPhong, LoaiPhong, NgayVao, NgayRa) VALUES ('015', '601', 'A', TO_DATE('2019-04-03 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-04-04 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- ***** Chèn dữ liệu vào bảng tDoanhThu *****
INSERT INTO tDoanhThu (MaDK, LoaiPhong, SoNgayO, ThucThu) VALUES ('012', 'A', 2, 400000);
INSERT INTO tDoanhThu (MaDK, LoaiPhong, SoNgayO, ThucThu) VALUES ('013', 'A', 2, -400000);
INSERT INTO tDoanhThu (MaDK, LoaiPhong, SoNgayO, ThucThu) VALUES ('014', 'A', 1, 200000);
INSERT INTO tDoanhThu (MaDK, LoaiPhong, SoNgayO, ThucThu) VALUES ('015', 'A', 1, 200000);

-- ***** Chèn dữ liệu vào bảng tKhachHang *****
INSERT INTO tKhachHang (LoaiKH, DienGiai) VALUES ('1', 'Khách vãng lai');
INSERT INTO tKhachHang (LoaiKH, DienGiai) VALUES ('2', 'Khách hàng thân thiết');
INSERT INTO tKhachHang (LoaiKH, DienGiai) VALUES ('3', 'Khách có thẻ của công ty Bảo hiểm');

-- ***** Chèn dữ liệu vào bảng tLoaiPhong *****
INSERT INTO tLoaiPhong (LoaiPhong, GiaiThich, DonGia) VALUES ('A', 'Máy Lạnh, Nước nóng, Ti Vi,Tủ lạnh, Đ.Thoại', 200000);
INSERT INTO tLoaiPhong (LoaiPhong, GiaiThich, DonGia) VALUES ('B', 'Máy Lạnh, Nươc Nóng, Điện Thoại', 150000);
INSERT INTO tLoaiPhong (LoaiPhong, GiaiThich, DonGia) VALUES ('C', 'Điện Thoại', 100000);

-- ***** Chèn dữ liệu vào bảng tPhong *****
INSERT INTO tPhong (SoPhong, LoaiPhong, GhiChu) VALUES ('101', 'A', NULL);
INSERT INTO tPhong (SoPhong, LoaiPhong, GhiChu) VALUES ('102', 'A', NULL);
INSERT INTO tPhong (SoPhong, LoaiPhong, GhiChu) VALUES ('103', 'C', NULL);
INSERT INTO tPhong (SoPhong, LoaiPhong, GhiChu) VALUES ('104', 'A', NULL);
INSERT INTO tPhong (SoPhong, LoaiPhong, GhiChu) VALUES ('105', 'B', NULL);
INSERT INTO tPhong (SoPhong, LoaiPhong, GhiChu) VALUES ('201', 'A', NULL);
INSERT INTO tPhong (SoPhong, LoaiPhong, GhiChu) VALUES ('202', 'B', NULL);
INSERT INTO tPhong (SoPhong, LoaiPhong, GhiChu) VALUES ('203', 'A', NULL);
INSERT INTO tPhong (SoPhong, LoaiPhong, GhiChu) VALUES ('204', 'B', NULL);
INSERT INTO tPhong (SoPhong, LoaiPhong, GhiChu) VALUES ('205', 'A', NULL);
INSERT INTO tPhong (SoPhong, LoaiPhong, GhiChu) VALUES ('301', 'A', NULL);
INSERT INTO tPhong (SoPhong, LoaiPhong, GhiChu) VALUES ('302', 'B', '');
INSERT INTO tPhong (SoPhong, LoaiPhong, GhiChu) VALUES ('303', 'C', NULL);
INSERT INTO tPhong (SoPhong, LoaiPhong, GhiChu) VALUES ('304', 'C', NULL);
INSERT INTO tPhong (SoPhong, LoaiPhong, GhiChu) VALUES ('305', 'A', NULL);
INSERT INTO tPhong (SoPhong, LoaiPhong, GhiChu) VALUES ('401', 'A', NULL);
INSERT INTO tPhong (SoPhong, LoaiPhong, GhiChu) VALUES ('402', 'B', NULL);
INSERT INTO tPhong (SoPhong, LoaiPhong, GhiChu) VALUES ('403', 'C', NULL);
INSERT INTO tPhong (SoPhong, LoaiPhong, GhiChu) VALUES ('404', 'A', NULL);
INSERT INTO tPhong (SoPhong, LoaiPhong, GhiChu) VALUES ('405', 'B', NULL);
INSERT INTO tPhong (SoPhong, LoaiPhong, GhiChu) VALUES ('601', 'B', NULL);
INSERT INTO tPhong (SoPhong, LoaiPhong, GhiChu) VALUES ('608', 'C', NULL);

-- Lệnh xác nhận các thay đổi
COMMIT;