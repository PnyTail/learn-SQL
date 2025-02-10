-- Tạo cơ sở dữ liệu để quản lý sinh viên

-- Yêu cầu:

-- có thông tin sinh viên, lớp (*: môn, điểm)
-- có kiểm tra ràng buộc
-- 1.Thêm mỗi bảng số bản ghi nhất định
-- 2.Lấy ra tất cả sinh viên kèm thông tin lớp
-- 3.Đếm số sinh viên theo từng lớp
-- 4.Lấy sinh viên kèm thông tin điểm và tên môn
-- 5.(*) Lấy điểm trung bình của sinh viên của lớp LT
-- 6.(*) Lấy điểm trung bình của sinh viên của môn SQL
-- 7.(*) Lấy điểm trung bình của sinh viên theo từng lớp

-- ---------------------------------------------------

CREATE TABLE lop(
	ma int identity,
  	ten nvarchar(50) unique NOT null,
  	PRIMARY KEY(ma)
)

INSERT INTO lop(ten)
VALUES ('LT'), ('ATTT'), ('BTMT')

CREATE TABLE sinh_vien(
	ma int identity,
  	ten nvarchar(50) NOT null,
  	ma_lop int,
  	foreign KEY(ma_lop) references lop(ma),
  	CONSTRAINT CK_do_dai_ten check(len(ten) >= 2),
  	PRIMARY KEY(ma)
)

INSERT INTO sinh_vien(ten, ma_lop)
VALUES
('Long', 1), (N'Tuấn', 1), ('Anh', 2)

INSERT INTO sinh_vien(ten, ma_lop)
VALUES
('Long sky', null)

CREATE TABLE mon(
	ma int identity,
  	ten nvarchar(50) unique NOT null,
  	PRIMARY KEY(ma)
)

INSERT INTO mon(ten)
VALUES
('SQL'), ('PHP'), ('HTML')

CREATE TABLE diem(
	ma_mon int NOT null,
  	ma_sinh_vien int not null,
  	diem float,
  	CONSTRAINT CK_diem check(diem >= 0 AND diem <= 10),
  	FOREIGN KEY(ma_mon) references mon(ma),
  	FOREIGN KEY(ma_sinh_vien) references sinh_vien(ma),
  	PRIMARY KEY(ma_mon, ma_sinh_vien)
)

INSERT INTO diem
VALUES (1, 1, 3), (1, 2, 5), (2, 1, 10)

-- 2.Lấy ra tất cả sinh viên kèm thông tin lớp (nếu có)
SELECT * FROM sinh_vien
left JOIN lop on sinh_vien.ma_lop = lop.ma

-- 3.Đếm số sinh viên theo từng lớp
SELECT 
lop.ma,
lop.ten,
COUNT(sinh_vien.ma_lop) as so_luong_sinh_vien
FROM sinh_vien
right JOIN lop on sinh_vien.ma_lop = lop.ma
GROUP by lop.ma, lop.ten

-- 4.Lấy sinh viên kèm thông tin điểm và tên môn (lấy sinh viên có điểm kèm tên môn)
SELECT 
sinh_vien.ten,
diem.diem,
mon.ten
FROM sinh_vien
join diem on diem.ma_sinh_vien = sinh_vien.ma
JOIN mon on mon.ma = diem.ma_mon

-- lấy tất cả sinh viên (kèm điểm nếu có)
SELECT
sinh_vien.ten,
diem.diem,
mon.ten
FROM sinh_vien
left JOIN diem on diem.ma_sinh_vien = sinh_vien.ma
left join mon on mon.ma = diem.ma_mon

-- 5.(*) Lấy điểm trung bình của sinh viên của lớp LT

-- tự làm
SELECT
avg(diem)
FROM sinh_vien
JOIN diem ON diem.ma_sinh_vien = sinh_vien.ma
join lop on sinh_vien.ma_lop = lop.ma
WHERE lop.ten = 'LT'


-- video làm
SELECT
avg(diem)
FROM sinh_vien
JOIN diem on diem.ma_sinh_vien = sinh_vien.ma
right join lop on lop.ma = sinh_vien.ma_lop
WHERE lop.ten = 'LT'


-- 7.(*) Lấy điểm trung bình của sinh viên theo từng lớp
SELECT
lop.ma,
avg(diem)
FROM sinh_vien
join diem on diem.ma_sinh_vien = sinh_vien.ma
right join lop on lop.ma = sinh_vien.ma_lop
group by lop.ma


-- 6.(*) Lấy điểm trung bình của sinh viên của môn SQL
SELECT
*
FROM sinh_vien
JOIN diem on diem.ma_sinh_vien = sinh_vien.ma
right join mon on mon.ma = diem.ma_mon -- lấy tất cả các môn
WHERE
mon.ten = 'SQL'

SELECT
avg(diem)
FROM sinh_vien
JOIN diem on diem.ma_sinh_vien = sinh_vien.ma
right join mon on mon.ma = diem.ma_mon -- lấy tất cả các môn
WHERE
mon.ten = 'SQL'

SELECT
avg(diem)
FROM mon
left JOIN diem on mon.ma = diem.ma_mon
WHERE
mon.ten = 'SQL'


 








