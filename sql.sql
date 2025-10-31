create database join_1;

use join_1;

CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,    
    user_name VARCHAR(50) UNIQUE NOT NULL,    
    password VARCHAR(50) NOT NULL,            
    email VARCHAR(100) UNIQUE NOT NULL,       
    age INT CHECK (age >= 18),                
    status VARCHAR(20) DEFAULT 'active',       
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP  
) ;

CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,     
    user_id INT,           
	order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  
    amount DECIMAL(10, 2) CHECK (amount > 0),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE IF NOT EXISTS orders (
    order_id INT,                                   -- Unique ID for each order
    user_id INT,                                    -- Links to 'users'
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Order creation time
    amount DECIMAL(10, 2) CHECK (amount > 0),       -- Order amount must be positive
    PRIMARY KEY (order_id),                         -- Declared at table level
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,   -- Unique ID for each product
    product_name VARCHAR(100) NOT NULL,          -- Non-null product name
    price DECIMAL(10, 2) CHECK (price > 0),      -- Price must be positive
    stock INT CHECK (stock >= 0)                 -- Stock must be non-negative
);

CREATE TABLE IF NOT EXISTS order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,  -- Unique ID for each order item
    order_id INT,                                  -- References 'orders'
    product_id INT,                                -- References 'products'
    quantity INT CHECK (quantity > 0),             -- Must be positive
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO users (user_name, password, email, age, status) VALUES
('john_doe',       'password123',  'john@example.com',   25, 'active'),
('alice_wonder',   'alice@pass',   'alice@example.com',  30, 'active'),
('mark_smith',     'mark@2024',    'mark@example.com',   28, 'inactive'),
('emily_davis',    'emily_pass',   'emily@example.com',  32, 'active'),
('james_bond',     '007@agent',    'james@example.com',  40, 'banned'),
('sophia_miller',  'sophia@pass',  'sophia@example.com', 27, 'active'),
('david_johnson',  'david@123',    'david@example.com',  35, 'active'),
('lucas_white',    'lucas_pass',   'lucas@example.com',  26, 'inactive'),
('olivia_brown',   'olivia@pass',  'olivia@example.com', 29, 'active'),
('ryan_green',     'ryan@2024',    'ryan@example.com',   31, 'active');

select * from users;

INSERT INTO orders (user_id, order_date, amount) VALUES
(1,  '2024-01-10 10:30:00', 250.75),
(2,  '2024-01-12 15:45:00', 120.50),
(3,  '2024-01-15 08:20:00', 340.99),
(4,  '2024-01-18 12:00:00', 85.30),
(5,  '2024-01-20 14:10:00', 560.25),
(6,  '2024-01-22 18:30:00', 199.99),
(7,  '2024-01-25 11:45:00', 420.00),
(8,  '2024-01-28 16:50:00', 310.80),
(9,  '2024-01-30 09:15:00', 125.99),
(10, '2024-02-02 13:20:00', 275.60),
(1,  '2024-02-05 17:30:00', 90.50),
(3,  '2024-02-07 11:10:00', 189.20),
(5,  '2024-02-10 14:45:00', 470.99),
(7,  '2024-02-12 08:30:00', 320.75),
(9,  '2024-02-15 19:20:00', 145.99);


INSERT INTO products (product_name, price, stock) VALUES
('Laptop',               850.00, 15),
('Smartphone',           499.99, 30),
('Headphones',           79.99,  50),
('Gaming Console',       399.99, 20),
('Smartwatch',           199.99, 25),
('Tablet',               350.50, 18),
('Wireless Earbuds',     99.99,  40),
('External Hard Drive',  120.00, 12),
('Mechanical Keyboard',  140.75, 22),
('Gaming Mouse',         55.00,  35);


INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1,  1,  1),
(1,  3,  2),
(2,  2,  1),
(3,  5,  1),
(4,  7,  3),
(5,  4,  1),
(6,  6,  2),
(7,  9,  1),
(8,  10, 2),
(9,  8,  1),
(10, 5,  1),
(11, 2,  2),
(12, 6,  1),
(13, 3,  1),
(14, 4,  2);

SHOW TABLES;


select * from users u, orders o where u.user_id = o.user_id;

select * from users , orders , order_items, products where users.user_id= orders.user_id and orders.order_id = order_items.order_id and products.product_id = order_items.product_id ;


SELECT * FROM users u, orders o WHERE u.user_id = o.user_id;

show tables;

SELECT 
    users.user_name, 
    orders.order_id, 
    orders.order_date, 
    orders.amount
FROM users
left JOIN orders ON users.user_id = orders.user_id;

SELECT 
    orders.order_id, 
    users.user_name, 
    orders.order_date, 
    orders.amount
FROM orders
RIGHT JOIN users ON orders.user_id = users.user_id;

SELECT 
    users.user_name, 
    products.product_name
FROM users
CROSS JOIN products;