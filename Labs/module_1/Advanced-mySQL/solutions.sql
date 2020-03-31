# Challenge 1

# Step1
select titleauthor.title_id, titleauthor.au_id, 
round((titles.advance*titleauthor.royaltyper / 100)) as advance,
round((titles.price*sales.qty*titles.royalty/100)*(titleauthor.royaltyper/100)) as sales_royalty
from titleauthor
inner join titles
on titleauthor.title_id = titles.title_id
inner join sales
on titleauthor.title_id = sales.title_id;

# Step 2
select title_id, au_id, sum(advance), sum(sales_royalty)
from(
select titleauthor.title_id, titleauthor.au_id, 
round((titles.advance*titleauthor.royaltyper / 100)) as advance,
round((titles.price*sales.qty*titles.royalty/100)*(titleauthor.royaltyper/100)) as sales_royalty
from titleauthor
inner join titles
on titleauthor.title_id = titles.title_id
inner join sales
on titleauthor.title_id = sales.title_id) table1
group by title_id, au_id;

# Step 3
select au_id, sum_advance+sum_sales_royalty as total_profit
from(
select title_id, au_id, sum(advance) as sum_advance, sum(sales_royalty) as sum_sales_royalty
from(
select titleauthor.title_id, titleauthor.au_id, 
round((titles.advance*titleauthor.royaltyper / 100)) as advance,
round((titles.price*sales.qty*titles.royalty/100)*(titleauthor.royaltyper/100)) as sales_royalty
from titleauthor
inner join titles
on titleauthor.title_id = titles.title_id
inner join sales
on titleauthor.title_id = sales.title_id) table1
group by title_id, au_id) table2
order by total_profit desc
limit 3;

# Challenge 2

#Step1
create temporary table table1b
select titleauthor.title_id, titleauthor.au_id, 
round((titles.advance*titleauthor.royaltyper / 100)) as advance,
round((titles.price*sales.qty*titles.royalty/100)*(titleauthor.royaltyper/100)) as sales_royalty
from titleauthor
inner join titles
on titleauthor.title_id = titles.title_id
inner join sales
on titleauthor.title_id = sales.title_id;

#Step2
create temporary table table2bok
select title_id, au_id, sum(advance) as sum_advance, sum(sales_royalty) as sum_sales_royalty
from table1b
group by title_id, au_id;

#Step3
create temporary table table3b
select au_id, sum_advance+sum_sales_royalty as total_profit
from table2bok 
order by total_profit desc
limit 3;

select *
from table3b;

#Challenge3
create table solution1 
select au_id, total_profit
from table3b; 

select * 
from solution1;

create view solution1b as 
select au_id, sum_advance+sum_sales_royalty as total_profit
from(
select title_id, au_id, sum(advance) as sum_advance, sum(sales_royalty) as sum_sales_royalty
from(
select titleauthor.title_id, titleauthor.au_id, 
round((titles.advance*titleauthor.royaltyper / 100)) as advance,
round((titles.price*sales.qty*titles.royalty/100)*(titleauthor.royaltyper/100)) as sales_royalty
from titleauthor
inner join titles
on titleauthor.title_id = titles.title_id
inner join sales
on titleauthor.title_id = sales.title_id) table1
group by title_id, au_id) table2
order by total_profit desc
limit 3;

select *
from solution1b;
