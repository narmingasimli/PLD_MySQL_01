CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    order_date DATE
);

INSERT INTO orders (order_id, customer_id, order_date) VALUES
(1, 100, '2024-06-01'),
(2, 101, '2024-06-02'),
(3, 102, '2024-06-03');

SELECT * FROM orders;
------------------------------------
CREATE TABLE order_items (
    item_id INT,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2)
);

INSERT INTO order_items (item_id, order_id, product_id, quantity, price) VALUES
(1, 1, 200, 2, 50.00),
(2, 1, 201, 1, 100.00),
(3, 2, 200, 1, 50.00),
(4, 2, 202, 3, 25.00),
(5, 3, 201, 2, 100.00);

SELECT * FROM order_items;
------------------------------------
CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(50),
    category VARCHAR(50)
);
INSERT INTO products (product_id, product_name, category) VALUES
(200, 'Widget A', 'Gadgets'),
(201, 'Widget B', 'Gadgets'),
(202, 'Widget C', 'Accessories');

SELECT * FROM products;
------------------------------------
SELECT
    o.order_id,
    SUM(oi.quantity * oi.price) AS total_price,
    SUM(CASE WHEN p.category = 'Gadgets' THEN oi.quantity ELSE 0 END) AS gadgets_quantity,
    SUM(CASE WHEN p.category = 'Accessories' THEN oi.quantity ELSE 0 END) AS accessories_quantity
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.order_date >= '2024-06-01' AND o.order_date < '2024-07-01'
GROUP BY o.order_id
ORDER BY o.order_id;