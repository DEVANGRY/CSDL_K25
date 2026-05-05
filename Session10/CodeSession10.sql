CREATE DATABASE IF NOT EXISTS QLSinhVien;
USE QLSinhVien;

-- 1. Bảng Khoa
CREATE TABLE Khoa (
    MaKhoa VARCHAR(10) PRIMARY KEY,
    TenKhoa VARCHAR(100) NOT NULL,
    SoLuongSV INT DEFAULT 0
);

-- 2. Bảng SinhVien
CREATE TABLE SinhVien (
    MaSV VARCHAR(10) PRIMARY KEY,
    HoTen VARCHAR(100) NOT NULL,
    NgaySinh DATE,
    GioiTinh VARCHAR(10),
    MaKhoa VARCHAR(10),
    Email VARCHAR(100) UNIQUE,
    DienThoai VARCHAR(15),
    FOREIGN KEY (MaKhoa) REFERENCES Khoa(MaKhoa)
);

-- 3. Bảng MonHoc
CREATE TABLE MonHoc (
    MaMH VARCHAR(10) PRIMARY KEY,
    TenMH VARCHAR(100) NOT NULL,
    SoTinChi INT,
    MaKhoa VARCHAR(10),
    FOREIGN KEY (MaKhoa) REFERENCES Khoa(MaKhoa)
);

-- 4. Bảng Diem
CREATE TABLE Diem (
    MaSV VARCHAR(10),
    MaMH VARCHAR(10),
    Diem FLOAT CHECK (Diem >= 0 AND Diem <= 10),
    LanThi INT DEFAULT 1,
    NgayThi DATE,
    PRIMARY KEY (MaSV, MaMH, LanThi),
    FOREIGN KEY (MaSV) REFERENCES SinhVien(MaSV),
    FOREIGN KEY (MaMH) REFERENCES MonHoc(MaMH)
);

-- 5. Bảng LopHoc 
CREATE TABLE LopHoc (
    MaLop VARCHAR(10) PRIMARY KEY,
    TenLop VARCHAR(50),
    MaKhoa VARCHAR(10),
    NamHoc INT,
    HocKy INT,
    FOREIGN KEY (MaKhoa) REFERENCES Khoa(MaKhoa)
);

INSERT INTO Khoa (MaKhoa, TenKhoa) VALUES
('CNTT', 'Công nghệ thông tin'),
('KT', 'Kế toán'),
('QTKD', 'Quản trị kinh doanh'),
('NN', 'Ngoại ngữ'),
('CK', 'Cơ khí');

