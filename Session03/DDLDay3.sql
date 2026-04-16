-- TẠO DATABASE 
CREATE DATABASE db_cuahang;
USE db_cuahang;

-- Có 2 bảng : product , review (1-N)
-- product : lưu trữ thông tin sản phẩm 
-- ma_san_pham : số , khóa chính 
-- ten_san_pham : chuỗi (100 ký tự) , không được trống 
-- gia_san_pham : số (10,2) , không được âm , không được trống
-- mau_san_pham : chuỗi (80) , không được trống
-- kich_co : ENUM("S" , "M" , "L" , "XL") , không được trống 

-- review : thông tin đánh giá sản phẩm 
-- id : số , khóa chính 
-- ma_san_pham : số , không được trống (khóa ngoại)
-- danh_gia : số thực , không được âm , nhỏ hơn hoặc bằng 5
-- binh_luan : chuỗi, được null
CREATE TABLE product (
	ma_san_pham INT PRIMARY KEY AUTO_INCREMENT,
    ten_san_pham VARCHAR(100) NOT NULL,
    gia_san_pham DECIMAL(10,2) CHECK( gia_san_pham > 0) NOT NULL,
    mau_san_pham VARCHAR(80) NOT NULL,
    kick_co ENUM("S" , "M" , "L" , "XL") NOT NULL
);

CREATE TABLE review (
	id INT PRIMARY KEY AUTO_INCREMENT,
    ma_san_pham INT NOT NULL,
    danh_gia FLOAT(1,1) CHECK(danh_gia >= 0 AND danh_gia <= 5) DEFAULT(5),
    binh_luan VARCHAR(258),
    FOREIGN KEY (ma_san_pham) REFERENCES product(ma_san_pham)
);

-- CRUD dữ liệu vào bảng
-- INSERT : THÊM DỮ LIỆU VÀO BẢNG
INSERT INTO product (ten_san_pham,gia_san_pham,mau_san_pham,kick_co)
VALUES 
	("Búp bê V1" , 100000 , "Hồng", "S"),
	("Siêu Nhân" , 300000 , "ĐỎ", "L"),
	("Ô Tô" , 10000000 , "Trắng", "XL"),
    ("Búp bê V2" , 5000 , "Hồng", "S");
    
-- READ : SELECT dữ liệu

-- * : Đổ hết dữ liệu từ bảng ra 
SELECT * FROM product;
SELECT * FROM product WHERE mau_san_pham = "Hồng";
-- ĐỔ thông tin sản phẩm nào có giá tiền nhỏ hơn 100000
SELECT * FROM product WHERE gia_san_pham <= 100000;

-- Đổ dữ liệu từ cột mong muốn
SELECT ma_san_pham,ten_san_pham FROM product;


-- Update : Cập nhật dữ liệu trong hàng
UPDATE product
SET
	kick_co = "M"
WHERE 
	ma_san_pham = 1;
    
-- DELETE : XÓa 
DELETE FROM product
WHERE ma_san_pham = 1;

SELECT * FROM product ORDER BY gia_san_pham DESC;