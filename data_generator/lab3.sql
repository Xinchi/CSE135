﻿/*
drop table sta_cat;
drop table sta_pro;
drop table cus_cat;
drop table cus_pro;
*/

/* state | category | amount */
create table sta_cat as (select u.state, p.category, SUM(o.price*o.quantity) as amount
from user_t u, order_t o, product p
where o.username = u.id
and o.product = p.id
group by u.state, p.category
order by amount desc
);


/* state | product | amount */
create table sta_pro as (select u.state, o.product, SUM(o.price*o.quantity) as amount
from user_t u, order_t o
where o.username = u.id
group by u.state, o.product
order by amount desc
);


/* uid | state | uname | product | amount  */

create table cus_pro as (select u.id,u.state, u.name as username, p.name, SUM(o.price*o.quantity) as amount
from user_t u, product p, order_t o
where o.username = u.id 
and   o.product = p.id
group by u.id, p.id
order by amount desc);

/* uid | uname | category | state | amount */

create table cus_cat as (select u.id,u.name, p.category, u.state,  SUM(o.price*o.quantity) as amount
from user_t u, product p, order_t o
where o.username = u.id 
and   o.product = p.id
group by u.id, p.category
order by amount desc);

/* state - get row header(top 20 product) */


create index cus_pro_uid_idx ON cus_pro (id);
create index cus_pro_state_idx ON cus_pro(state);
create index cus_pro_name_idx ON cus_pro(name);
create index cus_pro_amount_idx ON cus_pro(amount);

create index cus_cat_uid_idx ON cus_cat(id);
create index cus_cat_cid_idx ON cus_cat(category);
create index cus_cat_state_idx ON cus_cat(state);
create index cus_cat_amount_idx ON cus_cat(amount);

create index sta_cat_state_idx ON sta_cat(state);
create index sta_cat_cid_idx ON sta_cat(category);
create index sta_cat_amount_idx ON sta_cat(amount);

create index sta_pro_state_idx ON sta_pro(state);
create index sta_pro_pid_idx ON sta_pro(product);
create index sta_pro_amount_idx ON sta_pro(amount);