INSERT INTO SinhVien (MaSV, HoTen, NgaySinh, GioiTinh, MaKhoa, Email, DienThoai) VALUES
('SV001', 'Nguyễn Văn An', '2003-05-12', 'Nam', 'CNTT', 'an.nv@gmail.com', '0987123456'),
('SV002', 'Trần Thị Bình', '2004-01-20', 'Nữ', 'CNTT', 'binh.tt@gmail.com', '0978123456'),
('SV003', 'Lê Văn Cường', '2003-08-15', 'Nam', 'KT', 'cuong.lv@gmail.com', '0967123456'),
('SV004', 'Phạm Thị Dung', '2004-03-10', 'Nữ', 'QTKD', 'dung.pt@gmail.com', '0989123456'),
('SV005', 'Hoàng Minh Quân', '2003-11-05', 'Nam', 'CNTT', 'quan.hm@gmail.com', '0976123456'),
('SV006', 'Vũ Thị Lan', '2004-02-28', 'Nữ', 'NN', 'lan.vt@gmail.com', '0981123456'),
('SV007', 'Đặng Văn Khánh', '2003-07-19', 'Nam', 'CK', 'khanh.dv@gmail.com', '0968123456'),
('SV008', 'Nguyễn Thị Hương', '2004-04-15', 'Nữ', 'CNTT', 'huong.nt@gmail.com', '0979123456'),
('SV009', 'Trần Minh Long', '2003-09-30', 'Nam', 'KT', 'long.tm@gmail.com', '0982123456'),
('SV010', 'Lê Thị Mai', '2004-06-12', 'Nữ', 'QTKD', 'mai.lt@gmail.com', '0969123456'),
('SV011', 'Phạm Văn Hải', '2003-12-05', 'Nam', 'CNTT', 'hai.pv@gmail.com', '0973123456'),
('SV012', 'Hoàng Thị Ngọc', '2004-05-20', 'Nữ', 'NN', 'ngoc.ht@gmail.com', '0983123456'),
('SV013', 'Vũ Minh Đức', '2003-10-18', 'Nam', 'CK', 'duc.vm@gmail.com', '0965123456'),
('SV014', 'Đặng Thị Thanh', '2004-01-25', 'Nữ', 'KT', 'thanh.dt@gmail.com', '0978123456'),
('SV015', 'Nguyễn Văn Bình', '2003-03-08', 'Nam', 'CNTT', 'binh.nv2@gmail.com', '0984123456'),
('SV016', 'Trần Thị Kim', '2004-07-14', 'Nữ', 'QTKD', 'kim.tt@gmail.com', '0967123456'),
('SV017', 'Lê Văn Nam', '2003-11-22', 'Nam', 'CNTT', 'nam.lv@gmail.com', '0975123456'),
('SV018', 'Phạm Thị Hồng', '2004-02-10', 'Nữ', 'NN', 'hong.pt@gmail.com', '0985123456'),
('SV019', 'Hoàng Văn Phúc', '2003-08-30', 'Nam', 'CK', 'phuc.hv@gmail.com', '0968123456'),
('SV020', 'Vũ Thị Hà', '2004-04-05', 'Nữ', 'KT', 'ha.vt@gmail.com', '0976123456'),
('SV021', 'Đặng Minh Quân', '2003-06-17', 'Nam', 'CNTT', 'quan.dm@gmail.com', '0986123456'),
('SV022', 'Nguyễn Thị Lan Anh', '2004-09-12', 'Nữ', 'QTKD', 'anh.ntla@gmail.com', '0969123456'),
('SV023', 'Trần Văn Dũng', '2003-01-28', 'Nam', 'CNTT', 'dung.tv@gmail.com', '0977123456'),
('SV024', 'Lê Thị Ngọc Ánh', '2004-03-22', 'Nữ', 'NN', 'anh.ltn@gmail.com', '0987123456'),
('SV025', 'Phạm Minh Tuấn', '2003-10-10', 'Nam', 'CK', 'tuan.pm@gmail.com', '0963123456'),
('SV026', 'Hoàng Thị Mỹ Linh', '2004-05-18', 'Nữ', 'KT', 'linh.htm@gmail.com', '0974123456'),
('SV027', 'Vũ Văn Thịnh', '2003-07-25', 'Nam', 'CNTT', 'thinh.vv@gmail.com', '0988123456'),
('SV028', 'Đặng Thị Huyền', '2004-08-08', 'Nữ', 'QTKD', 'huyen.dt@gmail.com', '0964123456'),
('SV029', 'Nguyễn Văn Hoàng', '2003-04-14', 'Nam', 'CNTT', 'hoang.nv@gmail.com', '0979123456'),
('SV030', 'Trần Thị Phương', '2004-02-19', 'Nữ', 'NN', 'phuong.tt@gmail.com', '0989123456'),
('SV031', 'Lê Minh Quân', '2003-12-01', 'Nam', 'CK', 'quan.lm@gmail.com', '0962123456'),
('SV032', 'Phạm Thị Thu', '2004-06-25', 'Nữ', 'KT', 'thu.pt@gmail.com', '0972123456'),
('SV033', 'Hoàng Văn Nam', '2003-09-05', 'Nam', 'CNTT', 'nam.hv@gmail.com', '0982123456'),
('SV034', 'Vũ Thị Thanh Hằng', '2004-01-15', 'Nữ', 'QTKD', 'hang.vtt@gmail.com', '0966123456'),
('SV035', 'Đặng Văn Long', '2003-11-30', 'Nam', 'CNTT', 'long.dv@gmail.com', '0978123456'),
('SV036', 'Nguyễn Thị Mai Anh', '2004-07-08', 'Nữ', 'NN', 'anh.ntma@gmail.com', '0983123456'),
('SV037', 'Trần Minh Hiếu', '2003-05-20', 'Nam', 'CK', 'hieu.tm@gmail.com', '0967123456'),
('SV038', 'Lê Thị Kim Chi', '2004-03-28', 'Nữ', 'KT', 'chi.ltk@gmail.com', '0975123456'),
('SV039', 'Phạm Văn Việt', '2003-10-12', 'Nam', 'CNTT', 'viet.pv@gmail.com', '0984123456'),
('SV040', 'Hoàng Thị Nga', '2004-04-30', 'Nữ', 'QTKD', 'nga.ht@gmail.com', '0968123456'),
('SV041', 'Vũ Minh Khang', '2003-08-22', 'Nam', 'CNTT', 'khang.vm@gmail.com', '0976123456'),
('SV042', 'Đặng Thị Bích', '2004-02-14', 'Nữ', 'NN', 'bich.dt@gmail.com', '0985123456'),
('SV043', 'Nguyễn Văn Tùng', '2003-06-10', 'Nam', 'CK', 'tung.nv@gmail.com', '0969123456'),
('SV044', 'Trần Thị Mỹ Dung', '2004-09-18', 'Nữ', 'KT', 'dung.ttm@gmail.com', '0973123456'),
('SV045', 'Lê Văn Bình', '2003-12-25', 'Nam', 'CNTT', 'binh.lv2@gmail.com', '0986123456'),
('SV046', 'Phạm Thị Quỳnh', '2004-05-05', 'Nữ', 'QTKD', 'quynh.pt@gmail.com', '0965123456'),
('SV047', 'Hoàng Minh Đức', '2003-07-12', 'Nam', 'CNTT', 'duc.hm@gmail.com', '0974123456'),
('SV048', 'Vũ Thị Hương Giang', '2004-01-08', 'Nữ', 'NN', 'giang.vth@gmail.com', '0987123456'),
('SV049', 'Đặng Văn Hải', '2003-11-19', 'Nam', 'CK', 'hai.dv2@gmail.com', '0963123456'),
('SV050', 'Nguyễn Thị Ngọc', '2004-03-15', 'Nữ', 'KT', 'ngoc.nt@gmail.com', '0978123456');

