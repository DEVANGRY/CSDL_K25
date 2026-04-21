DROP DATABASE IF EXiSTS db_quanLyNhanVien;

CREATE DATABASE db_quanLyNhanVien;
USE db_quanLyNhanVien;

CREATE TABLE nhan_vien (
    ma_nv INT PRIMARY KEY,
    ho_ten VARCHAR(100),
    tuoi INT,
    luong DECIMAL(15, 2),
    phong_ban VARCHAR(50),
    gioi_tinh CHAR(1) -- 'M' cho Nam, 'F' cho Nữ
);

INSERT INTO nhan_vien (ma_nv, ho_ten, tuoi, luong, phong_ban, gioi_tinh) VALUES
(1, 'Nguyễn Lười Biếng', 22, 8500000, 'IT', 'M'),
(2, 'Trần Siêng Năng', 28, 20000000, 'Marketing', 'F'),
(3, 'Lê Coder Pro', 24, 15000000, 'IT', 'M'),
(4, 'Phạm Boss Nữ', 35, 50000000, 'Quản lý', 'F'),
(5, 'Hoàng Chill', 26, 12000000, 'Sales', 'M'),
(6, 'Vũ Ngủ Nhiều', 23, 7000000, 'IT', 'M'),
(7, 'Đặng Nữ Thần Tiền', 30, 25000000, 'Marketing', 'F');