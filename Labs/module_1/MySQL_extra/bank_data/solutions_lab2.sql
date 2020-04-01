#1. From the client table, of all districts with a district_id lower than 10, 
#how many clients are from each district_id? 
#Show the results sorted by district_id in ascending order.
select district_id, count(distinct client_id)
from client
where district_id<10
group by district_id;

#2. From the card table, how many cards exist for each type? 
#Rank the result starting with the most frequent type.
select type, count(card_id)
from card
group by type
order by count(card_id) desc;

#3. Using the loan table, print the top 10 account_ids based on
# the sum of all of their loan amounts.
select account_id, sum(amount)
from loan
group by account_id
order by sum(amount) desc
limit 10;

#4. From the loan table, retrieve the number of loans issued for each day, before (excl) 930907, 
#ordered by date in descending order
select date, count(loan_id)
from loan
where date < 930907
group by date
order by date desc;

#5. From the loan table, for each day in December 1997, 
#count the number of loans issued for each unique loan duration, 
#ordered by date and duration, both in ascending order. 
#You can ignore days without any loans in your output.
select date, duration, count(distinct loan_id)
from loan
where date like '9712%'
group by date, duration
order by date, duration;

#6. From the trans table, for account_id 396, sum the amount of transactions for each type
# (VYDAJ = Outgoing, PRIJEM = Incoming). Your output should have the account_id, 
#the type and the sum of amount, named as total_amount. Sort alphabetically by type.
select account_id, type, sum(amount) as total_amount
from trans
where account_id=396
group by type;

#7. From the previous output, translate the values for type to English, 
#rename the column to transaction_type, round total_amount down to an integer
create table t2ok
select account_id,
(CASE WHEN type='PRIJEM' 
THEN 'INCOMING'
ELSE 'OUTGOING' 
END) as transaction_type, round(total_amount,1) as total_amount2
from 
(select account_id, type, sum(amount) as total_amount
from trans
where account_id=396
group by type) t1;

#8. From the previous result, modify you query so that it returns only one row, 
#with a column for incoming amount, outgoing amount and the difference
select account_id, sum(if(transaction_type='INCOMING',total_amount2,0)) as INCOMING,
	sum(if(transaction_type like 'OUT%',total_amount2,0)) as OUTGOING, sum(if(transaction_type='INCOMING',total_amount2,0))-sum(if(transaction_type like 'OUT%',total_amount2,0)) as DIFFERENCE
from t2ok
group by account_id;

#9. Continuing with the previous example, rank the top 10 account_ids based on their difference

# create table with all ids per type
select account_id, type, round(sum(amount)) as total_amount
from trans
group by account_id, type;

#transform type into INCOMING and OUTGOING
create temporary table t6
select account_id,
(CASE WHEN type='PRIJEM' 
THEN 'INCOMING'
ELSE 'OUTGOING' 
END) as transaction_type, round(total_amount,1) as total_amount2
from 
(select account_id, type, sum(amount) as total_amount
from trans
group by account_id, type) t5b;

select *
from t6;

#final result with top 10 differences:
select account_id, sum(if(transaction_type='INCOMING',total_amount2,0)) as INCOMING,
	sum(if(transaction_type like 'OUT%',total_amount2,0)) as OUTGOING, sum(if(transaction_type='INCOMING',total_amount2,0))-sum(if(transaction_type like 'OUT%',total_amount2,0)) as DIFFERENCE
from t6
group by account_id
order by DIFFERENCE desc
limit 10;
