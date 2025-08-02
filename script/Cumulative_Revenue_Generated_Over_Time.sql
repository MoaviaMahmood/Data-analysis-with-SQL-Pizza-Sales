select order_date,
  sum(revenue) over(order by order_date) as cuml_revenue
  from
      (select orders.order_date,
      round(sum(orders_details.quantity * pizzas.price),0) as revenue
      from orders_details
      join pizzas
      on orders_details.pizza_id = pizzas.pizza_id
      join orders
      on orders.order_id = orders_details.order_id
      group by orders.order_date) as sales;
