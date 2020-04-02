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

select account_id, group_concat(distinct bank_to), group_concat(distinct amount), count(distinct amount) as diff
from finance.order
where k_symbol ='SIPO'
group by account_id
having diff>1;

#Challenge 3 - Best Selling Districts
select account.account_id, amount, account.district_id
from loan
inner join account
on account.account_id = loan.account_id
order by amount desc;

#Solution in class
select district_id, max(amount) as amount, group_concat(account_id) 
from xxx
group by district_id
order by 2 desc;

#Solution in class ok
select x1.district_id, x1.amount, xxx.account_id
from(select district_id, max(amount) as amount, group_concat(account_id)
from xxx
group by district_id) as x1
inner join xxx on xxx.district_id = x1.district_id
where xxx.amount=x1.amount
order by 2 desc;

#Challenge 4 - Best Selling Districts UPDATED
select account.district_id, sum(amount) as total_amount
from loan
inner join account
on account.account_id = loan.account_id
group by district_id
order by total_amount desc;

select district_id, sum(amount) as total_amount, group_concat(account_id) 
from xxx
group by district_id
order by 2 desc;

#Challenge 5 - Best Selling Districts UPDATED
select account.district_id, sum(amount), round(AVG(amount))
from loan
inner join account
on account.account_id = loan.account_id
group by district_id;

#Calculating the median:
#merge every single row with every single row:
select *
from xxx as x1, xxx as x2;

select count(*) as one_table 
from xxx;

select count(*)
from xxx as x1, xxx as x2;

# Calculating number of rows ranked
select * 
from (select x1.district_id, x1.amount, count(x2.amount) ranking
from xxx as x1, xxx as x2
where x1.amount<=x2.amount and x1.district_id=x2.district_id
group by x1.district_id, x1.amount
order by x1.district_id, x1.amount, x2.amount) ranked;

#calculated the middle number of rows for each district
select x1.district_id, ceil(count(x1.amount)/2) ranking
from xxx x1
group by district_id
order by district_id;

#computing the median for each district: final output
select district_id, amount, ranking
from (select x1.district_id, x1.amount, count(x2.amount) ranking
from xxx as x1, xxx as x2
where x1.amount<x2.amount and x1.district_id=x2.district_id
group by x1.district_id, x1.amount
order by x1.district_id, x1.amount, x2.amount) ranked
where exists (
select x1.district_id, ceil(count(x1.amount)/2) ranking
from xxx x1
group by district_id
having ranked.district_id=x1.district_id 
and ranked.ranking=ranking)
order by amount
;
