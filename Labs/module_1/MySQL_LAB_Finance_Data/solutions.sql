#Challenge 1 - What is the most successful district?
select district_id, count(account_id) as ac_freq 
from account
group by district_id
order by ac_freq desc
limit 5;

#Challenge 2 - How many people changed their place of residence?
#We assume that people move out from their places if they start paying more for their appartment. 
#Find all those people.

select *
from finance.order;

#Challenge 3 - Best Selling Districts
select account.account_id, amount, account.district_id
from loan
inner join account
on account.account_id = loan.account_id
order by amount desc;

#Challenge 4 - Best Selling Districts UPDATED
select account.district_id, sum(amount) as total_amount
from loan
inner join account
on account.account_id = loan.account_id
group by district_id
order by total_amount desc;

#Challenge 5 - Best Selling Districts UPDATED
select account.district_id, sum(amount), round(AVG(amount))
from loan
inner join account
on account.account_id = loan.account_id
group by district_id;

#Bonus Challenge - Salary/Loan balance
#Detect the Average Salary/ Average Loan/ Average Insurance balance in every district.
