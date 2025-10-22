USE Assignment02;

-- Non-optimized query
EXPLAIN ANALYZE
SELECT 
    c.cust_name,
    c.email,
    p.name AS product_name,
    SUM(s.quantity) AS total_quantity,
    COUNT(s.sale_id) AS num_purchases
FROM customers c
JOIN sales s
    ON c.customer_id = s.customer_id
JOIN products p
    ON s.product_id = p.product_id
WHERE s.sale_date >= '2025-01-01'
  AND s.quantity > 2
GROUP BY c.cust_name, c.email, p.name
ORDER BY total_quantity DESC;


-- Optimized

WITH filtered_sales AS (
    SELECT *
    FROM sales
    WHERE sale_date >= '2025-01-01' AND quantity > 3
),
customer_product AS (
    SELECT
        customer_id,
        product_id,
        SUM(quantity) AS total_quantity,
        COUNT(*) AS num_purchases
    FROM filtered_sales
    GROUP BY customer_id, product_id
)
SELECT
    c.cust_name,
    c.email,
    p.name AS product_name,
    cp.total_quantity,
    cp.num_purchases
FROM customer_product cp
JOIN customers c ON cp.customer_id = c.customer_id
JOIN products p ON cp.product_id = p.product_id
ORDER BY cp.total_quantity DESC
LIMIT 10;
