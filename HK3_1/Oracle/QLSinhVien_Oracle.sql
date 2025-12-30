-- Schema: QLSinhVien chuyển sang Oracle
-- Lưu ý: chỉnh NLS nếu cần để lưu Unicode (NVARCHAR2 đã dùng)

-- Bảng DMKhoa
CREATE TABLE DMKhoa (
    MaKhoa CHAR(2) NOT NULL,
    TenKhoa NVARCHAR2(30) NOT NULL,
    CONSTRAINT DMKhoa_pk PRIMARY KEY (MaKhoa)
);

-- Bảng DMMonHoc
CREATE TABLE DMMonHoc (
    MaMH CHAR(2) NOT NULL,
    TenMH NVARCHAR2(25) NOT NULL,
    SoTiet NUMBER(3),        -- tinyint -> NUMBER(3)
    GhiChu NCHAR(50),
    CONSTRAINT DMMH_MaMH_pk PRIMARY KEY (MaMH)
);

-- Bảng DSSinhVien
CREATE TABLE DSSinhVien (
    MaSV CHAR(3) NOT NULL,
    HoSV NVARCHAR2(15) NOT NULL,
    TenSV NVARCHAR2(7) NOT NULL,
    Phai NCHAR(7),
    NgaySinh DATE NOT NULL,
    NoiSinh NVARCHAR2(20),
    MaKhoa CHAR(2),
    HocBong NUMBER,          -- float -> NUMBER
    CONSTRAINT DSSinhVien_pk PRIMARY KEY (MaSV)
);

-- Bảng KetQua
CREATE TABLE KetQua (
    MaSV CHAR(3) NOT NULL,
    MaMH CHAR(2) NOT NULL,
    LanThi NUMBER(3) NOT NULL,     -- tinyint -> NUMBER(3)
    Diem NUMBER(4,2),
    CONSTRAINT KetQua_pk PRIMARY KEY (MaSV, MaMH, LanThi)
);

-- Dữ liệu cho DMKhoa
INSERT INTO DMKhoa (MaKhoa, TenKhoa) VALUES ('AV', N'Anh Văn');
INSERT INTO DMKhoa (MaKhoa, TenKhoa) VALUES ('TH', N'Tin Học');
INSERT INTO DMKhoa (MaKhoa, TenKhoa) VALUES ('TR', N'Triết');
INSERT INTO DMKhoa (MaKhoa, TenKhoa) VALUES ('VL', N'Vật Lý');

-- Dữ liệu cho DMMonHoc
INSERT INTO DMMonHoc (MaMH, TenMH, SoTiet, GhiChu) VALUES ('01', N'Cơ Sở Dữ Liệu', 45, NULL);
INSERT INTO DMMonHoc (MaMH, TenMH, SoTiet, GhiChu) VALUES ('02', N'Trí Tuệ Nhân Tạo', 45, NULL);
INSERT INTO DMMonHoc (MaMH, TenMH, SoTiet, GhiChu) VALUES ('03', N'Truyền Tin', 45, NULL);
INSERT INTO DMMonHoc (MaMH, TenMH, SoTiet, GhiChu) VALUES ('04', N'Đồ Họa', 60, NULL);
INSERT INTO DMMonHoc (MaMH, TenMH, SoTiet, GhiChu) VALUES ('05', N'Văn Phạm', 60, NULL);

-- Dữ liệu cho DSSinhVien
INSERT INTO DSSinhVien (MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKhoa, HocBong)
VALUES ('A01', N'Nguyễn Thị', N'Hải', N'Nữ     ', TO_DATE('1990-02-23','YYYY-MM-DD'), N'Hà Nội', 'TH', 130000);

INSERT INTO DSSinhVien (MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKhoa, HocBong)
VALUES ('A02', N'Trần Văn', N'Chính', N'Nam    ', TO_DATE('1992-12-24','YYYY-MM-DD'), N'Bình Định', 'VL', 150000);

INSERT INTO DSSinhVien (MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKhoa, HocBong)
VALUES ('A03', N'Lê Thu Bạch', N'Yến', N'Nữ     ', TO_DATE('1990-02-21','YYYY-MM-DD'), N'TP Hồ Chí Minh', 'TH', 170000);

