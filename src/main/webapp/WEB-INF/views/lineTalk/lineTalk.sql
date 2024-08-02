show tables;

create table lineTalk (
	idx int not null auto_increment primary key,
	mid varchar(20) not null,
	chat varchar(100),
	wDate datetime default now(),
	foreign key(mid) references member2(mid)
);

desc lineTalk;

select lineTalk.*, m.nickName, m.photo from lineTalk left join member2 m on lineTalk.mid = m.mid;