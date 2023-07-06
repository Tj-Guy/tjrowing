/*1.实体表*/
/*1.1用户user*/
create table users_info(
    user_id number(10,0),
    user_email VARCHAR(32),
    user_phone VARCHAR(11) NOT NULL,
    user_password VARCHAR(20) NOT NULL,
    user_name VARCHAR(20) NOT NULL UNIQUE,
    user_portrait_url varchar(256)  DEFAULT('https://airrowwing/') NOT NULL,
    user_birthday DATE,
    user_gender VARCHAR(1) check(user_gender='f' or user_gender='m'),  
    user_signature VARCHAR(256),
    user_follower_num NUMBER(10) NOT NULL,
    user_follow_num NUMBER(10) NOT NULL,
    user_grade NUMBER(10) NOT NULL check(user_grade>=0),
    user_is_banned NUMBER(1)  DEFAULT 0 NOT NULL,
    user_is_online NUMBER(1)  DEFAULT 0 NOT NULL,
    CONSTRAINT user_info_pk PRIMARY KEY (user_id)
);

--ALTER TABLE "users_info" ADD PRIMARY KEY("user_id");--设置主键
--ALTER TABLE "users_info" MODIFY user_phone varchar(11) NOT NULL;设置非空的另外一种方式
CREATE SEQUENCE seq_users_info
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 9999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE; 
ALTER TABLE users_info MODIFY user_id DEFAULT seq_users_info.NEXTVAL;

COMMENT ON TABLE users_info IS '用户表';
COMMENT ON COLUMN users_info.user_id IS '用户id';
COMMENT ON COLUMN users_info.user_email IS '用户邮箱';
COMMENT ON COLUMN users_info.user_phone IS '用户电话号码';
COMMENT ON COLUMN users_info.user_password IS '用户密码';
COMMENT ON COLUMN users_info.user_name IS '用户名';
COMMENT ON COLUMN users_info.user_portrait_url IS '用户头像相对地址';
COMMENT ON COLUMN users_info.user_birthday IS '用户生日';
COMMENT ON COLUMN users_info.user_gender IS '用户性别';
COMMENT ON COLUMN users_info.user_signature IS '用户个性签名';
COMMENT ON COLUMN users_info.user_follower_num IS '用户粉丝数';
COMMENT ON COLUMN users_info.user_follow_num IS '用户关注数';
COMMENT ON COLUMN users_info.user_grade IS '用户等级';
COMMENT ON COLUMN users_info.user_is_banned IS '用户封禁状态';
COMMENT ON COLUMN users_info.user_is_online IS '用户登录状态';
/*drop table tb_maintence purge;*/
/*1.2俱乐部club*/
CREATE TABLE club (
  club_id NUMBER(10,0),
  club_email VARCHAR(32),
  club_phone VARCHAR(11) NOT NULL,
  club_password VARCHAR(20) NOT NULL,
  club_name VARCHAR(20) UNIQUE NOT NULL,
  club_portrait_url VARCHAR(256) DEFAULT 'https://airrowwing ...' NOT NULL,
  club_location VARCHAR(64) NOT NULL,
  club_mem_num NUMBER(10) NOT NULL,
  club_website VARCHAR(256),
  club_photos_url VARCHAR(256) DEFAULT 'https://airrowwing ...' NOT NULL,
  CONSTRAINT club_pk PRIMARY KEY (club_id)
);

CREATE SEQUENCE seq_club
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 9999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE; 
ALTER TABLE club MODIFY club_id DEFAULT seq_club.NEXTVAL;

COMMENT ON TABLE club IS '俱乐部表';
COMMENT ON COLUMN club.club_id IS '俱乐部id';
COMMENT ON COLUMN club.club_email IS '俱乐部邮箱';
COMMENT ON COLUMN club.club_phone IS '俱乐部电话号码';
COMMENT ON COLUMN club.club_password IS '俱乐部密码';
COMMENT ON COLUMN club.club_name IS '俱乐部名';
COMMENT ON COLUMN club.club_portrait_url IS '俱乐部头像相对地址';
COMMENT ON COLUMN club.club_location IS '俱乐部地址';
COMMENT ON COLUMN club.club_mem_num IS '俱乐部成员数';
COMMENT ON COLUMN club.club_website IS '俱乐部网站';
COMMENT ON COLUMN club.club_photos_url IS '俱乐部照片相对地址';
/*1.3赛艇赛事tournament*/
CREATE TABLE tournament (
  tournament_id NUMBER(10,0),
  tournament_introduction VARCHAR(1000),
  tournament_time VARCHAR(32) NOT NULL,
  tournament_location VARCHAR(32) NOT NULL,
  tournament_host VARCHAR(32) NOT NULL,
  tournament_photos_url VARCHAR(256) DEFAULT 'https://airrowwing ...' NOT NULL,
  CONSTRAINT tournament_pk PRIMARY KEY (tournament_id)
);
CREATE SEQUENCE seq_tournament
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 9999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE;  
ALTER TABLE tournament MODIFY tournament_id DEFAULT seq_tournament.NEXTVAL;

