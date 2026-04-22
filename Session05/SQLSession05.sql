DROP DATABASE IF EXISTS db_restaurant;
CREATE DATABASE db_restaurant;
USE db_restaurant;

CREATE TABLE Customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    favorite_dish VARCHAR(50)
);

CREATE TABLE Dishes (
    dish_id INT PRIMARY KEY,
    dish_name VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2)
);

CREATE TABLE Orders (
    order_id VARCHAR(10) PRIMARY KEY,
    customer_id INT,
    dish_id INT,
    quantity INT DEFAULT 1,
    order_date DATE,
    CONSTRAINT FK_Order_Customer FOREIGN KEY (customer_id) 
        REFERENCES Customers(id) ON DELETE CASCADE,
    CONSTRAINT FK_Order_Dish FOREIGN KEY (dish_id) 
        REFERENCES Dishes(dish_id)
);


INSERT INTO Customers (name, favorite_dish) VALUES
('Nguyen Van Teo', 'Pho Bo'),
('Le Thi Ti', 'Banh Mi'),
('Tran Van Hoa', 'Bun Cha'),
('Pham Lan Anh', 'Com Tam'),
('Hoang Minh', 'Pho Bo'),
('Nguyen Bich Phuong', 'Tra Sua'),
('Dang Van Nam', 'Banh Mi'),
('Bui Thi Xuan', 'Bun Dau'),
('Do Hoang Long', 'Com Tam'),
('Le Thu Ha', 'Pho Bo'),
('Vu Minh Tri', 'Banh Mi'),
('Ngo Thanh Van', 'Tra Sua'),
('Ly Tieu Long', 'Bun Cha'),
('Phan Manh Quynh', 'Pho Bo'),
('Truong Ngoc Anh', 'Bun Dau');

INSERT INTO Dishes (dish_id, dish_name, price) VALUES
(200, 'Pho Bo V2', 55000);

INSERT INTO Dishes (dish_id, dish_name, price) VALUES
(101, 'Pho Bo', 55000),
(102, 'Banh Mi Pathe', 25000),
(103, 'Bun Cha Ha Noi', 45000),
(104, 'Com Tam Suon Nuong', 50000),
(105, 'Bun Dau Mam Tom', 60000),
(106, 'Tra Sua Tran Chau', 35000),
(107, 'Coca Cola', 15000),
(108, 'Cafe Den', 20000),
(109, 'Mien Ga', 40000),
(110, 'Xoi Xe', 25000);


INSERT INTO Orders (order_id, customer_id, dish_id, quantity, order_date) VALUES
('ORD001', 1, 101, 2, '2023-10-01'),
('ORD002', 2, 102, 3, '2023-10-01'),
('ORD003', 3, 103, 1, '2023-10-02'),
('ORD004', 5, 101, 1, '2023-10-02'),
('ORD005', 1, 107, 2, '2023-10-02'),
('ORD006', 4, 104, 2, '2023-10-03'),
('ORD007', 6, 106, 4, '2023-10-03'),
('ORD008', 7, 102, 1, '2023-10-04'),
('ORD009', 8, 105, 1, '2023-10-04'),
('ORD010', 9, 104, 1, '2023-10-05'),
('ORD011', 10, 101, 2, '2023-10-05'),
('ORD012', 11, 102, 5, '2023-10-06'),
('ORD013', 12, 106, 2, '2023-10-06'),
('ORD014', 1, 101, 1, '2023-10-07'), 
('ORD015', 13, 103, 2, '2023-10-07'),
('ORD016', 14, 101, 1, '2023-10-08'),
('ORD017', 15, 105, 3, '2023-10-08'),
('ORD018', 2, 108, 2, '2023-10-09'),
('ORD019', 4, 107, 1, '2023-10-09'),
('ORD020', 5, 101, 1, '2023-10-10');

INSERT INTO Orders (order_id, customer_id, dish_id, quantity, order_date) VALUES
('ORD021', 1, 123123 , 2, '2023-10-01');


SELECT * FROM customers;
SELECT * FROM dishes;
SELECT * FROM orders;

-- Lấy thông tin order có tên người dùng ;
-- INNER JOIN 

SELECT o.order_id,o.dish_id,o.quantity, c.name 
FROM orders AS o 
JOIN customers AS c
ON o.customer_id = c.id;

-- Lấy thông tin order có tên món ăn : order_id , customer_id , dish_name , quantity , order_date
SELECT * FROM orders AS o 
JOIN  dishes AS d
ON o.dish_id = d.dish_id;

