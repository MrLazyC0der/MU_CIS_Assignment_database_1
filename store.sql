CREATE DATABASE store;
GO

USE store;
GO

-- =========================================
-- TABLE: categories
-- =========================================

CREATE TABLE categories (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    description VARCHAR(255)
);

INSERT INTO categories (category_name, description)
VALUES
('Electronics', 'Electronic devices and accessories'),
('Clothes', 'Men, women and kids clothing'),
('Furniture', 'Home and office furniture'),
('Books', 'Scientific and literary books'),
('Sports', 'Sports equipment and clothing');

-- =========================================
-- TABLE: customers
-- =========================================

CREATE TABLE customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    address VARCHAR(255)
);

INSERT INTO customers (name, email, phone, address)
VALUES
('Ahmed Mohamed', 'ahmed@email.com', '0100000001', 'Cairo'),
('Sara Ali', 'sara@email.com', '0100000002', 'Alexandria'),
('Mahmoud Khaled', 'mah@email.com', '0100000003', 'Giza'),
('Fatma Hassan', 'fat@email.com', '0100000004', 'Assiut'),
('Yousef Ibrahim', 'you@email.com', '0100000005', 'Mansoura');

-- =========================================
-- TABLE: products
-- =========================================

CREATE TABLE products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_qty INT DEFAULT 0,
    category_id INT,
    
    CONSTRAINT FK_products_categories
    FOREIGN KEY (category_id)
    REFERENCES categories(category_id)
);

INSERT INTO products (product_name, price, stock_qty, category_id)
VALUES
('Dell Laptop', 15000.00, 20, 1),
('Samsung Mobile', 8000.00, 50, 1),
('Cotton T-Shirt', 200.00, 100, 2),
('Office Chair', 3000.00, 15, 3),
('SQL Book', 150.00, 30, 4);

-- =========================================
-- TABLE: orders
-- =========================================

CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT GETDATE(),
    total_amount DECIMAL(10,2),
    status VARCHAR(50) DEFAULT 'pending',

    CONSTRAINT FK_orders_customers
    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);

INSERT INTO orders (customer_id, order_date, total_amount, status)
VALUES
(1, GETDATE(), 23200.00, 'completed'),
(2, GETDATE(), 400.00, 'completed'),
(3, GETDATE(), 8000.00, 'pending'),
(1, GETDATE(), 3150.00, 'completed'),
(4, GETDATE(), 150.00, 'cancelled');

-- =========================================
-- TABLE: order_items
-- =========================================

CREATE TABLE order_items (
    item_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,

    CONSTRAINT FK_orderitems_orders
    FOREIGN KEY (order_id)
    REFERENCES orders(order_id),

    CONSTRAINT FK_orderitems_products
    FOREIGN KEY (product_id)
    REFERENCES products(product_id)
);

INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES
(1, 1, 1, 15000.00),
(1, 2, 1, 8200.00),
(2, 3, 2, 200.00),
(4, 4, 1, 3000.00),
(5, 5, 1, 150.00);