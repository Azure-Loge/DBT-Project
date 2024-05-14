
with customer as (

    select * from {{ ref('stg_customer') }}

),
orders as (

    select * from {{ ref('stg_Orders') }}

)


Select 
c_custkey,
c_name,
count(o_orderkey) as Total_Orders,
sum(o_totalprice) as Total_Price
from customer join orders on c_custkey=o_custkey
group by  c_custkey,c_name
