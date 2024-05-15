    select 
    o_orderkey,
    o_custkey,
    o_totalprice
    from {{ source('snow_sample_data', 'orders') }}