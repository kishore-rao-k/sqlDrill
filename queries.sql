-- create database chat_store;
use chat_store;
-- 1.Write CREATE TABLE statements for tables organization, channel, user, and message.

-- create table organization( id int auto_increment primary key, name text);
-- create table channel(id int auto_increment primary key, name text);
-- create table user(id int auto_increment primary key, name text);
 -- create table message(user_id int, channel_id int, post_time datetime default current_timestamp, content text,
	-- foreign key (user_id) references  user(id) on delete cascade,
  --  foreign key(channel_id) references  channel(id) on delete cascade);

show tables;
-- 2.Add additional foreign keys needed to the above tables, if any.

-- alter table channel
-- add column organization_id INT;

-- alter table channel
-- add constraint fk_organization
-- foreign key(organization_id) references organization(id);

-- 3.Add additional join tables needed, if any.
	-- create table user_channel(  user_id int, channel_id int ,
    -- primary key(user_id,channel_id),  -- composite primary key
   --  foreign key (user_id) references  user(id) on delete cascade,
    -- foreign key(channel_id) references  channel(id) on delete cascade)
   -- Drop table if exists user_channel
-- 4.Write INSERT queries to add information to the database.alter
-- i)One organization, Lambda School
-- insert into organization(name)
-- values ("Lambda School");

-- ii)Three users, Alice, Bob, and Chris
-- insert into channel(name, organization_id)
-- values('#general',1),('#random',1);

-- iii) Two channels, #general and #random
-- insert into user(name)
-- values("Alice"),("Bob"),("Chris");

-- iv) 10 messages (at least one per user, and at least one per channel).
-- drop table if exists message
insert into message(user_id,channel_id,post_time, content)
values(1,7,default,'first message'),(2,7,default,'second message'),(3,7,default,'third message'),
(1,8,default,'fourth message'),(2,8,default,'fifth message'),(3,8,default,'sixth message'),
(1,7,default,'seventh message'),(2,7,default,'8th message'),(3,7,default,'9th message'),
(1,7,default,'10th message'),(2,8,default,'11th message'),(3,8,default,'12th message');

-- v) Alice should be in #general and #random.
-- insert into user_channel(user_id,channel_id)
-- values(1,7),(1,8);

-- vi) Bob should be in #general.
-- insert into user_channel(user_id,channel_id)
-- values(2,7);

-- vii) Chris should be in #random.
-- insert into user_channel(user_id,channel_id)
-- values(3,8);

-- 5) Write SELECT queries to:

-- i) List all organization names.
select * from organization;
-- ii) List all channel names.
 select * from channel;
 -- iii) List all channels in a specific organization by organization name.
 select c.name,o.name from channel c
 join organization o
 on o.id = c.organization_id;
 
 -- iv) List all messages in a specific channel by channel name #general in order of post_time, descending. 
 -- (Hint: ORDER BY. Because your INSERTs might have all taken place at the exact same time, this might not return meaningful results.
 -- But humor us with the ORDER BY anyway.)
 
 select m.content, c.name from message m
 join channel c
 on m.channel_id = c.id
 where c.name = '#general'
 order by m.post_time desc;
 
 -- v) List all channels to which user Alice belongs.
 select c.name from channel c 
 join user_channel uc
 on c.id = uc.channel_id
 join user u 
 on u.id = uc.user_id
 where u.name = 'Alice';
 -- iv) List all users that belong to channel #general.
 select u.name from user u
 join user_channel uc
 on u.id = uc.user_id
 join channel c 
 on c.id = uc.channel_id
 where c.name = '#general';
 
 -- iiv)List all messages in all channels by user Alice.
 select m.content from message m
 join channel c 
 on m.channel_id = c.id
  join user u 
 on m.user_id = u.id
 where u.name = 'Alice';
 
 -- iiiv) List all messages in #random by user Bob.
 select m.content from message m 
 join channel c 
 on m.channel_id = c.id
 join user u 
 on u.id = m.user_id
 where c.name = '#random' and u.name = 'Bob';
 
 -- ix) List the count of messages across all channels per user. (Hint: COUNT, GROUP BY.)
/*
The title of the user's name column should be User Name and the title of the count column should be Message Count. (The SQLite commands .mode column and .header on might be useful here.)

The user names should be listed in reverse alphabetical order.

Example:

User Name   Message Count
----------  -------------
Chris       4
Bob         3
Alice       3
*/

select u.name as 'User Name', count(m.user_id) as 'Message Count' from user u 
join message m 
on u.id = m.user_id
group by m.user_id
order by u.name desc;

-- x) [Stretch!] List the count of messages per user per channel.
/*
Example:

User        Channel     Message Count
----------  ----------  -------------
Alice       #general    1
Bob         #general    1
Chris       #general    2
Alice       #random     2
Bob         #random     2
Chris       #random     2
*/

select u.name as User , c.name as Channel , count(m.user_id) as 'Message Count' from user u
join message m
on u.id = m.user_id
join channel c 
on c.id = m.channel_id
group by m.user_id, m.channel_id;

-- 6) What SQL keywords or concept would you use if you wanted to automatically delete all messages by a user if that user were deleted from the user table?
-- foreign key(col_id) references  tableName(id) on delete cascade 

desc  organization;
 desc  channel;
 desc  user;
 desc  user_channel;
 desc  message;



