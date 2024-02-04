-- The top 3 customers with the highest order values
with
 customers_orders as
		 (
		select 
			o.customer_id as customer
			,o.order_id 
		from orders o 
		order by 2
		),
orders_total as 	
		(
			select  
			 o.customer_id as client_id_or
			 ,o.order_id
			,Round((p.product_price * op.item_quantity),2) as Order_total
		from order_positions  op
		inner join products p  on op.product_id = p.product_id
		inner join orders o 	on o.order_id = op.order_id
		),
customer as 
		(
		select 
			distinct o.customer_id as client_id
			,customer_name as name_client
		from orders o
		inner join customers c on o.customer_id = c.customer_id
		order by 1
		)
select 
	name_client
	,round(sum(order_total),2) as customer_purchase_total
from orders_total
left join customer on client_id = client_id_or
group by 1
order by 2 desc
limit 3

