-- =====================================================
-- PIZZA SALES DATA ANALYSIS (MYSQL 8.0)
-- Author: Suraj Yadav
-- Description: End-to-end SQL analysis on 48,000+ pizza orders
-- =====================================================

-- 1. Retrieve the total number of orders placed
SELECT 
    COUNT(order_id) AS total_order 
FROM orders;

-- 2. Calculate the cumulative gross revenue generated across all pizza sales
SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price), 2) AS total_revenue
FROM pizzas
JOIN order_details 
    ON pizzas.pizza_id = order_details.pizza_id;

-- 3. Identify the highest-priced pizza
SELECT 
    pizza_types.name, 
    pizzas.price
FROM pizzas
JOIN pizza_types 
    ON pizzas.pizza_type_id = pizza_types.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

-- 4. Identify the most common pizza size ordered
SELECT 
    pizzas.size,
    COUNT(order_details.order_details_id) AS order_count
FROM order_details
JOIN pizzas 
    ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC;

-- 5. List the top 5 most-ordered pizza types along with their quantities
SELECT 
    pizza_types.name,
    SUM(order_details.quantity) AS total_quantity
FROM pizza_types
JOIN pizzas 
    ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details 
    ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY total_quantity DESC
LIMIT 5;

-- 6. Join the necessary tables to find the total quantity of each pizza category ordered
SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS total_quantity
FROM pizza_types
JOIN pizzas 
    ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details 
    ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY total_quantity DESC;

-- 7. Determine the distribution of orders by the hour of the day
SELECT 
    HOUR(order_time) AS order_hour,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY HOUR(order_time)
ORDER BY total_orders DESC;

-- 8. Find the category-wise distribution of pizzas
SELECT 
    category, 
    COUNT(name) AS total_pizza_types
FROM pizza_types
GROUP BY category
ORDER BY total_pizza_types DESC;

-- 9. Group the orders by date and calculate the average number of pizzas ordered per day
SELECT 
    ROUND(AVG(daily_quantity), 0) AS avg_pizzas_per_day
FROM (
    SELECT 
        orders.order_date,
        SUM(order_details.quantity) AS daily_quantity
    FROM orders
    JOIN order_details 
        ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date
) AS daily_orders;

-- 10. Determine the top 3 most-ordered pizza types based on revenue
SELECT 
    pizza_types.name,
    ROUND(SUM(order_details.quantity * pizzas.price), 2) AS total_revenue
FROM pizza_types
JOIN pizzas 
    ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details 
    ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY total_revenue DESC
LIMIT 3;

-- 11. Calculate the percentage contribution of each pizza category to total revenue
SELECT 
    pizza_types.category,
    ROUND(
        (SUM(order_details.quantity * pizzas.price) / 
            (SELECT ROUND(SUM(order_details.quantity * pizzas.price), 2) 
             FROM order_details 
             JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id)
        ) * 100, 2
    ) AS revenue_percentage
FROM pizza_types
JOIN pizzas 
    ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details 
    ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue_percentage DESC;

-- 12. Analyze cumulative revenue generated over time
SELECT 
    order_date,
    ROUND(SUM(revenue) OVER(ORDER BY order_date), 2) AS cum_revenue
FROM (
    SELECT 
        orders.order_date,
        SUM(order_details.quantity * pizzas.price) AS revenue
    FROM order_details
    JOIN pizzas 
        ON order_details.pizza_id = pizzas.pizza_id
    JOIN orders 
        ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date
) AS daily_sales;

-- 13. Determine top 3 most-ordered pizza types by revenue for each category (Window Function)
SELECT 
    category, 
    name, 
    revenue
FROM (
    SELECT 
        pizza_types.category,
        pizza_types.name,
        ROUND(SUM(order_details.quantity * pizzas.price), 2) AS revenue,
        DENSE_RANK() OVER(
            PARTITION BY pizza_types.category
            ORDER BY SUM(order_details.quantity * pizzas.price) DESC
        ) AS ranking
    FROM pizza_types
    JOIN pizzas 
        ON pizza_types.pizza_type_id = pizzas.pizza_type_id
    JOIN order_details 
        ON order_details.pizza_id = pizzas.pizza_id
    GROUP BY pizza_types.category, pizza_types.name
) AS ranked_pizzas
WHERE ranking <= 3;
