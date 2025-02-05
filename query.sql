CREATE DATABASE quan_ly_sinh_vien
use quan_ly_sinh_vien

DROP TABLE sinh_vien

CREATE TABLE sinh_vien(
	ten_sinh_vien nvarchar(50),
  	tuoi int,
  	gioi_tinh bit,
  	so_dien_thoai char(15)
)

INSERT INTO sinh_vien(ten_sinh_vien, tuoi, gioi_tinh, so_dien_thoai)
VALUES (N'Tuấn', 20, 1, '0123456789')

SELECT * FROM sinh_vien