INSERT INTO MonHoc (MaMH, TenMH, SoTinChi, MaKhoa) VALUES
('MH001', 'Cơ sở dữ liệu', 3, 'CNTT'),
('MH002', 'Lập trình Java', 4, 'CNTT'),
('MH003', 'Kế toán tài chính', 3, 'KT'),
('MH004', 'Marketing cơ bản', 3, 'QTKD'),
('MH005', 'Tiếng Anh chuyên ngành', 3, 'NN'),
('MH006', 'Cơ khí kỹ thuật', 4, 'CK'),
('MH007', 'Lập trình Python', 3, 'CNTT'),
('MH008', 'Quản trị mạng', 3, 'CNTT'),
('MH009', 'Kế toán quản trị', 3, 'KT'),
('MH010', 'Tài chính doanh nghiệp', 3, 'KT'),
('MH011', 'Quản trị nhân sự', 3, 'QTKD'),
('MH012', 'Tiếng Anh giao tiếp', 2, 'NN'),
('MH013', 'Vẽ kỹ thuật', 3, 'CK'),
('MH014', 'Phân tích thiết kế hệ thống', 3, 'CNTT'),
('MH015', 'Dữ liệu lớn (Big Data)', 4, 'CNTT');

INSERT INTO Diem (MaSV, MaMH, Diem, LanThi, NgayThi) VALUES
('SV001', 'MH001', 8.5, 1, '2025-01-15'),
('SV001', 'MH002', 9.0, 1, '2025-01-20'),
('SV001', 'MH007', 8.0, 1, '2025-02-10'),
('SV001', 'MH014', 7.5, 1, '2025-02-25'),
('SV002', 'MH001', 7.5, 1, '2025-01-15'),
('SV002', 'MH002', 8.5, 1, '2025-01-20'),
('SV002', 'MH007', 9.5, 1, '2025-02-10'),
('SV005', 'MH001', 8.0, 1, '2025-01-15'),
('SV005', 'MH008', 6.5, 1, '2025-02-15'),
('SV005', 'MH014', 9.0, 1, '2025-02-25'),
('SV008', 'MH001', 8.8, 1, '2025-01-15'),
('SV008', 'MH002', 7.0, 1, '2025-01-20'),
('SV008', 'MH007', 9.2, 1, '2025-02-10'),
('SV011', 'MH001', 6.0, 1, '2025-01-15'),
('SV011', 'MH014', 8.5, 2, '2025-03-01'),
('SV017', 'MH001', 9.5, 1, '2025-01-15'),
('SV017', 'MH007', 8.5, 1, '2025-02-10'),
('SV017', 'MH015', 7.5, 1, '2025-03-10'),
('SV003', 'MH003', 6.5, 1, '2025-01-18'),
('SV003', 'MH009', 7.0, 1, '2025-02-20'),
('SV003', 'MH010', 8.0, 1, '2025-03-05'),
('SV004', 'MH004', 8.5, 1, '2025-01-22'),
('SV004', 'MH011', 9.0, 1, '2025-02-28'),
('SV006', 'MH005', 8.0, 1, '2025-01-25'),
('SV006', 'MH012', 9.5, 1, '2025-02-15'),
('SV007', 'MH006', 7.5, 1, '2025-01-30'),
('SV007', 'MH013', 6.0, 2, '2025-03-10');

