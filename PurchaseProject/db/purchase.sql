SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS t_order_detail;
DROP TABLE IF EXISTS t_order_timeline;
DROP TABLE IF EXISTS t_order;
DROP TABLE IF EXISTS t_product_item;
DROP TABLE IF EXISTS t_product;
DROP TABLE IF EXISTS t_user;




/* Create Tables */

CREATE TABLE t_order
(
	id bigint NOT NULL AUTO_INCREMENT,
	user_id bigint NOT NULL,
	order_time datetime NOT NULL,
	product_count int NOT NULL,
	-- 0:正常
	-- 1:取消
	-- 
	order_status tinyint NOT NULL COMMENT '0:正常
1:取消
',
	-- 0：未支付
	-- 1：已支付
	pay_status tinyint NOT NULL COMMENT '0：未支付
1：已支付',
	pay_time datetime,
	create_user varchar(32),
	create_time datetime,
	update_user varchar(32),
	update_time datetime,
	-- 0 未删除
	-- 1 已删除
	delete_flg tinyint DEFAULT 0 COMMENT '0 未删除
1 已删除',
	PRIMARY KEY (id)
);


CREATE TABLE t_order_detail
(
	id bigint NOT NULL AUTO_INCREMENT,
	order_id bigint NOT NULL,
	product_item_id bigint NOT NULL,
	create_user varchar(32),
	create_time datetime,
	update_user varchar(32),
	update_time datetime,
	-- 0 未删除
	-- 1 已删除
	delete_flg tinyint DEFAULT 0 COMMENT '0 未删除
1 已删除',
	PRIMARY KEY (id)
);


CREATE TABLE t_order_timeline
(
	id bigint NOT NULL AUTO_INCREMENT,
	order_id bigint NOT NULL,
	-- 10:订单创建
	-- 20：订单支付
	-- 30：订单取消
	-- 
	event_type tinyint COMMENT '10:订单创建
20：订单支付
30：订单取消
',
	create_user varchar(32),
	create_time datetime,
	update_user varchar(32),
	update_time datetime,
	-- 0 未删除
	-- 1 已删除
	delete_flg tinyint DEFAULT 0 COMMENT '0 未删除
1 已删除',
	PRIMARY KEY (id)
);


CREATE TABLE t_product
(
	id bigint NOT NULL AUTO_INCREMENT,
	product_name varchar(128),
	product_desc text,
	product_count bigint,
	remain_count bigint,
	start_time datetime,
	end_time datetime,
	create_user varchar(32),
	create_time datetime,
	update_user varchar(32),
	update_time datetime,
	-- 0 未删除
	-- 1 已删除
	delete_flg tinyint DEFAULT 0 COMMENT '0 未删除
1 已删除',
	PRIMARY KEY (id)
);


CREATE TABLE t_product_item
(
	id bigint NOT NULL AUTO_INCREMENT,
	product_id bigint NOT NULL,
	-- 0：未销售
	-- 1：已销售
	sell_status tinyint COMMENT '0：未销售
1：已销售',
	create_user varchar(32),
	create_time datetime,
	update_user varchar(32),
	update_time datetime,
	-- 0 未删除
	-- 1 已删除
	delete_flg tinyint DEFAULT 0 COMMENT '0 未删除
1 已删除',
	PRIMARY KEY (id)
);


CREATE TABLE t_user
(
	id bigint NOT NULL AUTO_INCREMENT,
	username varchar(32),
	password varchar(128),
	token varchar(64),
	create_user varchar(32),
	create_time datetime,
	update_user varchar(32),
	update_time datetime,
	-- 0 未删除
	-- 1 已删除
	delete_flg tinyint DEFAULT 0 COMMENT '0 未删除
1 已删除',
	PRIMARY KEY (id)
);



/* Create Foreign Keys */

ALTER TABLE t_order_detail
	ADD FOREIGN KEY (order_id)
	REFERENCES t_order (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE t_order_timeline
	ADD FOREIGN KEY (order_id)
	REFERENCES t_order (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE t_product_item
	ADD FOREIGN KEY (product_id)
	REFERENCES t_product (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE t_order_detail
	ADD FOREIGN KEY (product_item_id)
	REFERENCES t_product_item (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE t_order
	ADD FOREIGN KEY (user_id)
	REFERENCES t_user (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



