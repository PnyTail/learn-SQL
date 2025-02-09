-- Tạo cơ sở dữ liệu để lưu thông tin kinh doanh của 1 cửa hàng

-- Yêu cầu có đủ:

-- 1.thông tin khách hàng
-- 2.thông tin sản phẩm
-- 3.thông tin hoá đơn


---------------------------------------------------

-- sửa bài tập buổi 6 - học buổi 7: nối bảng (P1)

CREATE TABLE lop(
	ma int identity,
  	ten nvarchar(50) unique NOT null,
  	PRIMARY KEY(ma)
)

INSERT into lop(ten)
VALUES ('LT'), ('ATTT')

INSERT into lop(ten)
VALUES ('hacker mu trang')

CREATE TABLE sinh_vien(
	ma int identity,
  	ten nvarchar(50) not null,
  	gioi_tinh bit not null default 0,
  	ma_lop int,
  	foreign KEY(ma_lop) references lop(ma),
  	PRIMARY KEY(ma)
)

INSERT INTO sinh_vien(ten, gioi_tinh, ma_lop)
VALUES ('Long', default, 1), (N'Tuấn', 1, 1), (N'Tuấn hacker', 1, 2)

INSERT INTO sinh_vien(ten)
VALUES ('Longsky')

-- inner join
SELECT * FROM sinh_vien
JOIN lop on lop.ma = sinh_vien.ma_lop

SELECT * FROM sinh_vien
left JOIN lop ON lop.ma = sinh_vien.ma_lop

SELECT * FROM sinh_vien
left JOIN lop ON lop.ma = sinh_vien.ma_lop
WHERE ma_lop is null

SELECT COUNT(*) FROM sinh_vien
inner join lop on sinh_vien.ma_lop = lop.ma
WHERE
lop.ten = 'LT'

-- đếm số sinh viên có lớp
-- count(*) vẫn đếm null
SELECT
lop.ma, COUNT(*) as N'số sinh viên'
FROM sinh_vien
right JOIN lop on sinh_vien.ma_lop = lop.ma
GROUP by lop.ma

-- 
SELECT
lop.ma, COUNT(sinh_vien.ma_lop) as N'số sinh viên'
FROM sinh_vien
right JOIN lop on sinh_vien.ma_lop = lop.ma
GROUP by lop.ma