COMMENT ON TABLE tournament IS '赛事表';
COMMENT ON COLUMN tournament.tournament_id IS '赛事id';
COMMENT ON COLUMN tournament.tournament_introduction IS '赛事介绍';
COMMENT ON COLUMN tournament.tournament_time IS '赛事举办时间';
COMMENT ON COLUMN tournament.tournament_location IS '赛事举办地点';
COMMENT ON COLUMN tournament.tournament_host IS '赛事主办方';
COMMENT ON COLUMN tournament.tournament_photos_url IS '赛事照片相对地址';
/*1.4赛事奖项tournament_result*/
CREATE TABLE tournament_prize (--此处与设计文档中的名字不同，但是考虑合理性我觉得这样更好
  tournament_id NUMBER(10,0) NOT NULL,
  prize_type NUMBER(10) NOT NULL,
  metal_type NUMBER(10) NOT NULL,
  winner_name VARCHAR(16),
  CONSTRAINT tournament_prize_pk PRIMARY KEY (tournament_id, prize_type, metal_type),
  CONSTRAINT FK_tournament_prize FOREIGN KEY (tournament_id) REFERENCES tournament(tournament_id)
);
COMMENT ON TABLE tournament_prize IS '赛事奖项';
COMMENT ON COLUMN tournament_prize.tournament_id IS '赛事id';
COMMENT ON COLUMN tournament_prize.prize_type IS '艇种';
COMMENT ON COLUMN tournament_prize.metal_type IS '奖牌种类';
COMMENT ON COLUMN tournament_prize.winner_name IS '获奖人名';

/*1.5成就勋章medal*/
CREATE TABLE medal (
  medal_type VARCHAR(30) PRIMARY KEY NOT NULL,
  medal_pattern_url VARCHAR(256) NOT NULL,
  achieved_num NUMBER(10) NOT NULL
);
COMMENT ON TABLE medal IS '勋章表';
COMMENT ON COLUMN medal.medal_type IS '勋章名称';
COMMENT ON COLUMN medal.medal_pattern_url IS '勋章图案相对地址';
COMMENT ON COLUMN medal.achieved_num IS '勋章获得人次';

/*1.6管理员administer*/
CREATE TABLE administrator_info (
  administrator_id NUMBER(10,0) PRIMARY KEY,
  administrator_email VARCHAR(32) NOT NULL,
  administrator_phone VARCHAR(11) NOT NULL,
  administrator_name VARCHAR(20) UNIQUE NOT NULL,
  administrator_password VARCHAR(20) NOT NULL,
  administrator_gender VARCHAR(1) CHECK (administrator_gender IN ('f', 'm')),
  administrator_profile VARCHAR(256) NOT NULL,
  administrator_createtime DATE NOT NULL
);
CREATE SEQUENCE seq_administrator_info
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 9999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE; 
ALTER TABLE administrator_info MODIFY administrator_id DEFAULT seq_administrator_info.NEXTVAL;
COMMENT ON TABLE administrator_info IS '管理员表';
COMMENT ON COLUMN administrator_info.administrator_id IS '管理员id';
COMMENT ON COLUMN administrator_info.administrator_email IS '管理员邮箱';
COMMENT ON COLUMN administrator_info.administrator_phone IS '管理员手机号';
COMMENT ON COLUMN administrator_info.administrator_name IS '管理员用户名';
COMMENT ON COLUMN administrator_info.administrator_password IS '管理员密码';
COMMENT ON COLUMN administrator_info.administrator_gender IS '管理员性别';
COMMENT ON COLUMN administrator_info.administrator_profile IS '管理员头像相对地址';
COMMENT ON COLUMN administrator_info.administrator_createtime IS '管理员账号注册日期';

