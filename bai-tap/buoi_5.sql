-- Ban lãnh đạo thành phố yêu cầu bạn tạo bảng lưu các con vật trong sở thú

-- Với điều kiện tự bạn quy ước (hãy áp dụng check và default)

-- 1.Sở thú hiện có 7 con
-- 2.Thống kê có bao nhiêu con 4 chân
-- 3.Thống kê số con tương ứng với số chân
-- 4.Thống kê số con theo môi trường sống
-- 5.Thống kê tuổi thọ trung bình theo môi trường sống
-- 6.Lấy ra 3 con có tuổi thọ thọ cao nhất
-- 7.(*) Tách những thông tin trên thành 2 bảng cho dễ quản lý (1 môi trường sống gồm nhiều con)

-- -----------------------------------------------------------------------------------------------

CREATE TABLE dong_vat(
	ma int identity,
  	ten nvarchar(50) not null unique,
  	so_chan int default 0 not null,
  	tuoi_tho int not null,
  	moi_truong_song nvarchar(50) not null,
  	CONSTRAINT CK_ten check (len(ten) > 2),
  	CONSTRAINT CK_so_chan check(so_chan >= 0 AND so_chan < 100 AND so_chan % 2 = 0),
  	CONSTRAINT CK_tuoi_tho check(tuoi_tho > 0),
  	PRIMARY KEY(ma)
)

-- 1.Sở thú hiện có 7 con
INSERT INto dong_vat(ten, so_chan, tuoi_tho, moi_truong_song)
VALUES (N'cún', 4, 20, N'trong nhà'), (N'mèo', 4, 9, N'trong nhà'), (N'cá cược', default, 10, N'dưới nước')

-- 2.Thống kê có bao nhiêu con 4 chân
SELECT COUNT(*) FROM dong_vat
WHERE so_chan = 4

-- 3.Thống kê số con tương ứng với số chân
SELECT so_chan,
COUNT(*) AS so_con
FROM dong_vat
GROUP BY so_chan

-- 4.Thống kê số con theo môi trường sống
SELECT moi_truong_song,
COUNT(*) AS so_con
FROM dong_vat
GROUP BY moi_truong_song

-- 5.Thống kê tuổi thọ trung bình theo môi trường sống
SELECT moi_truong_song,
avg(tuoi_tho) AS tuoi_tho_trung_binh
FROM dong_vat
GROUP BY moi_truong_song

-- 6.Lấy ra 3 con có tuổi thọ thọ cao nhất
SELECT top 3 *
FROM dong_vat
ORDER BY tuoi_tho DESC

-- Lấy ra 1 con có tuổi thọ thọ cao nhất
SELECT * FROM dong_vat
ORDER BY tuoi_tho DESC
offset 1 ROW
fetch first 1 row only

	-- MySQL
    -- SELECT * FROM dong_vat
    -- ORDER BY tuoi_tho DESC
    -- LIMIT 1 offset 1 -- limit 1, 1

-- 7.(*) Tách những thông tin trên thành 2 bảng cho dễ quản lý (1 môi trường sống gồm nhiều con)
-- 1 môi trường - n động vật
CREATE TABLE moi_truong_song(
	ma int identity,
  	ten nvarchar(50) unique not null,
  	PRIMARY KEY(ma)
)

INSERT INTO moi_truong_song(ten)
VALUES (N'trong nhà'), (N'ngoài trời')

SELECT * FROM moi_truong_song

DELETE FROM moi_truong_song

-- DROP TABLE dong_vat

CREATE TABLE dong_vat(
	ma int identity,
  	ten nvarchar(50) not null unique,
  	so_chan int default 0 not null,
  	tuoi_tho int not null,
  	ma_moi_truong_song int not null,
  	CONSTRAINT CK_ten check (len(ten) > 2),
  	CONSTRAINT CK_so_chan check(so_chan >= 0 AND so_chan < 100 AND so_chan % 2 = 0),
  	CONSTRAINT CK_tuoi_tho check(tuoi_tho > 0),
  	FOREIGN KEY (ma_moi_truong_song) references moi_truong_song(ma),
  	PRIMARY KEY(ma)
)

INSERT INto dong_vat(ten, so_chan, tuoi_tho, ma_moi_truong_song)
VALUES (N'cún', 4, 20, 3), (N'mèo', 4, 9, 3), (N'cá cược', default, 10, 4)

SELECT * FROM dong_vat
JOIN moi_truong_song 
on moi_truong_song.ma = dong_vat.ma_moi_truong_song

SELECT
dong_vat.ma,
dong_vat.ten,
dong_vat.so_chan,
dong_vat.tuoi_tho,
moi_truong_song.ten as ten_moi_truong_song
FROM dong_vat
JOIN moi_truong_song 
on moi_truong_song.ma = dong_vat.ma_moi_truong_song









