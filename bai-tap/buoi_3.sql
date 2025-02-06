-- Tạo bảng lưu thông tin điểm của sinh viên (mã, họ tên, điểm lần 1, điểm lần 2)

-- Với điều kiện:
    -- điểm không được phép nhỏ hơn 0 và lớn hơn 10
    -- điểm lần 1 nếu không nhập mặc định sẽ là 5
    -- (*) điểm lần 2 không được nhập khi mà điểm lần 1 lớn hơn hoặc bằng 5
    -- (**) tên không được phép ngắn hơn 2 ký tự
    -- 1.Điền 5 sinh viên kèm điểm
    -- 2.Lấy ra các bạn điểm lần 1 hoặc lần 2 lớn hơn 5
    -- 3.Lấy ra các bạn qua môn ngay từ lần 1
    -- 4.Lấy ra các bạn trượt môn
    -- 5.(*) Đếm số bạn qua môn sau khi thi lần 2
    -- 6.(**) Đếm số bạn cần phải thi lần 2 (tức là thi lần 1 chưa qua nhưng chưa nhập điểm lần 2)

--DROP TABLE sinh_vien

ALTER TABLE sinh_vien
DROP CONSTRAINT nhap_diem_lan_2

CREATE TABLE sinh_vien(
	ma int identity,
  	ho_ten nvarchar(50),
  	diem_lan_1 float default 5,
  	diem_lan_2 float,
  	PRIMARY KEY(ma),
  	CONSTRAINT check_gioi_han_diem check(diem_lan_1 >= 0 and diem_lan_1 <= 10 and diem_lan_2 >= 0 and diem_lan_2 <= 10)
)

-- (*) điểm lần 2 không được nhập khi mà điểm lần 1 lớn hơn hoặc bằng 5
ALTER TABLE sinh_vien
ADD CONSTRAINT check_nhap_diem_lan_2 check((diem_lan_1 >= 5 AND diem_lan_2 is null) OR diem_lan_1 < 5)

INSERT INTO sinh_vien(ho_ten, diem_lan_1, diem_lan_2)
VALUES (N'Tuấn 2', 7, null)

-- (**) tên không được phép ngắn hơn 2 ký tự
ALTER TABLE sinh_vien
add CONSTRAINT check_do_dai_ten check(len(ho_ten) >= 2)


-- 1.Điền 5 sinh viên kèm điểm
INSERT INTO sinh_vien(ho_ten, diem_lan_1, diem_lan_2)
VALUES ('Long', 1, 3), (N'Tuấn', 3, 7), ('Anh', 6, null)

SELECT * FROM sinh_vien

-- 2.Lấy ra các bạn điểm lần 1 hoặc lần 2 lớn hơn 5
SELECT * FROM sinh_vien
WHERE
diem_lan_1 > 5 OR diem_lan_2 > 5

-- 3.Lấy ra các bạn qua môn ngay từ lần 1
SELECT * FROM sinh_vien
WHERE
diem_lan_1 >= 5

-- 4.Lấy ra các bạn trượt môn (lần 1 và lần 2 đều dưới 5)
SELECT * FROM sinh_vien
WHERE
diem_lan_1 < 5 AND diem_lan_2 < 5

-- (*) Đếm số bạn qua môn sau khi thi 2 lần
SELECT COUNT(*) FROM sinh_vien
WHERE
diem_lan_1 >= 5 OR diem_lan_2 >=5

-- (*) Đếm số bạn trượt lần 1 và qua môn sau lần 2
--có check phía trên đảm bảo điểm lần 1 phải < 5 thì điểm lần 2 mới được nhập
-- hạn chế ghi có dấu trong code
--SELECT COUNT(*) as N'số bạn trượt lần 1 và qua môn lần 2' FROM sinh_vien
--WHERE
--diem_lan_2 >= 5

SELECT COUNT(*) as so_ban_truot_lan_1_va_qua_mon_lan_2 FROM sinh_vien
WHERE
diem_lan_2 >= 5

SELECT * FROM sinh_vien
WHERE
diem_lan_2 >= 5

-- 6.(**) Đếm số bạn cần phải thi lần 2 (tức là thi lần 1 chưa qua nhưng chưa nhập điểm lần 2)
INSERT INto sinh_vien(ho_ten, diem_lan_1, diem_lan_2)
VALUES ('Anhhh2', 3, null)

--thi lần 1 chưa qua nhưng chưa nhập điểm lần 2
SELECT * FROM sinh_vien
WHERE
diem_lan_1 < 5 AND diem_lan_2 is null

SELECT COUNT(*) FROM sinh_vien
WHERE
diem_lan_1 < 5 AND diem_lan_2 is null

SELECT * FROM sinh_vien
WHERE diem_lan_2 is not null

SELECT COUNT(*) FROM sinh_vien
WHERE diem_lan_2 is not null
--2 câu trên dưới này là như nhau
SELECT COUNT(diem_lan_2) FROM sinh_vien
--count chỉ đếm những thằng không null

--tổng
SELECT sum(diem_lan_2) FROM sinh_vien
--avg: trung bình

INSERT INTO sinh_vien(ho_ten, diem_lan_1, diem_lan_2)
VALUES (N'Long', 7, null)

SELECT * FROM sinh_vien

SELECT COUNT(*) FROM sinh_vien
WHERE
ho_ten = 'Long'

-- DISTINCT: không trùng nhau, và nó sắp xếp lại. sắp xếp lại để so sánh với nhau
SELECT DISTINCT ho_ten FROM sinh_vien
SELECT COUNT(DISTINCT ho_ten) FROM sinh_vien

--order by, group by, limit, offset
















