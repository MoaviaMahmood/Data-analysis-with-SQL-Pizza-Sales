  SELECT 
      ROUND(AVG(quantity), 0) AS average_order_quantity
  FROM
      (SELECT 
          orders.order_date AS date,
              SUM(orders_details.quantity) AS quantity
      FROM
          orders
      JOIN orders_details ON orders.order_id = orders_details.order_id
      GROUP BY date) AS order_quantity; 
