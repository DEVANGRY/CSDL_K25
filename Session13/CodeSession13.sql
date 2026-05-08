CREATE DATABASE cua_hang_laptop;
USE cua_hang_laptop;

CREATE TABLE products (
  id           INT PRIMARY KEY AUTO_INCREMENT,
  name         VARCHAR(100),
  price        DECIMAL(10,2),
  stock        INT DEFAULT 0,
  last_updated DATETIME
);

CREATE TABLE audit_log (
  id         INT PRIMARY KEY AUTO_INCREMENT,
  action     VARCHAR(20),
  product_id INT,
  old_price  DECIMAL(10,2),
  new_price  DECIMAL(10,2),
  old_stock  INT,
  new_stock  INT,
  changed_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
  id         INT PRIMARY KEY AUTO_INCREMENT,
  product_id INT,
  quantity   INT,
  order_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO products (name, price, stock, last_updated) VALUES
('MacBook Air M2', 28000000.00, 15, NOW()),
('Dell XPS 13', 32500000.00, 10, NOW()),
('HP Spectre x360', 30000000.00, 8, NOW()),
('Lenovo Legion 5', 25500000.00, 20, NOW()),
('Asus ROG Zephyrus', 42000000.00, 5, NOW());

INSERT INTO audit_log (action, product_id, old_price, new_price, old_stock, new_stock) VALUES
('UPDATE_PRICE', 1, 29000000.00, 28000000.00, 15, 15),
('RESTOCK', 4, 25500000.00, 25500000.00, 10, 20),
('UPDATE_PRICE', 5, 45000000.00, 42000000.00, 5, 5);

INSERT INTO orders (product_id, quantity, order_date) VALUES
(1, 1, '2024-03-20 10:30:00'),
(2, 2, '2024-03-21 14:15:00'),
(4, 1, '2024-03-22 09:00:00'),
(5, 1, NOW());

-- Tạo một Trigger với tên là before_insert_product theo các yêu cầu sau:
-- Trigger phải kích hoạt trước khi chèn (INSERT) 
-- một dòng mới vào bảng products nhập giá sản phẩm bị âm (price < 0):
-- Trigger tự động chuyển giá đó về 0.
-- Đồng thời, trigger phải tự động cập nhật trường last_updated = thời gian hiện tại

-- INSERT INTO products VALUES (name,price,stock,last_updated)

DELIMITER // 
CREATE TRIGGER before_insert_product 
	BEFORE INSERT ON products
	for each row
BEGIN
	-- logic xử lý
    IF NEW.price < 0 THEN
		SET NEW.price = 0;
	END IF;
    
    SET NEW.last_updated = NOW();
END
// DELIMITER ;

INSERT INTO products(name, price, stock) VALUES ("Gấu bông V3",-1 , 10);

SELECT * FROM products;

-- Mục đích: Sau khi dòng dữ liệu đã được chèn thành công, 
-- ghi thông tin vào bảng audit để theo dõi lịch sử. Dùng NEW để đọc giá trị vừa được chèn.
SELECT * FROM audit_log;
DELIMITER // 
CREATE TRIGGER after_insert_product 
	AFTER INSERT ON products
	for each row
BEGIN
	-- logic xử lý
    INSERT INTO audit_log(action,product_id,new_price,new_stock,changed_at) VALUES 
    ("INSERT", NEW.id , NEW.price , NEW.stock , NOW());
END
// DELIMITER ;
SELECT * FROM audit_log;
INSERT INTO products(name, price, stock) VALUES ("Siêu Nhân", 200000 , 20);
SELECT * FROM audit_log;

SELECT * FROM orders;
-- Khi khách hàng đặt hàng (Order) , stock phải tự động giảm.
-- Insert , after : Product
DELIMITER // 
CREATE TRIGGER after_insert_order 
	AFTER INSERT ON orders
	FOR EACH ROW
BEGIN 
 -- logic 
	UPDATE products
    SET stock = stock - NEW.quantity
    WHERE id = NEW.product_id;
END
// DELIMITER ;









