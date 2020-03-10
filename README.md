# Emall
基于Spring Web的电子商城管理系统，课程设计



### 界面
商品
- 列表
- 加入购物车

购物车
- 列表
- 移除
- 支付

购买
- 输入地址
- 支付

已购买的商品（物流）
- 列表
- 退款

### 数据库

账户
- userId 
- balance
- password
- cart
- uuid

订单
- orderId
- userId
- status
- address
- good_list

物流
- oderId
- status
- mail_number

商品
- goodId
- userId
- goodName
- price
- number
- description
- imgs



### 实体及其行为
买家Buyer
- 充值
- 添加购物车
- 删除购物车
- 确认收货

订单Order
- 购买
- 退款

卖家Seller
- 发货
- 创建店铺（账号）

商品Good
- 添加商品
- 修改商品
- 下架商品


