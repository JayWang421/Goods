-- 删除数据表
DROP TABLE item PURGE ;
DROP TABLE tag PURGE ;
DROP SEQUENCE goods_seq ;
-- 创建数据表
CREATE TABLE item(
	iid			NUMBER ,
	title		VARCHAR2(50) ,
	CONSTRAINT pk_iid PRIMARY KEY(iid)
) ;
CREATE TABLE tag(
	tid			NUMBER ,
	title		VARCHAR2(50) ,
	CONSTRAINT pk_tid PRIMARY KEY(tid)
) ;
CREATE SEQUENCE goods_seq ;
CREATE TABLE goods (
	gid			NUMBER ,
	name		VARCHAR2(50) ,
	price		NUMBER ,
	photo		VARCHAR2(100) ,
	iid			NUMBER ,
	CONSTRAINT pk_gid10 PRIMARY KEY(gid) ,
	CONSTRAINT fk_iid FOREIGN KEY(iid) REFERENCES item(iid)
) ;
CREATE TABLE goods_tag(
	gid			NUMBER , 
	tid			NUMBER ,
	CONSTRAINT fk_gid11 FOREIGN KEY(gid) REFERENCES goods(gid) ON DELETE CASCADE ,
	CONSTRAINT fk_tid11 FOREIGN KEY(tid) REFERENCES tag(tid)
) ;
-- 测试数据
INSERT INTO item(iid,title) VALUES (1,'图书音像') ;
INSERT INTO item(iid,title) VALUES (2,'办公用品') ;
INSERT INTO item(iid,title) VALUES (3,'家居生活') ;
INSERT INTO item(iid,title) VALUES (4,'厨房家电') ;
INSERT INTO item(iid,title) VALUES (5,'电子设备') ;

INSERT INTO tag(tid,title) VALUES (1,'高端') ;
INSERT INTO tag(tid,title) VALUES (2,'奢华') ;
INSERT INTO tag(tid,title) VALUES (3,'性价比高') ;
INSERT INTO tag(tid,title) VALUES (4,'免费') ;
INSERT INTO tag(tid,title) VALUES (5,'耐用') ;

-- 提交事务
COMMIT ;

