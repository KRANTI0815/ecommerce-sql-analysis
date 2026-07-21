-- 1. Total Revenue
SELECT SUM(total_amount) AS total_revenue FROM orders;

-- 2. Top 5 Customers by Spending
SELECT c.customer_id, c.name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC
LIMIT 5;

-- 3. Monthly Revenue Trend
SELECT strftime('%Y-%m', order_date) AS month, SUM(total_amount) AS revenue
FROM orders
GROUP BY month
ORDER BY month;

-- 4. Top 5 Selling Products
SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 5;

-- 5. Average Order Value
SELECT AVG(total_amount) AS avg_order_value FROM orders;

-- 6. Customers with No Orders
SELECT c.customer_id, c.name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 7. Orders with Highest Value
SELECT * FROM orders
ORDER BY total_amount DESC
LIMIT 5;

-- 8. Revenue by Category
SELECT p.category, SUM(oi.quantity * oi.price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;

-- 9. Repeat Customers
SELECT customer_id, COUNT(order_id) AS order_count
FROM orders
GROUP BY customer_id
HAVING order_count > 1;

-- 10. Daily Orders Count
SELECT order_date, COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_date
ORDER BY order_date;

-- 11. Most Expensive Products
SELECT product_name, price
FROM products
ORDER BY price DESC
LIMIT 5;

-- 12. Customer Lifetime Value
SELECT c.customer_id, c.name, SUM(o.total_amount) AS lifetime_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY lifetime_value DESC;
