DROP DATABASE IF EXISTS Assignment02;
CREATE DATABASE Assignment02;
USE Assignment02;


DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS sales;
TRUNCATE TABLE sales;
TRUNCATE TABLE products;
TRUNCATE TABLE customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT, 
    cust_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    city VARCHAR(100),
    country VARCHAR(100),
    registration_date DATE
) ;

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock_quantity INT
);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    quantity INT,
    total_price DECIMAL(10,2),
    sale_date DATETIME,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
