SELECT a.au_id,a.au_lname,a.au_fname, tt.title, p.pub_name
FROM authors a
inner join titleauthor t
on a.au_id = t.au_id 
inner join titles tt
on t.title_id = tt.title_id
inner join publishers p
on p.pub_id = tt.pub_id;

SELECT a.au_id,a.au_lname,a.au_fname, count(tt.title) as 'TITLE COUNT', p.pub_name
FROM authors a
join titleauthor t
on a.au_id = t.au_id 
join titles tt
on t.title_id = tt.title_id
join publishers p
on p.pub_id = tt.pub_id
group by a.au_id, p.pub_name

SELECT a.au_id, au_lname, au_fname, sum(s.qty)
FROM authors a
inner join titleauthor t
on a.au_id = t.au_id 
inner join titles tt
on t.title_id = tt.title_id
inner join sales s
on s.title_id = tt.title_id
group by a.au_id	
order by sum(s.qty) desc
limit 3;

SELECT a.au_id, au_lname, au_fname, IFNULL(sum(s.qty),0) as TOTAL
FROM authors a
left join titleauthor t
on a.au_id = t.au_id 
left join titles tt
on t.title_id = tt.title_id
left join sales s
on s.title_id = tt.title_id
group by a.au_id
order by sum(s.qty) desc