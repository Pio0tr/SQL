-- Which shipment class has the highest percentage of sales in a delivery_state?

select 
	o.delivery_state 
	,o.shipping_mode 
	,(select count(o.order_id) from orders o) 			as total_nr_of_orders 
	,ds.nr_of_orders_ds
	,count(o.order_id) 						as nr_of_orders_ds_sm 	-- orders per delivery_state and shipping_mode
	,round(count(o.order_id) / nr_of_orders_ds * 100,2) 		as percent_ratio_orders
from orders o 
inner join  
	(
	select 
			delivery_state
			,count(order_id) as nr_of_orders_ds	 -- orders per delivery_state
		from orders o 
		group by 1
	) ds on o.delivery_state = ds.delivery_state
group by 1,2
order by 1,2
