select * from TrongTai
CREATE TABLE TrongTai (
    MaTrongTai   VARCHAR2(10) PRIMARY KEY,
    TrongTaiQD   NUMBER
);

CREATE TABLE LoTrinh (
    MaLoTrinh    VARCHAR2(10) PRIMARY KEY,
    TenLoTrinh   NVARCHAR2(100),
    DonGia       NUMBER,
    ThoiGianQD   NUMBER
);

CREATE TABLE ChiTietVanTai (
    MaVT         NUMBER PRIMARY KEY,
    SoXe         NVARCHAR2(50),
    MaTrongTai   VARCHAR2(10),
    MaLoTrinh    VARCHAR2(10),
    SoLuongVT    NUMBER,
    NgayDi       DATE,
    NgayDen      DATE,
    CONSTRAINT fk_ctvt_trongtai FOREIGN KEY (MaTrongTai) REFERENCES TrongTai(MaTrongTai),
    CONSTRAINT fk_ctvt_lotrinh FOREIGN KEY (MaLoTrinh) REFERENCES LoTrinh(MaLoTrinh)
);
-- ========================
--  CHÈN DỮ LIỆU MẪU
-- ========================

-- Bảng LoTrinh
INSERT INTO LoTrinh VALUES ('DN', N'Đà Nẵng', 5000, 3);
INSERT INTO LoTrinh VALUES ('HN', N'Hà Nội', 10000, 5);
INSERT INTO LoTrinh VALUES ('NT', N'Nha Trang', 3000, 1);
INSERT INTO LoTrinh VALUES ('PK', N'Pleiku', 6000, 4);
INSERT INTO LoTrinh VALUES ('QN', N'Quảng Nam', 4000, 2);

-- Bảng TrongTai
INSERT INTO TrongTai VALUES ('50', 4);
INSERT INTO TrongTai VALUES ('51', 8);
INSERT INTO TrongTai VALUES ('52', 12);

-- Bảng ChiTietVanTai
INSERT INTO ChiTietVanTai VALUES (1,  N'333', '50', 'PK', 5,  TO_DATE('2014-05-01','YYYY-MM-DD'), TO_DATE('2014-05-03','YYYY-MM-DD'));
INSERT INTO ChiTietVanTai VALUES (2,  N'123', '52', 'QN', 10, TO_DATE('2014-05-03','YYYY-MM-DD'), TO_DATE('2014-05-04','YYYY-MM-DD'));
INSERT INTO ChiTietVanTai VALUES (3,  N'444', '50', 'NT', 2,  TO_DATE('2014-05-03','YYYY-MM-DD'), TO_DATE('2014-05-05','YYYY-MM-DD'));
INSERT INTO ChiTietVanTai VALUES (4,  N'333', '50', 'HN', 3,  TO_DATE('2014-05-04','YYYY-MM-DD'), TO_DATE('2014-05-10','YYYY-MM-DD'));
INSERT INTO ChiTietVanTai VALUES (5,  N'111', '51', 'NT', 6,  TO_DATE('2014-05-06','YYYY-MM-DD'), TO_DATE('2014-05-06','YYYY-MM-DD'));
INSERT INTO ChiTietVanTai VALUES (6,  N'222', '52', 'HN', 5,  TO_DATE('2014-05-10','YYYY-MM-DD'), TO_DATE('2014-05-16','YYYY-MM-DD'));
INSERT INTO ChiTietVanTai VALUES (7,  N'444', '50', 'HN', 3,  TO_DATE('2014-05-25','YYYY-MM-DD'), TO_DATE('2014-05-31','YYYY-MM-DD'));
INSERT INTO ChiTietVanTai VALUES (8,  N'111', '51', 'DN', 4,  TO_DATE('2014-05-10','YYYY-MM-DD'), TO_DATE('2014-05-12','YYYY-MM-DD'));
INSERT INTO ChiTietVanTai VALUES (9,  N'333', '50', 'PK', 4,  TO_DATE('2014-05-05','YYYY-MM-DD'), TO_DATE('2014-05-10','YYYY-MM-DD'));
INSERT INTO ChiTietVanTai VALUES (10, N'123', '52', 'HN', 14, TO_DATE('2014-05-07','YYYY-MM-DD'), TO_DATE('2014-05-15','YYYY-MM-DD'));


COMMIT;


-- ========================
--  KIỂM TRA DỮ LIỆU
-- ========================
SELECT * FROM TrongTai;
SELECT * FROM LoTrinh;
SELECT * FROM ChiTietVanTai;

SET SERVEROUTPUT ON;
declare
    message varchar2(20) := 'Hello, World!';
BEGIN
    dbms_output.put_line(message);
END;


--1. Tạo hàm có đầu vào là lộ trình, đầu ra là số xe, mã trọng tải, số lượng vận tải, ngày đi, ngày
--đến (SoXe, MaTrongTai, SoLuongVT, NgayDi, NgayDen.)
create or replace function fn_ThongTinVanTaiTheoLoTrinh
( p_MaLoTrinh VARCHAR2) return SYS_REFCURSOR 
IS
    v_cur SYS_REFCURSOR;
