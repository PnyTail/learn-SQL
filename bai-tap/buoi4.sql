-- Sếp yêu cầu bạn thiết kế cơ sở dữ liệu quản lý lương nhân viên
-- Với điều kiện:

-- mã nhân viên không được phép trùng
-- lương là số nguyên dương
-- tên không được phép ngắn hơn 2 ký tự
-- tuổi phải lớn hơn 18
-- giới tính mặc định là nữ
-- ngày vào làm mặc định là hôm nay
-- (*) nghề nghiệp phải nằm trong danh sách ('IT','kế toán','doanh nhân thành đạt')
-- tất cả các cột không được để trống
-- 1.Công ty có 5 nhân viên
-- 2.Tháng này sinh nhật sếp, sếp tăng lương cho nhân viên sinh tháng này thành 100. (*: tăng lương cho mỗi bạn thêm 100)
-- 3.Dịch dã khó khăn, cắt giảm nhân sự, cho nghỉ việc bạn nào lương dưới 50. (*: xoá cả bạn vừa thêm 100 nếu lương cũ dưới 50). (**: đuổi cả nhân viên mới vào làm dưới 2 tháng)
-- 4.Lấy ra tổng tiền mỗi tháng sếp phải trả cho nhân viên. (*: theo từng nghề)
-- 5.Lấy ra trung bình lương nhân viên. (*: theo từng nghề)
-- 6.(*) Lấy ra các bạn mới vào làm hôm nay
-- 7.(*) Lấy ra 3 bạn nhân viên cũ nhất
-- 8.(**) Tách những thông tin trên thành nhiều bảng cho dễ quản lý, lương 1 nhân viên có thể nhập nhiều lần

-----------------------------------------------------------------------------------------------

CREATE TABLE nhan_vien(
	ma int identity,
  	ten nvarchar(50) not null,
  	ngay_sinh date not null,
  	gioi_tinh bit default 0,
  	ngay_vao_lam date default getdate() not null,
  	nghe_nghiep nvarchar(50) not null,
  	luong int not null,
  	-- lương là số nguyên dương
  	CONSTRAINT CK_luong_nguyen_duong check(luong >= 0),
  	-- tên không được phép ngắn hơn 2 ký tự
  	CONSTRAINT CK_do_dai_ten check(len(ten) >= 2),
  	-- tuổi phải lớn hơn 18
  	CONSTRAINT CK_tuoi check(year(getdate()) - year(ngay_sinh) > 18),
  	-- (*) nghề nghiệp phải nằm trong danh sách ('IT','kế toán','doanh nhân thành đạt')
	CONSTRAINT CK_nghe_nghiep check(nghe_nghiep in ('IT', N'kế toán', N'doanh nhân thành đạt')),
  	PRIMARY KEY(ma)
)

-- 1.Công ty có 5 nhân viên
INSERT INTO nhan_vien(ten, ngay_sinh, gioi_tinh, ngay_vao_lam, nghe_nghiep, luong)
VALUES
('Long', '1997-01-01', 1, default, 'IT', 100),
(N'Tuấn', '2000-01-01', 0, default, N'doanh nhân thành đạt', 200),
(N'Anh', '2000-09-01', 1, default, N'Kế toán', 30)

INSERT INTO nhan_vien(ten, ngay_sinh, gioi_tinh, ngay_vao_lam, nghe_nghiep, luong)
VALUES
('Long 2', '1997-01-01', 1, '2025-03-1', 'IT', 150),
(N'Tuấn 2', '2000-01-01', 0, '2025-04-2', N'doanh nhân thành đạt', 60),
(N'Anh 2', '2000-09-01', 1, '2025-05-3', N'Kế toán', 20)

INSERT INTO nhan_vien(ten, ngay_sinh, gioi_tinh, ngay_vao_lam, nghe_nghiep, luong)
VALUES
('Long', '1997-01-01', 0, '2025-03-1', 'IT', 5000)

SELECT * FROM nhan_vien

-- 2.Tháng này sinh nhật sếp, sếp tăng lương cho nhân viên sinh tháng này thành 100.
UPDATE
nhan_vien
SET
luong = 100
WHERE
month(ngay_sinh) = month(getdate())

-- (*: tăng lương cho mỗi bạn thêm 100)
UPDATE
nhan_vien
SET
luong += 100

-- 3.Dịch dã khó khăn, cắt giảm nhân sự, cho nghỉ việc bạn nào lương dưới 50.
DELETE FROM nhan_vien
WHERE
luong < 50

-- (*: xoá cả bạn vừa thêm 100 nếu lương cũ dưới 50)
DELETE FROM nhan_vien
WHERE
luong < 50 + 100
AND
month(ngay_sinh) = month(getdate())

--(**: đuổi cả nhân viên mới vào làm dưới 2 tháng)
DELETE FROM nhan_vien
WHERE
datediff(month, ngay_vao_lam, getdate()) < 2
AND
ngay_vao_lam < getdate()

-- 4.Lấy ra tổng tiền mỗi tháng sếp phải trả cho nhân viên. (*: theo từng nghề)
SELECT sum(luong) FROM nhan_vien

-- (*: theo từng nghề)
SELECT nghe_nghiep, sum(luong) FROM nhan_vien
GROUP BY nghe_nghiep

-- 5.Lấy ra trung bình lương nhân viên. (*: theo từng nghề)
SELECT avg(luong) FROM nhan_vien

SELECT nghe_nghiep, avg(luong) as trung_binh_luong FROM nhan_vien
GROUP by nghe_nghiep

-- 6.(*) Lấy ra các bạn mới vào làm hôm nay
SELECT * FROM nhan_vien
WHERE
ngay_vao_lam = cast(getdate() as date)
--datediff(day, ngay_vao_lam, getdate()) = 0

-- limit
-- 7.(*) Lấy ra 3 bạn nhân viên cũ nhất
SELECT top 3 * FROM nhan_vien
ORDER BY ngay_vao_lam ASC

-- limit offset: bỏ qua 3 dòng đầu để lấy 3 dòng tiếp theo (bỏ qua)
SELECT * FROM nhan_vien
ORDER BY ngay_vao_lam ASC
offset 3 rows -- bỏ qua
fetch next 3 rows only -- fetch: lấy

-- MySQL
-- SELECT * FROM nhan_vien
-- ORDER BY ngay_vao_lam ASC
-- limit 3 offset 3

SELECT ten, sum(luong) FROM nhan_vien
GROUP by ten

SELECT ten, gioi_tinh, sum(luong) FROM nhan_vien
GROUP by ten, gioi_tinh







