create database HoVietTung_23120949_de02
use HoVietTung_23120949_de02
select * from hvtCatalog
INSERT INTO hvtCatalog (hvtCateName, hvtCatePrice, hvtCateQty, hvtPicture, hvtActive)
VALUES 
(N'Bùi Hải Đức', 0, 1, NULL, 1), 
(N'Khúc Phương Nam', 100.50, 10, 'A.jpg', 1), 
(N'Trần Tiến Sơn', 200.75, 5, 'B.jpg', 0); 


CREATE TABLE hvtCatalog (
    hvtId INT IDENTITY(1,1) PRIMARY KEY,
    hvtCateName NVARCHAR(100) NOT NULL, 
    hvtCatePrice DECIMAL(18,2) NOT NULL, 
    hvtCateQty INT NOT NULL,
    hvtPicture NVARCHAR(255), 
    hvtActive BIT NOT NULL
);

select * from hvtCatalog
