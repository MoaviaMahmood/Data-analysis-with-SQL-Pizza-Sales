-- Total revenue generated from pizza sales
SELECT 
    ROUND(SUM(orders_details.quantity * pizzas.price), 2) AS Total_Sales
FROM orders_details
JOIN pizzas 
ON pizzas.pizza_id = orders_details.pizza_id;