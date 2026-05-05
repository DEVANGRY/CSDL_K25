-- 1. Tạo bảng với đầy đủ ràng buộc
CREATE TABLE Customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    license_no VARCHAR(20) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL,
    address VARCHAR(200)
);

CREATE TABLE Staffs (
    staff_id VARCHAR(10) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    branch VARCHAR(50) NOT NULL,
    salary_base DECIMAL(15, 2) CHECK (salary_base >= 0),
    performance_score DECIMAL(3, 2) DEFAULT 0 CHECK (performance_score BETWEEN 0 AND 5)
);

CREATE TABLE Rentals (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id VARCHAR(10),
    staff_id VARCHAR(10),
    rental_date TIMESTAMP NOT NULL,
    return_date TIMESTAMP NOT NULL,
    status ENUM('Booked', 'PickedUp', 'Returned', 'Cancelled') DEFAULT 'Booked',
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (staff_id) REFERENCES Staffs(staff_id)
);

CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    rental_id INT,
    payment_method VARCHAR(50) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(15, 2) CHECK (amount >= 0),
    FOREIGN KEY (rental_id) REFERENCES Rentals(rental_id)
);

-- 2. Chèn dữ liệu mẫu
INSERT INTO Customers VALUES 
('C001', 'Nguyen Hoang Anh', 'B1-12345', '0912345678', 'Hanoi'),
('C002', 'Tran Van Hoang', 'B2-67890', '0922345678', 'HCM'),
('C003', 'Le Thi Buoi', 'B1-11223', '0932345678', 'Da Nang'),
('C004', 'Pham Hoang Long', 'C-44556', '0942345678', 'Can Tho'),
('C005', 'Vu Hoang Yen', 'B2-77889', '0952345678', 'Hai Phong');

INSERT INTO Staffs (staff_id, full_name, branch, salary_base, performance_score) VALUES 
('S001', 'Nguyen Van Minh', 'Hanoi', 15000000, 4.5),
('S002', 'Tran Thi Lan', 'Da Nang', 12000000, 3.8),
('S003', 'Le Hoang Nam', 'Hanoi', 14000000, 4.2),
('S004', 'Pham Quang Huy', 'HCM', 16000000, 4.9),
('S005', 'Vu Thi Mai', 'Da Nang', 11000000, 3.5);

INSERT INTO Rentals (customer_id, staff_id, rental_date, return_date, status) VALUES 
('C001', 'S001', '2024-10-01 08:00:00', '2024-10-05 08:00:00', 'Returned'),
('C002', 'S002', '2024-10-10 09:00:00', '2024-10-12 09:00:00', 'PickedUp'),
('C003', 'S003', '2023-12-15 10:00:00', '2023-12-20 10:00:00', 'Cancelled'),
('C004', 'S004', '2024-10-15 14:00:00', '2024-10-20 14:00:00', 'Returned'),
('C005', 'S001', '2024-10-20 16:00:00', '2024-10-25 16:00:00', 'Booked');

INSERT INTO Payments (rental_id, payment_method, amount) VALUES 
(1, 'Credit Card', 5000000),
(2, 'Cash', 3000000),
(4, 'Credit Card', 7500000),
(1, 'Cash', 500000),
(2, 'E-Wallet', 2000000);

-- 3. Cập nhật địa chỉ khách hàng C003
UPDATE Customers SET address = 'Lien Chieu, Da Nang' WHERE customer_id = 'C003';

-- 4. Cập nhật lương và điểm nhân viên S002
UPDATE Staffs 
SET salary_base = salary_base * 1.1, performance_score = 4.8 
WHERE staff_id = 'S002';

-- 5. Xóa hợp đồng Cancelled trước 2024
DELETE FROM Rentals WHERE status = 'Cancelled' AND rental_date < '2024-01-01';

-- 6. Thêm Default cho Address
ALTER TABLE Customers ALTER COLUMN address SET DEFAULT 'Unknown';

-- 7. Thêm cột Email cho Staffs
ALTER TABLE Staffs ADD COLUMN email VARCHAR(100);