/*1.7动态messages_info*/
CREATE TABLE messages_info (
  message_id NUMBER(10,0) NOT NULL,
  message_type NUMBER(10) NOT NULL,
  message_content VARCHAR(1024) NOT NULL,
  like_num NUMBER(10) DEFAULT 0,
  collection_num NUMBER(10) DEFAULT 0,
  message_time DATE DEFAULT SYSDATE NOT NULL,
  --photo_url VARCHAR(256),
  --PRIMARY KEY (message_id,message_type)
  CONSTRAINT messages_info_pk PRIMARY KEY (message_id, message_type)
);
CREATE SEQUENCE seq_messages_info
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 9999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE; 
ALTER TABLE messages_info MODIFY message_id DEFAULT seq_messages_info.NEXTVAL;--此处的message？
COMMENT ON TABLE messages_info IS '动态/评论表';
COMMENT ON COLUMN messages_info.message_id IS '动态id/评论id';
COMMENT ON COLUMN messages_info.message_type IS '类型1表示动态，2表示评论';
COMMENT ON COLUMN messages_info.message_content IS '动态/评论内容';
COMMENT ON COLUMN messages_info.like_num IS '动态/评论被点赞数';
COMMENT ON COLUMN messages_info.collection_num IS '动态/评论被收藏数';
COMMENT ON COLUMN messages_info.message_time IS '动态/评论发布时间';


/*多图片对应一动态的实现表*/
CREATE TABLE message_photo (
  message_id NUMBER(10,0) NOT NULL,
  photo_url VARCHAR(256) NOT NULL,
  CONSTRAINT message_photo_pk PRIMARY KEY (message_id, photo_url),
  CONSTRAINT message_photo_fk FOREIGN KEY (message_id) REFERENCES messages_info (message_id)
);
COMMENT ON COLUMN message_photo.photo_url IS '动态/评论内容图片';

/*1.8训练记录 training_record*/
CREATE TABLE training_record (
  training_id NUMBER(10,0) PRIMARY KEY,
  total_distance NUMBER(10,0) DEFAULT 0,
  total_time INTERVAL DAY TO SECOND DEFAULT INTERVAL '0 00:00:00' DAY TO SECOND,
  --duration INTERVAL DAY TO SECOND DEFAULT INTERVAL '0 00:00:00' DAY TO SECOND,
  create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  total_pace NUMBER(5,2) DEFAULT 0,
  stroke_frequence NUMBER(5,2) DEFAULT 0,
  posture_scores NUMBER(5,0) DEFAULT 0,
  performance_evaluation VARCHAR(64)
);
CREATE SEQUENCE seq_training_record
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 9999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE; 
ALTER TABLE training_record MODIFY training_id DEFAULT seq_training_record.NEXTVAL;
COMMENT ON TABLE training_record IS '训练记录表';
COMMENT ON COLUMN training_record.training_id IS '训练记录id';
COMMENT ON COLUMN training_record.total_distance IS '单次训练总里程';
COMMENT ON COLUMN training_record.total_time IS '单次训练总时间';
COMMENT ON COLUMN training_record.total_pace IS '单次训练总桨数';
COMMENT ON COLUMN training_record.stroke_frequence IS '平均桨频';
COMMENT ON COLUMN training_record.posture_scores IS '姿态评分';
COMMENT ON COLUMN training_record.performance_evaluation IS '表现评价';

