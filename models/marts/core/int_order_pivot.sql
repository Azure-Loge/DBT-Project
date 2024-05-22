{%- set payment_method = ['bank_transfer','coupon','credit_card','gift_card'] -%}

with payment as(
select * from {{ source('RAW_Database_strips','payment') }}
),

pivoted as(
    Select orderid,
    {% for paymentmethod in payment_method -%}

    sum(case when paymentmethod='{{paymentmethod}}' then amount else 0 end) as {{paymentmethod}}_amount

    {%- if not loop.last -%}
    ,
    {% endif -%}

    {% endfor -%}
    -- sum(case when paymentmethod='bank_transfer' then amount else 0 end) as bank_transfer_amount,
    -- sum(case when paymentmethod='coupon' then amount else 0 end) as coupon_amount,
    -- sum(case when paymentmethod='credit_card' then amount else 0 end) as credit_card_amount,
    -- sum(case when paymentmethod='gift_card' then amount else 0 end) as gift_card_amount
    
     from payment
     where status ='success'
     group by 1
)

Select * from pivoted