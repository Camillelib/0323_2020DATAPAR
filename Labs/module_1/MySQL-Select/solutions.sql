SELECT a.au_id,a.au_lname,a.au_fname, tt.title, p.pub_name
FROM authors a
left join titleauthor t
on a.au_id = t.au_id 
left join titles tt
on t.title_id = tt.title_id
left join publishers p
on p.pub_id = tt.pub_id;

SELECT a.au_id,a.au_lname,a.au_fname, p.pub_name, count(tt.title) as 'TITLE COUNT'
FROM authors a
left join titleauthor t
on a.au_id = t.au_id 
left join titles tt
on t.title_id = tt.title_id
left join publishers p
on p.pub_id = tt.pub_id
group by tt.title;

SELECT a.au_id,a.au_lname,a.au_fname, s.qty as TOTAL
FROM authors a
left join titleauthor t
on a.au_id = t.au_id 
left join titles tt
on t.title_id = tt.title_id
left join sales s
on s.title_id = tt.title_id
order by s.qty desc
limit 3;

SELECT a.au_id,a.au_lname,a.au_fname, s.qty as TOTAL
FROM authors a
left join titleauthor t
on a.au_id = t.au_id 
left join titles tt
on t.title_id = tt.title_id
left join sales s
on s.title_id = tt.title_id
order by s.qty desc;



