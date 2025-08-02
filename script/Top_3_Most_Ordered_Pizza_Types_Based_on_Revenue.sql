SELECT 
    pt.name AS names,
    ROUND(SUM(od.quantity * p.price), 0) AS revenue
FROM
    pizza_types pt
    JOIN pizzas p ON p.pizza_type_id = pt.pizza_type_id
    JOIN orders_details od ON od.pizza_id = p.pizza_id
GROUP BY pt.name
ORDER BY revenue DESC
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY; 
