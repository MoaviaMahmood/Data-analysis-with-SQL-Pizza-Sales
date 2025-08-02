select pizzas.size, count(orders_details.order_details_id) AS orders_count
from pizzas
join orders_details
on pizzas.pizza_id = orders_details.pizza_id
group by pizzas.size
order by orders_count desc;
