-- top 3 most orderd pizza based on revenue

SELECT 
    pizza_types.name AS names,
    ROUND(SUM(orders_details.quantity * pizzas.price),0) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY names
ORDER BY revenue DESC
LIMIT 3;