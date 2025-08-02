SELECT 
    DATEPART(HOUR, order_time) as hours, 
    COUNT(order_id) AS ORDERS
FROM
    orders
GROUP BY 
    DATEPART(HOUR, order_time)
order by hours;

Category-wise Distribution of Pizzas
  SELECT category, COUNT(name) as total
  FROM pizza_types
  group by category;