INSERT INTO DSSinhVien (MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKhoa, HocBong)
VALUES ('A04', N'Trần Anh', N'Tuấn', N'Nam    ', TO_DATE('1990-12-20','YYYY-MM-DD'), N'Hà Nội', 'AV', 80000);

INSERT INTO DSSinhVien (MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKhoa, HocBong)
VALUES ('A05', N'Hoàng Khánh', N'Ngọc', N'Nữ     ', TO_DATE('2000-11-10','YYYY-MM-DD'), N'Hà Nội', 'TH', 300000);

INSERT INTO DSSinhVien (MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKhoa, HocBong)
VALUES ('B01', N'Trần Thanh', N'Mai', N'Nữ     ', TO_DATE('1991-08-12','YYYY-MM-DD'), N'Hải Phòng', 'TR', 0);

INSERT INTO DSSinhVien (MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKhoa, HocBong)
VALUES ('B02', N'Trần Thị Thu', N'Thủy', N'Nữ     ', TO_DATE('1991-01-02','YYYY-MM-DD'), N'TP Hồ Chí Minh', 'AV', 0);

INSERT INTO DSSinhVien (MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKhoa, HocBong)
VALUES ('B03', N'Trần Thị', N'Hiền', N'Nữ     ', TO_DATE('2000-01-01','YYYY-MM-DD'), N'Hà Nội', 'AV', NULL);

INSERT INTO DSSinhVien (MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKhoa, HocBong)
VALUES ('B04', N'Lê Văn', N'Hùng', N'Nam    ', TO_DATE('2000-02-01','YYYY-MM-DD'), N'Hà Nội', 'AV', NULL);

INSERT INTO DSSinhVien (MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKhoa, HocBong)
VALUES ('B05', N'Lê Quang', N'Hưng', N'Nam    ', TO_DATE('2000-01-01','YYYY-MM-DD'), N'TP Hồ Chí Minh', 'VL', NULL);

INSERT INTO DSSinhVien (MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKhoa, HocBong)
VALUES ('B06', N'Nguyễn Mai', N'Hương', N'Nữ     ', TO_DATE('2000-01-01','YYYY-MM-DD'), N'Hưng Yên', 'TH', NULL);

INSERT INTO DSSinhVien (MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKhoa, HocBong)
VALUES ('B07', N'Hoàng Thanh', N'Hằng', N'Nữ     ', TO_DATE('2000-02-02','YYYY-MM-DD'), N'Thái Nguyên', 'TH', NULL);

-- Dữ liệu cho KetQua
INSERT INTO KetQua (MaSV, MaMH, LanThi, Diem) VALUES ('A01','01',1, 3.00);
INSERT INTO KetQua (MaSV, MaMH, LanThi, Diem) VALUES ('A01','01',2, 6.00);
INSERT INTO KetQua (MaSV, MaMH, LanThi, Diem) VALUES ('A01','02',2, 6.00);
INSERT INTO KetQua (MaSV, MaMH, LanThi, Diem) VALUES ('A01','03',1, 5.00);
INSERT INTO KetQua (MaSV, MaMH, LanThi, Diem) VALUES ('A02','01',1, 4.50);
INSERT INTO KetQua (MaSV, MaMH, LanThi, Diem) VALUES ('A02','01',2, 7.00);
INSERT INTO KetQua (MaSV, MaMH, LanThi, Diem) VALUES ('A02','03',1, 10.00);
INSERT INTO KetQua (MaSV, MaMH, LanThi, Diem) VALUES ('A02','05',1, 9.00);
INSERT INTO KetQua (MaSV, MaMH, LanThi, Diem) VALUES ('A03','01',1, 2.00);
INSERT INTO KetQua (MaSV, MaMH, LanThi, Diem) VALUES ('A03','01',2, 5.00);
INSERT INTO KetQua (MaSV, MaMH, LanThi, Diem) VALUES ('A03','03',1, 2.50);
INSERT INTO KetQua (MaSV, MaMH, LanThi, Diem) VALUES ('A03','03',2, 4.00);
INSERT INTO KetQua (MaSV, MaMH, LanThi, Diem) VALUES ('A04','05',2, 10.00);
INSERT INTO KetQua (MaSV, MaMH, LanThi, Diem) VALUES ('B01','01',1, 7.00);
INSERT INTO KetQua (MaSV, MaMH, LanThi, Diem) VALUES ('B01','03',1, 2.50);
INSERT INTO KetQua (MaSV, MaMH, LanThi, Diem) VALUES ('B01','03',2, 5.00);
INSERT INTO KetQua (MaSV, MaMH, LanThi, Diem) VALUES ('B02','02',1, 6.00);
INSERT INTO KetQua (MaSV, MaMH, LanThi, Diem) VALUES ('B02','04',1, 10.00);

