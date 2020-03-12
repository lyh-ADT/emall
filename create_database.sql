create database db_EMall DEFAULT CHARSET utf8 COLLATE utf8_general_ci;

use db_EMall;

-- 创建用户表
create table account(
	userId 		varchar(100) primary key,
	balance 	double default 0,
	password 	varchar(40) not null,
	uuid		varchar(40),
	constraint chk_balance CHECK (balance >= 0)
);

-- 创建商品表
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

-- 创建购物车表
create table carts(
	userId varchar(100),
	goodId varchar(100),
	number int default 0,
	primary key(userId, goodId),
	constraint chk_carts_number CHECK (number >= 0),
	FOREIGN KEY fk_carts_userId(userId)REFERENCES account(userId)
);

-- 创建订单表
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

-- 测试用用户数据
insert into account values('li', 1000, 'e10adc39-49ba59ab-be56e057-f20f883e'/*123456*/, null);
insert into account values('yu', 600, 'e10adc39-49ba59ab-be56e057-f20f883e'/*123456*/, null);

-- 测试用商品数据 80条
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('e0a03826-090a-45f9-bac0-10b608978b07', 'li', '34.1', '589', '疫情原因 发货待定 四川塔罗科血橙 新鲜水果 净重2.5斤装 果径70-80mm 2单合发1件5斤装 偶数件发货 奥奇健', '疫情原因 发货待定 四川塔罗科血橙 新鲜水果 净重2.5斤装 果径70-80mm 2单合发1件5斤装 偶数件发货 奥奇健', '39e13795-8da6-4b8b-b796-e7607c7ea012.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('5d8312a4-709a-4767-b189-1d7a9882e206', 'li', '87.8', '834', '【天府生鲜】甘肃花牛苹果 粉面苹果 75#-80#左右2.5斤 粉面香甜 西沛水果', '【天府生鲜】甘肃花牛苹果 粉面苹果 75#-80#左右2.5斤 粉面香甜 西沛水果', '21088ce7-1877-4697-a0d7-e99ecfa14254.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('71a13786-5628-4cb0-9c09-48da48829234', 'li', '82.6', '853', '绝世原味火山石烤肠地道肠台式肉肠热狗香肠烧烤脆皮肠3斤批发', '绝世原味火山石烤肠地道肠台式肉肠热狗香肠烧烤脆皮肠3斤批发', '73ebfd80-a045-49fb-abb8-5ec24f081fc8.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('d8a1dc57-cf4e-4b67-973d-5bbbaf096af7', 'li', '96.8', '569', '绝世厚切牛肉片肥牛片雪花烧烤火锅新鲜牛肉酸汤肥牛原料130克*5袋', '绝世厚切牛肉片肥牛片雪花烧烤火锅新鲜牛肉酸汤肥牛原料130克*5袋', 'd48608ca-674d-4ac7-98a4-ec809cdb42e3.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('d8a185f5-6ed5-456b-8aaf-088bec6505d1', 'li', '29.0', '683', '大希地 家家爱好虾仁500g*1袋 大颗饱满白虾仁翡翠虾仁 新鲜仿佛刚出水 肉质紧实 大餐 南美虾仁 较高包冰率', '大希地 家家爱好虾仁500g*1袋 大颗饱满白虾仁翡翠虾仁 新鲜仿佛刚出水 肉质紧实 大餐 南美虾仁 较高包冰率', '092e99c2-290e-4f4a-b99c-21bb4006e407.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('ad5e3ad7-55f2-4e08-9b29-c00104ce6017', 'li', '88.4', '429', '【预售 】品珍鲜活 越南黑虎虾毛重约900g 冷冻生鲜虾进口海鲜水产约20-25只装净重700g海鲜大虾', '【预售 】品珍鲜活 越南黑虎虾毛重约900g 冷冻生鲜虾进口海鲜水产约20-25只装净重700g海鲜大虾', 'cde75ae3-0f98-4832-89ba-919e3ac6f98f.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('243eb41b-421b-4c6e-9880-3d67b015e302', 'li', '2.3', '299', '好拾味 葱味手抓饼台湾风味手抓饼面饼 早餐面饼 手抓饼皮10片装*2 葱味', '好拾味 葱味手抓饼台湾风味手抓饼面饼 早餐面饼 手抓饼皮10片装*2 葱味', 'd55c1837-b4c0-438c-a482-b15fff9fce72.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('4c9d469b-ffd6-4ea4-ad48-5e8e949e83d6', 'li', '74.9', '948', '【4袋装】好拾味手打潮汕牛肉丸牛筋丸火锅食材 涮火锅丸子 烧烤丸串', '【4袋装】好拾味手打潮汕牛肉丸牛筋丸火锅食材 涮火锅丸子 烧烤丸串', 'f82ae81b-2803-430d-85a9-72c593dd9a1c.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('f2496318-b5e8-4eb2-9eeb-5cfb3c6271b5', 'li', '16.3', '351', '来伊份虎皮蛋糕168g糕点零食奶香夹心蛋糕美食早餐软点心小包装', '来伊份虎皮蛋糕168g糕点零食奶香夹心蛋糕美食早餐软点心小包装', '46c5d8b3-89c9-4102-af30-e8d2ebd8bbf2.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('b15a16ed-d9d4-401d-bccb-c000cca1215a', 'li', '49.5', '988', '【三只松鼠_猪肉脯自然片150g】休闲零食小吃靖江风味熟食猪肉干', '【三只松鼠_猪肉脯自然片150g】休闲零食小吃靖江风味熟食猪肉干', 'dcce34bb-dc4a-4fcc-9d0c-dd2a214dc6df.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('0380d467-cb1b-410d-adce-7498162bd6b2', 'li', '47.9', '880', '【三只松鼠_开心果100g】休闲零食每日坚果特产炒货干果孕妇无漂白', '【三只松鼠_开心果100g】休闲零食每日坚果特产炒货干果孕妇无漂白', '8170700f-210c-4110-b5cb-0d7144cd5f96.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('1072a681-eb89-4cde-809b-ab549356e124', 'li', '72.3', '681', '【百草味-芒果干120gx3袋】果脯蜜饯水果干条芒果片 休闲零食', '【百草味-芒果干120gx3袋】果脯蜜饯水果干条芒果片 休闲零食', '89c9712a-2133-4472-a267-c230360d3e61.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('ca4e3742-d83d-4989-a57c-5ea703c28653', 'li', '8.1', '815', '【良品铺子】原味酥脆薄饼300g*1盒 休闲零食咸味饼干零食饼干糕点包装', '【良品铺子】原味酥脆薄饼300g*1盒 休闲零食咸味饼干零食饼干糕点包装', '66fb38c9-a4db-4455-9d7d-104dcabf9400.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('14b72529-84d4-4fc1-a2ed-29dc244b4cf1', 'li', '8.5', '761', '【家乐福】哈利克斯棒棒糖跳跳糖组合（什锦水果味）12g', '【家乐福】哈利克斯棒棒糖跳跳糖组合（什锦水果味）12g', '5a9f42d9-398a-4610-9cb0-3c45374bf5d6.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('87120f56-d9e7-449f-a9c8-277277fcf131', 'li', '25.9', '886', '俄罗斯进口KDV奶球糖500g榛子果酱夹心糖果零食结婚喜糖', '俄罗斯进口KDV奶球糖500g榛子果酱夹心糖果零食结婚喜糖', 'cfc28dfa-e1fe-44b2-bb7b-a8632fce967f.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('e20635cf-a1e0-41e5-bf48-3c911c21b039', 'li', '58.5', '271', '达利园 蛋糕 蛋香味 福建特产营养食品点心早餐糕点600g 面包办公休闲小吃零食礼盒', '达利园 蛋糕 蛋香味 福建特产营养食品点心早餐糕点600g 面包办公休闲小吃零食礼盒', 'f358f7fd-abf7-494c-a50c-8a5adb9dff93.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('dcefd680-b202-44ac-88f5-2ad85a4ae654', 'li', '23.6', '585', '贵州茅台 汉酱 51度500ml 单瓶装 酱香型白酒（新老包装随机发货）', '贵州茅台 汉酱 51度500ml 单瓶装 酱香型白酒（新老包装随机发货）', '5bf48940-5ba2-4b7f-a7d1-67f925852b89.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('4c70a63a-1acc-469c-877f-1c6732aac30e', 'li', '93.3', '545', '古越龙山 绍兴黄酒 花雕酒糯米酒 半甜型 清醇三年 500ml*6瓶 整箱装 送礼佳品', '古越龙山 绍兴黄酒 花雕酒糯米酒 半甜型 清醇三年 500ml*6瓶 整箱装 送礼佳品', '988b8828-d87f-46fc-8874-222fc9a4fff2.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('bf920d06-8245-4322-a7ea-f146562a243a', 'li', '98.4', '69', '锐澳（RIO）洋酒 鸡尾酒 预调酒 微醺系列组合 330ml*8罐（微醺4种口味*2）', '锐澳（RIO）洋酒 鸡尾酒 预调酒 微醺系列组合 330ml*8罐（微醺4种口味*2）', 'fbff2ba8-f4b4-4b6a-bd22-9c159fb057e7.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('74984f54-b714-4263-9fc4-0e98147fb227', 'li', '85.7', '785', '西凤酒55度绿瓶盒装 凤香型白酒 整箱500ml*6盒', '西凤酒55度绿瓶盒装 凤香型白酒 整箱500ml*6盒', 'b705c357-a647-4d5c-88ee-357e4a9cd961.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('83eab332-8c89-41e1-aae0-6a8cd9d49bec', 'li', '73.0', '255', '洋河(YangHe) 蓝色经典 海之蓝42度 单瓶盒装白酒 480ml 口感绵柔浓香型（新老包装随机发货）', '洋河(YangHe) 蓝色经典 海之蓝42度 单瓶盒装白酒 480ml 口感绵柔浓香型（新老包装随机发货）', 'cd281b50-8f40-444d-b587-0b0e7fbe9843.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('e3e34cdd-c6ab-4de4-a07c-5dbaad45921b', 'li', '44.1', '470', '贵州习酒 红习酱1952 53度 500m*6 整箱装 酱香型白酒 （新老包装随机发货）', '贵州习酒 红习酱1952 53度 500m*6 整箱装 酱香型白酒 （新老包装随机发货）', '7f15a945-82ab-4e2d-a055-067e4c641a42.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('c9839fc1-d695-4f9a-b8ee-95fae41ad6e2', 'li', '92.2', '539', '剑南春 水晶剑 52度 500ml 浓香型 白酒 单瓶装', '剑南春 水晶剑 52度 500ml 浓香型 白酒 单瓶装', 'b237bc3c-73c9-4915-bc48-4f2bef48435c.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('397647e2-c07f-4ec4-8f6c-5c4f5bf8de1f', 'li', '52.7', '436', '法国原装进口红酒 梦诺蓝色星空干红葡萄酒750ml*6 整箱装', '法国原装进口红酒 梦诺蓝色星空干红葡萄酒750ml*6 整箱装', 'b0d27e43-ab18-4940-8c27-f17e55fdd7c7.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('725528e6-69fd-403b-8a8b-c6fb1ea565ff', 'li', '55.5', '603', 'Arla爱氏晨曦 全脂纯牛奶1L*12盒整箱 德国进口', 'Arla爱氏晨曦 全脂纯牛奶1L*12盒整箱 德国进口', '47a04335-e91b-4413-9536-2120bd6d97ce.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('4607e7f1-ab59-4dba-9779-3a419511a484', 'li', '26.9', '298', '德运（Devondale）全脂纯牛奶1L*10盒整箱 澳洲进口', '德运（Devondale）全脂纯牛奶1L*10盒整箱 澳洲进口', '2acd49bb-68a3-4c20-a481-a5db9912fcb3.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('25b4b584-d5c1-4c2b-863a-e4723325a32f', 'li', '56.4', '671', '新西兰进口Theland纽仕兰3.5g蛋白质高钙全脂纯牛奶（家庭装）250ml*24盒', '新西兰进口Theland纽仕兰3.5g蛋白质高钙全脂纯牛奶（家庭装）250ml*24盒', '02124913-5609-42e8-8b9d-f01ecf31bf50.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('2fc9b71d-1f3d-4b18-93b5-ae4470fc5e12', 'li', '5.1', '973', '【12+4盒】 伊利 安慕希希腊风味酸牛奶原味205g*16盒', '【12+4盒】 伊利 安慕希希腊风味酸牛奶原味205g*16盒', 'c5a735b1-6acd-4e28-b65a-13758d7bc49f.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('bdaa3268-43cf-468a-be6f-93712664e3e1', 'li', '83.9', '67', '伊利金典纯牛奶礼盒装250ml*12', '伊利金典纯牛奶礼盒装250ml*12', 'cc113c16-22c3-4d28-a193-f2202dac3a7b.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('642635bd-4a59-4287-a437-5e85a905f483', 'li', '80.7', '819', '安佳（Anchor）全脂纯牛奶250ml*24盒整箱 新西兰进口 牛奶', '安佳（Anchor）全脂纯牛奶250ml*24盒整箱 新西兰进口 牛奶', 'd301113a-9104-45c1-a5b7-4c4cebb1d93f.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('018d9bc9-cb60-4a4d-9d2c-62189fcb81dc', 'li', '13.4', '784', '伊利安慕希常温酸牛奶礼盒装205g*12 整箱', '伊利安慕希常温酸牛奶礼盒装205g*12 整箱', '571d1137-c098-45b7-b31e-6bffd4358ecf.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('34efc4cc-05fa-429a-a877-3e7bdaaada09', 'li', '32.8', '891', '尼平河全脂牛奶1L*12 甄喜系列 德国原装进口 整箱 常温全脂纯牛奶', '尼平河全脂牛奶1L*12 甄喜系列 德国原装进口 整箱 常温全脂纯牛奶', '86424644-7a11-42b1-af39-2ec2cf6b99eb.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('f8df9f3a-fe69-48b1-b396-8c741a039ab2', 'li', '52.3', '300', '燕之坊核桃芝麻黑豆粉250g*2罐装 五谷杂粮代餐粉 饱腹代餐', '燕之坊核桃芝麻黑豆粉250g*2罐装 五谷杂粮代餐粉 饱腹代餐', '63f0ccd0-50f2-4305-b3ab-5793daaf4be2.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('16ea931c-2bdb-4d88-8b02-f330d0d59e56', 'li', '90.3', '947', '桂格（Quaker）早餐谷物 膳食纤维 即食燕麦片 袋装1478g【新老包装交替发货】', '桂格（Quaker）早餐谷物 膳食纤维 即食燕麦片 袋装1478g【新老包装交替发货】', '2f91d931-edb0-4379-8001-8eed0a936f3c.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('f562b7bc-123e-4eed-aa94-6cb77cfe08a7', 'li', '99.8', '381', '【名仁】苏打水泡腾片弱碱性自制苏打水柠檬味（木糖醇）饮料24片', '【名仁】苏打水泡腾片弱碱性自制苏打水柠檬味（木糖醇）饮料24片', '61a2ba98-e3cd-4055-a617-c3af0daf9991.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('0921d51a-3a02-465c-b5fe-baae045ab43a', 'li', '74.3', '812', '农夫山泉天然饮用水5L*4 整箱装', '农夫山泉天然饮用水5L*4 整箱装', '0f6b54e7-6102-4004-82c8-b21ec5e7c33b.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('368a99b3-39f1-4f1d-be5e-35a7de61feb9', 'li', '81.2', '744', '【天地精华】 天然矿泉水350ml*20瓶/箱 弱碱性饮用水非纯净水整箱装', '【天地精华】 天然矿泉水350ml*20瓶/箱 弱碱性饮用水非纯净水整箱装', 'beff5858-d701-4c58-9c6e-4a97d7cd47af.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('1c9fbda7-4786-42a6-a6c3-0cf3b8930719', 'li', '25.0', '590', '屈臣氏（Watsons）盐味苏打汽水330mlX4罐', '屈臣氏（Watsons）盐味苏打汽水330mlX4罐', '37bf7129-15af-45ca-9d43-f8a1de5b598e.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('86b5b661-09cd-4e61-ba72-45d5e927d735', 'li', '66.1', '499', '维他（Vita） 柠檬茶250ml*6瓶', '维他（Vita） 柠檬茶250ml*6瓶', '10c6a76c-bda3-47fe-abcf-f1bf2706d69b.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('d9ed76af-1aeb-4506-800e-8e61eb710d3b', 'li', '75.1', '24', '零度可口可乐300ml*12瓶', '零度可口可乐300ml*12瓶', '09aca40c-4d65-4732-88e2-0dad18f88ccf.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('758b7d37-99bf-47be-947e-c2f906494cd7', 'li', '13.4', '504', '福临门 臻选东北大米5kg', '福临门 臻选东北大米5kg', 'dd5edfcf-e86e-4181-a830-39fbf256642b.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('a92bd10d-6e54-4111-836b-287202b5a08a', 'li', '78.8', '625', '富虹油品玉米胚芽油1.8L 非转基因压榨粮油 玉米油 食用油', '富虹油品玉米胚芽油1.8L 非转基因压榨粮油 玉米油 食用油', '6708cdf0-dac5-4bd1-85b3-ee9e832c1641.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('86ee4ae5-7b20-4fc0-b202-3ddbb29cc91a', 'li', '59.3', '174', '金龙鱼北国雾淞小町10kg 袋装粳米 东北吉林大米 寿司香米 自营', '金龙鱼北国雾淞小町10kg 袋装粳米 东北吉林大米 寿司香米 自营', 'de6935ac-5432-4edc-9460-13d832de6c45.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('65961329-4870-472a-8456-b6a8dc134610', 'li', '36.2', '954', '【2019新米上市】十月稻田稻花香大米 5kg东北大米东北稻花香米', '【2019新米上市】十月稻田稻花香大米 5kg东北大米东北稻花香米', '555477ab-4e6a-4a13-9676-4a8e79e34222.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('9afb569d-74a7-4294-b3e1-017581f3dced', 'li', '64.7', '712', '想念面粉 特一小麦粉2.5kg 家用面粉 多用途小麦粉 饺子粉', '想念面粉 特一小麦粉2.5kg 家用面粉 多用途小麦粉 饺子粉', '7ba2bf6e-f6f7-4565-b1f1-cb6e27a9e40d.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('9465a9d9-dd1c-4590-a2fe-5cb22fe89202', 'li', '39.7', '849', '【年货送礼】盛耳（shenger） 菌菇干货礼盒装580g 银耳 黑木耳等山珍喜福如意 福建土特产', '【年货送礼】盛耳（shenger） 菌菇干货礼盒装580g 银耳 黑木耳等山珍喜福如意 福建土特产', 'a72eb404-c18a-44a7-8fac-0113026aa492.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('09f8f590-5928-47fc-9a6f-65bba1026cd8', 'li', '71.6', '758', '雪都天然黑木耳500g东北特产黑木耳货干肉厚', '雪都天然黑木耳500g东北特产黑木耳货干肉厚', '5881f8c0-1114-4940-aee9-503318d77681.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('7a787437-2467-45c5-8b29-3df181fc3ac4', 'li', '68.4', '101', '民华黑珍 优质中菇250g 南北干货 香菇 蘑菇 山珍菌菇 煲汤烹饪食材', '民华黑珍 优质中菇250g 南北干货 香菇 蘑菇 山珍菌菇 煲汤烹饪食材', '3e731117-79c1-49d9-82e7-f8022916edd0.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('5f45aff1-59ed-4183-9b12-e8168a75b0f5', 'li', '28.0', '891', '百雀羚(PECHOIN)小雀幸静润补水保湿面膜25ml*10片（补水保湿 通用 护肤 各种肤质 面膜贴）', '百雀羚(PECHOIN)小雀幸静润补水保湿面膜25ml*10片（补水保湿 通用 护肤 各种肤质 面膜贴）', '26686fa7-496f-4b36-9e68-1952cb6afa01.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('6a1da6c7-b6cb-46dd-854a-946c34faae5b', 'li', '74.4', '571', '韩国JM solution肌司研莹润蜂胶面膜（黑臻版） 30ml*10片', '韩国JM solution肌司研莹润蜂胶面膜（黑臻版） 30ml*10片', '5067078e-8ee0-4883-8086-79c5174b7ae8.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('9c560bf6-e1ae-44df-8d4a-ef928dd9a6e6', 'li', '6.3', '262', '百雀羚(PECHOIN)水嫩倍现臻美套装 (洁面95g+水100ml+乳100ml）通用 护肤套装 保湿补水 护肤控油', '百雀羚(PECHOIN)水嫩倍现臻美套装 (洁面95g+水100ml+乳100ml）通用 护肤套装 保湿补水 护肤控油', '76e7c14b-3ed2-4fb9-9f06-c9810b083da8.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('3e29b971-f70f-48ea-954c-80520bcd69c8', 'li', '56.1', '331', '后Whoo拱辰享水沄系列化妆品护肤礼盒(309ml+2g)6件套改善浮肿状态;紧肤淡皱;控油平衡;', '后Whoo拱辰享水沄系列化妆品护肤礼盒(309ml+2g)6件套改善浮肿状态;紧肤淡皱;控油平衡;', '661c5f17-ec5c-44d2-8f9a-163d51328a47.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('a72a30b1-8ca7-4ba9-9f3f-cf97fb9d4c3c', 'li', '17.0', '108', '自然堂（CHANDO）雪域水乳套装 面部护肤品化妆品正品旗舰店 滋润保湿补水套装 女', '自然堂（CHANDO）雪域水乳套装 面部护肤品化妆品正品旗舰店 滋润保湿补水套装 女', 'db0b3734-9c5e-40ec-941a-4901363a9b82.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('2884dd9e-43b1-425d-94ea-1ca768d31cc3', 'li', '44.9', '392', '芙丽芳丝(Freeplus)净润洗面霜 100g 氨基酸系洗面奶 日本洁面乳 补水保湿 深层清洁 男女通用', '芙丽芳丝(Freeplus)净润洗面霜 100g 氨基酸系洗面奶 日本洁面乳 补水保湿 深层清洁 男女通用', '48c6feeb-73bf-40db-a329-ce326bfdf9f4.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('e00c6377-117e-48f6-b54d-36fd57f24103', 'li', '61.8', '502', '京润珍珠（gNPearl）纯珍珠粉 5g*20袋(微米级) 补水保湿祛斑淡痘印去淡斑面膜粉男女士化妆品提亮肤色', '京润珍珠（gNPearl）纯珍珠粉 5g*20袋(微米级) 补水保湿祛斑淡痘印去淡斑面膜粉男女士化妆品提亮肤色', '25d21edb-4736-4188-941b-7ab7181587e9.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('00e9cff4-5124-411d-8de6-8653ca831f59', 'li', '41.6', '690', '百雀羚(PECHOIN)水嫩倍现保湿精华乳液100ml（保湿补水 滋润营养 护肤 通用 各种肤质）', '百雀羚(PECHOIN)水嫩倍现保湿精华乳液100ml（保湿补水 滋润营养 护肤 通用 各种肤质）', 'e9ba8eb5-5955-4279-a391-eea2fe0fd780.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('f74ce49a-b625-412e-8408-ad9bfe147c46', 'li', '95.6', '806', '七度空间（SPACE7）少女系列 超薄 338mm超长夜用 大包装 12片 卫生巾姨妈巾', '七度空间（SPACE7）少女系列 超薄 338mm超长夜用 大包装 12片 卫生巾姨妈巾', '64b1586b-3b1f-4b57-92bd-9ba7bdc9e97a.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('6d3a0e69-413f-4435-93db-33da5caa3531', 'li', '56.1', '611', '七度空间(SPACE 7)优雅系列 超薄 丝柔 245mm日用32片卫生巾姨妈巾 大包装', '七度空间(SPACE 7)优雅系列 超薄 丝柔 245mm日用32片卫生巾姨妈巾 大包装', '21b54107-392c-4b5f-be0b-144b74e33377.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('6ce548e0-62bb-4a55-9c79-998dbf460ce2', 'li', '16.5', '401', '黑人（DARLIE）双重薄荷牙膏225g*3【好来化工出品】', '黑人（DARLIE）双重薄荷牙膏225g*3【好来化工出品】', '5c858fa6-ac2a-444e-a20d-428aeba62281.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('0f3e57ff-a360-4156-9059-171d2cf838d9', 'li', '69.3', '740', '舒肤佳1.5升纯白沐浴露', '舒肤佳1.5升纯白沐浴露', '2239130e-b328-4f05-a7a6-00bf0af76930.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('ddc0dd27-f1e1-4c5b-8542-100028dfcb01', 'li', '99.2', '39', '凡士林（VASELINE）经典修护晶冻50g 滋润营养【联合利华】', '凡士林（VASELINE）经典修护晶冻50g 滋润营养【联合利华】', 'c400c8d3-6ad3-4c29-818f-5754d3ef0e9a.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('4049bf59-fb83-4c63-abb8-46f52c5c0931', 'li', '59.7', '399', 'ABC卫生巾 日用+夜用组合女神定制装纤薄棉柔系列组合装9包62片姨妈巾 国产', 'ABC卫生巾 日用+夜用组合女神定制装纤薄棉柔系列组合装9包62片姨妈巾 国产', 'b105771a-5aa2-44f3-843b-7359e8944854.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('af225b23-4dca-43f5-9344-e4041a1672e6', 'li', '47.3', '501', '欧莱雅(LOREAL)奇焕润发精油（针对受损发质）100ml（滋养秀发）', '欧莱雅(LOREAL)奇焕润发精油（针对受损发质）100ml（滋养秀发）', '4968dc00-acb1-48b5-9a8a-e8671da553b9.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('716a9d28-1132-4fdb-90f5-080d9dc2e099', 'li', '89.7', '633', '海飞丝洗发水清爽去油750ml 去屑洗发水露洗头膏 持久去屑止痒清爽控油 柠檬香 男士女士通用', '海飞丝洗发水清爽去油750ml 去屑洗发水露洗头膏 持久去屑止痒清爽控油 柠檬香 男士女士通用', '86fa53c4-bbfc-46dd-8689-3f531907c4fb.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('3b4fbaeb-fd31-4e2c-969c-e286baf84ea6', 'li', '25.2', '504', '维达（Vinda） 抽纸 苏宁定制超韧三层132抽*18包纸巾 小规格整箱销售（新旧包装交替发货）', '维达（Vinda） 抽纸 苏宁定制超韧三层132抽*18包纸巾 小规格整箱销售（新旧包装交替发货）', '8860fbb6-a621-4f44-a169-a9174585dcd2.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('5da4dfa1-e6fa-4ed7-9967-74146a434b98', 'li', '71.8', '854', '清风 抽纸 淡绿花二层200抽*20包小规格(短幅)抽取式卫生纸巾餐巾纸擦手纸面巾纸家庭装（整箱销售）', '清风 抽纸 淡绿花二层200抽*20包小规格(短幅)抽取式卫生纸巾餐巾纸擦手纸面巾纸家庭装（整箱销售）', '00f41d9a-a633-4310-897a-f8d3e9491fe6.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('d344afed-5264-427c-9948-ac8cf3a01145', 'li', '8.5', '112', '汰渍全效360°洗衣液洁雅百合香型洗衣液3kgx2 宝洁官方正品', '汰渍全效360°洗衣液洁雅百合香型洗衣液3kgx2 宝洁官方正品', 'aa90a126-0839-4d12-a2f0-ca93d16dbaa6.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('83b46d4a-e2b5-430b-8953-0a6c6ba5b4bd', 'li', '41.6', '351', '卫新 薰衣草洗衣液 4.26kg 机洗净白亮色柔顺护衣威露士出品', '卫新 薰衣草洗衣液 4.26kg 机洗净白亮色柔顺护衣威露士出品', '505f5457-0051-42ef-9734-6471cee65a03.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('f2d998df-c177-493b-a357-69698c8904c3', 'li', '32.8', '151', '清风 抽纸 原木纯品二层150抽*20包小规格(短幅)抽取式纸巾（整箱销售）', '清风 抽纸 原木纯品二层150抽*20包小规格(短幅)抽取式纸巾（整箱销售）', '44dacdfc-0274-497d-863c-093a2489fedc.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('f8fd29fc-0460-4e75-9671-8d1d9d8a42a4', 'li', '75.1', '836', '【16斤+礼包】奥妙(OMO) 除菌除螨洗衣液 3kg*2+1kg*2+衣物洗护赠品礼包【联合利华】', '【16斤+礼包】奥妙(OMO) 除菌除螨洗衣液 3kg*2+1kg*2+衣物洗护赠品礼包【联合利华】', 'df136749-ddd9-4716-92fc-e6abc1e698b5.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('fd3e465c-7121-41f1-8ea4-32277a582042', 'li', '67.2', '647', '清风 抽纸 淡绿花二层200抽*20包小规格(短幅)抽取式纸巾（整箱销售）', '清风 抽纸 淡绿花二层200抽*20包小规格(短幅)抽取式纸巾（整箱销售）', 'd6b5debe-3e97-415f-a3da-bd637bdfe3c0.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('b1b3b5d7-f780-4b2d-a011-d1a6b8a1021e', 'li', '69.1', '137', '清风 手帕纸 中国城市热爱系列 4层7张12包 限量款', '清风 手帕纸 中国城市热爱系列 4层7张12包 限量款', '7d4904ab-3f48-489e-b2ee-a62d8bb7c920.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('ccd1f698-557c-41ee-a9fd-16f766fab6b7', 'li', '84.9', '588', '汤臣倍健(BY-HEALTH) 蛋白粉 450克+150*2罐 共750克 增强免疫力 保健品营养品', '汤臣倍健(BY-HEALTH) 蛋白粉 450克+150*2罐 共750克 增强免疫力 保健品营养品', '60ec25bb-ebb0-4fba-a619-bdadc2a2a85a.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('3c4903c2-2c29-4b04-b2c3-6c7efe14bdf7', 'li', '78.6', '600', '欧姆龙(OMRON)电子血压计 U10K 上臂式家用智能加压全自动测量血压仪 高血压报警', '欧姆龙(OMRON)电子血压计 U10K 上臂式家用智能加压全自动测量血压仪 高血压报警', '1f6c28d4-3b93-4145-b7f2-c8ca0b958243.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('c2f1dac4-55d4-4855-9db5-35d3fff3964d', 'li', '32.6', '477', '鱼跃（yuwell）电子血压计 YE660D语音血压仪 家用上臂式高精准全自动智能老人测量血压仪器', '鱼跃（yuwell）电子血压计 YE660D语音血压仪 家用上臂式高精准全自动智能老人测量血压仪器', 'aa1d7954-290e-462f-b630-5941ad5be666.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('47c8e93d-ad00-4f15-9220-c347e46b50ba', 'li', '67.0', '588', '丰凯园实业 宁夏特产中宁红枸杞子茶 特级500g罐装 正宗头茬免洗大粒 苏宁自营配送', '丰凯园实业 宁夏特产中宁红枸杞子茶 特级500g罐装 正宗头茬免洗大粒 苏宁自营配送', '9571bd83-5d85-4907-847e-ea5579589551.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('30957d7c-4d34-4c2a-a23a-91e482cb5d79', 'li', '61.6', '951', '欧姆龙(OMRON)电子体温计 MC-347 婴儿宝宝成人全家测温 儿童适用直肠式温度计', '欧姆龙(OMRON)电子体温计 MC-347 婴儿宝宝成人全家测温 儿童适用直肠式温度计', 'ebba0fd7-76fb-4c9c-a37b-75283a2ab5e7.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('34ae0eb8-f978-4ce2-805f-5c6b6ece5f8b', 'li', '49.6', '410', '青源堂 精选品质冬虫夏草 4条/g 5g礼盒装 青海玉树高海拔野生虫草', '青源堂 精选品质冬虫夏草 4条/g 5g礼盒装 青海玉树高海拔野生虫草', 'e99149c1-360d-441b-b5b3-7fe9951e1852.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('d428d149-77f8-4809-b46f-a3b31844492b', 'li', '6.4', '455', '江中猴姑 五谷养生营养品 早餐米稀 营养米糊(15袋)15天装 450g 猴姑米稀 代餐麦片 营养米稀 猴菇 早餐米稀', '江中猴姑 五谷养生营养品 早餐米稀 营养米糊(15袋)15天装 450g 猴姑米稀 代餐麦片 营养米稀 猴菇 早餐米稀', '74436b5a-dbb2-4098-b0ba-0925331412c4.jpg');
insert into goods(goodId, userId, price, number, goodName, description, imgs) values('24516a9e-bf48-4d93-ae34-6f644b3be81a', 'li', '44.7', '384', '康富来牌 血尔口服液 76ml*8瓶礼盒装 保健礼品 健康礼盒 营养滋补', '康富来牌 血尔口服液 76ml*8瓶礼盒装 保健礼品 健康礼盒 营养滋补', '09a4da59-e943-4d52-bcfe-8911b5ff6471.jpg');

-- 测试用购物车数据
insert into carts values('li', 'a72a30b1-8ca7-4ba9-9f3f-cf97fb9d4c3c', '13');
insert into carts values('li', 'c2f1dac4-55d4-4855-9db5-35d3fff3964d', '100');
insert into carts values('li', '3c4903c2-2c29-4b04-b2c3-6c7efe14bdf7', '1000');

-- 测试用订单数据
insert into orders values('e0a03826-090a-45f9-bac0-10b608978b07', 'yu', 'li', '24516a9e-bf48-4d93-ae34-6f644b3be81a,d428d149-77f8-4809-b46f-a3b31844492b', 'paid', '广东省广州市', '51.1');
