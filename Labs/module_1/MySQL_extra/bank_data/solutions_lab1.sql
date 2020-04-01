# From the client table, what are the ids of the first 5 clients from disrict_id 1?
select client_id
from client
where district_id=1
limit 5;

# From the client table, what is the id of the last client from district_id 72?
select client_id
from client
where district_id=72
order by client_id desc;

# From the loan table, what are the 3 lowest amounts?
select amount
from loan
order by amount
limit 3;

#From the loan table, what are the possible values for status, 
#ordered alphabetically in ascending order?
select status
from loan
group by status
order by status;

#From the loans table, what is the loan_id of the highest payment received?
select loan_id, payments
from loan
order by payments desc
limit 1;

#From the loans table, what is the loan amount of the lowest 5 account_ids. 
#Show the account_id and the corresponding amount
select account_id, amount
from loan
order by account_id
limit 5;

#From the loans table, which are the account_ids 
#with the lowest loan amount have a loan duration of 60?
select account_id, duration, amount
from loan
where duration = 60
order by amount
limit 5;

#From the order table, what are the unique values of k_symbol?
select distinct k_symbol
from bank.order
order by k_symbol;

#From the order table, which are the order_ids from the client with the account_id 34?
select order_id, account_id
from bank.order
where account_id=34;

#From the order table, which account_ids were responsible for orders 
#between order_id 29540 and order_id 29560 (inclusive)?
select account_id, group_concat(order_id)
from bank.order
where order_id between 29540 and 29560
group by account_id;

#From the order table, what are the individual amounts that 
#were sent to (account_to) id 30067122?
select account_to, amount
from bank.order
where account_to=30067122;

#From the trans table, show the trans_id, date, type and amount of the 10 first transactions 
#from account_id = 793 in chronological order, from newest to oldest.
select trans_id, date, type, amount
from bank.trans
where account_id=793
order by date
limit 10;

#The table trans is empty!!