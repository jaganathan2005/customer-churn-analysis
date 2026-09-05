use customer_churn_project;
select * from customer_churn_dataset_analysis;
-- select count(*) as total_rows from customer_churn_dataset_analysis;


-- 1. How many total customers, churned customers, and retained customers are there?
select count(customer_id) as total_customers, sum(case when churn = 1 then 1 else 0 end) as churned_customers,sum(case when churn = 0 then 1 else 0 end) as retained_customers
from customer_churn_dataset_analysis;

-- 2. What is the overall customer churn rate?
select round(sum(case when churn = 1 then 1 else 0 end)  / count(customer_id) * 100.0,2) as churn_rate from customer_churn_dataset_analysis;

-- 3. Which contract length has the highest churn rate?
select contract_length,count(customer_id) as total_customers,sum(case when churn = 1 then 1 else 0 end) as customer_churned,round(sum(case when churn = 1 then 1 else 0 end) / count(customer_id) * 100.0 ,2) as churn_rate 
from customer_churn_dataset_analysis group by contract_length order by churn_rate desc;

-- 4. Does payment delay increase customer churn?
select (case
when payment_delay = 0 then 'No Delay'
when payment_delay between 1 and 10   then 'Low Delay'
when payment_delay between 11 and 20  then 'Medium Delay'
else 'High Delay'
end) as payment_delay_group,
count(customer_id) as total_customers,
sum(case when churn = 1 then 1 else 0 end) as customer_churned,
round(sum(case when churn = 1 then 1 else 0 end)/count(customer_id) * 100.0,2) as churn_rate 
from  customer_churn_dataset_analysis
group by payment_delay_group
order by churn_rate desc;

-- 5. Do customers who make more support calls have a higher churn rate?
select support_calls,count(customer_id) as total_customers, sum(case when churn = 1 then 1 else 0 end) as churned_customers, round(
sum(case when churn = 1 then  1 else 0 end ) / count(customer_id) * 100.0 , 2) as churn_rate 
from  customer_churn_dataset_analysis
group by support_calls
order by support_calls asc;

-- 6. Usage Frequency Analysis
select (case 
when usage_frequency between 1 and 10 then 'Low Usage'
when usage_frequency between 11 and 20 then 'Medium Usage'
else 'High Usage'
end) as Usage_Frequency_group,
count(customer_id) as total_customers,
sum(case when churn = 1 then 1 else 0 end) as churned_customers,
round(sum(case when churn = 1 then 1 else 0 end) / count(customer_id) * 100.0 , 2) as churn_rate
from customer_churn_dataset_analysis
group by Usage_Frequency_group
order by churn_rate desc;

-- 7. Tenure Analysis
select tenure_group,count(customer_id) as total_customers,sum(case when churn = 1 then 1 else 0 end ) as churned_customers, round(
sum(case when churn = 1 then 1 else 0 end ) / count(customer_id) * 100.0,2) as churn_rate 
from customer_churn_dataset_analysis
group by tenure_group
order by min(tenure);

-- 8. Which subscription type has the highest churn rate?
select subscription_type,count(customer_id) as total_customers,sum(case when churn = 1 then 1 else 0 end ) as churned_customers, round(
sum(case when churn = 1 then 1 else 0 end ) / count(customer_id) * 100.0,2) as churn_rate 
from customer_churn_dataset_analysis
group by subscription_type
order by churn_rate desc;

-- 9. Which age group has the highest churn rate?
select age_group,count(customer_id) as total_customers,sum(case when churn = 1 then 1 else 0 end ) as churned_customers, round(
sum(case when churn = 1 then 1 else 0 end ) / count(customer_id) * 100.0,2) as churn_rate 
from customer_churn_dataset_analysis
group by age_group
order by min(age);

-- 10. Total Spend Analysis
select (case 
when total_spend between 100 and 300 then 'Low Spend'
when total_spend between 301 and 600 then 'Medium spend'
else 'High Spend'
end) as spend_groups,
count(customer_id) as total_customers,
sum(case when churn = 1 then 1 else 0 end ) as churned_customers,
round(sum(case when churn = 1 then 1 else 0 end) / count(customer_id) * 100.0,2) as churn_rate
from  customer_churn_dataset_analysis
group by spend_groups
order by churn_rate desc;

-- Identify high-risk customers
select count(customer_id) as total_high_risk_customers,sum(case when churn = 1 then 1 else 0 end) as churned_high_risk_customers,
round(sum(case when churn = 1 then 1 else 0 end) / count(customer_id) * 100.0,2) as high_risk_churn_rate
from customer_churn_dataset_analysis
where payment_delay >=21 and support_calls >=5 and usage_frequency <=10;






