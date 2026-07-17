select * from sellers
select * from category_name
select * from customers
select * from products
select * from orders
select * from order_items
select * from order_payments
select * from order_reviews

select * from order_items
select * from order_payments

-- Total Payment Value
SELECT 
	ROUND(SUM(payment_value),0) AS Total_Payment  
FROM order_payments

-- Total Price
SELECT
	ROUND(SUM(price),0) AS Total_Price
FROM order_items

-- Total Freight Value
SELECT
	ROUND(SUM(freight_value),0) AS Total_Freight_Value
FROM order_items

-- Top 10 State by Payment
SELECT TOP 10
    C.customer_state,
    ROUND(SUM(OP.payment_value),0) AS total_payment
FROM customers C
JOIN orders O ON C.customer_id = O.customer_id
JOIN order_payments OP ON O.order_id = OP.order_id
GROUP BY C.customer_state
ORDER BY total_payment DESC;

-- Top 10 City by Payment
SELECT TOP 10
    C.customer_city,
    ROUND(SUM(OP.payment_value),0) AS total_payment
FROM customers C
JOIN orders O ON C.customer_id = O.customer_id
JOIN order_payments OP ON O.order_id = OP.order_id
GROUP BY C.customer_city
ORDER BY total_payment DESC;

-- Top 5 Cities for Top 10 States
WITH RankedCities AS (
    SELECT
        C.customer_state,
        C.customer_city,
        ROUND(SUM(OP.payment_value), 0) AS total_payment,
        ROW_NUMBER() OVER (PARTITION BY C.customer_state ORDER BY SUM(OP.payment_value) DESC) AS rn
    FROM customers C
    JOIN orders O ON C.customer_id = O.customer_id
    JOIN order_payments OP ON O.order_id = OP.order_id
    GROUP BY C.customer_state, C.customer_city
),
TopStates AS (
    SELECT TOP 10
        customer_state,
        SUM(total_payment) AS state_payment
    FROM RankedCities
    GROUP BY customer_state
    ORDER BY state_payment DESC
)
SELECT
    R.customer_state,
    R.customer_city,
    R.total_payment
FROM RankedCities R
JOIN TopStates T ON R.customer_state = T.customer_state
WHERE R.rn <= 5
ORDER BY T.state_payment DESC, R.customer_state, R.total_payment DESC;

-- Average Delivery days
SELECT
    AVG(DATEDIFF(day,order_purchase_timestamp,order_delivered_customer_date)) AS Average_delivery_days
FROM orders
-- order takes about 12 days to be delivered 

-- Average estimated time - the real time
SELECT
    AVG(DATEDIFF(day,order_estimated_delivery_date,order_delivered_customer_date)) AS Average_delivery_days
FROM orders
-- oh it's negative with 11 days , it mean the delivery done ealier with 11 days

-- Total Orders
SELECT
    DISTINCT COUNT(order_id) AS Total_Orders
FROM orders

-- Number of Products
SELECT
     COUNT(product_id) AS Total_Products
FROM products;

-- Let's check TOP 10 price of each category
SELECT TOP 10
    CN.product_category_name_english,
    MIN(OI.price) AS min_products_price,
    MAX(OI.price) AS max_products_price,
    ROUND(AVG(OI.price), 0) AS avg_products_price
FROM products P
JOIN order_items OI ON OI.product_id = P.product_id
JOIN category_name CN ON CN.product_category_name = P.product_category_name
WHERE P.product_category_name IS NOT NULL
GROUP BY CN.product_category_name_english
ORDER BY avg_products_price DESC;
-- Each price has different value, maybe it's inflation or unmentioned discount, so we will use the average

-- Average Score
SELECT
    ROUND(AVG(CAST(review_score AS FLOAT)), 1) AS Average_Score
FROM order_reviews;

-- Top 10 Sellers by Payment
SELECT TOP 10 
    S.seller_id,
    ROUND(SUM(OP.payment_value),0) AS total_payment
FROM sellers S
JOIN order_items OI ON S.seller_id = OI.seller_id
JOIN order_payments OP ON OI.order_id = OP.order_id
GROUP BY S.seller_id
ORDER BY total_payment DESC;

-- Top 10 Sellers' States by Payment
SELECT TOP 10 
    S.seller_state,
    ROUND(SUM(OP.payment_value),0) AS total_payment
FROM sellers S
JOIN order_items OI ON S.seller_id = OI.seller_id
JOIN order_payments OP ON OI.order_id = OP.order_id
GROUP BY S.seller_state
ORDER BY total_payment DESC;

-- Top 10 Sellers' Cities by Payment
SELECT TOP 10 
    S.seller_city,
    ROUND(SUM(OP.payment_value),0) AS total_payment
FROM sellers S
JOIN order_items OI ON S.seller_id = OI.seller_id
JOIN order_payments OP ON OI.order_id = OP.order_id
GROUP BY S.seller_city
ORDER BY total_payment DESC;

-- Payment Types
SELECT
    payment_type,
    COUNT(payment_type) AS Payment_Types_count
FROM order_payments
GROUP BY payment_type
ORDER BY Payment_Types_count DESC;

-- Order Status
SELECT
    order_status,
    COUNT(order_status) AS Payment_Status_count
FROM orders
GROUP BY order_status
ORDER BY Payment_Status_count DESC;

-- Top 10 Wieghted Products
SELECT TOP 10
    c.product_category_name_english,
    p.product_weight_g,
    (p.product_length_cm * p.product_height_cm * p.product_width_cm) AS product_volume_cm3
FROM products p
JOIN category_name c ON c.product_category_name = p.product_category_name
WHERE p.product_category_name IS NOT NULL
ORDER BY p.product_weight_g DESC;

