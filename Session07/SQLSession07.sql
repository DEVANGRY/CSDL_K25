CREATE DATABASE IF NOT EXISTS sales_db;
USE sales_db;

DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- customers – khách hàng
-- employees – nhân viên
-- products – sản phẩm
-- orders – đơn hàng
-- order_details – chi tiết đơn hàng
-- departments – phòng ban

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    salary DECIMAL(10,2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(100)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(100),
    price DECIMAL(10,2),
    stock INT
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    employee_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE order_details (
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO departments VALUES
(1, 'Sales'),
(2, 'IT'),
(3, 'HR');

INSERT INTO employees VALUES
(1, 'An', 1200, 1),
(2, 'Binh', 1500, 1),
(3, 'Cuong', 2000, 2),
(4, 'Dung', 1800, 2),
(5, 'Hanh', 1300, 3);

INSERT INTO customers VALUES
(1, 'Nguyen Van A', 'Ha Noi'),
(2, 'Tran Thi B', 'Da Nang'),
(3, 'Le Van C', 'Ho Chi Minh'),
(4, 'Pham Thi D', 'Ha Noi');

INSERT INTO products VALUES
(1, 'Laptop A', 'Laptop', 1000, 10),
(2, 'Mouse B', 'Accessory', 20, 100),
(3, 'Keyboard C', 'Accessory', 30, 80),
(4, 'Monitor D', 'Monitor', 200, 20),
(5, 'Laptop E', 'Laptop', 1500, 5);

INSERT INTO orders VALUES
(1, 1, 1, '2025-01-10', 1040),
(2, 2, 2, '2025-01-15', 220),
(3, 1, 2, '2025-02-01', 1500),
(4, 3, 3, '2025-02-05', 60),
(5, 4, 1, '2025-02-10', 200);

INSERT INTO order_details VALUES
(1, 1, 1, 1000),
(1, 2, 2, 20),
(2, 4, 1, 200),
(2, 2, 1, 20),
(3, 5, 1, 1500),
(4, 3, 2, 30),
(5, 4, 1, 200);

SELECT * FROM products;

-- Lấy giá trung bình trong bảng products ;
SELECT AVG(price) AS trung_binh_tien FROM products;


-- Lấy thông tin các sản phẩm có giá tiền lớn hơn giá trung bình của các sản phẩm ; 

SELECT * FROM products 
WHERE price > (SELECT AVG(price) AS trung_binh_tien FROM products);


SELECT AVG(price) AS trung_binh_tien FROM products;

-- In những nhân viên có lương lớn hơn lương trung bình của khoa làm việc 
SELECT * FROM employees as e1
WHERE e1.salary > (
		SELECT AVG(e2.salary) FROM employees as e2
        WHERE e2.department_id = e1.department_id
);


-- In danh sách lương trung bình theo từng khoa
SELECT * FROM employees;

-- Lấy tên sản phẩm có giá tiền nhỏ nhất 

-- Lấy id khách hàng mua hàng nhiều hơn trung bình các khách hàng khác 
SELECT customer_id , SUM(total_amount) as total FROM orders AS o1
GROUP BY customer_id
HAVING total > (
	SELECT AVG(total_amount) FROM orders as o2
    WHERE o2.customer_id = o1.customer_id
);
SELECT * FROM orders

-- Sản phẩm giá lớn hơn trung bình

-- Khách hàng đã từng đặt hàng

-- Nhân viên lương cao hơn trung bình công ty

-- Nhân viên lương cao hơn trung bình phòng ban (Correlated)

-- Khách hàng có tổng chi tiêu trên mức trung bình (Lồng 2 cấp)