/*1.9训练计划traing_plan*/
CREATE TABLE training_plan (
  user_id NUMBER(10,0) PRIMARY KEY,
  planned_distance NUMBER(10,0) DEFAULT 0,
  planned_time INTERVAL DAY TO SECOND DEFAULT INTERVAL '0 00:00:00' DAY TO SECOND,
  planned_pace NUMBER(5,2) DEFAULT 0,
  planned_stroke_frequence NUMBER(5,2) DEFAULT 0,
  performance_on_the_plan VARCHAR(64)
);
CREATE SEQUENCE seq_training_plan
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 9999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE; 
ALTER TABLE training_plan MODIFY user_id DEFAULT seq_training_plan.NEXTVAL;
COMMENT ON TABLE training_plan IS '训练计划表';
COMMENT ON COLUMN training_plan.user_id IS '用户id';
COMMENT ON COLUMN training_plan.planned_distance IS '单次训练总里程——计划';
COMMENT ON COLUMN training_plan.planned_time IS '单次训练总时间——计划';
COMMENT ON COLUMN training_plan.planned_pace IS '单次训练总桨数——计划';
COMMENT ON COLUMN training_plan.planned_stroke_frequence IS '平均桨频——计划';
COMMENT ON COLUMN training_plan.performance_on_the_plan IS '计划内表现';
/*1.10举报表*/
CREATE TABLE report_info (
  report_id NUMBER(10,0) PRIMARY KEY
);
CREATE SEQUENCE seq_report
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 9999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE; 
ALTER TABLE report_info MODIFY report_id DEFAULT seq_report.NEXTVAL;
COMMENT ON TABLE report_info IS '举报表';
COMMENT ON COLUMN report.report_id IS '举报id';
/*关系表*/
/*2.1用户关注用户follw*/
CREATE TABLE follow (
  --follow_id NUMBER(10) PRIMARY KEY,
  follow_time TIMESTAMP DEFAULT SYSDATE NOT NULL,
  follow_id NUMBER(10,0) NOT NULL,
  followed_id NUMBER(10,0) NOT NULL,
  CONSTRAINT follow_pk PRIMARY KEY (follow_id, followed_id),
  CONSTRAINT follow_fk FOREIGN KEY (follow_id) REFERENCES users_info(user_id),
  CONSTRAINT followed_fk FOREIGN KEY (followed_id) REFERENCES users_info(user_id)
);

COMMENT ON TABLE follow IS '关注表';
--COMMENT ON COLUMN follow.follow_id IS '关注id，主键，自动生成';
COMMENT ON COLUMN follow.follow_time IS '关注时间';
COMMENT ON COLUMN follow.follow_id IS '关注者id';
COMMENT ON COLUMN follow.followed_id IS '被关注者id';
/*2.2用户拉黑用户*/
CREATE TABLE blocks_info (
  block_id NUMBER(10,0) NOT NULL,
  blocked_id NUMBER(10,0) NOT NULL,
  block_time TIMESTAMP DEFAULT SYSDATE NOT NULL,
  CONSTRAINT block_pk PRIMARY KEY (block_id, blocked_id),
  CONSTRAINT block_user_fk1 FOREIGN KEY (block_id) REFERENCES users_info(user_id),
  CONSTRAINT block_user_fk2 FOREIGN KEY (blocked_id) REFERENCES users_info(user_id)
);

COMMENT ON TABLE blocks_info IS '拉黑表';
COMMENT ON COLUMN blocks_info.block_id IS '拉黑者id';
COMMENT ON COLUMN blocks_info.blocked_id IS '被拉黑者id';
COMMENT ON COLUMN blocks_info.block_time IS '拉黑时间';

/*2.3用户认证俱乐部*/
CREATE TABLE user_club (
  user_id NUMBER(10,0) NOT NULL,
  club_id NUMBER(10,0) NOT NULL,
  user_club_status NUMBER(10) NOT NULL,
  auth_time TIMESTAMP DEFAULT SYSDATE NOT NULL,
  CONSTRAINT user_club_pk PRIMARY KEY (user_id, club_id),
  CONSTRAINT user_club_users_info_fk FOREIGN KEY (user_id) REFERENCES users_info(user_id),
  CONSTRAINT user_club_club_fk FOREIGN KEY (club_id) REFERENCES club(club_id)
);

COMMENT ON TABLE user_club IS '用户关注俱乐部表';
COMMENT ON COLUMN user_club.user_id IS '关注者id';
COMMENT ON COLUMN user_club.club_id IS '被关注俱乐部id';
COMMENT ON COLUMN user_club.user_club_status IS '认证状态1（认证中）、2（认证成功）、3（认证失败）';
COMMENT ON COLUMN user_club.auth_time IS '认证成功时间';

