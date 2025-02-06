Buổi 2 - Những lệnh cơ bản

-- Tạo bảng lưu thông tin khách hàng (mã, họ tên, số điện thoại, địa chỉ, giới tính, ngày sinh)

--     1.Thêm 5 khách hàng
--     2.Hiển thị chỉ họ tên và số điện thoại của tất cả khách hàng
--     3.Cập nhật khách có mã là 2 sang tên Tuấn
--     4.Xoá khách hàng có mã lớn hơn 3 và giới tính là Nam
--     5.(*) Lấy ra khách hàng sinh tháng 1
--     6.(*) Lấy ra khách hàng có họ tên trong danh sách .(Anh,Minh,Đức) và giới tính Nam hoặc chỉ cần năm sinh trước 2000
--     7.(**) Lấy ra khách hàng có tuổi lớn hơn 18
--     8.(**) Lấy ra 3 khách hàng mới nhất
--     9.(**) Lấy ra khách hàng có tên chứa chữ T
--     10.(***) Thay đổi bảng sao cho chỉ nhập được ngày sinh bé hơn ngày hiện tại


CREATE TABLE khach_hang(
	ma int identity,
  	ho_ten nvarchar(50) NOT NULL,
  	so_dien_thoai char(15) NOT NULL,
  	dia_chi ntext NOT NULL,
  	gioi_tinh bit NOT NULL,
  	ngay_sinh date NOT NULL,
  	PRIMARY KEY(ma)
)

INSERT INTO khach_hang(ho_ten, so_dien_thoai, dia_chi, gioi_tinh, ngay_sinh)
VALUES 
(N'Long', '123', 'HN', 1, '1997-01-01'),
(N'Tuấn', '234', 'HP', 0, '2000-01-01'),
(N'Anh', '135', 'HCM', 1, '1996-01-01')

SELECT * FROM khach_hang

--Cập nhật khách có mã là 2 sang tên Tuấn
UPDATE khach_hang SET ho_ten = N'Tuấn' WHERE ma = 2

--5.(*) Lấy ra khách hàng sinh tháng 1
SELECT * FROM khach_hang
WHERE month(ngay_sinh) = 1

--Lấy ra khách hàng có họ tên trong danh sách .(Anh,Minh,Đức) và giới tính Nam hoặc chỉ cần năm sinh trước 2000
SELECT * FROM khach_hang
WHERE (ho_ten IN('Anh', 'Minh', N'Đức') AND gioi_tinh = 1) OR year(ngay_sinh) < 2000
WHERE (ho_ten IN('Anh', 'Minh', N'Đức') AND gioi_tinh = 1) OR ngay_sinh < '2000-01-01'

--Lấy ra khách hàng có tuổi lớn hơn 18
SELECT *, year(ngay_sinh) as nam_sinh FROM khach_hang

SELECT * FROM khach_hang
WHERE year(getdate()) - year(ngay_sinh) > 18

--date diff sql

--Lấy ra 3 khách hàng mới nhất
SELECT top 3 *
FROM khach_hang
ORDER by ma desc

--Lấy ra khách hàng có tên chứa chữ T
SELECT *
FROM khach_hang
WHERE ho_ten LIKE '%T%'

-- bên MySQl không phân biệt chữ hoa thường và unicode, MS SQL Server thì có phân biệt unicode 
-- => MySQL không chặt chẽ bằng MS SQL Server
-- like không phân biệt hoa thường

-- Thay đổi bảng sao cho chỉ nhập được ngày sinh bé hơn ngày hiện tại
ALTER TABLE khach_hang
add check(ngay_sinh < getdate())

-- Thay đổi bảng sao cho chỉ nhập được giới tính nam với tên Long
ALTER TABLE khach_hang
add CONSTRAINT CK_gioi_tinh_kem_ten_long check((gioi_tinh = 1 AND ho_ten = 'Long') OR ho_ten != 'Long')

--default
ALTER TABLE khach_hang
ADD CONSTRAINT gioi_tinh_mac_dinh
default 1 for gioi_tinh














