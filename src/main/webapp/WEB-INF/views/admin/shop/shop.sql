show tables;

/* 대분류(category1) */
create table category1(
  category1Code  char(1)  not null,		/* 대분류코드(A,B,C,...) => 영문 대문자 1자(중복불허) */
  category1Name  varchar(20) not null, /* 대분류명(생존필수템, 낭만템, 비상식량..) */
  primary key(category1Code),
  unique key(category1Name)
);

/* 중분류(category2) */
create table category2(
	category1Code  char(1)  not null,			/* 대분류코드를 외래키로 지정 */
  category2Code  char(2)  not null,		/* 중분류코드(01,02,03,...) => 문자형 숫자 2자(중복불허) */
  category2Name  varchar(20) not null, /* 중분류명(제품분류명 => 생존필수템: 도구, 생존키트...(중복불허) */
  primary key(category2Code),
  foreign key(category1Code) references category1(category1Code)
);

/* 소분류(category3) */
create table category3(
	category1Code  char(1)  not null,			/* 대분류코드를 외래키로 지정 */
  category2Code  char(2)  not null,		/* 중분류코드를 외래키로 지정 */
  category3Code  char(3)  not null,				/* 소분류코드(001,002,003,...) => 문자형 숫자 2자(중복불허) */
  category3Name  varchar(20) not null, 		/* 소분류명(상품구분 => 생존필수템: 생존키트 > 생존배낭, 재난키트..) */
  primary key(category3Code),
  foreign key(category1Code) references category1(category1Code),
  foreign key(category2Code) references category2(category2Code)
);

desc category3;

/* 세분류(상품 테이블) */
create table product (
  idx  int not null, 				/* 상품 고유번호 */
	category1Code  char(1)  not null,					/* 대분류코드를 외래키로 지정 */
  category2Code  char(2)  not null,					/* 중분류코드를 외래키로 지정 */
  category3Code  char(3)  not null,					/* 소분류코드를 외래키로 지정 */
  productCode   varchar(20) not null,				/* 상품고유코드(대분류코드+중분류코드+소분류코드+상품고유번호) 예 : A 01 002 5 */
  productName   varchar(50) not null,				/* 상품명(상품모델명) */
  detail				varchar(100) not null,			/* 상품의 간단설명(초기화면 메인창에 출력할 간단한 설명) */
  mainPrice     int not null,								/* 상품의 기본가격 */
  fSName				varchar(200) not null,			/* 상품의 기본사진(1장이상 처리시는 '/'로 구분한다.) */
  content				text not null,							/* 상품의 상세설명 - ckeditor를 이용 */
  primary key(idx),
  unique key(productCode,productName),
  foreign key(category1Code) references category1(category1Code),
  foreign key(category2Code) references category2(category2Code),
  foreign key(category3Code) references category3(category3Code)
);

/* 상품 옵션 */
create table productOption (
  idx    int not null auto_increment, /* 옵션 고유번호 */
  productIdx int not null,						/* product테이블(상품)의 고유번호 - 외래키로 지정 */
  optionName varchar(50) not null, 		/* 옵션 이름 */
  optionPrice int not null default 0, /* 옵션 가격 */
  primary key(idx),
  foreign key(productIdx) references product(idx)
);

desc dbOption;
select * from dbOption where productIdx = 1 order by optionName;


/* ================ 상품 주문 시작시에 사용하는 테이블들~ ==================== */

/* 장바구니 테이블 */
create table dbCart (
  idx   int not null auto_increment,			/* 장바구니 고유번호 */
  cartDate datetime default now(),				/* 장바구니에 상품을 담은 날짜 */
  mid   varchar(20) not null,							/* 장바구니를 사용한 사용자의 아이디 - 로그인한 회원 아이디이다. */
  productIdx  int not null,								/* 장바구니에 구입한 상품의 고유번호 */
  productName varchar(50) not null,				/* 장바구니에 담은 구입한 상품명 */
  mainPrice   int not null,								/* 메인상품의 기본 가격 */
  thumbImg		varchar(100) not null,			/* 서버에 저장된 상품의 메인 이미지 */
  optionIdx	  varchar(50)	 not null,			/* 옵션의 고유번호리스트(여러개가 될수 있기에 문자열 배열로 처리한다.) */
  optionName  varchar(100) not null,			/* 옵션명 리스트(배열처리) */
  optionPrice varchar(100) not null,			/* 옵션가격 리스트(배열처리) */
  optionNum		varchar(50)  not null,			/* 옵션수량 리스트(배열처리) */
  totalPrice  int not null,								/* 구매한 모든 항목(상품과 옵션포함)에 따른 총 가격 */
  primary key(idx,mid),
  /* unique key(mid), */
  foreign key(productIdx) references product(idx) on update cascade on delete restrict
  /* foreign key(mid) references member2(mid) on update cascade on delete cascade */
);
drop table dbCart;
desc dbCart;
delete from dbCart;
select * from dbCart;

/* 주문 테이블 */
create table dbOrder (
  idx   int not null auto_increment,			/* 고유번호 */
  orderIdx   varchar(15) not null,				/* 주문 고유번호(새로 만들어준다.) */
  mid   varchar(20) not null,							/* 주문자 아이디 - 로그인한 회원 아이디이다. */
  productIdx  int not null,								/* 주문한 상품의 고유번호 */
  orderDate   datetime default now(),			/* 실제 주문을 한 날짜 */
  productName varchar(50) not null,				/* 상품명 */
  mainPrice   int not null,								/* 메인상품의 기본 가격 */
  thumbImg		varchar(100) not null,			/* 서버에 저장된 상품의 메인 이미지 */
  optionName  varchar(100) not null,			/* 옵션명 리스트(배열처리) */
  optionPrice varchar(100) not null,			/* 옵션가격 리스트(배열처리) */
  optionNum		varchar(50)  not null,			/* 옵션수량 리스트(배열처리) */
  totalPrice  int not null,								/* 구매한 모든 항목(상품과 옵션포함)에 따른 총 가격 */
  primary key(idx,orderIdx),
  foreign key(mid) references member2(mid),
  foreign key(productIdx) references product(idx) on update cascade on delete restrict
);
desc dbOrder;
select * from dbOrder;
drop table dbOrder;

/* 배송테이블 */
create table dbBaesong (
  idx     int not null auto_increment,
  oIdx    int not null,								/* 주문테이블의 고유번호를 외래키로 지정함 */
  orderIdx    varchar(15) not null,   /* 주문 고유번호 */
  orderTotalPrice int     not null,   /* 주문한 모든 상품의 총 가격 */
  mid         varchar(20) not null,   /* 회원 아이디 */
  name				varchar(20) not null,   /* 배송지 받는사람 이름 */
  address     varchar(100) not null,  /* 배송지 (우편번호)주소 */
  tel					varchar(15),						/* 받는사람 전화번호 */
  message     varchar(100),						/* 배송시 요청사항 */
  payment			varchar(10)  not null,	/* 결재도구 */
  payMethod   varchar(50)  not null,  /* 결재도구에 따른 방법(카드번호) */
  orderStatus varchar(10)  not null default '결제완료', /* 주문순서(결제완료->배송중->배송완료->구매완료) */
  primary key(idx)
  /* foreign key(oIdx) references dbOrder(idx) on update cascade on delete cascade */
);
desc dbBaesong;
drop table dbBaesong;