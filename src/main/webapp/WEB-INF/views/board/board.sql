show tables;

create table knowhow (
	idx 			int not null auto_increment, 	/* 게시글의 고유번호 */
	mid 			varchar(20) not null,					/* 게시글 올린이의 아이디 */
	title 		varchar(100) not null, 				/* 게시글 제목 */
	content 	text not null, 								/* 게시글 내용 */
	fName		 	varchar(200),									/* 업로드시의 화일명 */
  fSName   	varchar(200), 								/* 실제 서버에 저장되는 파일명 */
	readNum 	int default 0, 								/* 게시글 조회수 */
	hostIp 		varchar(40) not null, 				/* 글쓴이 아이피 */
	wDate 		datetime default now(), 			/* 글쓴시간 */
	good 			int default 0, 								/* 좋아요 */
	complaint char(2) default 'NO', 				/* 신고해당유무(신고당한글: OK) */
	openSw	char(2)  default 'OK',			/* 게시글 공개여부(OK:공개, NO:비공개) */
	primary key(idx),
	foreign key(mid) references member2(mid)
);

drop table knowhow;
desc knowhow;

insert into knowhow values (default,'admin','게시판 서비스를 시작합니다.','즐거운 게시판생활이 되세요.','','',default,'192.168.50.20',default,default,default,default);

select * from board2 where idx = 9;  /* 현재글 */
select idx,title from board2 where idx > 9 order by idx limit 1;  /* 다음글 */
select idx,title from board2 where idx < 9 order by idx desc limit 1;  /* 이전글 */

-- 시간으로 비교해서 필드에 값 저장하기
select *, timestampdiff(hour, wDate, now()) as hour_diff from board2;

-- 날짜로 비교해서 필드에 값 저장하기
select *, datediff(wDate, now()) as date_diff from board2;

-- 관리자는 모든글 보여주고, 일반사용자는 비공개글(openSw='NO')과 신고글(complaint='OK')은 볼수없다. 단, 자신이 작성한 글은 볼수 있다.
select count(*) as cnt from board2;
select count(*) as cnt from board2 where openSW = 'OK' and complaint = 'NO';
select count(*) as cnt from board2 where mid = 'hkd1234';

select * from board2 where openSW = 'OK' and complaint = 'NO';
select * from board2 where mid = 'hkd1234';
select * from board2 where openSW = 'OK' and complaint = 'NO' union select * from board2 where mid = 'hkd1234';
select * from board2 where openSW = 'OK' and complaint = 'NO' union all select * from board2 where mid = 'hkd1234';

select count(*) as cnt from board2 where openSW = 'OK' and complaint = 'NO' union select count(*) as cnt from board2 where mid = 'hkd1234';
select sum(a.cnt) from (select count(*) as cnt from board2 where openSW = 'OK' and complaint = 'NO' union select count(*) as cnt from board2 where mid = 'hkd1234') as a;

select sum(a.cnt) from (select count(*) as cnt from board2 where openSW = 'OK' and complaint = 'NO' union select count(*) as cnt from board2 where mid = 'hkd1234' and (openSW = 'NO' or complaint = 'OK')) as a;


/* 댓글 */
create table boardReply2 (
  idx       int not null auto_increment,	/* 댓글 고유번호 */
  boardName  int not null,						/* 원본글(부모글)의 테이블명 */
  boardIdx  int not null,						/* 원본글(부모글)의 고유번호-외래키로 지정 */
  re_step   int not null,						/* 레벨(re_step)에 따른 들여쓰기(계층번호): 부모댓글의 re_step는 0이다. 대댓글의 경우는 '부모re_step+1'로 처리한다. */
  re_order  int not null,						/* 댓글의 순서를 결정한다. 부모댓글을 1번, 대댓글의 경우는 부모댓글보다 큰 대댓글은 re_order+1 처리하고, 자신은 부모댓글의 re_order보다 +1 처리한다. */  
  mid				varchar(20) not null,		/* 댓글 올린이의 아이디 */
  nickName	varchar(20) not null,		/* 댓글 올린이의 닉네임 */
  wDate			datetime	default now(),/* 댓글 올린 날짜/시간 */
  hostIp		varchar(50) not null,		/* 댓글 올린 PC의 고유 IP */
  content		text not null,					/* 댓글 내용 */
  primary key(idx),
  foreign key(mid) references member2(mid)
);
desc boardReply2;

insert into boardReply2 values (default, 'knowhow', 1, 0, 1, 'atom', '아톰맨', default, '192.168.50.70','글을 참조 했습니다.');

select * from boardReply2;


/* 댓글수 연습 */
select * from board2 order by idx desc;
select * from boardReply2 order by boardIdx, idx desc;

-- 부모글(33)의 댓글만 출력
select * from boardReply2 where boardIdx = 33;
select boardIdx,count(*) as replyCnt from boardReply2 where boardIdx = 33;

select * from board2 where idx = 33;
select *,(select count(*) from boardReply2 where boardIdx = 33) as replyCnt from board2 where idx = 33;
select *,(select count(*) from boardReply2 where boardIdx = b.idx) as replyCnt from board2 b;



/*  view  /  index 파일 연습 */
select * from board2 where mid = 'admin';

create view adminView as select * from board2 where mid = 'admin';

select * from adminView;

show tables;

show full tables in javaclass where table_type like 'view';

drop view adminview;

desc board2;

create index nickNameIndex on board2(nickName);

show index from board2;

alter table board2 drop index nickNameIndex;

/* 게시판 관리 테이블 */
create table boardList (
	idx int not null auto_increment, 
	boardname varchar(20) not null unique, /* 게시판 이름, 중복불허 */
	tableName varchar(20) not null unique, /* 게시판 생성시 테이블명, 중복불허 */
	boardType varchar(20) not null, /* 게시판 타입 (일반게시판:board, 포토갤러리:gallery) */
	category varchar(50), /* 게시판 카테코기 사용안할시 null */
	cDate datetime default now(), /* 게시판 생성시간 */
	primary key(idx)
);