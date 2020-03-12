create database db_EMall DEFAULT CHARSET utf8 COLLATE utf8_general_ci;

use db_EMall;

-- �����û���
create table account(
	userId 		varchar(100) primary key,
	balance 	double default 0,
	password 	varchar(40) not null,
	uuid		varchar(40),
	constraint chk_balance CHECK (balance >= 0)
);

-- ������Ʒ��
create table goods(
	goodId 		varchar(100) primary key,
	userId 		varchar(100) not null,
	price 		double not null,
	number 		int default 0,
	goodName 	varchar(100) not null,
	description	text,
	imgs		text,
	constraint chk_price CHECK (price >= 0),
	constraint chk_number CHECK (number >= 0),
	FOREIGN KEY fk_userId(userId)REFERENCES account(userId)
);

-- �������ﳵ��
create table carts(
	userId varchar(100),
	goodId varchar(100),
	number int default 0,
	primary key(userId, goodId),
	constraint chk_carts_number CHECK (number >= 0),
	FOREIGN KEY fk_carts_userId(userId)REFERENCES account(userId)
);

-- ����������
create table orders(
	orderId		varchar(100) primary key,
	buyerId 	varchar(100) not null,
	sellerId	varchar(100) not null,
	goodId_list	text not null,
	status		varchar(100) default 'paid',
	address		text not null,
	totalPrice	double default 0,
	constraint chk_orders_status CHECK (status in ('paid', 'send', 'finished', 'canceled')),
	FOREIGN KEY fk_orders_buyerId(buyerId)REFERENCES account(userId),
	FOREIGN KEY fk_orders_sellerId(sellerId)REFERENCES account(userId)
);

-- �������û�����
insert into account values('li', 1000, 'e10adc39-49ba59ab-be56e057-f20f883e'/*123456*/, null);
insert into account values('yu', 600, 'e10adc39-49ba59ab-be56e057-f20f883e'/*123456*/, null);