/*2.4用户达成成就*/
CREATE TABLE achievement (
  user_id NUMBER(10) NOT NULL,
  medal_type VARCHAR(30) NOT NULL,
  achieve_time TIMESTAMP DEFAULT SYSDATE NOT NULL,
  CONSTRAINT achievement_pk PRIMARY KEY (user_id, medal_type),
  CONSTRAINT achievement_user_fk FOREIGN KEY (user_id) REFERENCES users_info(user_id),
  CONSTRAINT achievement_medal_fk FOREIGN KEY (medal_type) REFERENCES medal(medal_type)
);
COMMENT ON TABLE achievement IS '用户获得勋章表';
COMMENT ON COLUMN achievement.user_id IS '用户id';
COMMENT ON COLUMN achievement.medal_type IS '勋章类型';
COMMENT ON COLUMN achievement.achieve_time IS '获得勋章时间';
/*2.5用户认证赛事*/

ALTER TABLE tournament_prize ADD CONSTRAINT unique_tournament_prize UNIQUE (prize_type, metal_type);

CREATE TABLE user_authentication (
  user_id NUMBER(10,0) NOT NULL,
  tournament_id NUMBER(10,0) NOT NULL,
  prize_type NUMBER(10) NOT NULL,
  metal_type NUMBER(10) NOT NULL,
  CONSTRAINT user_authentication_pk PRIMARY KEY (user_id, tournament_id, prize_type, metal_type),
  CONSTRAINT user_authentication_user_fk FOREIGN KEY (user_id) REFERENCES users_info(user_id),
  CONSTRAINT user_authentication_tournament_prize_fk1 FOREIGN KEY (tournament_id) REFERENCES tournament(tournament_id),
  CONSTRAINT user_authentication_tournament_prize_fk2 FOREIGN KEY (prize_type,metal_type) REFERENCES tournament_prize(prize_type,metal_type)
  --CONSTRAINT user_authentication_tournament_prize_fk3 FOREIGN KEY (metal_type) REFERENCES tournament_prize(metal_type)
);
COMMENT ON TABLE user_authentication IS '用户认证赛事表';
COMMENT ON COLUMN user_authentication.user_id IS '用户id';
COMMENT ON COLUMN user_authentication.tournament_id IS '赛事id';
COMMENT ON COLUMN user_authentication.prize_type IS '艇种';
COMMENT ON COLUMN user_authentication.metal_type IS '奖牌种类';
/*2.6俱乐部认证赛事*/
CREATE TABLE club_authentication (
  club_id NUMBER(10,0) NOT NULL,
  tournament_id NUMBER(10,0) NOT NULL,
  CONSTRAINT club_authentication_pk PRIMARY KEY (club_id, tournament_id),
  CONSTRAINT club_authentication_club_fk FOREIGN KEY (club_id) REFERENCES club(club_id),
  CONSTRAINT club_authentication_tournament_fk FOREIGN KEY (tournament_id) REFERENCES tournament(tournament_id)
);
COMMENT ON TABLE club_authentication IS '俱乐部认证赛事表';
COMMENT ON COLUMN club_authentication.club_id IS '俱乐部id';
COMMENT ON COLUMN club_authentication.tournament_id IS '赛事id';

/*2.7收藏动态*/
CREATE TABLE message_collection (
  message_id NUMBER(10,0) NOT NULL,
  message_type NUMBER(10) NOT NULL,
  user_id NUMBER(10,0) NOT NULL,
  collection_time TIMESTAMP DEFAULT SYSDATE NOT NULL,
  CONSTRAINT message_collection_pk PRIMARY KEY (message_id, message_type, user_id),
  CONSTRAINT message_collection_user_fk FOREIGN KEY (user_id) REFERENCES users_info(user_id),
  CONSTRAINT message_collection_messages_info_fk1 FOREIGN KEY (message_id,message_type) REFERENCES messages_info(message_id,message_type)
  --CONSTRAINT message_collection_messages_info_fk2 FOREIGN KEY (message_type) REFERENCES messages_info(message_type)
);
COMMENT ON TABLE message_collection IS '收藏动态表';
COMMENT ON COLUMN message_collection.message_id IS '动态/评论id，主键';
COMMENT ON COLUMN message_collection.message_type IS '类型，1表示动态，2表示评论';
COMMENT ON COLUMN message_collection.user_id IS '用户id';
COMMENT ON COLUMN message_collection.collection_time IS '收藏时间';

