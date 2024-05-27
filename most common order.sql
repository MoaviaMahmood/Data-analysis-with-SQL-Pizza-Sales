-- most common pizza orderd

SELECT quantity, COUNT(order_details_id) as ordered
FROM orders_details
GROUP BY quantity;