INSERT INTO LopHoc (MaLop, TenLop, MaKhoa, NamHoc, HocKy) VALUES
('CNTT23A', 'Công nghệ thông tin A - K23', 'CNTT', 2023, 1),
('CNTT23B', 'Công nghệ thông tin B - K23', 'CNTT', 2023, 1),
('CNTT24A', 'Công nghệ thông tin A - K24', 'CNTT', 2024, 1),
('CNTT24B', 'Công nghệ thông tin B - K24', 'CNTT', 2024, 2),
('KT23A', 'Kế toán A - K23', 'KT', 2023, 1),
('KT23B', 'Kế toán B - K23', 'KT', 2023, 2),
('KT24A', 'Kế toán A - K24', 'KT', 2024, 1),
('QTKD23A', 'Quản trị kinh doanh A - K23', 'QTKD', 2023, 1),
('QTKD23B', 'Quản trị kinh doanh B - K23', 'QTKD', 2023, 1),
('QTKD24A', 'Quản trị kinh doanh A - K24', 'QTKD', 2024, 2),
('NN23A', 'Ngoại ngữ A - K23', 'NN', 2023, 1),
('NN24A', 'Ngoại ngữ A - K24', 'NN', 2024, 1),
('CK23A', 'Cơ khí A - K23', 'CK', 2023, 1),
('CK23B', 'Cơ khí B - K23', 'CK', 2023, 2),
('CK24A', 'Cơ khí A - K24', 'CK', 2024, 1),
('CNTT25A', 'Công nghệ thông tin A - K25', 'CNTT', 2025, 1),
('CNTT25B', 'Công nghệ thông tin B - K25', 'CNTT', 2025, 1),
('KT25A', 'Kế toán A - K25', 'KT', 2025, 1),
('QTKD25A', 'Quản trị kinh doanh A - K25', 'QTKD', 2025, 1),
('NN25A', 'Ngoại ngữ A - K25', 'NN', 2025, 1);

