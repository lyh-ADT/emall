create database db_EMall DEFAULT CHARSET utf8 COLLATE utf8_general_ci;

use db_EMall;

-- 创建用户表
create table account(
	userId 		varchar(100) primary key,
	balance 	double default 0,
	password 	varchar(40) not null,
	cart		text,
	uuid		varchar(40),
	constraint chk_balance CHECK (balance >= 0)
);

-- 测试用数据
insert into account values('li', 1000, 'e10adc39-49ba59ab-be56e057-f20f883e'/*123456*/, null);
insert into account values('yu', 600, 'e10adc39-49ba59ab-be56e057-f20f883e'/*123456*/, null);