-- ��������Ʒ���� 80��
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('e0a03826-090a-45f9-bac0-10b608978b07', 'li', '34.1', '589', '����ԭ�� �������� �Ĵ����޿�Ѫ�� ����ˮ�� ����2.5��װ ����70-80mm 2���Ϸ�1��5��װ ż�������� ���潡', '����ԭ�� �������� �Ĵ����޿�Ѫ�� ����ˮ�� ����2.5��װ ����70-80mm 2���Ϸ�1��5��װ ż�������� ���潡', '39e13795-8da6-4b8b-b796-e7607c7ea012.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('5d8312a4-709a-4767-b189-1d7a9882e206', 'li', '87.8', '834', '���츮���ʡ����໨ţƻ�� ����ƻ�� 75#-80#����2.5�� �������� ����ˮ��', '���츮���ʡ����໨ţƻ�� ����ƻ�� 75#-80#����2.5�� �������� ����ˮ��', '21088ce7-1877-4697-a0d7-e99ecfa14254.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('71a13786-5628-4cb0-9c09-48da48829234', 'li', '82.6', '853', '����ԭζ��ɽʯ�����ص���̨ʽ�⳦�ȹ��㳦�տ���Ƥ��3������', '����ԭζ��ɽʯ�����ص���̨ʽ�⳦�ȹ��㳦�տ���Ƥ��3������', '73ebfd80-a045-49fb-abb8-5ec24f081fc8.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('d8a1dc57-cf4e-4b67-973d-5bbbaf096af7', 'li', '96.8', '569', '��������ţ��Ƭ��ţƬѩ���տ��������ţ��������ţԭ��130��*5��', '��������ţ��Ƭ��ţƬѩ���տ��������ţ��������ţԭ��130��*5��', 'd48608ca-674d-4ac7-98a4-ec809cdb42e3.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('d8a185f5-6ed5-456b-8aaf-088bec6505d1', 'li', '29.0', '683', '��ϣ�� �ҼҰ���Ϻ��500g*1�� ��ű�����Ϻ�����Ϻ�� ���ʷ·�ճ�ˮ ���ʽ�ʵ ��� ����Ϻ�� �ϸ߰�����', '��ϣ�� �ҼҰ���Ϻ��500g*1�� ��ű�����Ϻ�����Ϻ�� ���ʷ·�ճ�ˮ ���ʽ�ʵ ��� ����Ϻ�� �ϸ߰�����', '092e99c2-290e-4f4a-b99c-21bb4006e407.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('ad5e3ad7-55f2-4e08-9b29-c00104ce6017', 'li', '88.4', '429', '��Ԥ�� ��Ʒ���ʻ� Խ�Ϻڻ�Ϻë��Լ900g �䶳����Ϻ���ں���ˮ��Լ20-25ֻװ����700g���ʴ�Ϻ', '��Ԥ�� ��Ʒ���ʻ� Խ�Ϻڻ�Ϻë��Լ900g �䶳����Ϻ���ں���ˮ��Լ20-25ֻװ����700g���ʴ�Ϻ', 'cde75ae3-0f98-4832-89ba-919e3ac6f98f.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('243eb41b-421b-4c6e-9880-3d67b015e302', 'li', '2.3', '299', '��ʰζ ��ζ��ץ��̨���ζ��ץ����� ������ ��ץ��Ƥ10Ƭװ*2 ��ζ', '��ʰζ ��ζ��ץ��̨���ζ��ץ����� ������ ��ץ��Ƥ10Ƭװ*2 ��ζ', 'd55c1837-b4c0-438c-a482-b15fff9fce72.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('4c9d469b-ffd6-4ea4-ad48-5e8e949e83d6', 'li', '74.9', '948', '��4��װ����ʰζ�ִ���ţ����ţ������ʳ�� �̻������ �տ��贮', '��4��װ����ʰζ�ִ���ţ����ţ������ʳ�� �̻������ �տ��贮', 'f82ae81b-2803-430d-85a9-72c593dd9a1c.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('f2496318-b5e8-4eb2-9eeb-5cfb3c6271b5', 'li', '16.3', '351', '�����ݻ�Ƥ����168g�����ʳ������ĵ�����ʳ��������С��װ', '�����ݻ�Ƥ����168g�����ʳ������ĵ�����ʳ��������С��װ', '46c5d8b3-89c9-4102-af30-e8d2ebd8bbf2.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('b15a16ed-d9d4-401d-bccb-c000cca1215a', 'li', '49.5', '988', '����ֻ����_���⸬��ȻƬ150g��������ʳС�Ծ�����ζ��ʳ�����', '����ֻ����_���⸬��ȻƬ150g��������ʳС�Ծ�����ζ��ʳ�����', 'dcce34bb-dc4a-4fcc-9d0c-dd2a214dc6df.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('0380d467-cb1b-410d-adce-7498162bd6b2', 'li', '47.9', '880', '����ֻ����_���Ĺ�100g��������ʳÿ�ռ���ز������ɹ��и���Ư��', '����ֻ����_���Ĺ�100g��������ʳÿ�ռ���ز������ɹ��и���Ư��', '8170700f-210c-4110-b5cb-0d7144cd5f96.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('1072a681-eb89-4cde-809b-ab549356e124', 'li', '72.3', '681', '���ٲ�ζ-â����120gx3���������۽�ˮ������â��Ƭ ������ʳ', '���ٲ�ζ-â����120gx3���������۽�ˮ������â��Ƭ ������ʳ', '89c9712a-2133-4472-a267-c230360d3e61.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('ca4e3742-d83d-4989-a57c-5ea703c28653', 'li', '8.1', '815', '����Ʒ���ӡ�ԭζ�ִౡ��300g*1�� ������ʳ��ζ������ʳ���ɸ���װ', '����Ʒ���ӡ�ԭζ�ִౡ��300g*1�� ������ʳ��ζ������ʳ���ɸ���װ', '66fb38c9-a4db-4455-9d7d-104dcabf9400.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('14b72529-84d4-4fc1-a2ed-29dc244b4cf1', 'li', '8.5', '761', '�����ָ���������˹��������������ϣ�ʲ��ˮ��ζ��12g', '�����ָ���������˹��������������ϣ�ʲ��ˮ��ζ��12g', '5a9f42d9-398a-4610-9cb0-3c45374bf5d6.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('87120f56-d9e7-449f-a9c8-277277fcf131', 'li', '25.9', '886', '����˹����KDV������500g��ӹ��������ǹ���ʳ���ϲ��', '����˹����KDV������500g��ӹ��������ǹ���ʳ���ϲ��', 'cfc28dfa-e1fe-44b2-bb7b-a8632fce967f.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('e20635cf-a1e0-41e5-bf48-3c911c21b039', 'li', '58.5', '271', '����԰ ���� ����ζ �����ز�Ӫ��ʳƷ������͸��600g ����칫����С����ʳ���', '����԰ ���� ����ζ �����ز�Ӫ��ʳƷ������͸��600g ����칫����С����ʳ���', 'f358f7fd-abf7-494c-a50c-8a5adb9dff93.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('dcefd680-b202-44ac-88f5-2ad85a4ae654', 'li', '23.6', '585', '����ę́ ���� 51��500ml ��ƿװ �����Ͱ׾ƣ����ϰ�װ���������', '����ę́ ���� 51��500ml ��ƿװ �����Ͱ׾ƣ����ϰ�װ���������', '5bf48940-5ba2-4b7f-a7d1-67f925852b89.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('4c70a63a-1acc-469c-877f-1c6732aac30e', 'li', '93.3', '545', '��Խ��ɽ ���˻ƾ� �����Ŵ�׾� ������ �崼���� 500ml*6ƿ ����װ �����Ʒ', '��Խ��ɽ ���˻ƾ� �����Ŵ�׾� ������ �崼���� 500ml*6ƿ ����װ �����Ʒ', '988b8828-d87f-46fc-8874-222fc9a4fff2.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('bf920d06-8245-4322-a7ea-f146562a243a', 'li', '98.4', '69', '��ģ�RIO����� ��β�� Ԥ���� ΢��ϵ����� 330ml*8�ޣ�΢��4�ֿ�ζ*2��', '��ģ�RIO����� ��β�� Ԥ���� ΢��ϵ����� 330ml*8�ޣ�΢��4�ֿ�ζ*2��', 'fbff2ba8-f4b4-4b6a-bd22-9c159fb057e7.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('74984f54-b714-4263-9fc4-0e98147fb227', 'li', '85.7', '785', '�����55����ƿ��װ �����Ͱ׾� ����500ml*6��', '�����55����ƿ��װ �����Ͱ׾� ����500ml*6��', 'b705c357-a647-4d5c-88ee-357e4a9cd961.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('83eab332-8c89-41e1-aae0-6a8cd9d49bec', 'li', '73.0', '255', '���(YangHe) ��ɫ���� ��֮��42�� ��ƿ��װ�׾� 480ml �ڸ�����Ũ���ͣ����ϰ�װ���������', '���(YangHe) ��ɫ���� ��֮��42�� ��ƿ��װ�׾� 480ml �ڸ�����Ũ���ͣ����ϰ�װ���������', 'cd281b50-8f40-444d-b587-0b0e7fbe9843.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('e3e34cdd-c6ab-4de4-a07c-5dbaad45921b', 'li', '44.1', '470', '����ϰ�� ��ϰ��1952 53�� 500m*6 ����װ �����Ͱ׾� �����ϰ�װ���������', '����ϰ�� ��ϰ��1952 53�� 500m*6 ����װ �����Ͱ׾� �����ϰ�װ���������', '7f15a945-82ab-4e2d-a055-067e4c641a42.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('c9839fc1-d695-4f9a-b8ee-95fae41ad6e2', 'li', '92.2', '539', '���ϴ� ˮ���� 52�� 500ml Ũ���� �׾� ��ƿװ', '���ϴ� ˮ���� 52�� 500ml Ũ���� �׾� ��ƿװ', 'b237bc3c-73c9-4915-bc48-4f2bef48435c.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('397647e2-c07f-4ec4-8f6c-5c4f5bf8de1f', 'li', '52.7', '436', '����ԭװ���ں�� ��ŵ��ɫ�ǿոɺ����Ѿ�750ml*6 ����װ', '����ԭװ���ں�� ��ŵ��ɫ�ǿոɺ����Ѿ�750ml*6 ����װ', 'b0d27e43-ab18-4940-8c27-f17e55fdd7c7.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('725528e6-69fd-403b-8a8b-c6fb1ea565ff', 'li', '55.5', '603', 'Arla���ϳ��� ȫ֬��ţ��1L*12������ �¹�����', 'Arla���ϳ��� ȫ֬��ţ��1L*12������ �¹�����', '47a04335-e91b-4413-9536-2120bd6d97ce.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('4607e7f1-ab59-4dba-9779-3a419511a484', 'li', '26.9', '298', '���ˣ�Devondale��ȫ֬��ţ��1L*10������ ���޽���', '���ˣ�Devondale��ȫ֬��ţ��1L*10������ ���޽���', '2acd49bb-68a3-4c20-a481-a5db9912fcb3.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('25b4b584-d5c1-4c2b-863a-e4723325a32f', 'li', '56.4', '671', '����������ThelandŦ����3.5g�����ʸ߸�ȫ֬��ţ�̣���ͥװ��250ml*24��', '����������ThelandŦ����3.5g�����ʸ߸�ȫ֬��ţ�̣���ͥװ��250ml*24��', '02124913-5609-42e8-8b9d-f01ecf31bf50.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('2fc9b71d-1f3d-4b18-93b5-ae4470fc5e12', 'li', '5.1', '973', '��12+4�С� ���� ��Ľϣϣ����ζ��ţ��ԭζ205g*16��', '��12+4�С� ���� ��Ľϣϣ����ζ��ţ��ԭζ205g*16��', 'c5a735b1-6acd-4e28-b65a-13758d7bc49f.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('bdaa3268-43cf-468a-be6f-93712664e3e1', 'li', '83.9', '67', '������䴿ţ�����װ250ml*12', '������䴿ţ�����װ250ml*12', 'cc113c16-22c3-4d28-a193-f2202dac3a7b.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('642635bd-4a59-4287-a437-5e85a905f483', 'li', '80.7', '819', '���ѣ�Anchor��ȫ֬��ţ��250ml*24������ ���������� ţ��', '���ѣ�Anchor��ȫ֬��ţ��250ml*24������ ���������� ţ��', 'd301113a-9104-45c1-a5b7-4c4cebb1d93f.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('018d9bc9-cb60-4a4d-9d2c-62189fcb81dc', 'li', '13.4', '784', '������Ľϣ������ţ�����װ205g*12 ����', '������Ľϣ������ţ�����װ205g*12 ����', '571d1137-c098-45b7-b31e-6bffd4358ecf.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('34efc4cc-05fa-429a-a877-3e7bdaaada09', 'li', '32.8', '891', '��ƽ��ȫ֬ţ��1L*12 ��ϲϵ�� �¹�ԭװ���� ���� ����ȫ֬��ţ��', '��ƽ��ȫ֬ţ��1L*12 ��ϲϵ�� �¹�ԭװ���� ���� ����ȫ֬��ţ��', '86424644-7a11-42b1-af39-2ec2cf6b99eb.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('f8df9f3a-fe69-48b1-b396-8c741a039ab2', 'li', '52.3', '300', '��֮������֥��ڶ���250g*2��װ ����������ͷ� ��������', '��֮������֥��ڶ���250g*2��װ ����������ͷ� ��������', '63f0ccd0-50f2-4305-b3ab-5793daaf4be2.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('16ea931c-2bdb-4d88-8b02-f330d0d59e56', 'li', '90.3', '947', '���Quaker����͹��� ��ʳ��ά ��ʳ����Ƭ ��װ1478g�����ϰ�װ���淢����', '���Quaker����͹��� ��ʳ��ά ��ʳ����Ƭ ��װ1478g�����ϰ�װ���淢����', '2f91d931-edb0-4379-8001-8eed0a936f3c.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('f562b7bc-123e-4eed-aa94-6cb77cfe08a7', 'li', '99.8', '381', '�����ʡ��մ�ˮ����Ƭ�����������մ�ˮ����ζ��ľ�Ǵ�������24Ƭ', '�����ʡ��մ�ˮ����Ƭ�����������մ�ˮ����ζ��ľ�Ǵ�������24Ƭ', '61a2ba98-e3cd-4055-a617-c3af0daf9991.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('0921d51a-3a02-465c-b5fe-baae045ab43a', 'li', '74.3', '812', 'ũ��ɽȪ��Ȼ����ˮ5L*4 ����װ', 'ũ��ɽȪ��Ȼ����ˮ5L*4 ����װ', '0f6b54e7-6102-4004-82c8-b21ec5e7c33b.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('368a99b3-39f1-4f1d-be5e-35a7de61feb9', 'li', '81.2', '744', '����ؾ����� ��Ȼ��Ȫˮ350ml*20ƿ/�� ����������ˮ�Ǵ���ˮ����װ', '����ؾ����� ��Ȼ��Ȫˮ350ml*20ƿ/�� ����������ˮ�Ǵ���ˮ����װ', 'beff5858-d701-4c58-9c6e-4a97d7cd47af.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('1c9fbda7-4786-42a6-a6c3-0cf3b8930719', 'li', '25.0', '590', '�����ϣ�Watsons����ζ�մ���ˮ330mlX4��', '�����ϣ�Watsons����ζ�մ���ˮ330mlX4��', '37bf7129-15af-45ca-9d43-f8a1de5b598e.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('86b5b661-09cd-4e61-ba72-45d5e927d735', 'li', '66.1', '499', 'ά����Vita�� ���ʲ�250ml*6ƿ', 'ά����Vita�� ���ʲ�250ml*6ƿ', '10c6a76c-bda3-47fe-abcf-f1bf2706d69b.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('d9ed76af-1aeb-4506-800e-8e61eb710d3b', 'li', '75.1', '24', '��ȿɿڿ���300ml*12ƿ', '��ȿɿڿ���300ml*12ƿ', '09aca40c-4d65-4732-88e2-0dad18f88ccf.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('758b7d37-99bf-47be-947e-c2f906494cd7', 'li', '13.4', '504', '������ ��ѡ��������5kg', '������ ��ѡ��������5kg', 'dd5edfcf-e86e-4181-a830-39fbf256642b.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('a92bd10d-6e54-4111-836b-287202b5a08a', 'li', '78.8', '625', '������Ʒ������ѿ��1.8L ��ת����ѹե���� ������ ʳ����', '������Ʒ������ѿ��1.8L ��ת����ѹե���� ������ ʳ����', '6708cdf0-dac5-4bd1-85b3-ee9e832c1641.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('86ee4ae5-7b20-4fc0-b202-3ddbb29cc91a', 'li', '59.3', '174', '�����㱱������С�10kg ��װ���� �������ִ��� ��˾���� ��Ӫ', '�����㱱������С�10kg ��װ���� �������ִ��� ��˾���� ��Ӫ', 'de6935ac-5432-4edc-9460-13d832de6c45.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('65961329-4870-472a-8456-b6a8dc134610', 'li', '36.2', '954', '��2019�������С�ʮ�µ��ﵾ������� 5kg�������׶�����������', '��2019�������С�ʮ�µ��ﵾ������� 5kg�������׶�����������', '555477ab-4e6a-4a13-9676-4a8e79e34222.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('9afb569d-74a7-4294-b3e1-017581f3dced', 'li', '64.7', '712', '������� ��һС���2.5kg ������� ����;С��� ���ӷ�', '������� ��һС���2.5kg ������� ����;С��� ���ӷ�', '7ba2bf6e-f6f7-4565-b1f1-cb6e27a9e40d.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('9465a9d9-dd1c-4590-a2fe-5cb22fe89202', 'li', '39.7', '849', '���������ʢ����shenger�� �����ɻ����װ580g ���� ��ľ����ɽ��ϲ������ �������ز�', '���������ʢ����shenger�� �����ɻ����װ580g ���� ��ľ����ɽ��ϲ������ �������ز�', 'a72eb404-c18a-44a7-8fac-0113026aa492.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('09f8f590-5928-47fc-9a6f-65bba1026cd8', 'li', '71.6', '758', 'ѩ����Ȼ��ľ��500g�����ز���ľ���������', 'ѩ����Ȼ��ľ��500g�����ز���ľ���������', '5881f8c0-1114-4940-aee9-503318d77681.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('7a787437-2467-45c5-8b29-3df181fc3ac4', 'li', '68.4', '101', '�񻪺��� �����й�250g �ϱ��ɻ� �㹽 Ģ�� ɽ����� �������ʳ��', '�񻪺��� �����й�250g �ϱ��ɻ� �㹽 Ģ�� ɽ����� �������ʳ��', '3e731117-79c1-49d9-82e7-f8022916edd0.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('5f45aff1-59ed-4183-9b12-e8168a75b0f5', 'li', '28.0', '891', '��ȸ��(PECHOIN)Сȸ�Ҿ���ˮ��ʪ��Ĥ25ml*10Ƭ����ˮ��ʪ ͨ�� ���� ���ַ��� ��Ĥ����', '��ȸ��(PECHOIN)Сȸ�Ҿ���ˮ��ʪ��Ĥ25ml*10Ƭ����ˮ��ʪ ͨ�� ���� ���ַ��� ��Ĥ����', '26686fa7-496f-4b36-9e68-1952cb6afa01.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('6a1da6c7-b6cb-46dd-854a-946c34faae5b', 'li', '74.4', '571', '����JM solution��˾��Ө��佺��Ĥ������棩 30ml*10Ƭ', '����JM solution��˾��Ө��佺��Ĥ������棩 30ml*10Ƭ', '5067078e-8ee0-4883-8086-79c5174b7ae8.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('9c560bf6-e1ae-44df-8d4a-ef928dd9a6e6', 'li', '6.3', '262', '��ȸ��(PECHOIN)ˮ�۱���������װ (����95g+ˮ100ml+��100ml��ͨ�� ������װ ��ʪ��ˮ ��������', '��ȸ��(PECHOIN)ˮ�۱���������װ (����95g+ˮ100ml+��100ml��ͨ�� ������װ ��ʪ��ˮ ��������', '76e7c14b-3ed2-4fb9-9f06-c9810b083da8.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('3e29b971-f70f-48ea-954c-80520bcd69c8', 'li', '56.1', '331', '��Whoo������ˮ�Vϵ�л�ױƷ�������(309ml+2g)6���׸��Ƹ���״̬;��������;����ƽ��;', '��Whoo������ˮ�Vϵ�л�ױƷ�������(309ml+2g)6���׸��Ƹ���״̬;��������;����ƽ��;', '661c5f17-ec5c-44d2-8f9a-163d51328a47.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('a72a30b1-8ca7-4ba9-9f3f-cf97fb9d4c3c', 'li', '17.0', '108', '��Ȼ�ã�CHANDO��ѩ��ˮ����װ �沿����Ʒ��ױƷ��Ʒ�콢�� ����ʪ��ˮ��װ Ů', '��Ȼ�ã�CHANDO��ѩ��ˮ����װ �沿����Ʒ��ױƷ��Ʒ�콢�� ����ʪ��ˮ��װ Ů', 'db0b3734-9c5e-40ec-941a-4901363a9b82.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('2884dd9e-43b1-425d-94ea-1ca768d31cc3', 'li', '44.9', '392', 'ܽ����˿(Freeplus)����ϴ��˪ 100g ������ϵϴ���� �ձ������� ��ˮ��ʪ ������ ��Ůͨ��', 'ܽ����˿(Freeplus)����ϴ��˪ 100g ������ϵϴ���� �ձ������� ��ˮ��ʪ ������ ��Ůͨ��', '48c6feeb-73bf-40db-a329-ce326bfdf9f4.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('e00c6377-117e-48f6-b54d-36fd57f24103', 'li', '61.8', '502', '�������飨gNPearl��������� 5g*20��(΢�׼�) ��ˮ��ʪ��ߵ���ӡȥ������Ĥ����Ůʿ��ױƷ������ɫ', '�������飨gNPearl��������� 5g*20��(΢�׼�) ��ˮ��ʪ��ߵ���ӡȥ������Ĥ����Ůʿ��ױƷ������ɫ', '25d21edb-4736-4188-941b-7ab7181587e9.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('00e9cff4-5124-411d-8de6-8653ca831f59', 'li', '41.6', '690', '��ȸ��(PECHOIN)ˮ�۱��ֱ�ʪ������Һ100ml����ʪ��ˮ ����Ӫ�� ���� ͨ�� ���ַ��ʣ�', '��ȸ��(PECHOIN)ˮ�۱��ֱ�ʪ������Һ100ml����ʪ��ˮ ����Ӫ�� ���� ͨ�� ���ַ��ʣ�', 'e9ba8eb5-5955-4279-a391-eea2fe0fd780.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('f74ce49a-b625-412e-8408-ad9bfe147c46', 'li', '95.6', '806', '�߶ȿռ䣨SPACE7����Ůϵ�� ���� 338mm����ҹ�� ���װ 12Ƭ �����������', '�߶ȿռ䣨SPACE7����Ůϵ�� ���� 338mm����ҹ�� ���װ 12Ƭ �����������', '64b1586b-3b1f-4b57-92bd-9ba7bdc9e97a.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('6d3a0e69-413f-4435-93db-33da5caa3531', 'li', '56.1', '611', '�߶ȿռ�(SPACE 7)����ϵ�� ���� ˿�� 245mm����32Ƭ����������� ���װ', '�߶ȿռ�(SPACE 7)����ϵ�� ���� ˿�� 245mm����32Ƭ����������� ���װ', '21b54107-392c-4b5f-be0b-144b74e33377.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('6ce548e0-62bb-4a55-9c79-998dbf460ce2', 'li', '16.5', '401', '���ˣ�DARLIE��˫�ر�������225g*3������������Ʒ��', '���ˣ�DARLIE��˫�ر�������225g*3������������Ʒ��', '5c858fa6-ac2a-444e-a20d-428aeba62281.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('0f3e57ff-a360-4156-9059-171d2cf838d9', 'li', '69.3', '740', '�����1.5��������ԡ¶', '�����1.5��������ԡ¶', '2239130e-b328-4f05-a7a6-00bf0af76930.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('ddc0dd27-f1e1-4c5b-8542-100028dfcb01', 'li', '99.2', '39', '��ʿ�֣�VASELINE�������޻�����50g ����Ӫ��������������', '��ʿ�֣�VASELINE�������޻�����50g ����Ӫ��������������', 'c400c8d3-6ad3-4c29-818f-5754d3ef0e9a.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('4049bf59-fb83-4c63-abb8-46f52c5c0931', 'li', '59.7', '399', 'ABC������ ����+ҹ�����Ů����װ�˱�����ϵ�����װ9��62Ƭ����� ����', 'ABC������ ����+ҹ�����Ů����װ�˱�����ϵ�����װ9��62Ƭ����� ����', 'b105771a-5aa2-44f3-843b-7359e8944854.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('af225b23-4dca-43f5-9344-e4041a1672e6', 'li', '47.3', '501', 'ŷ����(LOREAL)����󷢾��ͣ���������ʣ�100ml�������㷢��', 'ŷ����(LOREAL)����󷢾��ͣ���������ʣ�100ml�������㷢��', '4968dc00-acb1-48b5-9a8a-e8671da553b9.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('716a9d28-1132-4fdb-90f5-080d9dc2e099', 'li', '89.7', '633', '����˿ϴ��ˮ��ˬȥ��750ml ȥмϴ��ˮ¶ϴͷ�� �־�ȥмֹ����ˬ���� ������ ��ʿŮʿͨ��', '����˿ϴ��ˮ��ˬȥ��750ml ȥмϴ��ˮ¶ϴͷ�� �־�ȥмֹ����ˬ���� ������ ��ʿŮʿͨ��', '86fa53c4-bbfc-46dd-8689-3f531907c4fb.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('3b4fbaeb-fd31-4e2c-969c-e286baf84ea6', 'li', '25.2', '504', 'ά�Vinda�� ��ֽ �������Ƴ�������132��*18��ֽ�� С����������ۣ��¾ɰ�װ���淢����', 'ά�Vinda�� ��ֽ �������Ƴ�������132��*18��ֽ�� С����������ۣ��¾ɰ�װ���淢����', '8860fbb6-a621-4f44-a169-a9174585dcd2.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('5da4dfa1-e6fa-4ed7-9967-74146a434b98', 'li', '71.8', '854', '��� ��ֽ ���̻�����200��*20��С���(�̷�)��ȡʽ����ֽ��ͽ�ֽ����ֽ���ֽ��ͥװ���������ۣ�', '��� ��ֽ ���̻�����200��*20��С���(�̷�)��ȡʽ����ֽ��ͽ�ֽ����ֽ���ֽ��ͥװ���������ۣ�', '00f41d9a-a633-4310-897a-f8d3e9491fe6.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('d344afed-5264-427c-9948-ac8cf3a01145', 'li', '8.5', '112', '̭��ȫЧ360��ϴ��Һ���Űٺ�����ϴ��Һ3kgx2 ����ٷ���Ʒ', '̭��ȫЧ360��ϴ��Һ���Űٺ�����ϴ��Һ3kgx2 ����ٷ���Ʒ', 'aa90a126-0839-4d12-a2f0-ca93d16dbaa6.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('83b46d4a-e2b5-430b-8953-0a6c6ba5b4bd', 'li', '41.6', '351', '���� ޹�²�ϴ��Һ 4.26kg ��ϴ������ɫ��˳������¶ʿ��Ʒ', '���� ޹�²�ϴ��Һ 4.26kg ��ϴ������ɫ��˳������¶ʿ��Ʒ', '505f5457-0051-42ef-9734-6471cee65a03.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('f2d998df-c177-493b-a357-69698c8904c3', 'li', '32.8', '151', '��� ��ֽ ԭľ��Ʒ����150��*20��С���(�̷�)��ȡʽֽ���������ۣ�', '��� ��ֽ ԭľ��Ʒ����150��*20��С���(�̷�)��ȡʽֽ���������ۣ�', '44dacdfc-0274-497d-863c-093a2489fedc.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('f8fd29fc-0460-4e75-9671-8d1d9d8a42a4', 'li', '75.1', '836', '��16��+���������(OMO) ��������ϴ��Һ 3kg*2+1kg*2+����ϴ����Ʒ���������������', '��16��+���������(OMO) ��������ϴ��Һ 3kg*2+1kg*2+����ϴ����Ʒ���������������', 'df136749-ddd9-4716-92fc-e6abc1e698b5.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('fd3e465c-7121-41f1-8ea4-32277a582042', 'li', '67.2', '647', '��� ��ֽ ���̻�����200��*20��С���(�̷�)��ȡʽֽ���������ۣ�', '��� ��ֽ ���̻�����200��*20��С���(�̷�)��ȡʽֽ���������ۣ�', 'd6b5debe-3e97-415f-a3da-bd637bdfe3c0.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('b1b3b5d7-f780-4b2d-a011-d1a6b8a1021e', 'li', '69.1', '137', '��� ����ֽ �й������Ȱ�ϵ�� 4��7��12�� ������', '��� ����ֽ �й������Ȱ�ϵ�� 4��7��12�� ������', '7d4904ab-3f48-489e-b2ee-a62d8bb7c920.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('ccd1f698-557c-41ee-a9fd-16f766fab6b7', 'li', '84.9', '588', '��������(BY-HEALTH) ���׷� 450��+150*2�� ��750�� ��ǿ������ ����ƷӪ��Ʒ', '��������(BY-HEALTH) ���׷� 450��+150*2�� ��750�� ��ǿ������ ����ƷӪ��Ʒ', '60ec25bb-ebb0-4fba-a619-bdadc2a2a85a.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('3c4903c2-2c29-4b04-b2c3-6c7efe14bdf7', 'li', '78.6', '600', 'ŷķ��(OMRON)����Ѫѹ�� U10K �ϱ�ʽ�������ܼ�ѹȫ�Զ�����Ѫѹ�� ��Ѫѹ����', 'ŷķ��(OMRON)����Ѫѹ�� U10K �ϱ�ʽ�������ܼ�ѹȫ�Զ�����Ѫѹ�� ��Ѫѹ����', '1f6c28d4-3b93-4145-b7f2-c8ca0b958243.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('c2f1dac4-55d4-4855-9db5-35d3fff3964d', 'li', '32.6', '477', '��Ծ��yuwell������Ѫѹ�� YE660D����Ѫѹ�� �����ϱ�ʽ�߾�׼ȫ�Զ��������˲���Ѫѹ����', '��Ծ��yuwell������Ѫѹ�� YE660D����Ѫѹ�� �����ϱ�ʽ�߾�׼ȫ�Զ��������˲���Ѫѹ����', 'aa1d7954-290e-462f-b630-5941ad5be666.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('47c8e93d-ad00-4f15-9220-c347e46b50ba', 'li', '67.0', '588', '�῭԰ʵҵ �����ز�����������Ӳ� �ؼ�500g��װ ����ͷ����ϴ���� ������Ӫ����', '�῭԰ʵҵ �����ز�����������Ӳ� �ؼ�500g��װ ����ͷ����ϴ���� ������Ӫ����', '9571bd83-5d85-4907-847e-ea5579589551.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('30957d7c-4d34-4c2a-a23a-91e482cb5d79', 'li', '61.6', '951', 'ŷķ��(OMRON)�������¼� MC-347 Ӥ����������ȫ�Ҳ��� ��ͯ����ֱ��ʽ�¶ȼ�', 'ŷķ��(OMRON)�������¼� MC-347 Ӥ����������ȫ�Ҳ��� ��ͯ����ֱ��ʽ�¶ȼ�', 'ebba0fd7-76fb-4c9c-a37b-75283a2ab5e7.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('34ae0eb8-f978-4ce2-805f-5c6b6ece5f8b', 'li', '49.6', '410', '��Դ�� ��ѡƷ�ʶ����Ĳ� 4��/g 5g���װ �ຣ�����ߺ���Ұ�����', '��Դ�� ��ѡƷ�ʶ����Ĳ� 4��/g 5g���װ �ຣ�����ߺ���Ұ�����', 'e99149c1-360d-441b-b5b3-7fe9951e1852.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('d428d149-77f8-4809-b46f-a3b31844492b', 'li', '6.4', '455', '���к�� �������Ӫ��Ʒ �����ϡ Ӫ���׺�(15��)15��װ 450g �����ϡ ������Ƭ Ӫ����ϡ �ﹽ �����ϡ', '���к�� �������Ӫ��Ʒ �����ϡ Ӫ���׺�(15��)15��װ 450g �����ϡ ������Ƭ Ӫ����ϡ �ﹽ �����ϡ', '74436b5a-dbb2-4098-b0ba-0925331412c4.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('24516a9e-bf48-4d93-ae34-6f644b3be81a', 'li', '44.7', '384', '�������� Ѫ���ڷ�Һ 76ml*8ƿ���װ ������Ʒ ������� Ӫ���̲�', '�������� Ѫ���ڷ�Һ 76ml*8ƿ���װ ������Ʒ ������� Ӫ���̲�', '09a4da59-e943-4d52-bcfe-8911b5ff6471.jpg');

-- �����ù��ﳵ����
insert into carts values('li', 'a72a30b1-8ca7-4ba9-9f3f-cf97fb9d4c3c', '13');
insert into carts values('li', 'c2f1dac4-55d4-4855-9db5-35d3fff3964d', '100');
insert into carts values('li', '3c4903c2-2c29-4b04-b2c3-6c7efe14bdf7', '1000');

-- �����ö�������
insert into orders values('e0a03826-090a-45f9-bac0-10b608978b07', 'yu', 'li', '24516a9e-bf48-4d93-ae34-6f644b3be81a,d428d149-77f8-4809-b46f-a3b31844492b', 'paid', '�㶫ʡ������', '51.1');