-- Lấy thông tin order có tên món ăn : order_id , customer_id , dish_name , quantity , order_date
SELECT * FROM orders AS o 
RIGHT JOIN  dishes AS d
ON o.dish_id = d.dish_id;

-- Đếm tất cả xem có bao nhiêu đơn order
SELECT COUNT(order_id) AS tong_order FROM orders;

-- Tính tổng tiền của tất cả món ăn có trong cửa hàng 
SELECT SUM(price) AS tong_tien FROM dishes;

-- Tính trung binh số lượng hàng đã tiêu thụ 
SELECT AVG(orders.quantity) FROM orders;

-- Tính tổng tiền nhận được trong order
SELECT SUM(o.quantity * d.price) AS tong_tien FROM orders AS o 
JOIN dishes AS d 
ON o.dish_id = d.dish_id;

-- Tính tổng tiền ăn của từng khách trong quán 

-- Gộp nhóm 

SELECT c.name , SUM(o.quantity * d.price) AS tong_tien FROM orders AS o 
JOIN dishes AS d
ON o.dish_id = d.dish_id
JOIN customers AS c
ON o.customer_id = c.id
GROUP BY  c.name 
HAVING tong_tien > 100000;

-- Tính Doanh Thu Theo món ăn : Tên món ăn , tiền theo món ăn đó đã bán được
-- BTTH 
CREATE TABLE Users (
	user_id INT PRIMARY KEY, 
	full_name VARCHAR(100));
CREATE TABLE Hotels (
	hotel_id INT PRIMARY KEY, 
	hotel_name VARCHAR(100), 
	star_rating INT);
CREATE TABLE Bookings (
	booking_id INT PRIMARY KEY, 
	user_id INT, 
	hotel_id INT, 
	total_price DECIMAL(15,2), 
status VARCHAR(20));
INSERT INTO Users VALUES 
(1,'Nguyễn Văn A'), (2,'Trần Thị B'), (3,'Lê Văn C'), (4,'Phạm Minh D'), (5,'Hoàng Gia E'),
(6,'Vũ Hải F'), (7,'Đặng Thu G'), (8,'Bùi Quang H'), (9,'Đỗ Thùy I'), (10,'Ngô Bảo K'),
(11,'Lý Triều L'), (12,'Phan Nam M'), (13,'Trịnh Văn N'), (14,'Hồ Xuân O'), (15,'Trương Mỹ P'),
(16,'Đinh Quang Q'), (17,'Lương Gia R'), (18,'Võ Văn S'), (19,'Diệp Lan T'), (20,'Cao Minh U');
INSERT INTO Hotels VALUES 
(101,'Sheraton',5), 
(102,'InterContinental',5), 
(103,'Pullman',5), 
(104,'Park Hyatt',5), 
(105,'Marriott',5),
(106,'Novotel',4), 
(107,'Liberty Central',4), 
(108,'Muong Thanh',4), 
(109,'Vissai',4), 
(110,'Edenstar',4),
(111,'Ibis',3), 
(112,'A25 Hotel',3), 
(113,'Little Hanoi',3), 
(114,'Floral Hotel',3), 
(115,'Lavender',3),
(116,'RedDoorz Lux',4), 
(117,'Vinpearl Resort',5), 
(118,'FLC Luxury',5), 
(119,'Boutique Hotel',3), 
(120,'Rex Hotel',5);

INSERT INTO Bookings VALUES 
(1,1,101,30000000,'COMPLETED'), (2,1,102,25000000,'COMPLETED'), 
(3,1,106,60000000,'COMPLETED'),                           
(4,2,103,55000000,'COMPLETED'),                             
(5,3,101,10000000,'COMPLETED'), 
(6,3,101,-2000000,'COMPLETED'), 
(7,4,117,70000000,'COMPLETED'),                           
(8,5,108,12000000,'COMPLETED'), 
(9,5,109,40000000,'COMPLETED'), 
(10,6,120,45000000,'COMPLETED'), 
(11,6,101,10000000,'COMPLETED'),
(12,7,111,5000000,'PENDING'),                                
(13,8,104,80000000,'COMPLETED'),                            
(14,9,105,15000000,'COMPLETED'), 
(15,9,117,40000000,'COMPLETED'),
(16,10,110,51000000,'COMPLETED'),                            
(17,11,102,20000000,'COMPLETED'),
(18,12,103,10000000,'COMPLETED'),
(19,1,101,5000000,'COMPLETED'),                               
(20,13,120,90000000,'COMPLETED');        