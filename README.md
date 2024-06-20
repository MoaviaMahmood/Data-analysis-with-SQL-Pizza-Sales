# SQL Data Analysis for Pizza Sales

#### This repository contains SQL queries to perform data analysis on pizza sales data. The analysis covers various aspects such as order quantities, revenue, pizza preferences, and temporal patterns.



### Data Analysis
- #### Total Number of Orders Placed
  
```sql
  SELECT 
      COUNT(order_id) AS Total_Orders
  FROM
      orders;
```

- Total Revenue Generated from Pizza Sales
  
```sql
  SELECT 
    ROUND(SUM(orders_details.quantity * pizzas.price), 2) AS Total_Sales
  FROM orders_details
  JOIN pizzas
  ON pizzas.pizza_id = orders_details.pizza_id;
```

- Highest-Priced Pizza

```sql
  SELECT pizza_types.name, pizzas.price
  FROM pizza_types
  JOIN pizzas
  ON pizza_types.pizza_type_id = pizzas.pizza_type_id
  ORDER BY pizzas.price DESC
  LIMIT 1;
```

- Count of Pizza Size Ordered

```sql
select pizzas.size, count(orders_details.order_details_id) AS orders_count
from pizzas
join orders_details
on pizzas.pizza_id = orders_details.pizza_id
group by pizzas.size
order by orders_count desc;
```

- Top 5 Most Ordered Pizza Types along with Their Quantities

```sql
  SELECT pizza_types.name,
  		sum(orders_details.quantity) as quantity
  from pizza_types
  join pizzas
  on pizza_types.pizza_type_id = pizzas.pizza_type_id
  join orders_details
  on orders_details.pizza_id = pizzas.pizza_id
  group by pizza_types.name
  order by quantity desc
  limit 5;
```

- Total Quantity of Each Pizza Category Ordered

```sql
  SELECT 
      pizza_types.category,
      SUM(orders_details.quantity) AS quantity
  FROM
      pizza_types
          JOIN
      pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
          JOIN
      orders_details ON orders_details.pizza_id = pizzas.pizza_id
  GROUP BY pizza_types.
```

- Distribution of Orders by Hour of the Day

```sql
SELECT 
    DATEPART(HOUR, order_time) as hours, 
    COUNT(order_id) AS ORDERS
FROM
    orders
GROUP BY 
    DATEPART(HOUR, order_time)
order by hours;
```

- Category-wise Distribution of Pizzas
  
```sql
  SELECT category, COUNT(name) as total
  FROM pizza_types
  group by category;
```

- Average Number of Pizzas Ordered per Day
```sql
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
```
- Top 3 Most Ordered Pizza Types Based on Revenue

```sql
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
```

- Percentage Contribution of Each Pizza Type to Total Revenue

```sql
  SELECT 
      pizza_types.category,
      ROUND((SUM(orders_details.quantity * pizzas.price) / (SELECT 
                      ROUND(SUM(orders_details.quantity * pizzas.price),
                                  2) AS total_sales
                  FROM
                      orders_details
                          JOIN
                      pizzas ON pizzas.pizza_id = orders_details.pizza_id)) * 100,
              2) AS revenue
  FROM
      pizza_types
          JOIN
      pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
          JOIN
      orders_details ON orders_details.pizza_id = pizzas.pizza_id
  GROUP BY pizza_types.category
  ORDER BY revenue DESC;  
```

- Cumulative Revenue Generated Over Time

```sql
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
    
```

- Top 3 Most Ordered Pizza Types Based on Revenue for Each Pizza Category

```sql
  SELECT name,revenue
  FROM
  	(SELECT 
  		category, name, revenue,
  		RANK() OVER(PARTITION BY category ORDER BY revenue desc) as rn
  	 FROM
  		(SELECT 
  				pizza_types.category,
  				pizza_types.name,
  				SUM(orders_details.quantity * pizzas.price) AS revenue
  			FROM
  				pizza_types
  					JOIN pizzas 
  					ON pizza_types.pizza_type_id = pizzas.pizza_type_id
  					JOIN orders_details 
  					ON orders_details.pizza_id = pizzas.pizza_id
  			GROUP BY pizza_types.category , pizza_types.name
          )as a
  	)as b;
  
```
