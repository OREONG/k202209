create table member2(
 id varchar2(12) primary key,
 password varchar2(12) not null, 
 name varchar2(20) not null,
 address varchar2(50),
 tel varchar2(20) not null,
 reg_date date,
 del char(1) default 'n'
);
insert into member2 values('k1','1','로제','강남','010-1111-1111',sysdate);
select * from member2;
alter table member2 add (del char(1) default 'n');
select * from member2;