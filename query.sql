CREATE DATABASE quan_ly_sinh_vien
use quan_ly_sinh_vien

DROP TABLE sinh_vien

CREATE TABLE sinh_vien(
  	ma int identity,
	ten nvarchar(50),
  	tuoi int,
  	gioi_tinh bit,
  	so_dien_thoai char(15),
  	PRIMARY KEY(ma)
)

CREATE TABLE sinh_vien(
  	ma int identity,
	ten nvarchar(50) NOT NULL,
  	ngay_sinh date NOT NULL,
  	gioi_tinh bit NOT NULL,
  	so_dien_thoai char(15),
  	PRIMARY KEY(ma)
)

INSERT INTO sinh_vien(ten, tuoi, gioi_tinh, so_dien_thoai)
VALUES (N'Tuấn', 20, 1, '0123456789'), (N'Nam', 21, 1, '0123456789')

INSERT INTO sinh_vien(ten, ngay_sinh, gioi_tinh, so_dien_thoai)
VALUES (N'Tuấn', '1997-2-1', 1, '0123456789'), (N'Nam', '2000-4-15', 1, '0123456789')

SELECT * FROM sinh_vien
WHERE ma > 2

SELECT * FROM sinh_vien
WHERE ten in ('Nam',N'Tuấn') --về mặt tối ưu thì "in" nhanh hơn "or"

SELECT * FROM sinh_vien
WHERE ten = 'Nam' and gioi_tinh = 1

SELECT * FROM sinh_vien
WHERE (ten = 'Nam' or gioi_tinh = 0) AND tuoi = 21

SELECT * FROM sinh_vien
WHERE (ten = 'Nam' or gioi_tinh = 0) AND tuoi = '2000-4-15'

DELETE FROM sinh_vien
WHERE ma = 3

UPDATE sinh_vien
SET
ten	= 'Nam vip'
WHERE ma = 2