EXPLAIN ANALYZE 
SELECT * FROM sinhvien WHERE HoTen = "Nguyễn Văn An";
-- '-> Filter: (sinhvien.HoTen like \'%Văn%\')  (cost=5.25 rows=5.56) (actual time=0.369..0.532 rows=16 loops=1)\n 
--   -> Table scan on sinhvien  (cost=5.25 rows=50) (actual time=0.027..0.0552 rows=50 loops=1)\n'

CREATE INDEX idx_hoTen ON sinhvien(HoTen);
-- '-> Index lookup on sinhvien using idx_hoTen (HoTen=\'Nguyễn Văn An\')  (cost=0.35 rows=1) (actual time=0.043..0.0447 rows=1 loops=1)\n'
DROP INDEX idx_hoTen ON sinhvien;

-- View xem danh sách sinh viên kèm điểm trung bình
CREATE OR REPLACE VIEW v_SinhVien_DiemTB AS
SELECT sv.HoTen , d.MaSV , ROUND( AVG(d.Diem),2) AS "Điểm Trung Bình", COUNT(d.MaMH) AS "Số Môn Học"
FROM diem AS d
JOIN sinhvien AS sv
ON d.MaSV = sv.maSV
GROUP BY sv.HoTen, d.MaSV ;

SELECT * FROM v_SinhVien_DiemTB;

SELECT * FROM (
	SELECT sv.HoTen , d.MaSV , AVG(d.Diem) AS "Điểm Trung Bình", COUNT(DISTINCT d.MaMH) AS "Số Môn Học"
	FROM diem AS d
	JOIN sinhvien AS sv
	ON d.MaSV = sv.maSV
	GROUP BY sv.HoTen, d.MaSV
) AS sinhvien_diemtb
WHERE sinhvien_diemtb.`Số Môn Học` = "3"
ORDER BY sinhvien_diemtb.`Điểm Trung Bình` DESC;



SELECT * FROM sinhvien;
SELECT * FROM diem;

EXPLAIN ANALYZE 
SELECT * FROM v_sinhvien_diemtb;

CREATE DATABASE EXPLAIN_ANALYZE_DISTINCT;

CREATE VIEW V_Thong_ke_khoa AS (
	SELECT k.TenKhoa , COUNT(DISTINCT sv.MaSV)  AS `Số Lượng Sinh Viên` , ROUND(AVG(d.Diem) ,2) AS `Điểm Trung Bình` , COUNT(DISTINCT mh.MaMH) AS `Số Môn Học` FROM Khoa AS k
    LEFT JOIN sinhvien AS sv ON k.MaKhoa = sv.MaKhoa
    LEFT JOIN diem AS d ON sv.maSV = d.maSV
    LEFT JOIN monhoc AS mh ON mh.MaKHoa = k.MaKhoa
    GROUP BY k.TenKhoa
);

SELECT * FROM V_Thong_ke_khoa;

SELECT * FROM khoa 
LEFT JOIN sinhvien ON khoa.makhoa = sinhvien.makhoa
LEFT JOIN diem ON diem.masv= sinhvien.masv;

SELECT khoa.tenkhoa , COUNT(DISTINCT sinhvien.masv)  AS `Số Lượng Sinh Viên Theo Khoa`, ROUND(AVG(diem.diem)) AS `Điểm Trung Bình Theo Khoa` , COUNT(DISTINCT diem.maMH) AS `Số Lượng môn học` FROM khoa 
LEFT JOIN sinhvien ON khoa.makhoa = sinhvien.makhoa
LEFT JOIN diem ON diem.masv= sinhvien.masv
GROUP BY khoa.tenKhoa;
