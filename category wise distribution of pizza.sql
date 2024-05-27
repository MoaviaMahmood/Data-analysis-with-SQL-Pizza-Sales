-- category wise distribution of pizza

SELECT category, COUNT(name) as total
FROM pizza_types
group by category;