/*2.8点赞动态*/
CREATE TABLE message_like (
  message_id NUMBER(10,0) NOT NULL,
  message_type NUMBER(10) NOT NULL,
  user_id NUMBER(10,0) NOT NULL,
  like_time TIMESTAMP DEFAULT SYSDATE NOT NULL,
  like_status NUMBER(1) DEFAULT 0 NOT NULL,
  CONSTRAINT message_like_pk PRIMARY KEY (message_id, message_type, user_id),
  CONSTRAINT message_like_user_fk FOREIGN KEY (user_id) REFERENCES users_info(user_id),
  CONSTRAINT message_like_message_fk1 FOREIGN KEY (message_id,message_type) REFERENCES messages_info(message_id,message_type)
  --CONSTRAINT message_like_message_fk2 FOREIGN KEY (message_type) REFERENCES messages_info(message_type)
);
COMMENT ON TABLE message_like IS '用户点赞表';
COMMENT ON COLUMN message_like.message_id IS '动态/评论id';
COMMENT ON COLUMN message_like.message_type IS '类型，1表示动态，2表示评论';
COMMENT ON COLUMN message_like.user_id IS '用户id';
COMMENT ON COLUMN message_like.like_time IS '点赞时间';
COMMENT ON COLUMN message_like.like_status IS '点赞状态';
/*2.9管理员审核*/
CREATE TABLE message_check (
  message_id NUMBER(10,0) NOT NULL,
  message_type NUMBER(10) NOT NULL,
  administrator_id NUMBER(10,0),
  audit_date TIMESTAMP,
  audit_result VARCHAR2(20) CHECK (audit_result IN ('待审核', '审核通过', '审核不通过')),
  audit_reason VARCHAR2(64),
  CONSTRAINT message_check_pk PRIMARY KEY (message_id, message_type, administrator_id),
  CONSTRAINT message_check_administrator_fk FOREIGN KEY (administrator_id) REFERENCES administrator_info(administrator_id),
  CONSTRAINT message_check_messages_info_fk1 FOREIGN KEY (message_id,message_type) REFERENCES messages_info(message_id,message_type)
  --CONSTRAINT message_check_messages_info_fk2 FOREIGN KEY (message_type) REFERENCES messages_info(message_type)
);
COMMENT ON TABLE message_check IS '动态/评论审核表';
COMMENT ON COLUMN message_check.message_id IS '动态/评论id';
COMMENT ON COLUMN message_check.message_type IS '类型，1表示动态，2表示评论';
COMMENT ON COLUMN message_check.administrator_id IS '管理员id';
COMMENT ON COLUMN message_check.audit_date IS '审核时间';
COMMENT ON COLUMN message_check.audit_result IS '审核结果';
COMMENT ON COLUMN message_check.audit_reason IS '审核理由';

/*2.10用户举报信息*/
CREATE TABLE message_report (
  user_id NUMBER(10,0) NOT NULL,
  report_id NUMBER(10,0) NOT NULL,
  report_time TIMESTAMP DEFAULT SYSDATE NOT NULL,
  report_reason VARCHAR2(64),
  CONSTRAINT message_report_pk PRIMARY KEY (user_id, report_id),
  CONSTRAINT message_report_user_fk FOREIGN KEY (user_id) REFERENCES users_info(user_id),
  CONSTRAINT message_report_report_fk FOREIGN KEY (report_id) REFERENCES report_info(report_id)
);
COMMENT ON TABLE message_report IS '用户举报表';
COMMENT ON COLUMN message_report.user_id IS '用户id';
COMMENT ON COLUMN message_report.report_id IS '举报id';
COMMENT ON COLUMN message_report.report_time IS '举报时间';
COMMENT ON COLUMN message_report.report_reason IS '举报理由';

/*2.11举报信息动态评论*/
CREATE TABLE message_comment (
  message_id NUMBER(10,0) NOT NULL,
  message_type NUMBER(10) NOT NULL,
  report_id NUMBER(10,0) NOT NULL,
  CONSTRAINT message_comment_pk PRIMARY KEY (message_id, message_type, report_id),
  CONSTRAINT message_comment_report_fk FOREIGN KEY (report_id) REFERENCES report_info(report_id),
  CONSTRAINT message_comment_messages_info_fk1 FOREIGN KEY (message_id,message_type) REFERENCES messages_info(message_id,message_type)
  --CONSTRAINT message_comment_messages_info_fk2 FOREIGN KEY (message_type) REFERENCES messages_info(message_type)
);
COMMENT ON TABLE message_comment IS '动态/评论举报表';
COMMENT ON COLUMN message_comment.message_id IS '动态/评论id，主键';
COMMENT ON COLUMN message_comment.message_type IS '类型，1表示动态，2表示评论';
COMMENT ON COLUMN message_comment.report_id IS '举报id';