-- Ràng buộc khóa ngoại
ALTER TABLE DSSinhVien
  ADD CONSTRAINT DMKhoa_MaKhoa_fk FOREIGN KEY (MaKhoa) REFERENCES DMKhoa (MaKhoa);

ALTER TABLE KetQua
  ADD CONSTRAINT DMMH_MaMH_fk FOREIGN KEY (MaMH) REFERENCES DMMonHoc (MaMH);

ALTER TABLE KetQua
  ADD CONSTRAINT KetQua_MaSV_fk FOREIGN KEY (MaSV) REFERENCES DSSinhVien (MaSV);

COMMIT;


-- BAI TAP VIEW
--1. Tạo View danh sách sinh viên, gồm các thông tin sau: Mã sinh viên, Họ sinh viên,
--Tên sinh viên, Học bổng.


create or replace view v_DanhSachSV as
select MASV, HOSV, TENSV, HOCBONG from DSSINHVIEN

--2. Tạo view Liệt kê các sinh viên có học bổng từ 150,000 trở lên và sinh ở Hà Nội, gồm
--các thông tin: Họ tên sinh viên, Mã khoa, Nơi sinh, Học bổng.

create or replace view v_HocBong_HaNoi as
select  HOSV ||' ' || TENSV as HOTEN, MAKHOA, NOISINH, HOCBONG
from DSSINHVIEN
where   HOCBONG >= 150000 and NOISINH like N'Hà Nội'

--3. Tạo view liệt kê những sinh viên nam của khoa Anh văn và khoa tin học, gồm các thông
--tin: Mã sinh viên, Họ tên sinh viên, tên khoa, Phái.

create or replace view v_Nam_AnhTin as
select MASV, HOSV ||' ' || TENSV as HOTEN, DMKHOA.TENKHOA, Phai
from DSSINHVIEN join DMKHOA on DSSINHVIEN.MAKHOA = DMKHOA.MAKHOA
where PHAI = 'Nam' AND TENKHOA IN (N'Anh Văn', N'Tin Học');

--4. Tạo view gồm những sinh viên có tuổi từ 20 đến 25, thông tin gồm: Họ tên sinh viên,
--Tuổi, Tên khoa.

create or replace view v_SVTuoi20Den25 as
select HOSV ||' ' || TENSV as HOTEN, DMKHOA.TENKHOA, FLOOR(MONTHS_BETWEEN(SYSDATE, NgaySinh)/12) AS Tuoi
from DSSINHVIEN join DMKHOA on DSSINHVIEN.MAKHOA = DMKHOA.MAKHOA
where FLOOR(MONTHS_BETWEEN(SYSDATE, NgaySinh)/12) BETWEEN 20 and 25;

--5. Tạo view cho biết thông tin về mức học bổng của các sinh viên, gồm: Mã sinh viên,
--Phái, Mã khoa, Mức học bổng. Trong đó, mức học bổng sẽ hiển thị là “Học bổng cao”
--nếu giá trị của field học bổng lớn hơn 500,000 và ngược lại hiển thị là “Mức trung bình”
create or replace view v_MucHocBong as
select  MASV ,HOSV ||' ' || TENSV as HOTEN, MAKHOA,PHAI, 
    case 
        WHEN HOCBONG > 500000 then 'Học bổng cao'
        else 'Mức trung bình'
    end as MucHocBong
from DSSINHVIEN

