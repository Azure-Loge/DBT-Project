{%- set order_status = [ 'completed','returned','return_pending','shipped','placed' ] -%}

with Order_Statuswise_Amount as
(
    Select od.Status,od.User_id,py.amount from {{ source('RAW_Database','orders') }} od 
    inner join
    {{ source('RAW_Database_strips','payment') }} py on py.orderid=od.id
),

final as(
Select user_id,

{%- for status in order_status -%}

sum(case when status='{{status}}' then amount else 0 end) as {{status}}_Amount

{%- if not loop.last -%}
,
{% endif -%}

{% endfor %}

-- sum(case when status='completed' then amount else 0 end) as completed_Amount,
-- sum(case when status='returned' then amount else 0 end) as returned_Amount,
-- sum(case when status='return_pending' then amount else 0 end) as return_pending_Amount,
-- sum(case when status='shipped' then amount else 0 end) as shipped_Amount,
-- sum(case when status='placed' then amount else 0 end) as placed_Amount

from order_statuswise_amount
group by 1
)

Select * from final order by 1 asc