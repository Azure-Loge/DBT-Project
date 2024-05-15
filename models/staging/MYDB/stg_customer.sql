    select c_custkey,
    c_name,
    c_address
    from {{ source('snow_sample_data','customer')}}