--6. Tạo view đưa ra thông tin những sinh viên có học bổng lớn hơn bất kỳ học bổng của
--sinh viên học khóa anh 
create or replace view v_SV_HbHonAnhVan as
select  MASV ,HOSV ||' ' || TENSV as HOTEN, HOCBONG from DSSINHVIEN
where HOCBONG > (select max(HocBong) from DSSINHVIEN s join DMKHOA k on s.MAKHOA = k.MAKHOA where k.TENKHOA = N'Anh Văn')

--7. Tạo view đưa ra thông tin những sinh viên đạt điểm cao nhất trong từng môn.
CREATE OR REPLACE VIEW v_SV_DiemCaoNhat AS
SELECT KQ.MaMH, MH.TenMH, SV.MASV,
       SV.HoSV || ' ' || SV.TenSV AS HoTen, KQ.Diem
FROM KETQUA KQ
JOIN DSSINHVIEN SV ON KQ.MaSV = SV.MaSV
JOIN DMMONHOC MH ON KQ.MaMH = MH.MaMH
WHERE KQ.Diem = (
    SELECT MAX(DIEM)
    FROM KETQUA
    WHERE MAMH = KQ.MAMH
);
--8. Tạo view đưa ra những sinh viên chưa thi môn cơ sở dữ liệu.
CREATE OR REPLACE VIEW v_SV_ChuaThi_CSDL AS
SELECT MaSV, HoSV || ' ' || TenSV AS HoTen from DSSINHVIEN sv
where sv.MASV not in(
    select kq.MASV
    from KETQUA kq
    join DMMONHOC mh on kq.MAMH = mh.MAMH
    where mh.TENMH = 'Cơ Sở Dữ Liệu'
);


--9. Tạo view đưa ra thông tin những sinh viên không trượt môn nào.
CREATE OR REPLACE VIEW v_SV_KhongTruot AS
SELECT MaSV, HoSV || ' ' || TenSV AS HoTen
FROM DSSINHVIEN SV
WHERE NOT EXISTS (
    SELECT *
    FROM KETQUA KQ
    WHERE KQ.MASV = SV.MASV AND KQ.Diem < 5
);

select * from DSSINHVIEN sv
where MASV not in(
    select MASV
    from KETQUA kq
    where kq.DIEM < 5
)

-- BAI TAP FUNCTION VA PROCEDURES

CREATE OR REPLACE PROCEDURE pcd_indssinhvien
IS
      r_dssinhvien DSSINHVIEN%ROWTYPE;
BEGIN
        SELECT *
        INTO r_dssinhvien
        FROM DSSINHVIEN
        WHERE ROWNUM = 5;
--    FOR r IN (SELECT * FROM DSSINHVIEN) LOOP
--        DBMS_OUTPUT.PUT_LINE(
--            TO_CHAR(r.MASV) || ' - ' || r.HOSV || ' ' || r.TENSV || ' - ' || TO_CHAR(r.NGAYSINH, 'DD/MM/YYYY')
--        );
--    END LOOP;
        DBMS_OUTPUT.PUT_LINE(
        TO_CHAR(r_dssinhvien.MASV) || ' - ' ||
        r_dssinhvien.HOSV || ' ' || r_dssinhvien.TENSV || ' - ' ||
        TO_CHAR(r_dssinhvien.NGAYSINH, 'DD/MM/YYYY')
    );
END;

BEGIN
    pcd_indssinhvien;
END;

SET SERVEROUTPUT ON;
exec pcd_indssinhvien
drop procedure pcd_indssinhvien

CREATE OR REPLACE PROCEDURE pcd_indssinhvien
IS
    CURSOR cur_sv IS SELECT * FROM DSSINHVIEN;
    r_dssinhvien DSSINHVIEN%ROWTYPE;
BEGIN
    OPEN cur_sv;
    LOOP
        FETCH cur_sv INTO r_dssinhvien;
        EXIT WHEN cur_sv%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            TO_CHAR(r_dssinhvien.MASV) || ' - ' ||
            r_dssinhvien.HOSV || ' ' || r_dssinhvien.TENSV || ' - ' ||
            TO_CHAR(r_dssinhvien.NGAYSINH, 'DD/MM/YYYY')
        );
    END LOOP;
    CLOSE cur_sv;
END;

exec pcd_indssinhvien


select * from KETQUA
--BÀI TẬP TRIGGER
CREATE OR REPLACE