-- 8. Giảm 5% cho thanh toán bằng Cash
UPDATE Payments SET amount = amount * 0.95 WHERE payment_method = 'Cash';

-- 9. Sao lưu bảng Staffs
CREATE TABLE Staff_Backup AS (SELECT * FROM Staffs);

-- 10. Ràng buộc ngày trả >= ngày thuê
ALTER TABLE Rentals ADD CONSTRAINT chk_date CHECK (return_date >= rental_date);

-- 11. Nhân viên điểm >= 4.0 tại Hanoi
SELECT * FROM Staffs WHERE performance_score >= 4.0 AND branch = 'Hanoi';

-- 12. Khách hàng tên chứa "Hoang"
SELECT * FROM Customers WHERE full_name LIKE '%Hoang%';

-- 13. Hợp đồng sắp xếp theo ngày thuê giảm dần
SELECT rental_id, rental_date, status FROM Rentals ORDER BY rental_date DESC;

-- 14. 3 bản ghi Credit Card mới nhất
SELECT * FROM Payments WHERE payment_method = 'Credit Card' 
ORDER BY payment_date DESC LIMIT 3;

-- 15. Phân trang nhân viên (Bỏ qua 3, lấy 2)
SELECT staff_id, full_name FROM Staffs LIMIT 2 OFFSET 3;

-- 16. Thanh toán từ 1tr đến 5tr
SELECT * FROM Payments WHERE amount BETWEEN 1000000 AND 5000000;

-- 17. Hợp đồng trong tháng 10/2024
SELECT * FROM Rentals WHERE rental_date LIKE '2024-10%';

-- 18. Danh sách chi nhánh duy nhất
SELECT DISTINCT branch FROM Staffs;

-- 19. Nhân viên tại Hanoi hoặc Da Nang
SELECT * FROM Staffs WHERE branch IN ('Hanoi', 'Da Nang');

-- 20. Khách hàng chưa có bằng lái (Giả định cột cho phép NULL)
SELECT * FROM Customers WHERE license_no IS NULL;

-- 21. Inner Join lấy thông tin hợp đồng đang PickedUp
SELECT r.rental_id, c.full_name AS customer_name, s.full_name AS staff_name
FROM Rentals r
JOIN Customers c ON r.customer_id = c.customer_id
JOIN Staffs s ON r.staff_id = s.staff_id
WHERE r.status = 'PickedUp';

-- 22. Left Join tất cả nhân viên và hợp đồng
SELECT s.staff_id, s.full_name, r.rental_id
FROM Staffs s
LEFT JOIN Rentals r ON s.staff_id = r.staff_id;

-- 23. Tổng doanh thu theo phương thức thanh toán
SELECT payment_method, SUM(amount) AS Total_Revenue
FROM Payments
GROUP BY payment_method;

-- 24. Nhân viên có trên 2 hợp đồng
SELECT s.staff_id, s.full_name, COUNT(r.rental_id) AS Total_Rentals
FROM Staffs s
JOIN Rentals r ON s.staff_id = r.staff_id
GROUP BY s.staff_id, s.full_name
HAVING COUNT(r.rental_id) > 2;

-- 25. Nhân viên lương cao hơn trung bình (Subquery)
SELECT staff_id, full_name, salary_base
FROM Staffs
WHERE salary_base > (SELECT AVG(salary_base) FROM Staffs);

-- 26. Tên khách và tổng tiền đã trả cho xe đã hoàn tất (Multi-Join)
SELECT c.full_name, SUM(p.amount) AS Total_Paid
FROM Customers c
JOIN Rentals r ON c.customer_id = r.customer_id
JOIN Payments p ON r.rental_id = p.rental_id
WHERE r.status = 'Returned'
GROUP BY c.customer_id, c.full_name;

-- 27. Báo cáo tổng hợp
SELECT r.rental_id, c.full_name AS customer_name, s.full_name AS staff_name, p.amount
FROM Rentals r
JOIN Customers c ON r.customer_id = c.customer_id
JOIN Staffs s ON r.staff_id = s.staff_id
JOIN Payments p ON r.rental_id = p.rental_id;