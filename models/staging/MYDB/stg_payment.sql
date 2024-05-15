

select * from {{ source('MYDB_sample_data', 'loan_payment') }}