/*2.12管理员审核举报信息*/
CREATE TABLE report_check (
  administrator_id NUMBER(10,0) NOT NULL,
  report_id NUMBER(10,0) NOT NULL,
  report_result VARCHAR2(20) CHECK (report_result IN ('待审核', '审核通过', '审核不通过')),
  CONSTRAINT report_check_pk PRIMARY KEY (administrator_id, report_id),
  CONSTRAINT report_check_administrator_fk FOREIGN KEY (administrator_id) REFERENCES administrator_info(administrator_id),
  CONSTRAINT report_check_report_fk FOREIGN KEY (report_id) REFERENCES report_info(report_id)
);

COMMENT ON TABLE report_check IS '举报审核表';
COMMENT ON COLUMN report_check.administrator_id IS '管理员id';
COMMENT ON COLUMN report_check.report_id IS '举报id';
COMMENT ON COLUMN report_check.report_result IS '举报审核结果';

/*2.13用户发布动态/评论*/
CREATE TABLE message_post (
  user_id NUMBER(10,0) NOT NULL,
  message_id NUMBER(10,0) NOT NULL,
  message_type NUMBER(10) NOT NULL,
  comment_time TIMESTAMP DEFAULT SYSDATE NOT NULL,
  CONSTRAINT message_post_pk PRIMARY KEY (user_id, message_id, message_type),
  CONSTRAINT message_post_user_fk FOREIGN KEY (user_id) REFERENCES users_info(user_id),
  CONSTRAINT message_post_messages_info_fk1 FOREIGN KEY (message_id,message_type) REFERENCES messages_info(message_id,message_type)
  --CONSTRAINT message_post_messages_info_fk2 FOREIGN KEY (message_type) REFERENCES messages_info(message_type)
);

COMMENT ON TABLE message_post IS '用户评论表';
COMMENT ON COLUMN message_post.user_id IS '用户id';
COMMENT ON COLUMN message_post.message_id IS '动态/评论id';
COMMENT ON COLUMN message_post.message_type IS '类型，1表示动态，2表示评论';
COMMENT ON COLUMN message_post.comment_time IS '评论时间';

/*2.14用户管理训练记录*/
CREATE TABLE training_management (
  user_id NUMBER(10,0) NOT NULL,
  training_id NUMBER(10,0) NOT NULL,
  CONSTRAINT training_management_pk PRIMARY KEY (user_id, training_id),
  CONSTRAINT training_management_user_fk FOREIGN KEY (user_id) REFERENCES users_info(user_id)
);
COMMENT ON TABLE training_management IS '用户训练记录管理表';
COMMENT ON COLUMN training_management.user_id IS '用户id';
COMMENT ON COLUMN training_management.training_id IS '训练记录id';

--删除所有表和序列
/*drop table users_info purge;
drop table club purge;
drop table tournament_prize purge;
drop table tournament purge;
drop table medal purge;
drop table administrator_info purge;
drop table messages_info purge;
drop table training_record purge;
drop table training_plan purge;
drop table report_info purge;
drop table follow purge;
drop table blocks_info purge;
drop table user_club purge;
drop table achievement purge;
drop table user_authentication purge;
drop table club_authentication purge;
drop table message_collection purge;
drop table message_like purge;
drop table message_check purge;
drop table message_report purge;
drop table message_post purge;
drop table training_management purge;
drop table report_check purge;
drop table message_comment purge;
drop SEQUENCE seq_administrator_info;
drop  SEQUENCE seq_club;
drop  SEQUENCE seq_messages_info;
drop  SEQUENCE seq_report;
drop  SEQUENCE seq_tournament;
drop  SEQUENCE seq_training_plan;
drop  SEQUENCE seq_training_record;
drop  SEQUENCE seq_users_info;
create table ABC(
  AID NUMBER(10),
  ANAME VARCHAR(20)
  )
  
  INSERT INTO ABC VALUES(1,'2323');
  create TABLE messages_info (
  message_id NUMBER(10,0) NOT NULL,
  message_type NUMBER(10) NOT NULL,
  message_content VARCHAR(1024) NOT NULL,
  photo_url list_photo
);
insert into messages_info values(1,1,'123123',list_photo('ss','ssssssssssss'))
  */