BEGIN
    OPEN v_cur FOR
        SELECT SOXE, MATRONGTAI,SOLUONGVT, NGAYDI, NGAYDEN
        FROM CHITIETVANTAI ctvt
        WHERE ctvt.malotrinh = p_MaLoTrinh;
    RETURN v_cur;
END;

declare
VAR c REFCURSOR;
EXEC :c := fn_ThongTinVanTaiTheoLoTrinh('HN');
PRINT c;
/
    
    
--2. Thiết lập hàm có đầu vào là số xe, đầu ra là thông tin về lộ trình
create or replace function fn_ThongTinLoTrinhTheoSoXe
( p_SOXE NVARCHAR2) return SYS_REFCURSOR
AS
    v_cur SYS_REFCURSOR;
BEGIN
    OPEN v_cur FOR
        SELECT *
        FROM LOTRINH lt 
        JOIN CHITIETVANTAI ctvt ON ctvt.MALOTRINH = lt.MALOTRINH
        WHERE ctvt.SoXe = p_SoXe;
    RETURN v_cur;
END;
/
select * from CHITIETVANTAI
VAR c REFCURSOR;
EXEC :c := fn_ThongTinLoTrinhTheoSoXe('333');
PRINT c;

--3.Tạo hàm có đầu vào là trọng tải, đầu ra là các số xe có trọng tải quy định lớn hơn hoặc bằng
--trọng tải đó
create or replace function fn_TimSoXeTheoTrongTai
(p_TrongTai NUMBER) return SYS_REFCURSOR
AS
    v_cur SYS_REFCURSOR;
BEGIN
    OPEN v_cur FOR
        SELECT *
        FROM CHITIETVANTAI ctvt 
        join TRONGTAI tt on tt.MATRONGTAI = ctvt.MATRONGTAI
        WHERE tt.TRONGTAIQD >= p_TRONGTAI;
    RETURN v_cur;
END;

var c REFCURSOR
EXEC :c := fn_TimSoXeTheoTrongTai('8')
PRINT c;

DECLARE
   v_cur SYS_REFCURSOR;
BEGIN
   v_cur := fn_TimSoXeTheoTrongTai(8);
   DBMS_SQL.RETURN_RESULT(v_cur);
END;
/


--4. Tạo hàm có đầu vào là trọng tải và mã lộ trình, đầu ra là số lượng xe có trọng tải quy định
--lớn hơn hoặc bằng trọng tải đó và thuộc lộ trình đó.
create or replace function fn_SoXeTheoTrongTai_LoTrinh
(p_TrongTaiQD in NUMBER, p_MaLoTrinh in VARCHAR2 ) return NUMBER
AS
    v_SoLuong NUMBER;
BEGIN 
    SELECT  COUNT(CTVT.SoXe)
    INTO    v_SoLuong 
    FROM    CHITIETVANTAI   ctvt
    JOIN    TRONGTAI        tt  on  CTVT.MATRONGTAI = TT.MATRONGTAI
    WHERE   TT.TRONGTAIQD >= p_TrongTaiQD
    AND     CTVT.MALOTRINH = p_MaLoTrinh;
    RETURN v_SoLuong;
END;
/
var c NUMBER
EXEC :c := fn_SoXeTheoTrongTai_LoTrinh(2, 'HN')
PRINT c;
    SELECT  *
    FROM    CHITIETVANTAI   ctvt
    JOIN    TRONGTAI        tt  on  CTVT.MATRONGTAI = TT.MATRONGTAI
    WHERE   TT.TRONGTAIQD >= 2
    AND     CTVT.MALOTRINH = 'HN';
select * from CHITIETVANTAI

--5. Tạo thủ tục có đầu vào Mã lộ trình đầu ra là số lượng xe thuộc lộ trình đó.
CREATE OR REPLACE PROCEDURE sp_SoXeTheoLoTrinh (
    p_MaLoTrinh IN NVARCHAR2,
    p_SoLuong OUT NUMBER
)
AS
BEGIN
    SELECT COUNT(DISTINCT SoXe)
    INTO p_SoLuong
    FROM ChiTietVanTai
    WHERE MaLoTrinh = p_MaLoTrinh;
END;
 DECLARE sl NUMBER;
 BEGIN sp_SoXeTheoLoTrinh('HN', sl); DBMS_OUTPUT.PUT_LINE('Số xe: ' || sl); END;
Set SERVEROUTPUT ON;

exec 
--6. Tạo thủ tục có đầu vào là mã lộ trình, năm vận tải, đầu ra là số tiền theo mã lộ trình và năm
--vận tải đó
--
--7. Tạo thủ tục có đầu vào là số xe, năm vận tải, đầu ra là số tiền theo số xe và năm vận tải đó
--đó
--8. Tạo thủ tục có đầu vào là mã trọng tải, đầu ra là số lượng xe vượt quá trọng tải quy định
--của mã trọng tải đó.
