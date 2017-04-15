/*
Navicat PGSQL Data Transfer

Source Server         : pgsql10.10.3.118
Source Server Version : 90405
Source Host           : 10.10.3.118:5432
Source Database       : kms
Source Schema         : public

Target Server Type    : PGSQL
Target Server Version : 90405
File Encoding         : 65001

Date: 2016-01-19 16:34:19
*/


-- ----------------------------
-- Table structure for act_ge_bytearray
-- ----------------------------
DROP TABLE IF EXISTS "act_ge_bytearray";
CREATE TABLE "act_ge_bytearray" (
"id_" varchar(64) COLLATE "default" NOT NULL,
"rev_" int4,
"name_" varchar(255) COLLATE "default",
"deployment_id_" varchar(64) COLLATE "default",
"bytes_" bytea,
"generated_" bool
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of act_ge_bytearray
-- ----------------------------

-- ----------------------------
-- Table structure for act_ge_property
-- ----------------------------
DROP TABLE IF EXISTS "act_ge_property";
CREATE TABLE "act_ge_property" (
"name_" varchar(64) COLLATE "default" NOT NULL,
"value_" varchar(300) COLLATE "default",
"rev_" numeric
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of act_ge_property
-- ----------------------------
INSERT INTO "act_ge_property" VALUES ('next.dbid', '1', '1');
INSERT INTO "act_ge_property" VALUES ('schema.history', 'create(5.15.1)', '1');
INSERT INTO "act_ge_property" VALUES ('schema.version', '5.15.1', '1');

-- ----------------------------
-- Table structure for act_hi_actinst
-- ----------------------------
DROP TABLE IF EXISTS "act_hi_actinst";
CREATE TABLE "act_hi_actinst" (
"id_" varchar(64) COLLATE "default" NOT NULL,
"proc_def_id_" varchar(64) COLLATE "default" NOT NULL,
"proc_inst_id_" varchar(64) COLLATE "default" NOT NULL,
"execution_id_" varchar(64) COLLATE "default" NOT NULL,
"act_id_" varchar(255) COLLATE "default" NOT NULL,
"task_id_" varchar(64) COLLATE "default",
"call_proc_inst_id_" varchar(64) COLLATE "default",
"act_name_" varchar(255) COLLATE "default",
"act_type_" varchar(255) COLLATE "default" NOT NULL,
"assignee_" varchar(255) COLLATE "default",
"start_time_" timestamp(6) NOT NULL,
"end_time_" timestamp(6),
"duration_" numeric(19),
"tenant_id_" varchar(255) COLLATE "default"
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of act_hi_actinst
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_attachment
-- ----------------------------
DROP TABLE IF EXISTS "act_hi_attachment";
CREATE TABLE "act_hi_attachment" (
"id_" varchar(64) COLLATE "default" NOT NULL,
"rev_" numeric,
"user_id_" varchar(255) COLLATE "default",
"name_" varchar(255) COLLATE "default",
"description_" varchar(2000) COLLATE "default",
"type_" varchar(255) COLLATE "default",
"task_id_" varchar(64) COLLATE "default",
"proc_inst_id_" varchar(64) COLLATE "default",
"url_" varchar(2000) COLLATE "default",
"content_id_" varchar(64) COLLATE "default"
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of act_hi_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_comment
-- ----------------------------
DROP TABLE IF EXISTS "act_hi_comment";
CREATE TABLE "act_hi_comment" (
"id_" varchar(64) COLLATE "default" NOT NULL,
"type_" varchar(255) COLLATE "default",
"time_" timestamp(6) NOT NULL,
"user_id_" varchar(255) COLLATE "default",
"task_id_" varchar(64) COLLATE "default",
"proc_inst_id_" varchar(64) COLLATE "default",
"action_" varchar(255) COLLATE "default",
"message_" varchar(2000) COLLATE "default",
"full_msg_" bytea
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of act_hi_comment
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_detail
-- ----------------------------
DROP TABLE IF EXISTS "act_hi_detail";
CREATE TABLE "act_hi_detail" (
"id_" varchar(64) COLLATE "default" NOT NULL,
"type_" varchar(255) COLLATE "default" NOT NULL,
"proc_inst_id_" varchar(64) COLLATE "default",
"execution_id_" varchar(64) COLLATE "default",
"task_id_" varchar(64) COLLATE "default",
"act_inst_id_" varchar(64) COLLATE "default",
"name_" varchar(255) COLLATE "default" NOT NULL,
"var_type_" varchar(64) COLLATE "default",
"rev_" numeric,
"time_" timestamp(6) NOT NULL,
"bytearray_id_" varchar(64) COLLATE "default",
"double_" numeric(10,10),
"long_" numeric(19),
"text_" varchar(2000) COLLATE "default",
"text2_" varchar(2000) COLLATE "default"
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of act_hi_detail
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_identitylink
-- ----------------------------
DROP TABLE IF EXISTS "act_hi_identitylink";
CREATE TABLE "act_hi_identitylink" (
"id_" varchar(64) COLLATE "default" NOT NULL,
"group_id_" varchar(255) COLLATE "default",
"type_" varchar(255) COLLATE "default",
"user_id_" varchar(255) COLLATE "default",
"task_id_" varchar(64) COLLATE "default",
"proc_inst_id_" varchar(64) COLLATE "default"
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of act_hi_identitylink
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_procinst
-- ----------------------------
DROP TABLE IF EXISTS "act_hi_procinst";
CREATE TABLE "act_hi_procinst" (
"id_" varchar(64) COLLATE "default" NOT NULL,
"proc_inst_id_" varchar(64) COLLATE "default" NOT NULL,
"business_key_" varchar(255) COLLATE "default",
"proc_def_id_" varchar(64) COLLATE "default" NOT NULL,
"start_time_" timestamp(6) NOT NULL,
"end_time_" timestamp(6),
"duration_" numeric(19),
"start_user_id_" varchar(255) COLLATE "default",
"start_act_id_" varchar(255) COLLATE "default",
"end_act_id_" varchar(255) COLLATE "default",
"super_process_instance_id_" varchar(64) COLLATE "default",
"delete_reason_" varchar(2000) COLLATE "default",
"tenant_id_" varchar(255) COLLATE "default"
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of act_hi_procinst
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_taskinst
-- ----------------------------
DROP TABLE IF EXISTS "act_hi_taskinst";
CREATE TABLE "act_hi_taskinst" (
"id_" varchar(64) COLLATE "default" NOT NULL,
"proc_def_id_" varchar(64) COLLATE "default",
"task_def_key_" varchar(255) COLLATE "default",
"proc_inst_id_" varchar(64) COLLATE "default",
"execution_id_" varchar(64) COLLATE "default",
"parent_task_id_" varchar(64) COLLATE "default",
"name_" varchar(255) COLLATE "default",
"description_" varchar(2000) COLLATE "default",
"owner_" varchar(255) COLLATE "default",
"assignee_" varchar(255) COLLATE "default",
"start_time_" timestamp(6) NOT NULL,
"claim_time_" timestamp(6),
"end_time_" timestamp(6),
"duration_" numeric(19),
"delete_reason_" varchar(2000) COLLATE "default",
"priority_" numeric,
"due_date_" timestamp(6),
"form_key_" varchar(255) COLLATE "default",
"category_" varchar(255) COLLATE "default",
"tenant_id_" varchar(255) COLLATE "default"
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of act_hi_taskinst
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_varinst
-- ----------------------------
DROP TABLE IF EXISTS "act_hi_varinst";
CREATE TABLE "act_hi_varinst" (
"id_" varchar(64) COLLATE "default" NOT NULL,
"proc_inst_id_" varchar(64) COLLATE "default",
"execution_id_" varchar(64) COLLATE "default",
"task_id_" varchar(64) COLLATE "default",
"name_" varchar(255) COLLATE "default" NOT NULL,
"var_type_" varchar(100) COLLATE "default",
"rev_" numeric,
"bytearray_id_" varchar(64) COLLATE "default",
"double_" numeric(10,10),
"long_" numeric(19),
"text_" varchar(2000) COLLATE "default",
"text2_" varchar(2000) COLLATE "default",
"create_time_" timestamp(6),
"last_updated_time_" timestamp(6)
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of act_hi_varinst
-- ----------------------------

-- ----------------------------
-- Table structure for act_id_group
-- ----------------------------
DROP TABLE IF EXISTS "act_id_group";
CREATE TABLE "act_id_group" (
"id_" varchar(64) COLLATE "default" NOT NULL,
"rev_" numeric,
"name_" varchar(255) COLLATE "default",
"type_" varchar(255) COLLATE "default"
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of act_id_group
-- ----------------------------

-- ----------------------------
-- Table structure for act_id_info
-- ----------------------------
DROP TABLE IF EXISTS "act_id_info";
CREATE TABLE "act_id_info" (
"id_" varchar(64) COLLATE "default" NOT NULL,
"rev_" numeric,
"user_id_" varchar(64) COLLATE "default",
"type_" varchar(64) COLLATE "default",
"key_" varchar(255) COLLATE "default",
"value_" varchar(255) COLLATE "default",
"password_" bytea,
"parent_id_" varchar(255) COLLATE "default"
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of act_id_info
-- ----------------------------

-- ----------------------------
-- Table structure for act_id_membership
-- ----------------------------
DROP TABLE IF EXISTS "act_id_membership";
CREATE TABLE "act_id_membership" (
"user_id_" varchar(64) COLLATE "default" NOT NULL,
"group_id_" varchar(64) COLLATE "default" NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of act_id_membership
-- ----------------------------

-- ----------------------------
-- Table structure for act_id_user
-- ----------------------------
DROP TABLE IF EXISTS "act_id_user";
CREATE TABLE "act_id_user" (
"id_" varchar(64) COLLATE "default" NOT NULL,
"rev_" numeric,
"first_" varchar(255) COLLATE "default",
"last_" varchar(255) COLLATE "default",
"email_" varchar(255) COLLATE "default",
"pwd_" varchar(255) COLLATE "default",
"picture_id_" varchar(64) COLLATE "default"
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of act_id_user
-- ----------------------------

-- ----------------------------
-- Table structure for act_re_deployment
-- ----------------------------
DROP TABLE IF EXISTS "act_re_deployment";
CREATE TABLE "act_re_deployment" (
"id_" varchar(64) COLLATE "default" NOT NULL,
"name_" varchar(255) COLLATE "default",
"category_" varchar(255) COLLATE "default",
"tenant_id_" varchar(255) COLLATE "default",
"deploy_time_" timestamp(6)
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of act_re_deployment
-- ----------------------------
INSERT INTO "act_re_deployment" VALUES ('469efa7803134cf8a3abfe4a69e8fc1a', 'SpringAutoDeployment', null, null, '2015-10-15 10:21:01');
INSERT INTO "act_re_deployment" VALUES ('4dc8950f83a3409db426ffa3449e5fe0', 'SpringAutoDeployment', null, null, '2015-10-13 10:46:04');
INSERT INTO "act_re_deployment" VALUES ('51a09233e76047d190bf9d076b91c41c', 'SpringAutoDeployment', null, null, '2015-11-30 14:05:01');
INSERT INTO "act_re_deployment" VALUES ('84921ef778374fbaa592cd9279f89ba7', 'SpringAutoDeployment', null, null, '2015-10-23 13:00:05');
INSERT INTO "act_re_deployment" VALUES ('bef160230c334960a9359fb4dcf82dbf', 'SpringAutoDeployment', null, null, '2015-11-18 12:46:01');

-- ----------------------------
-- Table structure for act_re_model
-- ----------------------------
DROP TABLE IF EXISTS "act_re_model";
CREATE TABLE "act_re_model" (
"id_" varchar(64) COLLATE "default" NOT NULL,
"rev_" numeric,
"name_" varchar(255) COLLATE "default",
"key_" varchar(255) COLLATE "default",
"category_" varchar(255) COLLATE "default",
"create_time_" timestamp(6),
"last_update_time_" timestamp(6),
"version_" numeric,
"meta_info_" varchar(2000) COLLATE "default",
"deployment_id_" varchar(64) COLLATE "default",
"editor_source_value_id_" varchar(64) COLLATE "default",
"editor_source_extra_value_id_" varchar(64) COLLATE "default",
"tenant_id_" varchar(255) COLLATE "default"
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of act_re_model
-- ----------------------------

-- ----------------------------
-- Table structure for act_re_procdef
-- ----------------------------
DROP TABLE IF EXISTS "act_re_procdef";
CREATE TABLE "act_re_procdef" (
"id_" varchar(64) COLLATE "default" NOT NULL,
"rev_" int4,
"category_" varchar(255) COLLATE "default",
"name_" varchar(255) COLLATE "default",
"key_" varchar(255) COLLATE "default" NOT NULL,
"version_" int4 NOT NULL,
"deployment_id_" varchar(64) COLLATE "default",
"resource_name_" varchar(4000) COLLATE "default",
"dgrm_resource_name_" varchar(4000) COLLATE "default",
"description_" varchar(4000) COLLATE "default",
"has_start_form_key_" bool,
"suspension_state_" int4,
"tenant_id_" varchar(255) COLLATE "default" DEFAULT ''::character varying
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of act_re_procdef
-- ----------------------------
INSERT INTO "act_re_procdef" VALUES ('test_audit:1:a20fa565418f49e5a5d4f2135282ca46', '1', 'http://www.activiti.org/test', '流程审批测试流程', 'test_audit', '1', '4dc8950f83a3409db426ffa3449e5fe0', 'test_audit.bpmn20.xml', 'test_audit.png', null, 't', '1', null);
INSERT INTO "act_re_procdef" VALUES ('test_audit:2:ad4a5301626d4b2cb740adce16db92dd', '1', 'http://www.activiti.org/test', '流程审批测试流程', 'test_audit', '2', '469efa7803134cf8a3abfe4a69e8fc1a', 'test_audit.bpmn20.xml', 'test_audit.png', null, 't', '1', null);
INSERT INTO "act_re_procdef" VALUES ('test_audit:3:a6992d6ff0aa4008996809a0454f84e3', '1', 'http://www.activiti.org/test', '流程审批测试流程', 'test_audit', '3', '84921ef778374fbaa592cd9279f89ba7', 'test_audit.bpmn20.xml', 'test_audit.png', null, 't', '1', null);
INSERT INTO "act_re_procdef" VALUES ('test_audit:4:2d9f3d363fe84db983d5d74fa58163e7', '1', 'http://www.activiti.org/test', '流程审批测试流程', 'test_audit', '4', 'bef160230c334960a9359fb4dcf82dbf', 'test_audit.bpmn20.xml', 'test_audit.png', null, 't', '1', null);
INSERT INTO "act_re_procdef" VALUES ('test_audit:5:95f56bcb6ee145da9294beb476bbc972', '1', 'http://www.activiti.org/test', '流程审批测试流程', 'test_audit', '5', '51a09233e76047d190bf9d076b91c41c', 'test_audit.bpmn20.xml', 'test_audit.png', null, 't', '1', null);

-- ----------------------------
-- Table structure for act_ru_event_subscr
-- ----------------------------
DROP TABLE IF EXISTS "act_ru_event_subscr";
CREATE TABLE "act_ru_event_subscr" (
"id_" varchar(64) COLLATE "default" NOT NULL,
"rev_" numeric,
"event_type_" varchar(255) COLLATE "default" NOT NULL,
"event_name_" varchar(255) COLLATE "default",
"execution_id_" varchar(64) COLLATE "default",
"proc_inst_id_" varchar(64) COLLATE "default",
"activity_id_" varchar(64) COLLATE "default",
"configuration_" varchar(255) COLLATE "default",
"created_" timestamp(6) NOT NULL,
"proc_def_id_" varchar(64) COLLATE "default",
"tenant_id_" varchar(255) COLLATE "default"
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of act_ru_event_subscr
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_execution
-- ----------------------------
DROP TABLE IF EXISTS "act_ru_execution";
CREATE TABLE "act_ru_execution" (
"id_" varchar(64) COLLATE "default" NOT NULL,
"rev_" int4,
"proc_inst_id_" varchar(64) COLLATE "default",
"business_key_" varchar(255) COLLATE "default",
"parent_id_" varchar(64) COLLATE "default",
"proc_def_id_" varchar(64) COLLATE "default",
"super_exec_" varchar(64) COLLATE "default",
"act_id_" varchar(255) COLLATE "default",
"is_active_" bool,
"is_concurrent_" bool,
"is_scope_" bool,
"is_event_scope_" bool,
"suspension_state_" int4,
"cached_ent_state_" int4,
"tenant_id_" varchar(255) COLLATE "default" DEFAULT ''::character varying
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of act_ru_execution
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_identitylink
-- ----------------------------
DROP TABLE IF EXISTS "act_ru_identitylink";
CREATE TABLE "act_ru_identitylink" (
"id_" varchar(64) COLLATE "default" NOT NULL,
"rev_" numeric,
"group_id_" varchar(255) COLLATE "default",
"type_" varchar(255) COLLATE "default",
"user_id_" varchar(255) COLLATE "default",
"task_id_" varchar(64) COLLATE "default",
"proc_inst_id_" varchar(64) COLLATE "default",
"proc_def_id_" varchar(64) COLLATE "default"
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of act_ru_identitylink
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_job
-- ----------------------------
DROP TABLE IF EXISTS "act_ru_job";
CREATE TABLE "act_ru_job" (
"id_" varchar(64) COLLATE "default" NOT NULL,
"rev_" numeric,
"type_" varchar(255) COLLATE "default" NOT NULL,
"lock_exp_time_" timestamp(6),
"lock_owner_" varchar(255) COLLATE "default",
"exclusive_" numeric(1),
"execution_id_" varchar(64) COLLATE "default",
"process_instance_id_" varchar(64) COLLATE "default",
"proc_def_id_" varchar(64) COLLATE "default",
"retries_" numeric,
"exception_stack_id_" varchar(64) COLLATE "default",
"exception_msg_" varchar(2000) COLLATE "default",
"duedate_" timestamp(6),
"repeat_" varchar(255) COLLATE "default",
"handler_type_" varchar(255) COLLATE "default",
"handler_cfg_" varchar(2000) COLLATE "default",
"tenant_id_" varchar(255) COLLATE "default"
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of act_ru_job
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_task
-- ----------------------------
DROP TABLE IF EXISTS "act_ru_task";
CREATE TABLE "act_ru_task" (
"id_" varchar(64) COLLATE "default" NOT NULL,
"rev_" numeric,
"execution_id_" varchar(64) COLLATE "default",
"proc_inst_id_" varchar(64) COLLATE "default",
"proc_def_id_" varchar(64) COLLATE "default",
"name_" varchar(255) COLLATE "default",
"parent_task_id_" varchar(64) COLLATE "default",
"description_" varchar(2000) COLLATE "default",
"task_def_key_" varchar(255) COLLATE "default",
"owner_" varchar(255) COLLATE "default",
"assignee_" varchar(255) COLLATE "default",
"delegation_" varchar(64) COLLATE "default",
"priority_" numeric,
"create_time_" timestamp(6),
"due_date_" timestamp(6),
"category_" varchar(255) COLLATE "default",
"suspension_state_" numeric,
"tenant_id_" varchar(255) COLLATE "default"
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of act_ru_task
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_variable
-- ----------------------------
DROP TABLE IF EXISTS "act_ru_variable";
CREATE TABLE "act_ru_variable" (
"id_" varchar(64) COLLATE "default" NOT NULL,
"rev_" numeric,
"type_" varchar(255) COLLATE "default" NOT NULL,
"name_" varchar(255) COLLATE "default" NOT NULL,
"execution_id_" varchar(64) COLLATE "default",
"proc_inst_id_" varchar(64) COLLATE "default",
"task_id_" varchar(64) COLLATE "default",
"bytearray_id_" varchar(64) COLLATE "default",
"double_" numeric(10,10),
"long_" numeric(19),
"text_" varchar(2000) COLLATE "default",
"text2_" varchar(2000) COLLATE "default"
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of act_ru_variable
-- ----------------------------

-- ----------------------------
-- Table structure for cms_article
-- ----------------------------
DROP TABLE IF EXISTS "cms_article";
CREATE TABLE "cms_article" (
"id" varchar(64) COLLATE "default" NOT NULL,
"category_id" varchar(64) COLLATE "default" NOT NULL,
"title" varchar(255) COLLATE "default" NOT NULL,
"link" varchar(255) COLLATE "default",
"color" varchar(50) COLLATE "default",
"image" varchar(255) COLLATE "default",
"keywords" varchar(255) COLLATE "default",
"description" varchar(255) COLLATE "default",
"weight" int8 DEFAULT 0,
"weight_date" timestamp(6),
"hits" int8 DEFAULT 0,
"posid" varchar(10) COLLATE "default",
"custom_content_view" varchar(255) COLLATE "default",
"view_config" text COLLATE "default",
"create_by" varchar(64) COLLATE "default",
"create_date" timestamp(6),
"update_by" varchar(64) COLLATE "default",
"update_date" timestamp(6),
"remarks" varchar(255) COLLATE "default",
"del_flag" char(1) COLLATE "default" DEFAULT '0'::bpchar NOT NULL,
"label_list" varchar(500) COLLATE "default"
)
WITH (OIDS=FALSE)

;
COMMENT ON TABLE "cms_article" IS '文章表';
COMMENT ON COLUMN "cms_article"."id" IS '编号';
COMMENT ON COLUMN "cms_article"."category_id" IS '栏目编号';
COMMENT ON COLUMN "cms_article"."title" IS '标题';
COMMENT ON COLUMN "cms_article"."link" IS '文章链接';
COMMENT ON COLUMN "cms_article"."color" IS '标题颜色';
COMMENT ON COLUMN "cms_article"."image" IS '文章图片';
COMMENT ON COLUMN "cms_article"."keywords" IS '关键字';
COMMENT ON COLUMN "cms_article"."description" IS '描述、摘要';
COMMENT ON COLUMN "cms_article"."weight" IS '权重，越大越靠前';
COMMENT ON COLUMN "cms_article"."weight_date" IS '权重期限';
COMMENT ON COLUMN "cms_article"."hits" IS '点击数';
COMMENT ON COLUMN "cms_article"."posid" IS '推荐位，多选';
COMMENT ON COLUMN "cms_article"."custom_content_view" IS '自定义内容视图';
COMMENT ON COLUMN "cms_article"."view_config" IS '视图配置';
COMMENT ON COLUMN "cms_article"."create_by" IS '创建者';
COMMENT ON COLUMN "cms_article"."create_date" IS '创建时间';
COMMENT ON COLUMN "cms_article"."update_by" IS '更新者';
COMMENT ON COLUMN "cms_article"."update_date" IS '更新时间';
COMMENT ON COLUMN "cms_article"."remarks" IS '备注信息';
COMMENT ON COLUMN "cms_article"."del_flag" IS '删除标记';
COMMENT ON COLUMN "cms_article"."label_list" IS '知识关联的标签列表';

-- ----------------------------
-- Records of cms_article
-- ----------------------------

-- ----------------------------
-- Table structure for cms_article_att_file
-- ----------------------------
DROP TABLE IF EXISTS "cms_article_att_file";
CREATE TABLE "cms_article_att_file" (
"id" varchar(64) COLLATE "default" NOT NULL,
"acticle_id" varchar(64) COLLATE "default",
"att_file_time" varchar(150) COLLATE "default",
"att_file_name" varchar(100) COLLATE "default",
"att_file_size" varchar(255) COLLATE "default",
"att_file_type" varchar(64) COLLATE "default",
"create_by" varchar(64) COLLATE "default",
"create_date" timestamp(6),
"update_by" varchar(64) COLLATE "default",
"update_date" timestamp(6),
"att_file_key" varchar(255) COLLATE "default",
"del_flag" char(1) COLLATE "default" DEFAULT '0'::bpchar,
"attfile_temp_guid" varchar(64) COLLATE "default",
"ispostarticle" char(1) COLLATE "default" DEFAULT '0'::bpchar
)
WITH (OIDS=FALSE)

;
COMMENT ON COLUMN "cms_article_att_file"."acticle_id" IS '文章ID';
COMMENT ON COLUMN "cms_article_att_file"."att_file_time" IS '附件时间戳';
COMMENT ON COLUMN "cms_article_att_file"."att_file_name" IS '附件原始名';
COMMENT ON COLUMN "cms_article_att_file"."att_file_size" IS '附件大小';
COMMENT ON COLUMN "cms_article_att_file"."att_file_type" IS '附件类型';
COMMENT ON COLUMN "cms_article_att_file"."create_by" IS '作者';
COMMENT ON COLUMN "cms_article_att_file"."update_by" IS '作者';
COMMENT ON COLUMN "cms_article_att_file"."att_file_key" IS 'OSSkey值';
COMMENT ON COLUMN "cms_article_att_file"."del_flag" IS '0正常1删除';
COMMENT ON COLUMN "cms_article_att_file"."attfile_temp_guid" IS '指定上传点';
COMMENT ON COLUMN "cms_article_att_file"."ispostarticle" IS '0文章未保存';

-- ----------------------------
-- Records of cms_article_att_file
-- ----------------------------

-- ----------------------------
-- Table structure for cms_article_count
-- ----------------------------
DROP TABLE IF EXISTS "cms_article_count";
CREATE TABLE "cms_article_count" (
"article_id" varchar(500) COLLATE "default" NOT NULL,
"article_title" varchar(500) COLLATE "default",
"count_click" int8,
"count_reco" int8,
"count_comm" int8,
"count_share" int8,
"count_collect" int8
)
WITH (OIDS=FALSE)

;
COMMENT ON COLUMN "cms_article_count"."article_id" IS '知识id';
COMMENT ON COLUMN "cms_article_count"."article_title" IS '文章标题';
COMMENT ON COLUMN "cms_article_count"."count_click" IS '点击数';
COMMENT ON COLUMN "cms_article_count"."count_reco" IS '推荐数';
COMMENT ON COLUMN "cms_article_count"."count_comm" IS '评论数';
COMMENT ON COLUMN "cms_article_count"."count_share" IS '分享数';
COMMENT ON COLUMN "cms_article_count"."count_collect" IS '收藏数';

-- ----------------------------
-- Records of cms_article_count
-- ----------------------------

-- ----------------------------
-- Table structure for cms_article_data
-- ----------------------------
DROP TABLE IF EXISTS "cms_article_data";
CREATE TABLE "cms_article_data" (
"id" varchar(64) COLLATE "default" NOT NULL,
"content" text COLLATE "default",
"copyfrom" varchar(255) COLLATE "default",
"relation" varchar(255) COLLATE "default",
"allow_comment" char(1) COLLATE "default",
"allow_share" char(1) COLLATE "default" DEFAULT '0'::bpchar,
"isallowdownload" char(1) COLLATE "default" DEFAULT '1'::bpchar,
"attfile_number" varchar(20) COLLATE "default" DEFAULT '0'::character varying
)
WITH (OIDS=FALSE)

;
COMMENT ON TABLE "cms_article_data" IS '文章详表';
COMMENT ON COLUMN "cms_article_data"."id" IS '编号';
COMMENT ON COLUMN "cms_article_data"."content" IS '文章内容';
COMMENT ON COLUMN "cms_article_data"."copyfrom" IS '文章来源';
COMMENT ON COLUMN "cms_article_data"."relation" IS '相关文章';
COMMENT ON COLUMN "cms_article_data"."allow_comment" IS '是否允许评论';
COMMENT ON COLUMN "cms_article_data"."allow_share" IS '是否允许分享';
COMMENT ON COLUMN "cms_article_data"."isallowdownload" IS '1:允许下载';
COMMENT ON COLUMN "cms_article_data"."attfile_number" IS '文章附件数';

-- ----------------------------
-- Records of cms_article_data
-- ----------------------------

-- ----------------------------
-- Table structure for cms_category
-- ----------------------------
DROP TABLE IF EXISTS "cms_category";
CREATE TABLE "cms_category" (
"id" varchar(64) COLLATE "default" NOT NULL,
"parent_id" varchar(64) COLLATE "default" NOT NULL,
"parent_ids" varchar(2000) COLLATE "default" NOT NULL,
"site_id" varchar(64) COLLATE "default" DEFAULT '1'::character varying,
"office_id" varchar(64) COLLATE "default",
"module" varchar(20) COLLATE "default",
"name" varchar(100) COLLATE "default" NOT NULL,
"image" varchar(255) COLLATE "default",
"href" varchar(255) COLLATE "default",
"target" varchar(20) COLLATE "default",
"description" varchar(255) COLLATE "default",
"keywords" varchar(255) COLLATE "default",
"sort" int8 DEFAULT 30,
"in_menu" char(1) COLLATE "default" DEFAULT '1'::bpchar,
"in_list" char(1) COLLATE "default" DEFAULT '1'::bpchar,
"show_modes" char(1) COLLATE "default" DEFAULT '0'::bpchar,
"allow_comment" char(1) COLLATE "default",
"is_audit" char(1) COLLATE "default",
"custom_list_view" varchar(255) COLLATE "default",
"custom_content_view" varchar(255) COLLATE "default",
"view_config" text COLLATE "default",
"create_by" varchar(64) COLLATE "default",
"create_date" timestamp(6),
"update_by" varchar(64) COLLATE "default",
"update_date" timestamp(6),
"remarks" varchar(255) COLLATE "default",
"del_flag" char(1) COLLATE "default" DEFAULT '0'::bpchar NOT NULL
)
WITH (OIDS=FALSE)

;
COMMENT ON TABLE "cms_category" IS '栏目表';
COMMENT ON COLUMN "cms_category"."id" IS '编号';
COMMENT ON COLUMN "cms_category"."parent_id" IS '父级编号';
COMMENT ON COLUMN "cms_category"."parent_ids" IS '所有父级编号';
COMMENT ON COLUMN "cms_category"."site_id" IS '站点编号';
COMMENT ON COLUMN "cms_category"."office_id" IS '归属机构';
COMMENT ON COLUMN "cms_category"."module" IS '栏目模块';
COMMENT ON COLUMN "cms_category"."name" IS '栏目名称';
COMMENT ON COLUMN "cms_category"."image" IS '栏目图片';
COMMENT ON COLUMN "cms_category"."href" IS '链接';
COMMENT ON COLUMN "cms_category"."target" IS '目标';
COMMENT ON COLUMN "cms_category"."description" IS '描述';
COMMENT ON COLUMN "cms_category"."keywords" IS '关键字';
COMMENT ON COLUMN "cms_category"."sort" IS '排序（升序）';
COMMENT ON COLUMN "cms_category"."in_menu" IS '是否在导航中显示';
COMMENT ON COLUMN "cms_category"."in_list" IS '是否在分类页中显示列表';
COMMENT ON COLUMN "cms_category"."show_modes" IS '展现方式';
COMMENT ON COLUMN "cms_category"."allow_comment" IS '是否允许评论';
COMMENT ON COLUMN "cms_category"."is_audit" IS '是否需要审核';
COMMENT ON COLUMN "cms_category"."custom_list_view" IS '自定义列表视图';
COMMENT ON COLUMN "cms_category"."custom_content_view" IS '自定义内容视图';
COMMENT ON COLUMN "cms_category"."view_config" IS '视图配置';
COMMENT ON COLUMN "cms_category"."create_by" IS '创建者';
COMMENT ON COLUMN "cms_category"."create_date" IS '创建时间';
COMMENT ON COLUMN "cms_category"."update_by" IS '更新者';
COMMENT ON COLUMN "cms_category"."update_date" IS '更新时间';
COMMENT ON COLUMN "cms_category"."remarks" IS '备注信息';
COMMENT ON COLUMN "cms_category"."del_flag" IS '删除标记';

-- ----------------------------
-- Records of cms_category
-- ----------------------------
INSERT INTO "cms_category" VALUES ('1', '0', '0,', '0', '1', null, '顶级栏目', null, null, null, null, null, '0', '1', '1', '0', '0', '1', null, null, null, '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');



-- ----------------------------
-- Table structure for cms_comment
-- ----------------------------
DROP TABLE IF EXISTS "cms_comment";
CREATE TABLE "cms_comment" (
"id" varchar(64) COLLATE "default" NOT NULL,
"category_id" varchar(64) COLLATE "default" NOT NULL,
"content_id" varchar(64) COLLATE "default" NOT NULL,
"title" varchar(255) COLLATE "default",
"content" varchar(255) COLLATE "default",
"name" varchar(100) COLLATE "default",
"ip" varchar(100) COLLATE "default",
"create_date" timestamp(6) NOT NULL,
"audit_user_id" varchar(64) COLLATE "default",
"audit_date" timestamp(6),
"del_flag" char(1) COLLATE "default" DEFAULT '0'::bpchar NOT NULL,
"article_creater" varchar(60) COLLATE "default",
"article_creater_id" varchar(60) COLLATE "default",
"name_id" varchar(60) COLLATE "default"
)
WITH (OIDS=FALSE)

;
COMMENT ON TABLE "cms_comment" IS '评论表';
COMMENT ON COLUMN "cms_comment"."id" IS '编号';
COMMENT ON COLUMN "cms_comment"."category_id" IS '栏目编号';
COMMENT ON COLUMN "cms_comment"."content_id" IS '栏目内容的编号';
COMMENT ON COLUMN "cms_comment"."title" IS '栏目内容的标题';
COMMENT ON COLUMN "cms_comment"."content" IS '评论内容';
COMMENT ON COLUMN "cms_comment"."name" IS '评论姓名';
COMMENT ON COLUMN "cms_comment"."ip" IS '评论IP';
COMMENT ON COLUMN "cms_comment"."create_date" IS '评论时间';
COMMENT ON COLUMN "cms_comment"."audit_user_id" IS '审核人';
COMMENT ON COLUMN "cms_comment"."audit_date" IS '审核时间';
COMMENT ON COLUMN "cms_comment"."del_flag" IS '删除标记';
COMMENT ON COLUMN "cms_comment"."article_creater" IS '文章创建人';
COMMENT ON COLUMN "cms_comment"."article_creater_id" IS '文章创建人ID';
COMMENT ON COLUMN "cms_comment"."name_id" IS '评论人ID';

-- ----------------------------
-- Records of cms_comment
-- ----------------------------

-- ----------------------------
-- Table structure for cms_depart_contribution
-- ----------------------------
DROP TABLE IF EXISTS "cms_depart_contribution";
CREATE TABLE "cms_depart_contribution" (
"office_id" varchar(500) COLLATE "default" NOT NULL,
"office_value" varchar(500) COLLATE "default",
"count_article" int8
)
WITH (OIDS=FALSE)

;
COMMENT ON COLUMN "cms_depart_contribution"."office_id" IS '部门的id';
COMMENT ON COLUMN "cms_depart_contribution"."office_value" IS '部门名';
COMMENT ON COLUMN "cms_depart_contribution"."count_article" IS '整个部门贡献的知识数';

-- ----------------------------
-- Records of cms_depart_contribution
-- ----------------------------

-- ----------------------------
-- Table structure for cms_frontswitch
-- ----------------------------
DROP TABLE IF EXISTS "cms_frontswitch";
CREATE TABLE "cms_frontswitch" (
"id" varchar(20) COLLATE "default" NOT NULL,
"article_url" varchar(300) COLLATE "default",
"image_url" varchar(300) COLLATE "default",
"update_date" timestamp(6),
"update_by" varchar(64) COLLATE "default",
"del_flag" varchar(20) COLLATE "default",
"topic_word" varchar(300) COLLATE "default",
"detail_explanation" varchar(300) COLLATE "default"
)
WITH (OIDS=FALSE)

;
COMMENT ON COLUMN "cms_frontswitch"."article_url" IS '知识链接';
COMMENT ON COLUMN "cms_frontswitch"."image_url" IS '图片路径';
COMMENT ON COLUMN "cms_frontswitch"."update_date" IS '修改时间';
COMMENT ON COLUMN "cms_frontswitch"."update_by" IS '修改人';
COMMENT ON COLUMN "cms_frontswitch"."del_flag" IS '状态';
COMMENT ON COLUMN "cms_frontswitch"."topic_word" IS '主题概要';
COMMENT ON COLUMN "cms_frontswitch"."detail_explanation" IS '详细描述';

-- ----------------------------
-- Records of cms_frontswitch
-- ----------------------------
INSERT INTO "cms_frontswitch" VALUES ('1', 'http://www.yonyou.com/', '1.png', '2016-01-05 16:00:09.456', '0001', '0', null, null);
INSERT INTO "cms_frontswitch" VALUES ('2', 'http://www.yonyou.com/', 'slide-2.png', '2015-12-09 10:48:39.877', '1', '0', null, null);
INSERT INTO "cms_frontswitch" VALUES ('3', 'http://www.yonyou.com/', 'Jellyfish.jpg', '2015-12-09 11:28:29.118', '1', '1', null, null);
INSERT INTO "cms_frontswitch" VALUES ('4', 'http://www.yonyou.com/', 'slide-4.png', '2015-12-09 10:48:58.861', '1', '0', null, null);
INSERT INTO "cms_frontswitch" VALUES ('5', 'http://www.yonyou.com/', 'slide-5.png', '2015-12-09 12:00:22.185', '1', '0', 'null', 'null');

-- ----------------------------
-- Table structure for cms_guestbook
-- ----------------------------
DROP TABLE IF EXISTS "cms_guestbook";
CREATE TABLE "cms_guestbook" (
"id" varchar(64) COLLATE "default" NOT NULL,
"type" char(1) COLLATE "default" NOT NULL,
"content" varchar(255) COLLATE "default" NOT NULL,
"name" varchar(100) COLLATE "default" NOT NULL,
"email" varchar(100) COLLATE "default" NOT NULL,
"phone" varchar(100) COLLATE "default" NOT NULL,
"workunit" varchar(100) COLLATE "default" NOT NULL,
"ip" varchar(100) COLLATE "default" NOT NULL,
"create_date" timestamp(6) NOT NULL,
"re_user_id" varchar(64) COLLATE "default",
"re_date" timestamp(6),
"re_content" varchar(100) COLLATE "default",
"del_flag" char(1) COLLATE "default" DEFAULT '0'::bpchar NOT NULL
)
WITH (OIDS=FALSE)

;
COMMENT ON TABLE "cms_guestbook" IS '留言板';
COMMENT ON COLUMN "cms_guestbook"."id" IS '编号';
COMMENT ON COLUMN "cms_guestbook"."type" IS '留言分类';
COMMENT ON COLUMN "cms_guestbook"."content" IS '留言内容';
COMMENT ON COLUMN "cms_guestbook"."name" IS '姓名';
COMMENT ON COLUMN "cms_guestbook"."email" IS '邮箱';
COMMENT ON COLUMN "cms_guestbook"."phone" IS '电话';
COMMENT ON COLUMN "cms_guestbook"."workunit" IS '单位';
COMMENT ON COLUMN "cms_guestbook"."ip" IS 'IP';
COMMENT ON COLUMN "cms_guestbook"."create_date" IS '留言时间';
COMMENT ON COLUMN "cms_guestbook"."re_user_id" IS '回复人';
COMMENT ON COLUMN "cms_guestbook"."re_date" IS '回复时间';
COMMENT ON COLUMN "cms_guestbook"."re_content" IS '回复内容';
COMMENT ON COLUMN "cms_guestbook"."del_flag" IS '删除标记';

-- ----------------------------
-- Records of cms_guestbook
-- ----------------------------

-- ----------------------------
-- Table structure for cms_hotlabel
-- ----------------------------
DROP TABLE IF EXISTS "cms_hotlabel";
CREATE TABLE "cms_hotlabel" (
"label_value" varchar(50) COLLATE "default" NOT NULL,
"count_acti" int8
)
WITH (OIDS=FALSE)

;
COMMENT ON COLUMN "cms_hotlabel"."label_value" IS '标签内容';
COMMENT ON COLUMN "cms_hotlabel"."count_acti" IS '标签下的知识数';

-- ----------------------------
-- Records of cms_hotlabel
-- ----------------------------

-- ----------------------------
-- Table structure for cms_label
-- ----------------------------
DROP TABLE IF EXISTS "cms_label";
CREATE TABLE "cms_label" (
"label_id" varchar(500) COLLATE "default" NOT NULL,
"label_value" varchar(500) COLLATE "default",
"label_content" varchar(200) COLLATE "default",
"del_flag" varchar(50) COLLATE "default",
"user_id" varchar(300) COLLATE "default",
"createdate" timestamp(6)
)
WITH (OIDS=FALSE)

;
COMMENT ON COLUMN "cms_label"."label_id" IS '标签的编号';
COMMENT ON COLUMN "cms_label"."label_value" IS '标签的标题';

-- ----------------------------
-- Records of cms_label
-- ----------------------------

-- ----------------------------
-- Table structure for cms_label_conn_arti
-- ----------------------------
DROP TABLE IF EXISTS "cms_label_conn_arti";
CREATE TABLE "cms_label_conn_arti" (
"label_id" varchar(500) COLLATE "default",
"article_id" varchar(500) COLLATE "default" NOT NULL,
"category_id" varchar(500) COLLATE "default",
"id" varchar(500) COLLATE "default" NOT NULL
)
WITH (OIDS=FALSE)

;
COMMENT ON COLUMN "cms_label_conn_arti"."label_id" IS '标签的id';
COMMENT ON COLUMN "cms_label_conn_arti"."article_id" IS '知识id';
COMMENT ON COLUMN "cms_label_conn_arti"."category_id" IS '所属知识分类id';
COMMENT ON COLUMN "cms_label_conn_arti"."id" IS 'id';

-- ----------------------------
-- Records of cms_label_conn_arti
-- ----------------------------

-- ----------------------------
-- Table structure for cms_label_conn_user
-- ----------------------------
DROP TABLE IF EXISTS "cms_label_conn_user";
CREATE TABLE "cms_label_conn_user" (
"label_id" varchar(500) COLLATE "default",
"user_id" varchar(500) COLLATE "default" NOT NULL,
"id" varchar(50) COLLATE "default" NOT NULL
)
WITH (OIDS=FALSE)

;
COMMENT ON COLUMN "cms_label_conn_user"."label_id" IS '标签的id';
COMMENT ON COLUMN "cms_label_conn_user"."user_id" IS '用户的id';
COMMENT ON COLUMN "cms_label_conn_user"."id" IS 'id';

-- ----------------------------
-- Records of cms_label_conn_user
-- ----------------------------

-- ----------------------------
-- Table structure for cms_label_count
-- ----------------------------
DROP TABLE IF EXISTS "cms_label_count";
CREATE TABLE "cms_label_count" (
"label_id" varchar(200) COLLATE "default" NOT NULL,
"count_user" int8,
"count_article" int8
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of cms_label_count
-- ----------------------------

-- ----------------------------
-- Table structure for cms_link
-- ----------------------------
DROP TABLE IF EXISTS "cms_link";
CREATE TABLE "cms_link" (
"id" varchar(64) COLLATE "default" NOT NULL,
"category_id" varchar(64) COLLATE "default" NOT NULL,
"title" varchar(255) COLLATE "default" NOT NULL,
"color" varchar(50) COLLATE "default",
"image" varchar(255) COLLATE "default",
"href" varchar(255) COLLATE "default",
"weight" int8 DEFAULT 0,
"weight_date" timestamp(6),
"create_by" varchar(64) COLLATE "default",
"create_date" timestamp(6),
"update_by" varchar(64) COLLATE "default",
"update_date" timestamp(6),
"remarks" varchar(255) COLLATE "default",
"del_flag" char(1) COLLATE "default" DEFAULT '0'::bpchar NOT NULL
)
WITH (OIDS=FALSE)

;
COMMENT ON TABLE "cms_link" IS '友情链接';
COMMENT ON COLUMN "cms_link"."id" IS '编号';
COMMENT ON COLUMN "cms_link"."category_id" IS '栏目编号';
COMMENT ON COLUMN "cms_link"."title" IS '链接名称';
COMMENT ON COLUMN "cms_link"."color" IS '标题颜色';
COMMENT ON COLUMN "cms_link"."image" IS '链接图片';
COMMENT ON COLUMN "cms_link"."href" IS '链接地址';
COMMENT ON COLUMN "cms_link"."weight" IS '权重，越大越靠前';
COMMENT ON COLUMN "cms_link"."weight_date" IS '权重期限';
COMMENT ON COLUMN "cms_link"."create_by" IS '创建者';
COMMENT ON COLUMN "cms_link"."create_date" IS '创建时间';
COMMENT ON COLUMN "cms_link"."update_by" IS '更新者';
COMMENT ON COLUMN "cms_link"."update_date" IS '更新时间';
COMMENT ON COLUMN "cms_link"."remarks" IS '备注信息';
COMMENT ON COLUMN "cms_link"."del_flag" IS '删除标记';

-- ----------------------------
-- Records of cms_link
-- ----------------------------

-- ----------------------------
-- Table structure for cms_mystore
-- ----------------------------
DROP TABLE IF EXISTS "cms_mystore";
CREATE TABLE "cms_mystore" (
"id" varchar(60) COLLATE "default" NOT NULL,
"create_by" varchar(64) COLLATE "default",
"store_date" timestamp(6),
"upload_user_id" varchar(60) COLLATE "default",
"del_flag" char(60) COLLATE "default" NOT NULL,
"title_id" varchar(60) COLLATE "default" NOT NULL,
"update_date" timestamp(6),
"update_by" varchar(64) COLLATE "default",
"store_count" int8,
"creater" varchar(64) COLLATE "default",
"title" varchar(108) COLLATE "default",
"category_id" varchar(60) COLLATE "default"
)
WITH (OIDS=FALSE)

;
COMMENT ON COLUMN "cms_mystore"."id" IS '文章ID';
COMMENT ON COLUMN "cms_mystore"."create_by" IS '收藏文章的人ID';
COMMENT ON COLUMN "cms_mystore"."store_date" IS '收藏的时间';
COMMENT ON COLUMN "cms_mystore"."upload_user_id" IS '上传文章的人name';
COMMENT ON COLUMN "cms_mystore"."del_flag" IS '标记';
COMMENT ON COLUMN "cms_mystore"."title_id" IS '文章ID';
COMMENT ON COLUMN "cms_mystore"."update_date" IS '更新时间';
COMMENT ON COLUMN "cms_mystore"."update_by" IS '更新的人';
COMMENT ON COLUMN "cms_mystore"."store_count" IS '收藏次数';
COMMENT ON COLUMN "cms_mystore"."creater" IS '收藏文章的人的name';
COMMENT ON COLUMN "cms_mystore"."title" IS '收藏文章的name';

-- ----------------------------
-- Records of cms_mystore
-- ----------------------------

-- ----------------------------
-- Table structure for cms_person_contribution
-- ----------------------------
DROP TABLE IF EXISTS "cms_person_contribution";
CREATE TABLE "cms_person_contribution" (
"user_id" varchar(500) COLLATE "default" NOT NULL,
"user_name" varchar(500) COLLATE "default",
"count_article" int8
)
WITH (OIDS=FALSE)

;
COMMENT ON COLUMN "cms_person_contribution"."user_id" IS '用户的id';
COMMENT ON COLUMN "cms_person_contribution"."user_name" IS '用户姓名';
COMMENT ON COLUMN "cms_person_contribution"."count_article" IS '贡献的知识数';

-- ----------------------------
-- Records of cms_person_contribution
-- ----------------------------

-- ----------------------------
-- Table structure for cms_recommend
-- ----------------------------
DROP TABLE IF EXISTS "cms_recommend";
CREATE TABLE "cms_recommend" (
"id" varchar(64) COLLATE "default" NOT NULL,
"recom_date" timestamp(6) NOT NULL,
"recom_count" int8,
"del_flag" varchar(20) COLLATE "default" NOT NULL,
"update_date" timestamp(6),
"create_by" varchar(60) COLLATE "default" NOT NULL,
"title_id" varchar(60) COLLATE "default",
"title" varchar(60) COLLATE "default",
"category_id" varchar(60) COLLATE "default"
)
WITH (OIDS=FALSE)

;
COMMENT ON COLUMN "cms_recommend"."id" IS 'ID';
COMMENT ON COLUMN "cms_recommend"."recom_date" IS '推荐时间';
COMMENT ON COLUMN "cms_recommend"."recom_count" IS '推荐次数';
COMMENT ON COLUMN "cms_recommend"."del_flag" IS '标记';
COMMENT ON COLUMN "cms_recommend"."update_date" IS '更新时间';
COMMENT ON COLUMN "cms_recommend"."create_by" IS '推荐人ID';
COMMENT ON COLUMN "cms_recommend"."title_id" IS '文章ID';

-- ----------------------------
-- Records of cms_recommend
-- ----------------------------

-- ----------------------------
-- Table structure for cms_share
-- ----------------------------
DROP TABLE IF EXISTS "cms_share";
CREATE TABLE "cms_share" (
"id" varchar(60) COLLATE "default" NOT NULL,
"title" varchar(60) COLLATE "default",
"title_id" varchar(40) COLLATE "default" NOT NULL,
"create_by" varchar(60) COLLATE "default",
"ownlib" varchar(60) COLLATE "default",
"share_date" timestamp(6) NOT NULL,
"way" varchar(60) COLLATE "default",
"allow_share" char(1) COLLATE "default",
"share_count" int8,
"category_id" varchar(60) COLLATE "default",
"update_date" varchar(60) COLLATE "default"
)
WITH (OIDS=FALSE)

;
COMMENT ON COLUMN "cms_share"."id" IS 'id';
COMMENT ON COLUMN "cms_share"."title" IS '文章name';
COMMENT ON COLUMN "cms_share"."title_id" IS '文章ID';
COMMENT ON COLUMN "cms_share"."create_by" IS '分享人ID';
COMMENT ON COLUMN "cms_share"."ownlib" IS '所属分类';
COMMENT ON COLUMN "cms_share"."share_date" IS '分享时间';
COMMENT ON COLUMN "cms_share"."way" IS '分享方式';
COMMENT ON COLUMN "cms_share"."allow_share" IS '是否允许分享';
COMMENT ON COLUMN "cms_share"."share_count" IS '分享次数';

-- ----------------------------
-- Records of cms_share
-- ----------------------------

-- ----------------------------
-- Table structure for cms_site
-- ----------------------------
DROP TABLE IF EXISTS "cms_site";
CREATE TABLE "cms_site" (
"id" varchar(64) COLLATE "default" NOT NULL,
"name" varchar(100) COLLATE "default" NOT NULL,
"title" varchar(100) COLLATE "default" NOT NULL,
"logo" varchar(255) COLLATE "default",
"domain" varchar(255) COLLATE "default",
"description" varchar(255) COLLATE "default",
"keywords" varchar(255) COLLATE "default",
"theme" varchar(255) COLLATE "default" DEFAULT 'default'::character varying,
"copyright" text COLLATE "default",
"custom_index_view" text COLLATE "default",
"create_by" varchar(64) COLLATE "default",
"create_date" timestamp(6),
"update_by" varchar(64) COLLATE "default",
"update_date" timestamp(6),
"remarks" varchar(255) COLLATE "default",
"del_flag" char(1) COLLATE "default" DEFAULT '0'::bpchar NOT NULL
)
WITH (OIDS=FALSE)

;
COMMENT ON TABLE "cms_site" IS '站点表';
COMMENT ON COLUMN "cms_site"."id" IS '编号';
COMMENT ON COLUMN "cms_site"."name" IS '站点名称';
COMMENT ON COLUMN "cms_site"."title" IS '站点标题';
COMMENT ON COLUMN "cms_site"."logo" IS '站点Logo';
COMMENT ON COLUMN "cms_site"."domain" IS '站点域名';
COMMENT ON COLUMN "cms_site"."description" IS '描述';
COMMENT ON COLUMN "cms_site"."keywords" IS '关键字';
COMMENT ON COLUMN "cms_site"."theme" IS '主题';
COMMENT ON COLUMN "cms_site"."copyright" IS '版权信息';
COMMENT ON COLUMN "cms_site"."custom_index_view" IS '自定义站点首页视图';
COMMENT ON COLUMN "cms_site"."create_by" IS '创建者';
COMMENT ON COLUMN "cms_site"."create_date" IS '创建时间';
COMMENT ON COLUMN "cms_site"."update_by" IS '更新者';
COMMENT ON COLUMN "cms_site"."update_date" IS '更新时间';
COMMENT ON COLUMN "cms_site"."remarks" IS '备注信息';
COMMENT ON COLUMN "cms_site"."del_flag" IS '删除标记';

-- ----------------------------
-- Records of cms_site
-- ----------------------------


-- ----------------------------
-- Table structure for gen_scheme
-- ----------------------------
--
DROP TABLE IF EXISTS "gen_scheme";
CREATE TABLE "gen_scheme" (
"id" varchar(64) COLLATE "default" NOT NULL,
"name" varchar(200) COLLATE "default",
"category" varchar(2000) COLLATE "default",
"package_name" varchar(500) COLLATE "default",
"module_name" varchar(30) COLLATE "default",
"sub_module_name" varchar(30) COLLATE "default",
"function_name" varchar(500) COLLATE "default",
"function_name_simple" varchar(100) COLLATE "default",
"function_author" varchar(100) COLLATE "default",
"gen_table_id" varchar(200) COLLATE "default",
"create_by" varchar(64) COLLATE "default",
"create_date" timestamp(6),
"update_by" varchar(64) COLLATE "default",
"update_date" timestamp(6),
"remarks" varchar(255) COLLATE "default",
"del_flag" char(1) COLLATE "default" DEFAULT '0'::bpchar NOT NULL
)
WITH (OIDS=FALSE)

;
COMMENT ON TABLE "gen_scheme" IS '生成方案';
COMMENT ON COLUMN "gen_scheme"."id" IS '编号';
COMMENT ON COLUMN "gen_scheme"."name" IS '名称';
COMMENT ON COLUMN "gen_scheme"."category" IS '分类';
COMMENT ON COLUMN "gen_scheme"."package_name" IS '生成包路径';
COMMENT ON COLUMN "gen_scheme"."module_name" IS '生成模块名';
COMMENT ON COLUMN "gen_scheme"."sub_module_name" IS '生成子模块名';
COMMENT ON COLUMN "gen_scheme"."function_name" IS '生成功能名';
COMMENT ON COLUMN "gen_scheme"."function_name_simple" IS '生成功能名（简写）';
COMMENT ON COLUMN "gen_scheme"."function_author" IS '生成功能作者';
COMMENT ON COLUMN "gen_scheme"."gen_table_id" IS '生成表编号';
COMMENT ON COLUMN "gen_scheme"."create_by" IS '创建者';
COMMENT ON COLUMN "gen_scheme"."create_date" IS '创建时间';
COMMENT ON COLUMN "gen_scheme"."update_by" IS '更新者';
COMMENT ON COLUMN "gen_scheme"."update_date" IS '更新时间';
COMMENT ON COLUMN "gen_scheme"."remarks" IS '备注信息';
COMMENT ON COLUMN "gen_scheme"."del_flag" IS '删除标记（0：正常；1：删除）';

-- ----------------------------
-- Records of gen_scheme
-- ----------------------------
INSERT INTO "gen_scheme" VALUES ('35a13dc260284a728a270db3f382664b', '树结构', 'treeTable', 'com.yonyou.kms.modules', 'test', null, '树结构生成', '树结构', 'hotusm', 'f6e4dafaa72f4c509636484715f33a96', '1', '2013-12-08 11:17:06.818', '1', '2013-12-08 13:50:01.781', null, '0');
INSERT INTO "gen_scheme" VALUES ('9c9de9db6da743bb899036c6546061ac', '单表', 'curd', 'com.yonyou.kms.modules', 'test', null, '单表生成', '单表', 'hotusm', 'aef6f1fc948f4c9ab1c1b780bc471cc2', '1', '2013-12-08 11:11:05.943', '1', '2013-12-08 11:28:13.953', null, '0');
INSERT INTO "gen_scheme" VALUES ('e6d905fd236b46d1af581dd32bdfb3b0', '主子表', 'curd_many', 'com.yonyou.kms.modules', 'test', null, '主子表生成', '主子表', 'hotusm', '43d6d5acffa14c258340ce6765e46c6f', '1', '2013-12-08 11:13:34.428', '1', '2013-12-08 11:42:16.729', null, '0');

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS "gen_table";
CREATE TABLE "gen_table" (
"id" varchar(64) COLLATE "default" NOT NULL,
"name" varchar(200) COLLATE "default",
"comments" varchar(500) COLLATE "default",
"class_name" varchar(100) COLLATE "default",
"parent_table" varchar(200) COLLATE "default",
"parent_table_fk" varchar(100) COLLATE "default",
"create_by" varchar(64) COLLATE "default",
"create_date" timestamp(6),
"update_by" varchar(64) COLLATE "default",
"update_date" timestamp(6),
"remarks" varchar(255) COLLATE "default",
"del_flag" char(1) COLLATE "default" DEFAULT '0'::bpchar NOT NULL
)
WITH (OIDS=FALSE)

;
COMMENT ON TABLE "gen_table" IS '业务表';
COMMENT ON COLUMN "gen_table"."id" IS '编号';
COMMENT ON COLUMN "gen_table"."name" IS '名称';
COMMENT ON COLUMN "gen_table"."comments" IS '描述';
COMMENT ON COLUMN "gen_table"."class_name" IS '实体类名称';
COMMENT ON COLUMN "gen_table"."parent_table" IS '关联父表';
COMMENT ON COLUMN "gen_table"."parent_table_fk" IS '关联父表外键';
COMMENT ON COLUMN "gen_table"."create_by" IS '创建者';
COMMENT ON COLUMN "gen_table"."create_date" IS '创建时间';
COMMENT ON COLUMN "gen_table"."update_by" IS '更新者';
COMMENT ON COLUMN "gen_table"."update_date" IS '更新时间';
COMMENT ON COLUMN "gen_table"."remarks" IS '备注信息';
COMMENT ON COLUMN "gen_table"."del_flag" IS '删除标记（0：正常；1：删除）';

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO "gen_table" VALUES ('43d6d5acffa14c258340ce6765e46c6f', 'test_data_main', '业务数据表', 'TestDataMain', null, null, '1', '2013-12-08 11:11:59.745', '1', '2013-12-08 11:26:16.36', null, '0');
INSERT INTO "gen_table" VALUES ('6e05c389f3c6415ea34e55e9dfb28934', 'test_data_child', '业务数据子表', 'TestDataChild', 'test_data_main', 'test_data_main_id', '1', '2013-12-08 11:12:57.96', '1', '2013-12-08 11:30:22.324', null, '0');
INSERT INTO "gen_table" VALUES ('aef6f1fc948f4c9ab1c1b780bc471cc2', 'test_data', '业务数据表', 'TestData', null, null, '1', '2013-12-08 11:10:28.984', '1', '2013-12-08 11:28:00.511', null, '0');
INSERT INTO "gen_table" VALUES ('f6e4dafaa72f4c509636484715f33a96', 'test_tree', '树结构表', 'TestTree', null, null, '1', '2013-12-08 11:16:19.093', '1', '2013-12-08 13:49:47.755', null, '0');

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS "gen_table_column";
CREATE TABLE "gen_table_column" (
"id" varchar(64) COLLATE "default" NOT NULL,
"gen_table_id" varchar(64) COLLATE "default",
"name" varchar(200) COLLATE "default",
"comments" varchar(500) COLLATE "default",
"jdbc_type" varchar(100) COLLATE "default",
"java_type" varchar(500) COLLATE "default",
"java_field" varchar(200) COLLATE "default",
"is_pk" char(1) COLLATE "default",
"is_null" char(1) COLLATE "default",
"is_insert" char(1) COLLATE "default",
"is_edit" char(1) COLLATE "default",
"is_list" char(1) COLLATE "default",
"is_query" char(1) COLLATE "default",
"query_type" varchar(200) COLLATE "default",
"show_type" varchar(200) COLLATE "default",
"dict_type" varchar(200) COLLATE "default",
"settings" varchar(2000) COLLATE "default",
"sort" int8,
"create_by" varchar(64) COLLATE "default",
"create_date" timestamp(6),
"update_by" varchar(64) COLLATE "default",
"update_date" timestamp(6),
"remarks" varchar(255) COLLATE "default",
"del_flag" char(1) COLLATE "default" DEFAULT '0'::bpchar NOT NULL
)
WITH (OIDS=FALSE)

;
COMMENT ON TABLE "gen_table_column" IS '业务表字段';
COMMENT ON COLUMN "gen_table_column"."id" IS '编号';
COMMENT ON COLUMN "gen_table_column"."gen_table_id" IS '归属表编号';
COMMENT ON COLUMN "gen_table_column"."name" IS '名称';
COMMENT ON COLUMN "gen_table_column"."comments" IS '描述';
COMMENT ON COLUMN "gen_table_column"."jdbc_type" IS '列的数据类型的字节长度';
COMMENT ON COLUMN "gen_table_column"."java_type" IS 'JAVA类型';
COMMENT ON COLUMN "gen_table_column"."java_field" IS 'JAVA字段名';
COMMENT ON COLUMN "gen_table_column"."is_pk" IS '是否主键';
COMMENT ON COLUMN "gen_table_column"."is_null" IS '是否可为空';
COMMENT ON COLUMN "gen_table_column"."is_insert" IS '是否为插入字段';
COMMENT ON COLUMN "gen_table_column"."is_edit" IS '是否编辑字段';
COMMENT ON COLUMN "gen_table_column"."is_list" IS '是否列表字段';
COMMENT ON COLUMN "gen_table_column"."is_query" IS '是否查询字段';
COMMENT ON COLUMN "gen_table_column"."query_type" IS '查询方式（等于、不等于、大于、小于、范围、左LIKE、右LIKE、左右LIKE）';
COMMENT ON COLUMN "gen_table_column"."show_type" IS '字段生成方案（文本框、文本域、下拉框、复选框、单选框、字典选择、人员选择、部门选择、区域选择）';
COMMENT ON COLUMN "gen_table_column"."dict_type" IS '字典类型';
COMMENT ON COLUMN "gen_table_column"."settings" IS '其它设置（扩展字段JSON）';
COMMENT ON COLUMN "gen_table_column"."sort" IS '排序（升序）';
COMMENT ON COLUMN "gen_table_column"."create_by" IS '创建者';
COMMENT ON COLUMN "gen_table_column"."create_date" IS '创建时间';
COMMENT ON COLUMN "gen_table_column"."update_by" IS '更新者';
COMMENT ON COLUMN "gen_table_column"."update_date" IS '更新时间';
COMMENT ON COLUMN "gen_table_column"."remarks" IS '备注信息';
COMMENT ON COLUMN "gen_table_column"."del_flag" IS '删除标记（0：正常；1：删除）';

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO "gen_table_column" VALUES ('0902a0cb3e8f434280c20e9d771d0658', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'sex', '性别', 'char(1)', 'String', 'sex', '0', '1', '1', '1', '1', '1', '=', 'radiobox', 'sex', null, '6', '1', '2013-12-08 11:10:29.133', '1', '2013-12-08 11:28:00.524', null, '0');
INSERT INTO "gen_table_column" VALUES ('103fc05c88ff40639875c2111881996a', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'create_date', '创建时间', 'timestamp(6)', 'java.util.Date', 'createDate', '0', '0', '1', '0', '0', '0', '=', 'dateselect', null, null, '9', '1', '2013-12-08 11:10:29.137', '1', '2013-12-08 11:28:00.717', null, '0');
INSERT INTO "gen_table_column" VALUES ('12fa38dd986e41908f7fefa5839d1220', '6e05c389f3c6415ea34e55e9dfb28934', 'create_by', '创建者', 'varchar2(64)', 'com.yonyou.kms.modules.modules.sys.entity.User', 'createBy.id', '0', '0', '1', '0', '0', '0', '=', 'input', null, null, '4', '1', '2013-12-08 11:12:57.967', '1', '2013-12-08 11:30:22.33', null, '0');
INSERT INTO "gen_table_column" VALUES ('195ee9241f954d008fe01625f4adbfef', 'f6e4dafaa72f4c509636484715f33a96', 'create_by', '创建者', 'varchar2(64)', 'com.yonyou.kms.modules.modules.sys.entity.User', 'createBy.id', '0', '0', '1', '0', '0', '0', '=', 'input', null, null, '6', '1', '2013-12-08 11:16:19.117', '1', '2013-12-08 13:49:47.766', null, '0');
INSERT INTO "gen_table_column" VALUES ('19c6478b8ff54c60910c2e4fc3d27503', '43d6d5acffa14c258340ce6765e46c6f', 'id', '编号', 'varchar2(64)', 'String', 'id', '1', '0', '1', '0', '0', '0', '=', 'input', null, null, '1', '1', '2013-12-08 11:11:59.747', '1', '2013-12-08 11:26:16.362', null, '0');
INSERT INTO "gen_table_column" VALUES ('1ac6562f753d4e599693840651ab2bf7', '43d6d5acffa14c258340ce6765e46c6f', 'in_date', '加入日期', 'date(7)', 'java.util.Date', 'inDate', '0', '1', '1', '1', '0', '0', '=', 'dateselect', null, null, '7', '1', '2013-12-08 11:11:59.758', '1', '2013-12-08 11:26:16.378', null, '0');
INSERT INTO "gen_table_column" VALUES ('1b8eb55f65284fa6b0a5879b6d8ad3ec', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'in_date', '加入日期', 'date(7)', 'java.util.Date', 'inDate', '0', '1', '1', '1', '0', '1', 'between', 'dateselect', null, null, '7', '1', '2013-12-08 11:10:29.134', '1', '2013-12-08 11:28:00.526', null, '0');
INSERT INTO "gen_table_column" VALUES ('1d5ca4d114be41e99f8dc42a682ba609', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'user_id', '归属用户', 'varchar2(64)', 'com.yonyou.kms.modules.modules.sys.entity.User', 'user.id|name', '0', '1', '1', '1', '1', '1', '=', 'userselect', null, null, '2', '1', '2013-12-08 11:10:29.125', '1', '2013-12-08 11:28:00.515', null, '0');
INSERT INTO "gen_table_column" VALUES ('21756504ffdc487eb167a823f89c0c06', '43d6d5acffa14c258340ce6765e46c6f', 'update_by', '更新者', 'varchar2(64)', 'com.yonyou.kms.modules.modules.sys.entity.User', 'updateBy.id', '0', '0', '1', '1', '0', '0', '=', 'input', null, null, '10', '1', '2013-12-08 11:11:59.763', '1', '2013-12-08 11:26:16.383', null, '0');
INSERT INTO "gen_table_column" VALUES ('24bbdc0a555e4412a106ab1c5f03008e', 'f6e4dafaa72f4c509636484715f33a96', 'parent_ids', '所有父级编号', 'varchar2(2000)', 'String', 'parentIds', '0', '0', '1', '1', '0', '0', 'like', 'input', null, null, '3', '1', '2013-12-08 11:16:19.098', '1', '2013-12-08 13:49:47.761', null, '0');
INSERT INTO "gen_table_column" VALUES ('33152ce420904594b3eac796a27f0560', '6e05c389f3c6415ea34e55e9dfb28934', 'id', '编号', 'varchar2(64)', 'String', 'id', '1', '0', '1', '0', '0', '0', '=', 'input', null, null, '1', '1', '2013-12-08 11:12:57.962', '1', '2013-12-08 11:30:22.326', null, '0');
INSERT INTO "gen_table_column" VALUES ('35af241859624a01917ab64c3f4f0813', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'del_flag', '删除标记（0：正常；1：删除）', 'char(1)', 'String', 'delFlag', '0', '0', '1', '0', '0', '0', '=', 'radiobox', 'del_flag', null, '13', '1', '2013-12-08 11:10:29.144', '1', '2013-12-08 11:28:00.726', null, '0');
INSERT INTO "gen_table_column" VALUES ('398b4a03f06940bfb979ca574e1911e3', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'create_by', '创建者', 'varchar2(64)', 'com.yonyou.kms.modules.modules.sys.entity.User', 'createBy.id', '0', '0', '1', '0', '0', '0', '=', 'input', null, null, '8', '1', '2013-12-08 11:10:29.136', '1', '2013-12-08 11:28:00.7', null, '0');
INSERT INTO "gen_table_column" VALUES ('3a7cf23ae48a4c849ceb03feffc7a524', '43d6d5acffa14c258340ce6765e46c6f', 'area_id', '归属区域', 'nvarchar2(64)', 'com.yonyou.kms.modules.modules.sys.entity.Area', 'area.id|name', '0', '1', '1', '1', '0', '0', '=', 'areaselect', null, null, '4', '1', '2013-12-08 11:11:59.754', '1', '2013-12-08 11:26:16.372', null, '0');
INSERT INTO "gen_table_column" VALUES ('3d9c32865bb44e85af73381df0ffbf3d', '43d6d5acffa14c258340ce6765e46c6f', 'update_date', '更新时间', 'timestamp(6)', 'java.util.Date', 'updateDate', '0', '0', '1', '1', '1', '0', '=', 'dateselect', null, null, '11', '1', '2013-12-08 11:11:59.764', '1', '2013-12-08 11:26:16.385', null, '0');
INSERT INTO "gen_table_column" VALUES ('416c76d2019b4f76a96d8dc3a8faf84c', 'f6e4dafaa72f4c509636484715f33a96', 'update_date', '更新时间', 'timestamp(6)', 'java.util.Date', 'updateDate', '0', '0', '1', '1', '1', '0', '=', 'dateselect', null, null, '9', '1', '2013-12-08 11:16:19.12', '1', '2013-12-08 13:49:47.772', null, '0');
INSERT INTO "gen_table_column" VALUES ('46e6d8283270493687085d29efdecb05', 'f6e4dafaa72f4c509636484715f33a96', 'del_flag', '删除标记（0：正常；1：删除）', 'char(1)', 'String', 'delFlag', '0', '0', '1', '0', '0', '0', '=', 'radiobox', 'del_flag', null, '11', '1', '2013-12-08 11:16:19.122', '1', '2013-12-08 13:49:47.775', null, '0');
INSERT INTO "gen_table_column" VALUES ('4a0a1fff86ca46519477d66b82e01991', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'name', '名称', 'nvarchar2(100)', 'String', 'name', '0', '1', '1', '1', '1', '1', 'like', 'input', null, null, '5', '1', '2013-12-08 11:10:29.131', '1', '2013-12-08 11:28:00.522', null, '0');
INSERT INTO "gen_table_column" VALUES ('4c8ef12cb6924b9ba44048ba9913150b', '43d6d5acffa14c258340ce6765e46c6f', 'create_date', '创建时间', 'timestamp(6)', 'java.util.Date', 'createDate', '0', '0', '1', '0', '0', '0', '=', 'dateselect', null, null, '9', '1', '2013-12-08 11:11:59.761', '1', '2013-12-08 11:26:16.381', null, '0');
INSERT INTO "gen_table_column" VALUES ('53d65a3d306d4fac9e561db9d3c66912', '6e05c389f3c6415ea34e55e9dfb28934', 'del_flag', '删除标记（0：正常；1：删除）', 'char(1)', 'String', 'delFlag', '0', '0', '1', '0', '0', '0', '=', 'radiobox', 'del_flag', null, '9', '1', '2013-12-08 11:12:57.975', '1', '2013-12-08 11:30:22.337', null, '0');
INSERT INTO "gen_table_column" VALUES ('56fa71c0bd7e4132931874e548dc9ba5', '6e05c389f3c6415ea34e55e9dfb28934', 'update_by', '更新者', 'varchar2(64)', 'com.yonyou.kms.modules.modules.sys.entity.User', 'updateBy.id', '0', '0', '1', '1', '0', '0', '=', 'input', null, null, '6', '1', '2013-12-08 11:12:57.969', '1', '2013-12-08 11:30:22.333', null, '0');
INSERT INTO "gen_table_column" VALUES ('5a4a1933c9c844fdba99de043dc8205e', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'update_by', '更新者', 'varchar2(64)', 'com.yonyou.kms.modules.modules.sys.entity.User', 'updateBy.id', '0', '0', '1', '1', '0', '0', '=', 'input', null, null, '10', '1', '2013-12-08 11:10:29.138', '1', '2013-12-08 11:28:00.721', null, '0');
INSERT INTO "gen_table_column" VALUES ('5e5c69bd3eaa4dcc9743f361f3771c08', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'id', '编号', 'varchar2(64)', 'String', 'id', '1', '0', '1', '0', '0', '0', '=', 'input', null, null, '1', '1', '2013-12-08 11:10:29.017', '1', '2013-12-08 11:28:00.513', null, '0');
INSERT INTO "gen_table_column" VALUES ('633f5a49ec974c099158e7b3e6bfa930', 'f6e4dafaa72f4c509636484715f33a96', 'name', '名称', 'nvarchar2(100)', 'String', 'name', '0', '0', '1', '1', '1', '1', 'like', 'input', null, null, '4', '1', '2013-12-08 11:16:19.115', '1', '2013-12-08 13:49:47.763', null, '0');
INSERT INTO "gen_table_column" VALUES ('652491500f2641ffa7caf95a93e64d34', '6e05c389f3c6415ea34e55e9dfb28934', 'update_date', '更新时间', 'timestamp(6)', 'java.util.Date', 'updateDate', '0', '0', '1', '1', '1', '0', '=', 'dateselect', null, null, '7', '1', '2013-12-08 11:12:57.971', '1', '2013-12-08 11:30:22.334', null, '0');
INSERT INTO "gen_table_column" VALUES ('6763ff6dc7cd4c668e76cf9b697d3ff6', 'f6e4dafaa72f4c509636484715f33a96', 'sort', '排序', 'number(10)', 'Integer', 'sort', '0', '0', '1', '1', '1', '0', '=', 'input', null, null, '5', '1', '2013-12-08 11:16:19.116', '1', '2013-12-08 13:49:47.764', null, '0');
INSERT INTO "gen_table_column" VALUES ('67d0331f809a48ee825602659f0778e8', '43d6d5acffa14c258340ce6765e46c6f', 'name', '名称', 'nvarchar2(100)', 'String', 'name', '0', '1', '1', '1', '1', '1', 'like', 'input', null, null, '5', '1', '2013-12-08 11:11:59.756', '1', '2013-12-08 11:26:16.374', null, '0');
INSERT INTO "gen_table_column" VALUES ('68345713bef3445c906f70e68f55de38', '6e05c389f3c6415ea34e55e9dfb28934', 'test_data_main_id', '业务主表', 'varchar2(64)', 'String', 'testDataMain.id', '0', '1', '1', '1', '0', '0', '=', 'input', null, null, '2', '1', '2013-12-08 11:12:57.964', '1', '2013-12-08 11:30:22.327', null, '0');
INSERT INTO "gen_table_column" VALUES ('71ea4bc10d274911b405f3165fc1bb1a', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'area_id', '归属区域', 'nvarchar2(64)', 'com.yonyou.kms.modules.modules.sys.entity.Area', 'area.id|name', '0', '1', '1', '1', '1', '1', '=', 'areaselect', null, null, '4', '1', '2013-12-08 11:10:29.13', '1', '2013-12-08 11:28:00.52', null, '0');
INSERT INTO "gen_table_column" VALUES ('7f871058d94c4d9a89084be7c9ce806d', '6e05c389f3c6415ea34e55e9dfb28934', 'remarks', '备注信息', 'nvarchar2(255)', 'String', 'remarks', '0', '1', '1', '1', '1', '0', '=', 'input', null, null, '8', '1', '2013-12-08 11:12:57.973', '1', '2013-12-08 11:30:22.335', null, '0');
INSERT INTO "gen_table_column" VALUES ('8b48774cfe184913b8b5eb17639cf12d', '43d6d5acffa14c258340ce6765e46c6f', 'create_by', '创建者', 'varchar2(64)', 'com.yonyou.kms.modules.modules.sys.entity.User', 'createBy.id', '0', '0', '1', '0', '0', '0', '=', 'input', null, null, '8', '1', '2013-12-08 11:11:59.76', '1', '2013-12-08 11:26:16.379', null, '0');
INSERT INTO "gen_table_column" VALUES ('8b7cf0525519474ebe1de9e587eb7067', '6e05c389f3c6415ea34e55e9dfb28934', 'create_date', '创建时间', 'timestamp(6)', 'java.util.Date', 'createDate', '0', '0', '1', '0', '0', '0', '=', 'dateselect', null, null, '5', '1', '2013-12-08 11:12:57.968', '1', '2013-12-08 11:30:22.332', null, '0');
INSERT INTO "gen_table_column" VALUES ('8b9de88df53e485d8ef461c4b1824bc1', '43d6d5acffa14c258340ce6765e46c6f', 'user_id', '归属用户', 'varchar2(64)', 'com.yonyou.kms.modules.modules.sys.entity.User', 'user.id|name', '0', '1', '1', '1', '1', '1', '=', 'userselect', null, null, '2', '1', '2013-12-08 11:11:59.749', '1', '2013-12-08 11:26:16.365', null, '0');
INSERT INTO "gen_table_column" VALUES ('8da38dbe5fe54e9bb1f9682c27fbf403', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'remarks', '备注信息', 'nvarchar2(255)', 'String', 'remarks', '0', '1', '1', '1', '1', '0', '=', 'textarea', null, null, '12', '1', '2013-12-08 11:10:29.142', '1', '2013-12-08 11:28:00.724', null, '0');
INSERT INTO "gen_table_column" VALUES ('92481c16a0b94b0e8bba16c3c54eb1e4', 'f6e4dafaa72f4c509636484715f33a96', 'create_date', '创建时间', 'timestamp(6)', 'java.util.Date', 'createDate', '0', '0', '1', '0', '0', '0', '=', 'dateselect', null, null, '7', '1', '2013-12-08 11:16:19.118', '1', '2013-12-08 13:49:47.768', null, '0');
INSERT INTO "gen_table_column" VALUES ('9a012c1d2f934dbf996679adb7cc827a', 'f6e4dafaa72f4c509636484715f33a96', 'parent_id', '父级编号', 'varchar2(64)', 'This', 'parent.id|name', '0', '0', '1', '1', '0', '0', '=', 'treeselect', null, null, '2', '1', '2013-12-08 11:16:19.096', '1', '2013-12-08 13:49:47.759', null, '0');
INSERT INTO "gen_table_column" VALUES ('ad3bf0d4b44b4528a5211a66af88f322', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'office_id', '归属部门', 'varchar2(64)', 'com.yonyou.kms.modules.modules.sys.entity.Office', 'office.id|name', '0', '1', '1', '1', '1', '1', '=', 'officeselect', null, null, '3', '1', '2013-12-08 11:10:29.128', '1', '2013-12-08 11:28:00.517', null, '0');
INSERT INTO "gen_table_column" VALUES ('bb1256a8d1b741f6936d8fed06f45eed', 'f6e4dafaa72f4c509636484715f33a96', 'update_by', '更新者', 'varchar2(64)', 'com.yonyou.kms.modules.modules.sys.entity..User', 'updateBy.id', '0', '0', '1', '1', '0', '0', '=', 'input', null, null, '8', '1', '2013-12-08 11:16:19.119', '1', '2013-12-08 13:49:47.77', null, '0');
INSERT INTO "gen_table_column" VALUES ('ca68a2d403f0449cbaa1d54198c6f350', '43d6d5acffa14c258340ce6765e46c6f', 'office_id', '归属部门', 'varchar2(64)', 'com.yonyou.kms.modules.modules.sys.entity.Office', 'office.id|name', '0', '1', '1', '1', '0', '0', '=', 'officeselect', null, null, '3', '1', '2013-12-08 11:11:59.751', '1', '2013-12-08 11:26:16.367', null, '0');
INSERT INTO "gen_table_column" VALUES ('cb9c0ec3da26432d9cbac05ede0fd1d0', '43d6d5acffa14c258340ce6765e46c6f', 'remarks', '备注信息', 'nvarchar2(255)', 'String', 'remarks', '0', '1', '1', '1', '1', '0', '=', 'textarea', null, null, '12', '1', '2013-12-08 11:11:59.765', '1', '2013-12-08 11:26:16.386', null, '0');
INSERT INTO "gen_table_column" VALUES ('cfcfa06ea61749c9b4c4dbc507e0e580', 'f6e4dafaa72f4c509636484715f33a96', 'id', '编号', 'varchar2(64)', 'String', 'id', '1', '0', '1', '0', '0', '0', '=', 'input', null, null, '1', '1', '2013-12-08 11:16:19.095', '1', '2013-12-08 13:49:47.756', null, '0');
INSERT INTO "gen_table_column" VALUES ('d5c2d932ae904aa8a9f9ef34cd36fb0b', '43d6d5acffa14c258340ce6765e46c6f', 'sex', '性别', 'char(1)', 'String', 'sex', '0', '1', '1', '1', '0', '1', '=', 'select', 'sex', null, '6', '1', '2013-12-08 11:11:59.757', '1', '2013-12-08 11:26:16.376', null, '0');
INSERT INTO "gen_table_column" VALUES ('e64050a2ebf041faa16f12dda5dcf784', '6e05c389f3c6415ea34e55e9dfb28934', 'name', '名称', 'nvarchar2(100)', 'String', 'name', '0', '1', '1', '1', '1', '1', 'like', 'input', null, null, '3', '1', '2013-12-08 11:12:57.966', '1', '2013-12-08 11:30:22.329', null, '0');
INSERT INTO "gen_table_column" VALUES ('e8d11127952d4aa288bb3901fc83127f', '43d6d5acffa14c258340ce6765e46c6f', 'del_flag', '删除标记（0：正常；1：删除）', 'char(1)', 'String', 'delFlag', '0', '0', '1', '0', '0', '0', '=', 'radiobox', 'del_flag', null, '13', '1', '2013-12-08 11:11:59.767', '1', '2013-12-08 11:26:16.388', null, '0');
INSERT INTO "gen_table_column" VALUES ('eb2e5afd13f147a990d30e68e7f64e12', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'update_date', '更新时间', 'timestamp(6)', 'java.util.Date', 'updateDate', '0', '0', '1', '1', '1', '0', '=', 'dateselect', null, null, '11', '1', '2013-12-08 11:10:29.14', '1', '2013-12-08 11:28:00.723', null, '0');
INSERT INTO "gen_table_column" VALUES ('f5ed8c82bad0413fbfcccefa95931358', 'f6e4dafaa72f4c509636484715f33a96', 'remarks', '备注信息', 'nvarchar2(255)', 'String', 'remarks', '0', '1', '1', '1', '1', '0', '=', 'textarea', null, null, '10', '1', '2013-12-08 11:16:19.121', '1', '2013-12-08 13:49:47.774', null, '0');

-- ----------------------------
-- Table structure for gen_template
-- ----------------------------
DROP TABLE IF EXISTS "gen_template";
CREATE TABLE "gen_template" (
"id" varchar(64) COLLATE "default" NOT NULL,
"name" varchar(200) COLLATE "default",
"category" varchar(2000) COLLATE "default",
"file_path" varchar(500) COLLATE "default",
"file_name" varchar(200) COLLATE "default",
"content" text COLLATE "default",
"create_by" varchar(64) COLLATE "default",
"create_date" timestamp(6),
"update_by" varchar(64) COLLATE "default",
"update_date" timestamp(6),
"remarks" varchar(255) COLLATE "default",
"del_flag" char(1) COLLATE "default" DEFAULT '0'::bpchar NOT NULL
)
WITH (OIDS=FALSE)

;
COMMENT ON TABLE "gen_template" IS '代码模板表';
COMMENT ON COLUMN "gen_template"."id" IS '编号';
COMMENT ON COLUMN "gen_template"."name" IS '名称';
COMMENT ON COLUMN "gen_template"."category" IS '分类';
COMMENT ON COLUMN "gen_template"."file_path" IS '生成文件路径';
COMMENT ON COLUMN "gen_template"."file_name" IS '生成文件名';
COMMENT ON COLUMN "gen_template"."content" IS '内容';
COMMENT ON COLUMN "gen_template"."create_by" IS '创建者';
COMMENT ON COLUMN "gen_template"."create_date" IS '创建时间';
COMMENT ON COLUMN "gen_template"."update_by" IS '更新者';
COMMENT ON COLUMN "gen_template"."update_date" IS '更新时间';
COMMENT ON COLUMN "gen_template"."remarks" IS '备注信息';
COMMENT ON COLUMN "gen_template"."del_flag" IS '删除标记（0：正常；1：删除）';

-- ----------------------------
-- Records of gen_template
-- ----------------------------

-- ----------------------------
-- Table structure for oa_leave
-- ----------------------------
DROP TABLE IF EXISTS "oa_leave";
CREATE TABLE "oa_leave" (
"id" varchar(64) COLLATE "default" NOT NULL,
"process_instance_id" varchar(64) COLLATE "default",
"start_time" timestamp(6),
"end_time" timestamp(6),
"leave_type" varchar(20) COLLATE "default",
"reason" varchar(255) COLLATE "default",
"apply_time" timestamp(6),
"reality_start_time" timestamp(6),
"reality_end_time" timestamp(6),
"create_by" varchar(64) COLLATE "default" NOT NULL,
"create_date" timestamp(6) NOT NULL,
"update_by" varchar(64) COLLATE "default" NOT NULL,
"update_date" timestamp(6) NOT NULL,
"remarks" varchar(255) COLLATE "default",
"del_flag" char(1) COLLATE "default" DEFAULT '0'::bpchar NOT NULL
)
WITH (OIDS=FALSE)

;
COMMENT ON TABLE "oa_leave" IS '请假流程表';
COMMENT ON COLUMN "oa_leave"."id" IS '编号';
COMMENT ON COLUMN "oa_leave"."process_instance_id" IS '流程实例编号';
COMMENT ON COLUMN "oa_leave"."start_time" IS '开始时间';
COMMENT ON COLUMN "oa_leave"."end_time" IS '结束时间';
COMMENT ON COLUMN "oa_leave"."leave_type" IS '请假类型';
COMMENT ON COLUMN "oa_leave"."reason" IS '请假理由';
COMMENT ON COLUMN "oa_leave"."apply_time" IS '申请时间';
COMMENT ON COLUMN "oa_leave"."reality_start_time" IS '实际开始时间';
COMMENT ON COLUMN "oa_leave"."reality_end_time" IS '实际结束时间';
COMMENT ON COLUMN "oa_leave"."create_by" IS '创建者';
COMMENT ON COLUMN "oa_leave"."create_date" IS '创建时间';
COMMENT ON COLUMN "oa_leave"."update_by" IS '更新者';
COMMENT ON COLUMN "oa_leave"."update_date" IS '更新时间';
COMMENT ON COLUMN "oa_leave"."remarks" IS '备注信息';
COMMENT ON COLUMN "oa_leave"."del_flag" IS '删除标记';

-- ----------------------------
-- Records of oa_leave
-- ----------------------------

-- ----------------------------
-- Table structure for oa_notify
-- ----------------------------
DROP TABLE IF EXISTS "oa_notify";
CREATE TABLE "oa_notify" (
"id" varchar(64) COLLATE "default" NOT NULL,
"type" char(1) COLLATE "default",
"title" varchar(200) COLLATE "default",
"content" varchar(2000) COLLATE "default",
"files" varchar(2000) COLLATE "default",
"status" char(1) COLLATE "default",
"create_by" varchar(64) COLLATE "default" NOT NULL,
"create_date" timestamp(6) NOT NULL,
"update_by" varchar(64) COLLATE "default" NOT NULL,
"update_date" timestamp(6) NOT NULL,
"remarks" varchar(255) COLLATE "default",
"del_flag" char(1) COLLATE "default" DEFAULT '0'::bpchar NOT NULL
)
WITH (OIDS=FALSE)

;
COMMENT ON TABLE "oa_notify" IS '通知通告';
COMMENT ON COLUMN "oa_notify"."id" IS '编号';
COMMENT ON COLUMN "oa_notify"."type" IS '类型';
COMMENT ON COLUMN "oa_notify"."title" IS '标题';
COMMENT ON COLUMN "oa_notify"."content" IS '内容';
COMMENT ON COLUMN "oa_notify"."files" IS '附件';
COMMENT ON COLUMN "oa_notify"."status" IS '状态';
COMMENT ON COLUMN "oa_notify"."create_by" IS '创建者';
COMMENT ON COLUMN "oa_notify"."create_date" IS '创建时间';
COMMENT ON COLUMN "oa_notify"."update_by" IS '更新者';
COMMENT ON COLUMN "oa_notify"."update_date" IS '更新时间';
COMMENT ON COLUMN "oa_notify"."remarks" IS '备注信息';
COMMENT ON COLUMN "oa_notify"."del_flag" IS '删除标记';

-- ----------------------------
-- Records of oa_notify
-- ----------------------------

-- ----------------------------
-- Table structure for oa_notify_record
-- ----------------------------
DROP TABLE IF EXISTS "oa_notify_record";
CREATE TABLE "oa_notify_record" (
"id" varchar(64) COLLATE "default" NOT NULL,
"oa_notify_id" varchar(64) COLLATE "default",
"user_id" varchar(64) COLLATE "default",
"read_flag" char(1) COLLATE "default" DEFAULT '0'::bpchar,
"read_date" timestamp(6)
)
WITH (OIDS=FALSE)

;
COMMENT ON TABLE "oa_notify_record" IS '通知通告发送记录';
COMMENT ON COLUMN "oa_notify_record"."id" IS '编号';
COMMENT ON COLUMN "oa_notify_record"."oa_notify_id" IS '通知通告ID';
COMMENT ON COLUMN "oa_notify_record"."user_id" IS '接受人';
COMMENT ON COLUMN "oa_notify_record"."read_flag" IS '阅读标记';
COMMENT ON COLUMN "oa_notify_record"."read_date" IS '阅读时间';

-- ----------------------------
-- Records of oa_notify_record
-- ----------------------------

-- ----------------------------
-- Table structure for oa_test_audit
-- ----------------------------
DROP TABLE IF EXISTS "oa_test_audit";
CREATE TABLE "oa_test_audit" (
"id" varchar(64) COLLATE "default" NOT NULL,
"proc_ins_id" varchar(64) COLLATE "default",
"user_id" varchar(64) COLLATE "default",
"office_id" varchar(64) COLLATE "default",
"post" varchar(255) COLLATE "default",
"age" char(1) COLLATE "default",
"edu" varchar(255) COLLATE "default",
"content" varchar(255) COLLATE "default",
"olda" varchar(255) COLLATE "default",
"oldb" varchar(255) COLLATE "default",
"oldc" varchar(255) COLLATE "default",
"newa" varchar(255) COLLATE "default",
"newb" varchar(255) COLLATE "default",
"newc" varchar(255) COLLATE "default",
"add_num" varchar(255) COLLATE "default",
"exe_date" varchar(255) COLLATE "default",
"hr_text" varchar(255) COLLATE "default",
"lead_text" varchar(255) COLLATE "default",
"main_lead_text" varchar(255) COLLATE "default",
"create_by" varchar(64) COLLATE "default" NOT NULL,
"create_date" timestamp(6) NOT NULL,
"update_by" varchar(64) COLLATE "default" NOT NULL,
"update_date" timestamp(6) NOT NULL,
"remarks" varchar(255) COLLATE "default",
"del_flag" char(1) COLLATE "default" DEFAULT '0'::bpchar NOT NULL
)
WITH (OIDS=FALSE)

;
COMMENT ON TABLE "oa_test_audit" IS '审批流程测试表';
COMMENT ON COLUMN "oa_test_audit"."id" IS '编号';
COMMENT ON COLUMN "oa_test_audit"."proc_ins_id" IS '流程实例ID';
COMMENT ON COLUMN "oa_test_audit"."user_id" IS '变动用户';
COMMENT ON COLUMN "oa_test_audit"."office_id" IS '归属部门';
COMMENT ON COLUMN "oa_test_audit"."post" IS '岗位';
COMMENT ON COLUMN "oa_test_audit"."age" IS '性别';
COMMENT ON COLUMN "oa_test_audit"."edu" IS '学历';
COMMENT ON COLUMN "oa_test_audit"."content" IS '调整原因';
COMMENT ON COLUMN "oa_test_audit"."olda" IS '现行标准 薪酬档级';
COMMENT ON COLUMN "oa_test_audit"."oldb" IS '现行标准 月工资额';
COMMENT ON COLUMN "oa_test_audit"."oldc" IS '现行标准 年薪总额';
COMMENT ON COLUMN "oa_test_audit"."newa" IS '调整后标准 薪酬档级';
COMMENT ON COLUMN "oa_test_audit"."newb" IS '调整后标准 月工资额';
COMMENT ON COLUMN "oa_test_audit"."newc" IS '调整后标准 年薪总额';
COMMENT ON COLUMN "oa_test_audit"."add_num" IS '月增资';
COMMENT ON COLUMN "oa_test_audit"."exe_date" IS '执行时间';
COMMENT ON COLUMN "oa_test_audit"."hr_text" IS '人力资源部门意见';
COMMENT ON COLUMN "oa_test_audit"."lead_text" IS '分管领导意见';
COMMENT ON COLUMN "oa_test_audit"."main_lead_text" IS '集团主要领导意见';
COMMENT ON COLUMN "oa_test_audit"."create_by" IS '创建者';
COMMENT ON COLUMN "oa_test_audit"."create_date" IS '创建时间';
COMMENT ON COLUMN "oa_test_audit"."update_by" IS '更新者';
COMMENT ON COLUMN "oa_test_audit"."update_date" IS '更新时间';
COMMENT ON COLUMN "oa_test_audit"."remarks" IS '备注信息';
COMMENT ON COLUMN "oa_test_audit"."del_flag" IS '删除标记';

-- ----------------------------
-- Records of oa_test_audit
-- ----------------------------

-- ----------------------------
-- Table structure for sys_area
-- ----------------------------
DROP TABLE IF EXISTS "sys_area";
CREATE TABLE "sys_area" (
"id" varchar(64) COLLATE "default" NOT NULL,
"parent_id" varchar(64) COLLATE "default" NOT NULL,
"parent_ids" varchar(2000) COLLATE "default" NOT NULL,
"name" varchar(100) COLLATE "default" NOT NULL,
"sort" int8 NOT NULL,
"code" varchar(100) COLLATE "default",
"type" char(1) COLLATE "default",
"create_by" varchar(64) COLLATE "default" NOT NULL,
"create_date" timestamp(6) NOT NULL,
"update_by" varchar(64) COLLATE "default" NOT NULL,
"update_date" timestamp(6) NOT NULL,
"remarks" varchar(255) COLLATE "default",
"del_flag" char(1) COLLATE "default" DEFAULT '0'::bpchar NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of sys_area
-- ----------------------------
INSERT INTO "sys_area" VALUES ('1', '0', '0,', '中国', '10', '100000', '1', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', '0', '0');

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS "sys_dict";
CREATE TABLE "sys_dict" (
"id" varchar(64) COLLATE "default" NOT NULL,
"value" varchar(100) COLLATE "default" NOT NULL,
"label" varchar(100) COLLATE "default" NOT NULL,
"type" varchar(100) COLLATE "default" NOT NULL,
"description" varchar(100) COLLATE "default" NOT NULL,
"sort" int8 NOT NULL,
"parent_id" varchar(64) COLLATE "default" DEFAULT '0'::character varying,
"create_by" varchar(64) COLLATE "default" NOT NULL,
"create_date" timestamp(6) NOT NULL,
"update_by" varchar(64) COLLATE "default" NOT NULL,
"update_date" timestamp(6) NOT NULL,
"remarks" varchar(255) COLLATE "default",
"del_flag" char(1) COLLATE "default" DEFAULT '0'::bpchar NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO "sys_dict" VALUES ('1', '0', '正常', 'del_flag', '删除标记', '10', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('10', 'yellow', '黄色', 'color', '颜色值', '40', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('100', 'java.util.Date', 'Date', 'gen_java_type', 'Java类型', '50', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('101', 'com.yonyou.kms.modules.sys.entity.User', 'User', 'gen_java_type', 'Java类型', '60', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('102', 'com.yonyou.kms.modules.sys.entity.Office', 'Office', 'gen_java_type', 'Java类型', '70', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('103', 'com.yonyou.kms.modules.sys.entity.Area', 'Area', 'gen_java_type', 'Java类型', '80', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('104', 'Custom', 'Custom', 'gen_java_type', 'Java类型', '90', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('105', '1', '收藏', 'oa_notify_type', '通知通告类型', '10', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('106', '2', '推荐', 'oa_notify_type', '通知通告类型', '20', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('107', '3', '评论', 'oa_notify_type', '通知通告类型', '30', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('108', '0', '草稿', 'oa_notify_status', '通知通告状态', '10', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('109', '1', '发布', 'oa_notify_status', '通知通告状态', '20', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('11', 'orange', '橙色', 'color', '颜色值', '50', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('110', '0', '未读', 'oa_notify_read', '通知通告状态', '10', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('111', '1', '已读', 'oa_notify_read', '通知通告状态', '20', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('12', 'default', '默认主题', 'theme', '主题方案', '10', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('120', '10', '机构及以上数据(机构之间数据共享)   
', 'sys_data_scope', '数据范围', '110', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('13', 'cerulean', '天蓝主题', 'theme', '主题方案', '20', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('130', '11', '所在公司及以上数据', 'sys_data_scope', '数据范围', '120', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('14', 'readable', '橙色主题', 'theme', '主题方案', '30', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('15', 'united', '红色主题', 'theme', '主题方案', '40', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('16', 'flat', 'Flat主题', 'theme', '主题方案', '60', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('17', '1', '国家', 'sys_area_type', '区域类型', '10', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('18', '2', '省份、直辖市', 'sys_area_type', '区域类型', '20', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('19', '3', '地市', 'sys_area_type', '区域类型', '30', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('2', '1', '删除', 'del_flag', '删除标记', '20', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('20', '4', '区县', 'sys_area_type', '区域类型', '40', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('207', '4', '分享', 'oa_notify_type', '通知通告类型', '40', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('21', '1', '公司', 'sys_office_type', '机构类型', '60', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('22', '2', '部门', 'sys_office_type', '机构类型', '70', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('23', '3', '小组', 'sys_office_type', '机构类型', '80', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('24', '4', '其它', 'sys_office_type', '机构类型', '90', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('25', '1', '综合部', 'sys_office_common', '快捷通用部门', '30', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('26', '2', '开发部', 'sys_office_common', '快捷通用部门', '40', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('27', '3', '人力部', 'sys_office_common', '快捷通用部门', '50', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('28', '1', '一级', 'sys_office_grade', '机构等级', '10', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('29', '2', '二级', 'sys_office_grade', '机构等级', '20', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('3', '1', '显示', 'show_hide', '显示/隐藏', '10', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('30', '3', '三级', 'sys_office_grade', '机构等级', '30', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('31', '4', '四级', 'sys_office_grade', '机构等级', '40', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('32', '1', '所有数据', 'sys_data_scope', '数据范围', '10', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('33', '2', '所在公司及以下数据', 'sys_data_scope', '数据范围', '20', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('34', '3', '所在公司数据', 'sys_data_scope', '数据范围', '30', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('35', '4', '所在部门及以下数据', 'sys_data_scope', '数据范围', '40', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('352', '4', '提交中', 'cms_del_flag_user', '内容状态', '20', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('353', '0', '已发布', 'cms_del_flag_user', '内容状态', '10', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('355', '2', '待审核', 'cms_del_flag_user', '内容状态', '15', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('356', '0', '通过', 'cms_del_flag_label', '标签内容状态', '10', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('357', '1', '待审核', 'cms_del_flag_label', '标签内容状态', '15', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('358', '2', '未通过', 'cms_del_flag_label', '标签内容状态', '20', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('36', '5', '所在部门数据', 'sys_data_scope', '数据范围', '50', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('360', '0', '已发布', 'cms_del_flag_comment', '评论管理状态', '10', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('361', '2', '删除', 'cms_del_flag_comment', '评论管理状态', '15', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('37', '8', '仅本人数据', 'sys_data_scope', '数据范围', '90', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('38', '9', '按明细设置', 'sys_data_scope', '数据范围', '100', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('39', '1', '系统管理', 'sys_user_type', '用户类型', '10', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('4', '0', '隐藏', 'show_hide', '显示/隐藏', '20', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('40', '2', '部门经理', 'sys_user_type', '用户类型', '20', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('41', '3', '普通用户', 'sys_user_type', '用户类型', '30', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('42', 'basic', '基础主题', 'cms_theme', '站点主题', '10', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('43', 'blue', '蓝色主题', 'cms_theme', '站点主题', '20', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('44', 'red', '红色主题', 'cms_theme', '站点主题', '30', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('45', 'article', '知识分类', 'cms_module', '栏目模型', '10', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('46', 'picture', '图片模型', 'cms_module', '栏目模型', '20', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('47', 'download', '下载模型', 'cms_module', '栏目模型', '30', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('48', 'link', '链接模型', 'cms_module', '栏目模型', '40', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('49', 'special', '专题模型', 'cms_module', '栏目模型', '50', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('5', '1', '是', 'yes_no', '是/否', '10', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('50', '0', '默认展现方式', 'cms_show_modes', '展现方式', '10', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('500', '0', '通过', 'cms_del_flag_usertag', '用户标签内容状态', '10', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('501', '1', '待审核', 'cms_del_flag_usertag', '用户标签内容状态', '15', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('51', '1', '首栏目内容列表', 'cms_show_modes', '展现方式', '20', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('52', '2', '栏目第一条内容', 'cms_show_modes', '展现方式', '30', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('53', '0', '已发布', 'cms_del_flag', '内容状态', '10', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('54', '1', '已下架', 'cms_del_flag', '内容状态', '20', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('55', '2', '待审核', 'cms_del_flag', '内容状态', '15', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('56', '1', '首页焦点图', 'cms_posid', '推荐位', '10', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('57', '2', '栏目页文章推荐', 'cms_posid', '推荐位', '20', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('58', '1', '咨询', 'cms_guestbook', '留言板分类', '10', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('59', '2', '建议', 'cms_guestbook', '留言板分类', '20', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('6', '0', '否', 'yes_no', '是/否', '20', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('60', '3', '投诉', 'cms_guestbook', '留言板分类', '30', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('61', '4', '其它', 'cms_guestbook', '留言板分类', '40', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('62', '1', '公休', 'oa_leave_type', '请假类型', '10', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('63', '2', '病假', 'oa_leave_type', '请假类型', '20', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('64', '3', '事假', 'oa_leave_type', '请假类型', '30', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('65', '4', '调休', 'oa_leave_type', '请假类型', '40', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('66', '5', '婚假', 'oa_leave_type', '请假类型', '60', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('67', '1', '接入日志', 'sys_log_type', '日志类型', '30', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('68', '2', '异常日志', 'sys_log_type', '日志类型', '40', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('69', 'leave', '请假流程', 'act_type', '流程类型', '10', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('7', 'red', '红色', 'color', '颜色值', '10', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('70', 'test_audit', '审批测试流程', 'act_type', '流程类型', '20', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('71', '1', '分类1', 'act_category', '流程分类', '10', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('72', '2', '分类2', 'act_category', '流程分类', '20', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('73', 'crud', '增删改查', 'gen_category', '代码生成分类', '10', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('74', 'crud_many', '增删改查（包含从表）', 'gen_category', '代码生成分类', '20', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('75', 'tree', '树结构', 'gen_category', '代码生成分类', '30', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('76', '=', '=', 'gen_query_type', '查询方式', '10', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('77', '!=', '!=', 'gen_query_type', '查询方式', '20', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('78', '&gt;', '&gt;', 'gen_query_type', '查询方式', '30', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('79', '&lt;', '&lt;', 'gen_query_type', '查询方式', '40', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('8', 'green', '绿色', 'color', '颜色值', '20', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('80', 'between', 'Between', 'gen_query_type', '查询方式', '50', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('81', 'like', 'Like', 'gen_query_type', '查询方式', '60', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('82', 'left_like', 'Left Like', 'gen_query_type', '查询方式', '70', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('83', 'right_like', 'Right Like', 'gen_query_type', '查询方式', '80', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('84', 'input', '文本框', 'gen_show_type', '字段生成方案', '10', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('85', 'textarea', '文本域', 'gen_show_type', '字段生成方案', '20', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('86', 'select', '下拉框', 'gen_show_type', '字段生成方案', '30', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('87', 'checkbox', '复选框', 'gen_show_type', '字段生成方案', '40', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('88', 'radiobox', '单选框', 'gen_show_type', '字段生成方案', '50', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('89', 'dateselect', '日期选择', 'gen_show_type', '字段生成方案', '60', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('9', 'blue', '蓝色', 'color', '颜色值', '30', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('90', 'userselect', '人员选择', 'gen_show_type', '字段生成方案', '70', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('91', 'officeselect', '部门选择', 'gen_show_type', '字段生成方案', '80', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('92', 'areaselect', '区域选择', 'gen_show_type', '字段生成方案', '90', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('93', 'String', 'String', 'gen_java_type', 'Java类型', '10', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('94', 'Long', 'Long', 'gen_java_type', 'Java类型', '20', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('95', 'dao', '仅持久层', 'gen_category', '代码生成分类', '40', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('96', '1', '男', 'sex', '性别', '10', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('97', '2', '女', 'sex', '性别', '20', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_dict" VALUES ('98', 'Integer', 'Integer', 'gen_java_type', 'Java类型', '30', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');
INSERT INTO "sys_dict" VALUES ('99', 'Double', 'Double', 'gen_java_type', 'Java类型', '40', '0', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '1');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS "sys_log";
CREATE TABLE "sys_log" (
"id" varchar(64) COLLATE "default" NOT NULL,
"type" char(1) COLLATE "default" DEFAULT '1'::bpchar,
"title" varchar(500) COLLATE "default",
"create_by" varchar(64) COLLATE "default",
"create_date" timestamp(6),
"remote_addr" varchar(255) COLLATE "default",
"user_agent" varchar(255) COLLATE "default",
"request_uri" varchar(255) COLLATE "default",
"method" varchar(5) COLLATE "default",
"params" text COLLATE "default",
"exception" text COLLATE "default"
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of sys_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_mdict
-- ----------------------------
DROP TABLE IF EXISTS "sys_mdict";
CREATE TABLE "sys_mdict" (
"id" varchar(64) COLLATE "default" NOT NULL,
"parent_id" varchar(64) COLLATE "default" NOT NULL,
"parent_ids" varchar(2000) COLLATE "default" NOT NULL,
"name" varchar(100) COLLATE "default" NOT NULL,
"sort" int8 NOT NULL,
"description" varchar(100) COLLATE "default",
"create_by" varchar(64) COLLATE "default" NOT NULL,
"create_date" timestamp(6) NOT NULL,
"update_by" varchar(64) COLLATE "default" NOT NULL,
"update_date" timestamp(6) NOT NULL,
"remarks" varchar(255) COLLATE "default",
"del_flag" char(1) COLLATE "default" DEFAULT '0'::bpchar NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of sys_mdict
-- ----------------------------

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS "sys_menu";
CREATE TABLE "sys_menu" (
"id" varchar(64) COLLATE "default" NOT NULL,
"parent_id" varchar(64) COLLATE "default" NOT NULL,
"parent_ids" varchar(2000) COLLATE "default" NOT NULL,
"name" varchar(100) COLLATE "default" NOT NULL,
"sort" int8 NOT NULL,
"href" varchar(2000) COLLATE "default",
"target" varchar(20) COLLATE "default",
"icon" varchar(100) COLLATE "default",
"is_show" char(1) COLLATE "default" NOT NULL,
"permission" varchar(200) COLLATE "default",
"create_by" varchar(64) COLLATE "default" NOT NULL,
"create_date" timestamp(6) NOT NULL,
"update_by" varchar(64) COLLATE "default" NOT NULL,
"update_date" timestamp(6) NOT NULL,
"remarks" varchar(255) COLLATE "default",
"del_flag" char(1) COLLATE "default" DEFAULT '0'::bpchar NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO "sys_menu" VALUES ('0991ef2474f242109fa20f8be1cf8fc9', '1', '0,1,', '首页', '50', '/cms/f', null, null, '1', 'sys:user', '1', '2015-10-14 15:10:38.422', '1', '2015-10-22 09:53:12.499', null, '0');
INSERT INTO "sys_menu" VALUES ('0ad7b66c70674bef9c1a3ee1f11cc253', '1c492072ef694f29b42d3711b05676f2', '0,1,f7dcbc8cc8d849fc898fa4b18fb41487,1c492072ef694f29b42d3711b05676f2,', '评论记录', '33', '/sys/user/userComment', null, null, '1', null, '1', '2015-10-16 09:25:58.545', '1', '2015-10-22 17:51:02.363', null, '0');
INSERT INTO "sys_menu" VALUES ('1', '0', '0,', '功能菜单', '0', null, null, null, '1', null, '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_menu" VALUES ('13', '2', '0,1,2,', '机构用户', '970', null, null, null, '0', null, '1', '2013-12-08 15:16:19.119', '1', '2015-10-28 09:35:57.263', null, '0');
INSERT INTO "sys_menu" VALUES ('14', '13', '0,1,2,13,', '区域管理', '50', '/sys/area/', null, 'th', '1', 'sys:menu:view', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_menu" VALUES ('15', '14', '0,1,2,13,14,', '查看', '30', null, null, null, '1', 'sys:menu:edit', '1', '2013-12-08 15:16:19.119', '1', '2015-10-28 09:29:09.833', null, '0');
INSERT INTO "sys_menu" VALUES ('16', '14', '0,1,2,13,14,', '修改', '40', null, null, null, '0', null, '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_menu" VALUES ('168fc24fb231483f9635dffffaadd4aa', '1c492072ef694f29b42d3711b05676f2', '0,1,f7dcbc8cc8d849fc898fa4b18fb41487,1c492072ef694f29b42d3711b05676f2,', '我的收藏', '60', '/sys/user/userCollect', null, null, '1', null, '1', '2015-10-16 09:24:57.987', '1', '2015-10-16 10:49:37.377', null, '0');
INSERT INTO "sys_menu" VALUES ('16ef78515d524a81bffc0159bd3b094a', '73c23e3113314dcebe4eb6d234ee3653', '0,1,0991ef2474f242109fa20f8be1cf8fc9,e6b56ff783fd43e29515bbd0f8402751,73c23e3113314dcebe4eb6d234ee3653,', '修改', '90', null, null, null, '0', 'cms:article:edit', '1', '2015-10-29 09:50:26.918', '1', '2015-10-29 09:50:26.918', null, '0');
INSERT INTO "sys_menu" VALUES ('17', '13', '0,1,2,13,', '机构管理', '40', '/sys/office/', null, 'th-large', '1', 'sys:role:view', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_menu" VALUES ('18', '17', '0,1,2,13,17,', '查看', '30', null, null, null, '0', 'sys:role:edit', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_menu" VALUES ('187ab10c1cf2404eb5b621ba5707004c', '1c492072ef694f29b42d3711b05676f2', '0,1,f7dcbc8cc8d849fc898fa4b18fb41487,1c492072ef694f29b42d3711b05676f2,', '我的上传', '30', '/sys/user/uploaded', null, null, '1', null, '1', '2015-10-16 09:24:41.145', '1', '2015-10-16 09:55:38.946', null, '0');
INSERT INTO "sys_menu" VALUES ('1c492072ef694f29b42d3711b05676f2', 'f7dcbc8cc8d849fc898fa4b18fb41487', '0,1,f7dcbc8cc8d849fc898fa4b18fb41487,', '个人中心', '30', null, null, null, '1', null, '1', '2015-10-16 09:24:23.169', '1', '2015-10-16 09:24:23.169', null, '0');
INSERT INTO "sys_menu" VALUES ('2', '1', '0,1,', '菜单', '2000', null, null, null, '1', null, '1', '2013-12-08 15:16:19.119', '1', '2015-10-16 17:01:47.442', null, '0');
INSERT INTO "sys_menu" VALUES ('20', '13', '0,1,2,13,', '用户管理', '30', '/sys/user/index', null, 'user', '1', 'sys:dict:view', '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_menu" VALUES ('22b00a47c1c44ed28ab79be8d6318fcd', '3001e261d2f5420daa42bc7245dbd325', '0,1,27,3001e261d2f5420daa42bc7245dbd325,', '知识统计', '120', '/cms/stats/article', null, null, '1', 'cms:stats:article', '1', '2015-10-13 15:50:02.185', '1', '2015-10-13 16:33:39.081', null, '0');
INSERT INTO "sys_menu" VALUES ('22f7199e005a41be8c73c5a18060ccec', '73c23e3113314dcebe4eb6d234ee3653', '0,1,0991ef2474f242109fa20f8be1cf8fc9,e6b56ff783fd43e29515bbd0f8402751,73c23e3113314dcebe4eb6d234ee3653,', '审核', '30', null, null, null, '0', 'cms:article:audit', '1', '2015-10-29 09:49:51.258', '1', '2015-10-29 09:49:51.258', null, '0');
INSERT INTO "sys_menu" VALUES ('25be531c51ad4a488ffb98acac1dab9e', '1', '0,1,', '知识分类', '930', '/cms/classifyList', null, null, '1', null, '1', '2015-10-14 15:11:51.903', '1', '2015-10-29 08:58:44.565', null, '0');
INSERT INTO "sys_menu" VALUES ('264d42fa4c6a4c6bb2a8931c4bb1f8f4', '3001e261d2f5420daa42bc7245dbd325', '0,1,27,3001e261d2f5420daa42bc7245dbd325,', '知识管理', '30', '/cms/', null, null, '1', 'cms:view', '1', '2015-10-13 15:38:36.82', '1', '2015-10-16 11:00:25.307', null, '0');
INSERT INTO "sys_menu" VALUES ('27', '1', '0,1,', '后台管理', '1000', null, null, null, '1', 'sys:manager', '1', '2013-12-08 15:16:19.119', '1', '2016-01-04 09:20:53.639', null, '0');
INSERT INTO "sys_menu" VALUES ('2ecff12b7cb84b07a10884c9dd6228ff', '3001e261d2f5420daa42bc7245dbd325', '0,1,27,3001e261d2f5420daa42bc7245dbd325,', '知识分类', '90', '/cms/category/', null, null, '1', null, '1', '2015-10-13 15:47:26.518', '1', '2015-10-28 09:38:52.686', null, '0');
INSERT INTO "sys_menu" VALUES ('3', '2', '0,1,2,', '系统设置', '980', null, null, null, '1', null, '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_menu" VALUES ('3001e261d2f5420daa42bc7245dbd325', '27', '0,1,27,', '后台管理', '120', null, null, null, '1', 'sys:office:view', '1', '2015-10-13 15:36:51.916', '1', '2016-01-04 09:20:41.091', null, '0');
INSERT INTO "sys_menu" VALUES ('32194ca386e04a5b8e924157df607268', '1c492072ef694f29b42d3711b05676f2', '0,1,f7dcbc8cc8d849fc898fa4b18fb41487,1c492072ef694f29b42d3711b05676f2,', '我的分享', '90', '/sys/user/userShare', null, null, '1', null, '1', '2015-10-16 09:25:07.74', '1', '2015-10-19 15:55:25.968', null, '0');
INSERT INTO "sys_menu" VALUES ('36248fa585464d4980fe593c636f603a', '264d42fa4c6a4c6bb2a8931c4bb1f8f4', '0,1,27,3001e261d2f5420daa42bc7245dbd325,264d42fa4c6a4c6bb2a8931c4bb1f8f4,', '知识库模型', '30', '/cms/article/', null, null, '0', null, '1', '2015-10-13 15:39:12.982', '1', '2015-11-04 11:00:44.371', null, '0');
INSERT INTO "sys_menu" VALUES ('39d949fbf81e4012be55261c71ec0b9b', 'c191500b31ca43daa42f1823197e7411', '0,1,25be531c51ad4a488ffb98acac1dab9e,c191500b31ca43daa42f1823197e7411,', '审核', '30', null, null, null, '0', 'cms:article:audit', '1', '2015-10-20 16:36:24.995', '1', '2015-10-20 16:36:24.995', null, '0');
INSERT INTO "sys_menu" VALUES ('4', '3', '0,1,2,3,', '菜单管理', '30', '/sys/menu/', null, 'list-alt', '0', null, '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_menu" VALUES ('4a5065fca6b54ae0942e5e2127921bfd', 'd8586fcff069459f9bb4ea1745a02c72', '0,1,27,3001e261d2f5420daa42bc7245dbd325,d8586fcff069459f9bb4ea1745a02c72,', '查看', '30', null, null, null, '0', 'sys:user:view', '1', '2015-10-13 15:52:58.344', '1', '2015-10-13 15:52:58.344', null, '0');
INSERT INTO "sys_menu" VALUES ('5', '4', '0,1,2,3,4,', '查看', '30', null, null, null, '0', null, '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_menu" VALUES ('5f9e9bbef9c94b4d884fd4ab71386fcf', '82f1561c52044b04892856512090a9b1', '0,1,27,3001e261d2f5420daa42bc7245dbd325,82f1561c52044b04892856512090a9b1,', '查看', '30', null, null, null, '0', 'cms:comment:view', '1', '2015-10-13 15:44:38.916', '1', '2015-10-13 15:44:38.916', null, '0');
INSERT INTO "sys_menu" VALUES ('6', '4', '0,1,2,3,4,', '修改', '40', null, null, null, '0', null, '1', '2013-12-08 15:16:19.119', '1', '2013-12-08 15:16:19.119', null, '0');
INSERT INTO "sys_menu" VALUES ('6129d8d4114b40499359c93452325aa5', 'c191500b31ca43daa42f1823197e7411', '0,1,25be531c51ad4a488ffb98acac1dab9e,c191500b31ca43daa42f1823197e7411,', '修改', '90', null, null, null, '0', 'cms:article:edit', '1', '2015-10-20 16:37:03.247', '1', '2015-10-20 16:37:03.247', null, '0');
INSERT INTO "sys_menu" VALUES ('686ea863501841ca90cf039485658256', '1c492072ef694f29b42d3711b05676f2', '0,1,f7dcbc8cc8d849fc898fa4b18fb41487,1c492072ef694f29b42d3711b05676f2,', '关注标签', '130', '/sys/user/myTag', null, null, '1', null, '1', '2015-10-16 16:02:08.35', '1', '2015-10-16 16:06:39.832', null, '0');
INSERT INTO "sys_menu" VALUES ('699e66e048ce4b4186bdad82d5d5b989', 'b959f8ca2f9d4089808533304379efb4', '0,1,27,3001e261d2f5420daa42bc7245dbd325,b959f8ca2f9d4089808533304379efb4,', '查看', '30', null, null, null, '0', 'sys:role:view', '1', '2015-10-13 15:51:15.996', '1', '2015-10-13 15:51:15.996', null, '0');
INSERT INTO "sys_menu" VALUES ('6a0ed27b4c5f4f16bb075f20d8dd8d74', '2ecff12b7cb84b07a10884c9dd6228ff', '0,1,27,3001e261d2f5420daa42bc7245dbd325,2ecff12b7cb84b07a10884c9dd6228ff,', '修改', '60', null, null, null, '0', 'cms:category:edit', '1', '2015-10-13 15:48:30.216', '1', '2015-10-13 15:48:30.216', null, '0');
INSERT INTO "sys_menu" VALUES ('73c23e3113314dcebe4eb6d234ee3653', 'e6b56ff783fd43e29515bbd0f8402751', '0,1,0991ef2474f242109fa20f8be1cf8fc9,e6b56ff783fd43e29515bbd0f8402751,', '知识库模型', '30', '/cms/article/', null, null, '0', null, '1', '2015-10-29 09:49:12.669', '1', '2015-10-29 09:49:28.583', null, '0');
INSERT INTO "sys_menu" VALUES ('7b7aae5c21bc4246b00e1f958d8f317c', '36248fa585464d4980fe593c636f603a', '0,1,27,3001e261d2f5420daa42bc7245dbd325,264d42fa4c6a4c6bb2a8931c4bb1f8f4,36248fa585464d4980fe593c636f603a,', '审核', '30', null, null, null, '0', 'cms:article:audit', '1', '2015-10-13 15:40:29.404', '1', '2015-10-13 15:40:29.404', null, '0');
INSERT INTO "sys_menu" VALUES ('82f1561c52044b04892856512090a9b1', '3001e261d2f5420daa42bc7245dbd325', '0,1,27,3001e261d2f5420daa42bc7245dbd325,', '评论管理', '60', '/cms/comment/initcomment?status=2', null, null, '1', null, '1', '2015-10-13 15:43:38.784', '1', '2015-11-09 14:33:13.504', null, '0');
INSERT INTO "sys_menu" VALUES ('8575c45a2f6541febfd5146205f7c4fd', '1c492072ef694f29b42d3711b05676f2', '0,1,f7dcbc8cc8d849fc898fa4b18fb41487,1c492072ef694f29b42d3711b05676f2,', '个人信息', '25', '/sys/user/info', null, null, '1', null, '1', '2015-12-08 08:57:54.823', '1', '2015-12-08 08:59:53.921', null, '0');
INSERT INTO "sys_menu" VALUES ('8a1246fad5a2404d9615d08fc2167ab3', 'b959f8ca2f9d4089808533304379efb4', '0,1,27,3001e261d2f5420daa42bc7245dbd325,b959f8ca2f9d4089808533304379efb4,', '修改', '60', null, null, null, '0', 'sys:role:view', '1', '2015-10-13 15:51:37.981', '1', '2015-10-13 15:51:37.981', null, '0');
INSERT INTO "sys_menu" VALUES ('8b15cffed40e4948857efe9a6aa5e377', '3001e261d2f5420daa42bc7245dbd325', '0,1,27,3001e261d2f5420daa42bc7245dbd325,', '标签管理', '70', '/cms/tagControl', null, null, '1', null, '1', '2015-10-13 16:35:15.178', '1', '2015-10-31 11:36:25.452', null, '0');
INSERT INTO "sys_menu" VALUES ('94f2fe4d20984bf8ba1f4cf754a61855', 'c191500b31ca43daa42f1823197e7411', '0,1,25be531c51ad4a488ffb98acac1dab9e,c191500b31ca43daa42f1823197e7411,', '查看', '60', null, null, null, '0', 'cms:article:view', '1', '2015-10-20 16:36:44.808', '1', '2015-10-20 16:36:44.808', null, '0');
INSERT INTO "sys_menu" VALUES ('9a7fe964a4924965be38478862a587a9', 'd8586fcff069459f9bb4ea1745a02c72', '0,1,27,3001e261d2f5420daa42bc7245dbd325,d8586fcff069459f9bb4ea1745a02c72,', '修改', '60', null, null, null, '0', 'sys:user:edit', '1', '2015-10-13 15:53:28.815', '1', '2015-10-13 15:53:28.815', null, '0');
INSERT INTO "sys_menu" VALUES ('a092c8f7547e4884958dcacdb74c41a4', '73c23e3113314dcebe4eb6d234ee3653', '0,1,0991ef2474f242109fa20f8be1cf8fc9,e6b56ff783fd43e29515bbd0f8402751,73c23e3113314dcebe4eb6d234ee3653,', '查看', '60', null, null, null, '0', 'cms:article:view', '1', '2015-10-29 09:50:09.365', '1', '2015-10-29 09:50:09.365', null, '0');
INSERT INTO "sys_menu" VALUES ('ad4a9dafccc54dc28823b1f7d325b41e', '36248fa585464d4980fe593c636f603a', '0,1,27,3001e261d2f5420daa42bc7245dbd325,264d42fa4c6a4c6bb2a8931c4bb1f8f4,36248fa585464d4980fe593c636f603a,', '查看', '60', null, null, null, '0', 'cms:article:view', '1', '2015-10-13 15:40:59.085', '1', '2015-10-13 15:40:59.085', null, '0');
INSERT INTO "sys_menu" VALUES ('b2d6804530794ddeb7787e17db08d300', '3001e261d2f5420daa42bc7245dbd325', '0,1,27,3001e261d2f5420daa42bc7245dbd325,', '首页定制', '240', '/cms/frontswitch', null, null, '1', null, '1', '2015-12-07 13:52:27.595', '1', '2015-12-08 09:41:39.952', null, '0');
INSERT INTO "sys_menu" VALUES ('b959f8ca2f9d4089808533304379efb4', '3001e261d2f5420daa42bc7245dbd325', '0,1,27,3001e261d2f5420daa42bc7245dbd325,', '角色管理', '150', '/sys/role/', null, null, '1', null, '1', '2015-10-13 15:50:50.441', '1', '2015-10-13 16:34:02.86', null, '0');
INSERT INTO "sys_menu" VALUES ('c191500b31ca43daa42f1823197e7411', '25be531c51ad4a488ffb98acac1dab9e', '0,1,25be531c51ad4a488ffb98acac1dab9e,', '知识库模型', '30', '/cms/article/', null, null, '0', null, '1', '2015-10-20 16:35:41.331', '1', '2015-10-20 16:35:41.331', null, '0');
INSERT INTO "sys_menu" VALUES ('c4804996c0f64f769e621e9438c19487', '25be531c51ad4a488ffb98acac1dab9e', '0,1,25be531c51ad4a488ffb98acac1dab9e,', '下载权限', '60', null, null, null, '0', 'sys:article:upload', '1', '2016-01-06 13:22:33.395', '1', '2016-01-06 13:22:33.395', null, '0');
INSERT INTO "sys_menu" VALUES ('cca30ab1b0004038b4c2620b64c39d61', '1c492072ef694f29b42d3711b05676f2', '0,1,f7dcbc8cc8d849fc898fa4b18fb41487,1c492072ef694f29b42d3711b05676f2,', '我的推荐', '160', '/sys/user/userRecommend', null, null, '1', null, '1', '2015-10-29 11:19:58.309', '1', '2015-10-29 11:19:58.309', null, '0');
INSERT INTO "sys_menu" VALUES ('d8586fcff069459f9bb4ea1745a02c72', '3001e261d2f5420daa42bc7245dbd325', '0,1,27,3001e261d2f5420daa42bc7245dbd325,', '用户管理', '180', '/sys/user/index', null, null, '1', null, '1', '2015-10-13 15:52:38.002', '1', '2015-10-13 15:52:38.002', null, '0');
INSERT INTO "sys_menu" VALUES ('e6b56ff783fd43e29515bbd0f8402751', '0991ef2474f242109fa20f8be1cf8fc9', '0,1,0991ef2474f242109fa20f8be1cf8fc9,', '发布权限', '30', null, null, null, '0', 'cms:view', '1', '2015-10-29 09:48:13.229', '1', '2015-10-29 09:48:52.22', null, '0');
INSERT INTO "sys_menu" VALUES ('e91a9d751d4749c0b4b84ca93cd3ec45', '1c492072ef694f29b42d3711b05676f2', '0,1,f7dcbc8cc8d849fc898fa4b18fb41487,1c492072ef694f29b42d3711b05676f2,', '我的消息', '20', '/sys/user/userMessage', null, null, '1', null, '1', '2015-11-02 13:30:45.052', '1', '2015-11-02 13:30:45.052', null, '0');
INSERT INTO "sys_menu" VALUES ('eb9e2fa24e744420b9878a1b7717dbcd', '3001e261d2f5420daa42bc7245dbd325', '0,1,27,3001e261d2f5420daa42bc7245dbd325,', '合并知识分类权限', '210', null, null, null, '0', 'sys:category:merge', '1', '2015-11-12 15:02:37', '1', '2015-11-12 15:02:37', null, '0');
INSERT INTO "sys_menu" VALUES ('eee9a5db959a47f093daac0f41e78ff6', '82f1561c52044b04892856512090a9b1', '0,1,27,3001e261d2f5420daa42bc7245dbd325,82f1561c52044b04892856512090a9b1,', '审核', '60', null, null, null, '0', 'cms:comment:edit', '1', '2015-10-13 15:45:03.741', '1', '2015-10-13 15:45:03.741', null, '0');
INSERT INTO "sys_menu" VALUES ('f7dcbc8cc8d849fc898fa4b18fb41487', '1', '0,1,', '个人中心', '950', null, null, null, '1', 'sys:office:edit', '1', '2015-10-14 15:21:08.984', '1', '2015-10-16 09:27:18.059', null, '0');
INSERT INTO "sys_menu" VALUES ('fc36c1a2668044aeb34253c9232ad837', '2ecff12b7cb84b07a10884c9dd6228ff', '0,1,27,3001e261d2f5420daa42bc7245dbd325,2ecff12b7cb84b07a10884c9dd6228ff,', '查看', '30', null, null, null, '0', 'cms:category:view', '1', '2015-10-13 15:48:15.079', '1', '2015-10-13 15:48:15.079', null, '0');
INSERT INTO "sys_menu" VALUES ('fee942d02e7c4bffa8a1b865e68a4333', '36248fa585464d4980fe593c636f603a', '0,1,27,3001e261d2f5420daa42bc7245dbd325,264d42fa4c6a4c6bb2a8931c4bb1f8f4,36248fa585464d4980fe593c636f603a,', '修改', '90', null, null, null, '0', 'cms:article:edit', '1', '2015-10-13 15:41:27.596', '1', '2015-10-13 15:41:27.596', null, '0');

-- ----------------------------
-- Table structure for sys_office
-- ----------------------------
DROP TABLE IF EXISTS "sys_office";
CREATE TABLE "sys_office" (
"id" varchar(64) COLLATE "default" NOT NULL,
"parent_id" varchar(64) COLLATE "default" NOT NULL,
"parent_ids" varchar(2000) COLLATE "default" NOT NULL,
"name" varchar(100) COLLATE "default" NOT NULL,
"sort" int8 NOT NULL,
"area_id" varchar(64) COLLATE "default" NOT NULL,
"code" varchar(100) COLLATE "default",
"type" char(1) COLLATE "default" NOT NULL,
"grade" char(1) COLLATE "default" NOT NULL,
"address" varchar(255) COLLATE "default",
"zip_code" varchar(100) COLLATE "default",
"master" varchar(100) COLLATE "default",
"phone" varchar(200) COLLATE "default",
"fax" varchar(200) COLLATE "default",
"email" varchar(200) COLLATE "default",
"useable" varchar(64) COLLATE "default",
"primary_person" varchar(64) COLLATE "default",
"deputy_person" varchar(64) COLLATE "default",
"create_by" varchar(64) COLLATE "default" NOT NULL,
"create_date" timestamp(6) NOT NULL,
"update_by" varchar(64) COLLATE "default" NOT NULL,
"update_date" timestamp(6) NOT NULL,
"remarks" varchar(255) COLLATE "default",
"del_flag" char(1) COLLATE "default" DEFAULT '0'::bpchar NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of sys_office
-- ----------------------------
INSERT INTO "sys_office" VALUES ('1', '0', '0,', '系统', '10', '1', '100000', '1', '1', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO "sys_office" VALUES ('2', '1', '0,1,', '管理员', '10', '1', '100001', '2', '1', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS "sys_role";
CREATE TABLE "sys_role" (
"id" varchar(64) COLLATE "default" NOT NULL,
"office_id" varchar(64) COLLATE "default",
"name" varchar(100) COLLATE "default" NOT NULL,
"enname" varchar(255) COLLATE "default",
"role_type" varchar(255) COLLATE "default",
"data_scope" varchar(20) COLLATE "default",
"is_sys" varchar(64) COLLATE "default",
"useable" varchar(64) COLLATE "default",
"create_by" varchar(64) COLLATE "default" NOT NULL,
"create_date" timestamp(6) NOT NULL,
"update_by" varchar(64) COLLATE "default" NOT NULL,
"update_date" timestamp(6) NOT NULL,
"remarks" varchar(255) COLLATE "default",
"del_flag" char(1) COLLATE "default" DEFAULT '0'::bpchar NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO "sys_role" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', '1', '审核管理员', 'audiManager', null, '4', '1', '1', '1', '2015-11-02 10:46:00.431', '1', '2016-01-06 16:53:18.481', null, '0');
INSERT INTO "sys_role" VALUES ('1', '1', '系统管理员', 'SysManager', 'a,assignment,assignment', '1', '1', '1', '1', '2013-12-08 15:16:19.119', '1', '2016-01-06 17:00:37.409', null, '0');
INSERT INTO "sys_role" VALUES ('3', '1', '本公司管理员', 'CompanyManager', 'assignment,assignment,assignment', '2', '1', '1', '1', '2013-12-08 15:16:19.119', '1', '2016-01-06 16:53:59.418', null, '0');
INSERT INTO "sys_role" VALUES ('5', '1', '本部门管理员', 'DeptManager', 'assignment,assignment,assignment,assignment', '4', '1', '1', '1', '2013-12-08 15:16:19.119', '1', '2016-01-06 16:54:18.254', null, '0');
INSERT INTO "sys_role" VALUES ('6', '1', '普通用户', 'SimpleUser', 's,assignment,assignment,assignment', '10', '1', '1', '1', '2013-12-08 15:16:19.119', '1', '2016-01-06 16:53:33.765', null, '0');
INSERT INTO "sys_role" VALUES ('d8ed67233dd641a59e6bba9c82c76511', '1', '知识附件下载角色', 'articleUpload', null, '1', '1', '1', '1', '2016-01-06 13:25:52.648', '1', '2016-01-06 17:00:26.524', null, '0');

-- ----------------------------
-- Table structure for sys_role_category
-- ----------------------------
DROP TABLE IF EXISTS "sys_role_category";
CREATE TABLE "sys_role_category" (
"role_id" varchar(64) COLLATE "default" NOT NULL,
"category_id" varchar(64) COLLATE "default" NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of sys_role_category
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS "sys_role_menu";
CREATE TABLE "sys_role_menu" (
"role_id" varchar(64) COLLATE "default" NOT NULL,
"menu_id" varchar(64) COLLATE "default" NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', '0991ef2474f242109fa20f8be1cf8fc9');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', '0ad7b66c70674bef9c1a3ee1f11cc253');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', '1');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', '168fc24fb231483f9635dffffaadd4aa');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', '16ef78515d524a81bffc0159bd3b094a');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', '187ab10c1cf2404eb5b621ba5707004c');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', '1c492072ef694f29b42d3711b05676f2');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', '22f7199e005a41be8c73c5a18060ccec');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', '25be531c51ad4a488ffb98acac1dab9e');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', '264d42fa4c6a4c6bb2a8931c4bb1f8f4');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', '27');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', '3001e261d2f5420daa42bc7245dbd325');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', '32194ca386e04a5b8e924157df607268');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', '36248fa585464d4980fe593c636f603a');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', '39d949fbf81e4012be55261c71ec0b9b');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', '5f9e9bbef9c94b4d884fd4ab71386fcf');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', '6129d8d4114b40499359c93452325aa5');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', '686ea863501841ca90cf039485658256');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', '73c23e3113314dcebe4eb6d234ee3653');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', '7b7aae5c21bc4246b00e1f958d8f317c');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', '82f1561c52044b04892856512090a9b1');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', '8575c45a2f6541febfd5146205f7c4fd');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', '94f2fe4d20984bf8ba1f4cf754a61855');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', 'a092c8f7547e4884958dcacdb74c41a4');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', 'ad4a9dafccc54dc28823b1f7d325b41e');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', 'c191500b31ca43daa42f1823197e7411');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', 'cca30ab1b0004038b4c2620b64c39d61');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', 'e6b56ff783fd43e29515bbd0f8402751');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', 'e91a9d751d4749c0b4b84ca93cd3ec45');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', 'eee9a5db959a47f093daac0f41e78ff6');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', 'f7dcbc8cc8d849fc898fa4b18fb41487');
INSERT INTO "sys_role_menu" VALUES ('031fdd2fe88f4853a92199bf7d7c2ee6', 'fee942d02e7c4bffa8a1b865e68a4333');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '0991ef2474f242109fa20f8be1cf8fc9');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '0ad7b66c70674bef9c1a3ee1f11cc253');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '1');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '13');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '14');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '15');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '16');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '168fc24fb231483f9635dffffaadd4aa');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '16ef78515d524a81bffc0159bd3b094a');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '17');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '18');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '187ab10c1cf2404eb5b621ba5707004c');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '1c492072ef694f29b42d3711b05676f2');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '2');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '20');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '22f7199e005a41be8c73c5a18060ccec');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '25be531c51ad4a488ffb98acac1dab9e');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '264d42fa4c6a4c6bb2a8931c4bb1f8f4');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '27');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '3');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '3001e261d2f5420daa42bc7245dbd325');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '32194ca386e04a5b8e924157df607268');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '36248fa585464d4980fe593c636f603a');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '39d949fbf81e4012be55261c71ec0b9b');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '4');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '5');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '6');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '6129d8d4114b40499359c93452325aa5');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '686ea863501841ca90cf039485658256');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '73c23e3113314dcebe4eb6d234ee3653');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', '94f2fe4d20984bf8ba1f4cf754a61855');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', 'a092c8f7547e4884958dcacdb74c41a4');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', 'ad4a9dafccc54dc28823b1f7d325b41e');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', 'c191500b31ca43daa42f1823197e7411');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', 'cca30ab1b0004038b4c2620b64c39d61');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', 'e6b56ff783fd43e29515bbd0f8402751');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', 'e91a9d751d4749c0b4b84ca93cd3ec45');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', 'f7dcbc8cc8d849fc898fa4b18fb41487');
INSERT INTO "sys_role_menu" VALUES ('075f02f73ce64b80b7dcad1c86419dd3', 'fee942d02e7c4bffa8a1b865e68a4333');
INSERT INTO "sys_role_menu" VALUES ('1', '0991ef2474f242109fa20f8be1cf8fc9');
INSERT INTO "sys_role_menu" VALUES ('1', '0ad7b66c70674bef9c1a3ee1f11cc253');
INSERT INTO "sys_role_menu" VALUES ('1', '1');
INSERT INTO "sys_role_menu" VALUES ('1', '13');
INSERT INTO "sys_role_menu" VALUES ('1', '14');
INSERT INTO "sys_role_menu" VALUES ('1', '15');
INSERT INTO "sys_role_menu" VALUES ('1', '16');
INSERT INTO "sys_role_menu" VALUES ('1', '168fc24fb231483f9635dffffaadd4aa');
INSERT INTO "sys_role_menu" VALUES ('1', '16ef78515d524a81bffc0159bd3b094a');
INSERT INTO "sys_role_menu" VALUES ('1', '17');
INSERT INTO "sys_role_menu" VALUES ('1', '18');
INSERT INTO "sys_role_menu" VALUES ('1', '187ab10c1cf2404eb5b621ba5707004c');
INSERT INTO "sys_role_menu" VALUES ('1', '1c492072ef694f29b42d3711b05676f2');
INSERT INTO "sys_role_menu" VALUES ('1', '2');
INSERT INTO "sys_role_menu" VALUES ('1', '20');
INSERT INTO "sys_role_menu" VALUES ('1', '22b00a47c1c44ed28ab79be8d6318fcd');
INSERT INTO "sys_role_menu" VALUES ('1', '22f7199e005a41be8c73c5a18060ccec');
INSERT INTO "sys_role_menu" VALUES ('1', '25be531c51ad4a488ffb98acac1dab9e');
INSERT INTO "sys_role_menu" VALUES ('1', '264d42fa4c6a4c6bb2a8931c4bb1f8f4');
INSERT INTO "sys_role_menu" VALUES ('1', '27');
INSERT INTO "sys_role_menu" VALUES ('1', '2ecff12b7cb84b07a10884c9dd6228ff');
INSERT INTO "sys_role_menu" VALUES ('1', '3');
INSERT INTO "sys_role_menu" VALUES ('1', '3001e261d2f5420daa42bc7245dbd325');
INSERT INTO "sys_role_menu" VALUES ('1', '32194ca386e04a5b8e924157df607268');
INSERT INTO "sys_role_menu" VALUES ('1', '36248fa585464d4980fe593c636f603a');
INSERT INTO "sys_role_menu" VALUES ('1', '39d949fbf81e4012be55261c71ec0b9b');
INSERT INTO "sys_role_menu" VALUES ('1', '4');
INSERT INTO "sys_role_menu" VALUES ('1', '4a5065fca6b54ae0942e5e2127921bfd');
INSERT INTO "sys_role_menu" VALUES ('1', '5');
INSERT INTO "sys_role_menu" VALUES ('1', '5f9e9bbef9c94b4d884fd4ab71386fcf');
INSERT INTO "sys_role_menu" VALUES ('1', '6');
INSERT INTO "sys_role_menu" VALUES ('1', '6129d8d4114b40499359c93452325aa5');
INSERT INTO "sys_role_menu" VALUES ('1', '686ea863501841ca90cf039485658256');
INSERT INTO "sys_role_menu" VALUES ('1', '699e66e048ce4b4186bdad82d5d5b989');
INSERT INTO "sys_role_menu" VALUES ('1', '6a0ed27b4c5f4f16bb075f20d8dd8d74');
INSERT INTO "sys_role_menu" VALUES ('1', '73c23e3113314dcebe4eb6d234ee3653');
INSERT INTO "sys_role_menu" VALUES ('1', '7b7aae5c21bc4246b00e1f958d8f317c');
INSERT INTO "sys_role_menu" VALUES ('1', '82f1561c52044b04892856512090a9b1');
INSERT INTO "sys_role_menu" VALUES ('1', '8575c45a2f6541febfd5146205f7c4fd');
INSERT INTO "sys_role_menu" VALUES ('1', '8a1246fad5a2404d9615d08fc2167ab3');
INSERT INTO "sys_role_menu" VALUES ('1', '8b15cffed40e4948857efe9a6aa5e377');
INSERT INTO "sys_role_menu" VALUES ('1', '94f2fe4d20984bf8ba1f4cf754a61855');
INSERT INTO "sys_role_menu" VALUES ('1', '9a7fe964a4924965be38478862a587a9');
INSERT INTO "sys_role_menu" VALUES ('1', 'a092c8f7547e4884958dcacdb74c41a4');
INSERT INTO "sys_role_menu" VALUES ('1', 'ad4a9dafccc54dc28823b1f7d325b41e');
INSERT INTO "sys_role_menu" VALUES ('1', 'b2d6804530794ddeb7787e17db08d300');
INSERT INTO "sys_role_menu" VALUES ('1', 'b959f8ca2f9d4089808533304379efb4');
INSERT INTO "sys_role_menu" VALUES ('1', 'c191500b31ca43daa42f1823197e7411');
INSERT INTO "sys_role_menu" VALUES ('1', 'cca30ab1b0004038b4c2620b64c39d61');
INSERT INTO "sys_role_menu" VALUES ('1', 'd8586fcff069459f9bb4ea1745a02c72');
INSERT INTO "sys_role_menu" VALUES ('1', 'e6b56ff783fd43e29515bbd0f8402751');
INSERT INTO "sys_role_menu" VALUES ('1', 'e91a9d751d4749c0b4b84ca93cd3ec45');
INSERT INTO "sys_role_menu" VALUES ('1', 'eb9e2fa24e744420b9878a1b7717dbcd');
INSERT INTO "sys_role_menu" VALUES ('1', 'eee9a5db959a47f093daac0f41e78ff6');
INSERT INTO "sys_role_menu" VALUES ('1', 'f7dcbc8cc8d849fc898fa4b18fb41487');
INSERT INTO "sys_role_menu" VALUES ('1', 'fc36c1a2668044aeb34253c9232ad837');
INSERT INTO "sys_role_menu" VALUES ('1', 'fee942d02e7c4bffa8a1b865e68a4333');
INSERT INTO "sys_role_menu" VALUES ('2', '0991ef2474f242109fa20f8be1cf8fc9');
INSERT INTO "sys_role_menu" VALUES ('2', '0ad7b66c70674bef9c1a3ee1f11cc253');
INSERT INTO "sys_role_menu" VALUES ('2', '0b439e8fb5cd47098266c6fef087bf33');
INSERT INTO "sys_role_menu" VALUES ('2', '1');
INSERT INTO "sys_role_menu" VALUES ('2', '12');
INSERT INTO "sys_role_menu" VALUES ('2', '168fc24fb231483f9635dffffaadd4aa');
INSERT INTO "sys_role_menu" VALUES ('2', '187ab10c1cf2404eb5b621ba5707004c');
INSERT INTO "sys_role_menu" VALUES ('2', '1c492072ef694f29b42d3711b05676f2');
INSERT INTO "sys_role_menu" VALUES ('2', '22b00a47c1c44ed28ab79be8d6318fcd');
INSERT INTO "sys_role_menu" VALUES ('2', '25be531c51ad4a488ffb98acac1dab9e');
INSERT INTO "sys_role_menu" VALUES ('2', '264d42fa4c6a4c6bb2a8931c4bb1f8f4');
INSERT INTO "sys_role_menu" VALUES ('2', '27');
INSERT INTO "sys_role_menu" VALUES ('2', '28');
INSERT INTO "sys_role_menu" VALUES ('2', '29');
INSERT INTO "sys_role_menu" VALUES ('2', '2ecff12b7cb84b07a10884c9dd6228ff');
INSERT INTO "sys_role_menu" VALUES ('2', '3001e261d2f5420daa42bc7245dbd325');
INSERT INTO "sys_role_menu" VALUES ('2', '32194ca386e04a5b8e924157df607268');
INSERT INTO "sys_role_menu" VALUES ('2', '36248fa585464d4980fe593c636f603a');
INSERT INTO "sys_role_menu" VALUES ('2', '39d949fbf81e4012be55261c71ec0b9b');
INSERT INTO "sys_role_menu" VALUES ('2', '4a5065fca6b54ae0942e5e2127921bfd');
INSERT INTO "sys_role_menu" VALUES ('2', '57');
INSERT INTO "sys_role_menu" VALUES ('2', '58');
INSERT INTO "sys_role_menu" VALUES ('2', '59');
INSERT INTO "sys_role_menu" VALUES ('2', '5c665741a1d54320a66822639737eb7f');
INSERT INTO "sys_role_menu" VALUES ('2', '5f9e9bbef9c94b4d884fd4ab71386fcf');
INSERT INTO "sys_role_menu" VALUES ('2', '6129d8d4114b40499359c93452325aa5');
INSERT INTO "sys_role_menu" VALUES ('2', '686ea863501841ca90cf039485658256');
INSERT INTO "sys_role_menu" VALUES ('2', '699e66e048ce4b4186bdad82d5d5b989');
INSERT INTO "sys_role_menu" VALUES ('2', '6a0ed27b4c5f4f16bb075f20d8dd8d74');
INSERT INTO "sys_role_menu" VALUES ('2', '7090ea3f51ce47b0bfa8432835df4ed7');
INSERT INTO "sys_role_menu" VALUES ('2', '71649709c09648669c706b00b5cfd198');
INSERT INTO "sys_role_menu" VALUES ('2', '7b7aae5c21bc4246b00e1f958d8f317c');
INSERT INTO "sys_role_menu" VALUES ('2', '82f1561c52044b04892856512090a9b1');
INSERT INTO "sys_role_menu" VALUES ('2', '85');
INSERT INTO "sys_role_menu" VALUES ('2', '8526b51ab687425ca8037ab2525ad07c');
INSERT INTO "sys_role_menu" VALUES ('2', '8a1246fad5a2404d9615d08fc2167ab3');
INSERT INTO "sys_role_menu" VALUES ('2', '8b15cffed40e4948857efe9a6aa5e377');
INSERT INTO "sys_role_menu" VALUES ('2', '94f2fe4d20984bf8ba1f4cf754a61855');
INSERT INTO "sys_role_menu" VALUES ('2', '9a7fe964a4924965be38478862a587a9');
INSERT INTO "sys_role_menu" VALUES ('2', '9cc708571c044e50891268ba1a753697');
INSERT INTO "sys_role_menu" VALUES ('2', 'ad4a9dafccc54dc28823b1f7d325b41e');
INSERT INTO "sys_role_menu" VALUES ('2', 'b959f8ca2f9d4089808533304379efb4');
INSERT INTO "sys_role_menu" VALUES ('2', 'c191500b31ca43daa42f1823197e7411');
INSERT INTO "sys_role_menu" VALUES ('2', 'd8586fcff069459f9bb4ea1745a02c72');
INSERT INTO "sys_role_menu" VALUES ('2', 'eee9a5db959a47f093daac0f41e78ff6');
INSERT INTO "sys_role_menu" VALUES ('2', 'f1e0e09fe7b0441eadf5703ebdb8e202');
INSERT INTO "sys_role_menu" VALUES ('2', 'f23ab4a51db64ea08e7f881a2e117c79');
INSERT INTO "sys_role_menu" VALUES ('2', 'f7dcbc8cc8d849fc898fa4b18fb41487');
INSERT INTO "sys_role_menu" VALUES ('2', 'fc36c1a2668044aeb34253c9232ad837');
INSERT INTO "sys_role_menu" VALUES ('2', 'fee942d02e7c4bffa8a1b865e68a4333');
INSERT INTO "sys_role_menu" VALUES ('3', '0991ef2474f242109fa20f8be1cf8fc9');
INSERT INTO "sys_role_menu" VALUES ('3', '0ad7b66c70674bef9c1a3ee1f11cc253');
INSERT INTO "sys_role_menu" VALUES ('3', '1');
INSERT INTO "sys_role_menu" VALUES ('3', '168fc24fb231483f9635dffffaadd4aa');
INSERT INTO "sys_role_menu" VALUES ('3', '16ef78515d524a81bffc0159bd3b094a');
INSERT INTO "sys_role_menu" VALUES ('3', '187ab10c1cf2404eb5b621ba5707004c');
INSERT INTO "sys_role_menu" VALUES ('3', '1c492072ef694f29b42d3711b05676f2');
INSERT INTO "sys_role_menu" VALUES ('3', '22f7199e005a41be8c73c5a18060ccec');
INSERT INTO "sys_role_menu" VALUES ('3', '25be531c51ad4a488ffb98acac1dab9e');
INSERT INTO "sys_role_menu" VALUES ('3', '264d42fa4c6a4c6bb2a8931c4bb1f8f4');
INSERT INTO "sys_role_menu" VALUES ('3', '27');
INSERT INTO "sys_role_menu" VALUES ('3', '2ecff12b7cb84b07a10884c9dd6228ff');
INSERT INTO "sys_role_menu" VALUES ('3', '3001e261d2f5420daa42bc7245dbd325');
INSERT INTO "sys_role_menu" VALUES ('3', '32194ca386e04a5b8e924157df607268');
INSERT INTO "sys_role_menu" VALUES ('3', '36248fa585464d4980fe593c636f603a');
INSERT INTO "sys_role_menu" VALUES ('3', '39d949fbf81e4012be55261c71ec0b9b');
INSERT INTO "sys_role_menu" VALUES ('3', '5f9e9bbef9c94b4d884fd4ab71386fcf');
INSERT INTO "sys_role_menu" VALUES ('3', '6129d8d4114b40499359c93452325aa5');
INSERT INTO "sys_role_menu" VALUES ('3', '686ea863501841ca90cf039485658256');
INSERT INTO "sys_role_menu" VALUES ('3', '6a0ed27b4c5f4f16bb075f20d8dd8d74');
INSERT INTO "sys_role_menu" VALUES ('3', '73c23e3113314dcebe4eb6d234ee3653');
INSERT INTO "sys_role_menu" VALUES ('3', '7b7aae5c21bc4246b00e1f958d8f317c');
INSERT INTO "sys_role_menu" VALUES ('3', '82f1561c52044b04892856512090a9b1');
INSERT INTO "sys_role_menu" VALUES ('3', '8575c45a2f6541febfd5146205f7c4fd');
INSERT INTO "sys_role_menu" VALUES ('3', '94f2fe4d20984bf8ba1f4cf754a61855');
INSERT INTO "sys_role_menu" VALUES ('3', 'a092c8f7547e4884958dcacdb74c41a4');
INSERT INTO "sys_role_menu" VALUES ('3', 'ad4a9dafccc54dc28823b1f7d325b41e');
INSERT INTO "sys_role_menu" VALUES ('3', 'c191500b31ca43daa42f1823197e7411');
INSERT INTO "sys_role_menu" VALUES ('3', 'cca30ab1b0004038b4c2620b64c39d61');
INSERT INTO "sys_role_menu" VALUES ('3', 'e6b56ff783fd43e29515bbd0f8402751');
INSERT INTO "sys_role_menu" VALUES ('3', 'e91a9d751d4749c0b4b84ca93cd3ec45');
INSERT INTO "sys_role_menu" VALUES ('3', 'eee9a5db959a47f093daac0f41e78ff6');
INSERT INTO "sys_role_menu" VALUES ('3', 'f7dcbc8cc8d849fc898fa4b18fb41487');
INSERT INTO "sys_role_menu" VALUES ('3', 'fc36c1a2668044aeb34253c9232ad837');
INSERT INTO "sys_role_menu" VALUES ('3', 'fee942d02e7c4bffa8a1b865e68a4333');
INSERT INTO "sys_role_menu" VALUES ('4', '0991ef2474f242109fa20f8be1cf8fc9');
INSERT INTO "sys_role_menu" VALUES ('4', '0ad7b66c70674bef9c1a3ee1f11cc253');
INSERT INTO "sys_role_menu" VALUES ('4', '1');
INSERT INTO "sys_role_menu" VALUES ('4', '168fc24fb231483f9635dffffaadd4aa');
INSERT INTO "sys_role_menu" VALUES ('4', '187ab10c1cf2404eb5b621ba5707004c');
INSERT INTO "sys_role_menu" VALUES ('4', '1c492072ef694f29b42d3711b05676f2');
INSERT INTO "sys_role_menu" VALUES ('4', '22b00a47c1c44ed28ab79be8d6318fcd');
INSERT INTO "sys_role_menu" VALUES ('4', '25be531c51ad4a488ffb98acac1dab9e');
INSERT INTO "sys_role_menu" VALUES ('4', '264d42fa4c6a4c6bb2a8931c4bb1f8f4');
INSERT INTO "sys_role_menu" VALUES ('4', '27');
INSERT INTO "sys_role_menu" VALUES ('4', '2ecff12b7cb84b07a10884c9dd6228ff');
INSERT INTO "sys_role_menu" VALUES ('4', '3001e261d2f5420daa42bc7245dbd325');
INSERT INTO "sys_role_menu" VALUES ('4', '32194ca386e04a5b8e924157df607268');
INSERT INTO "sys_role_menu" VALUES ('4', '36248fa585464d4980fe593c636f603a');
INSERT INTO "sys_role_menu" VALUES ('4', '39d949fbf81e4012be55261c71ec0b9b');
INSERT INTO "sys_role_menu" VALUES ('4', '4a5065fca6b54ae0942e5e2127921bfd');
INSERT INTO "sys_role_menu" VALUES ('4', '5f9e9bbef9c94b4d884fd4ab71386fcf');
INSERT INTO "sys_role_menu" VALUES ('4', '6129d8d4114b40499359c93452325aa5');
INSERT INTO "sys_role_menu" VALUES ('4', '686ea863501841ca90cf039485658256');
INSERT INTO "sys_role_menu" VALUES ('4', '699e66e048ce4b4186bdad82d5d5b989');
INSERT INTO "sys_role_menu" VALUES ('4', '6a0ed27b4c5f4f16bb075f20d8dd8d74');
INSERT INTO "sys_role_menu" VALUES ('4', '7b7aae5c21bc4246b00e1f958d8f317c');
INSERT INTO "sys_role_menu" VALUES ('4', '82f1561c52044b04892856512090a9b1');
INSERT INTO "sys_role_menu" VALUES ('4', '8a1246fad5a2404d9615d08fc2167ab3');
INSERT INTO "sys_role_menu" VALUES ('4', '8b15cffed40e4948857efe9a6aa5e377');
INSERT INTO "sys_role_menu" VALUES ('4', '94f2fe4d20984bf8ba1f4cf754a61855');
INSERT INTO "sys_role_menu" VALUES ('4', '9a7fe964a4924965be38478862a587a9');
INSERT INTO "sys_role_menu" VALUES ('4', 'ad4a9dafccc54dc28823b1f7d325b41e');
INSERT INTO "sys_role_menu" VALUES ('4', 'b959f8ca2f9d4089808533304379efb4');
INSERT INTO "sys_role_menu" VALUES ('4', 'c191500b31ca43daa42f1823197e7411');
INSERT INTO "sys_role_menu" VALUES ('4', 'd8586fcff069459f9bb4ea1745a02c72');
INSERT INTO "sys_role_menu" VALUES ('4', 'eee9a5db959a47f093daac0f41e78ff6');
INSERT INTO "sys_role_menu" VALUES ('4', 'f7dcbc8cc8d849fc898fa4b18fb41487');
INSERT INTO "sys_role_menu" VALUES ('4', 'fc36c1a2668044aeb34253c9232ad837');
INSERT INTO "sys_role_menu" VALUES ('4', 'fee942d02e7c4bffa8a1b865e68a4333');
INSERT INTO "sys_role_menu" VALUES ('5', '0991ef2474f242109fa20f8be1cf8fc9');
INSERT INTO "sys_role_menu" VALUES ('5', '0ad7b66c70674bef9c1a3ee1f11cc253');
INSERT INTO "sys_role_menu" VALUES ('5', '1');
INSERT INTO "sys_role_menu" VALUES ('5', '168fc24fb231483f9635dffffaadd4aa');
INSERT INTO "sys_role_menu" VALUES ('5', '16ef78515d524a81bffc0159bd3b094a');
INSERT INTO "sys_role_menu" VALUES ('5', '187ab10c1cf2404eb5b621ba5707004c');
INSERT INTO "sys_role_menu" VALUES ('5', '1c492072ef694f29b42d3711b05676f2');
INSERT INTO "sys_role_menu" VALUES ('5', '22f7199e005a41be8c73c5a18060ccec');
INSERT INTO "sys_role_menu" VALUES ('5', '25be531c51ad4a488ffb98acac1dab9e');
INSERT INTO "sys_role_menu" VALUES ('5', '264d42fa4c6a4c6bb2a8931c4bb1f8f4');
INSERT INTO "sys_role_menu" VALUES ('5', '27');
INSERT INTO "sys_role_menu" VALUES ('5', '2ecff12b7cb84b07a10884c9dd6228ff');
INSERT INTO "sys_role_menu" VALUES ('5', '3001e261d2f5420daa42bc7245dbd325');
INSERT INTO "sys_role_menu" VALUES ('5', '32194ca386e04a5b8e924157df607268');
INSERT INTO "sys_role_menu" VALUES ('5', '36248fa585464d4980fe593c636f603a');
INSERT INTO "sys_role_menu" VALUES ('5', '39d949fbf81e4012be55261c71ec0b9b');
INSERT INTO "sys_role_menu" VALUES ('5', '5f9e9bbef9c94b4d884fd4ab71386fcf');
INSERT INTO "sys_role_menu" VALUES ('5', '6129d8d4114b40499359c93452325aa5');
INSERT INTO "sys_role_menu" VALUES ('5', '686ea863501841ca90cf039485658256');
INSERT INTO "sys_role_menu" VALUES ('5', '6a0ed27b4c5f4f16bb075f20d8dd8d74');
INSERT INTO "sys_role_menu" VALUES ('5', '73c23e3113314dcebe4eb6d234ee3653');
INSERT INTO "sys_role_menu" VALUES ('5', '7b7aae5c21bc4246b00e1f958d8f317c');
INSERT INTO "sys_role_menu" VALUES ('5', '82f1561c52044b04892856512090a9b1');
INSERT INTO "sys_role_menu" VALUES ('5', '8575c45a2f6541febfd5146205f7c4fd');
INSERT INTO "sys_role_menu" VALUES ('5', '94f2fe4d20984bf8ba1f4cf754a61855');
INSERT INTO "sys_role_menu" VALUES ('5', 'a092c8f7547e4884958dcacdb74c41a4');
INSERT INTO "sys_role_menu" VALUES ('5', 'ad4a9dafccc54dc28823b1f7d325b41e');
INSERT INTO "sys_role_menu" VALUES ('5', 'c191500b31ca43daa42f1823197e7411');
INSERT INTO "sys_role_menu" VALUES ('5', 'cca30ab1b0004038b4c2620b64c39d61');
INSERT INTO "sys_role_menu" VALUES ('5', 'e6b56ff783fd43e29515bbd0f8402751');
INSERT INTO "sys_role_menu" VALUES ('5', 'e91a9d751d4749c0b4b84ca93cd3ec45');
INSERT INTO "sys_role_menu" VALUES ('5', 'eee9a5db959a47f093daac0f41e78ff6');
INSERT INTO "sys_role_menu" VALUES ('5', 'f7dcbc8cc8d849fc898fa4b18fb41487');
INSERT INTO "sys_role_menu" VALUES ('5', 'fc36c1a2668044aeb34253c9232ad837');
INSERT INTO "sys_role_menu" VALUES ('5', 'fee942d02e7c4bffa8a1b865e68a4333');
INSERT INTO "sys_role_menu" VALUES ('6', '0991ef2474f242109fa20f8be1cf8fc9');
INSERT INTO "sys_role_menu" VALUES ('6', '0ad7b66c70674bef9c1a3ee1f11cc253');
INSERT INTO "sys_role_menu" VALUES ('6', '1');
INSERT INTO "sys_role_menu" VALUES ('6', '168fc24fb231483f9635dffffaadd4aa');
INSERT INTO "sys_role_menu" VALUES ('6', '16ef78515d524a81bffc0159bd3b094a');
INSERT INTO "sys_role_menu" VALUES ('6', '187ab10c1cf2404eb5b621ba5707004c');
INSERT INTO "sys_role_menu" VALUES ('6', '1c492072ef694f29b42d3711b05676f2');
INSERT INTO "sys_role_menu" VALUES ('6', '22f7199e005a41be8c73c5a18060ccec');
INSERT INTO "sys_role_menu" VALUES ('6', '25be531c51ad4a488ffb98acac1dab9e');
INSERT INTO "sys_role_menu" VALUES ('6', '32194ca386e04a5b8e924157df607268');
INSERT INTO "sys_role_menu" VALUES ('6', '39d949fbf81e4012be55261c71ec0b9b');
INSERT INTO "sys_role_menu" VALUES ('6', '6129d8d4114b40499359c93452325aa5');
INSERT INTO "sys_role_menu" VALUES ('6', '686ea863501841ca90cf039485658256');
INSERT INTO "sys_role_menu" VALUES ('6', '73c23e3113314dcebe4eb6d234ee3653');
INSERT INTO "sys_role_menu" VALUES ('6', '8575c45a2f6541febfd5146205f7c4fd');
INSERT INTO "sys_role_menu" VALUES ('6', '94f2fe4d20984bf8ba1f4cf754a61855');
INSERT INTO "sys_role_menu" VALUES ('6', 'a092c8f7547e4884958dcacdb74c41a4');
INSERT INTO "sys_role_menu" VALUES ('6', 'c191500b31ca43daa42f1823197e7411');
INSERT INTO "sys_role_menu" VALUES ('6', 'cca30ab1b0004038b4c2620b64c39d61');
INSERT INTO "sys_role_menu" VALUES ('6', 'e6b56ff783fd43e29515bbd0f8402751');
INSERT INTO "sys_role_menu" VALUES ('6', 'e91a9d751d4749c0b4b84ca93cd3ec45');
INSERT INTO "sys_role_menu" VALUES ('6', 'f7dcbc8cc8d849fc898fa4b18fb41487');
INSERT INTO "sys_role_menu" VALUES ('7', '0991ef2474f242109fa20f8be1cf8fc9');
INSERT INTO "sys_role_menu" VALUES ('7', '0ad7b66c70674bef9c1a3ee1f11cc253');
INSERT INTO "sys_role_menu" VALUES ('7', '1');
INSERT INTO "sys_role_menu" VALUES ('7', '13');
INSERT INTO "sys_role_menu" VALUES ('7', '14');
INSERT INTO "sys_role_menu" VALUES ('7', '15');
INSERT INTO "sys_role_menu" VALUES ('7', '16');
INSERT INTO "sys_role_menu" VALUES ('7', '168fc24fb231483f9635dffffaadd4aa');
INSERT INTO "sys_role_menu" VALUES ('7', '16ef78515d524a81bffc0159bd3b094a');
INSERT INTO "sys_role_menu" VALUES ('7', '17');
INSERT INTO "sys_role_menu" VALUES ('7', '18');
INSERT INTO "sys_role_menu" VALUES ('7', '187ab10c1cf2404eb5b621ba5707004c');
INSERT INTO "sys_role_menu" VALUES ('7', '1c492072ef694f29b42d3711b05676f2');
INSERT INTO "sys_role_menu" VALUES ('7', '2');
INSERT INTO "sys_role_menu" VALUES ('7', '20');
INSERT INTO "sys_role_menu" VALUES ('7', '22b00a47c1c44ed28ab79be8d6318fcd');
INSERT INTO "sys_role_menu" VALUES ('7', '22f7199e005a41be8c73c5a18060ccec');
INSERT INTO "sys_role_menu" VALUES ('7', '25be531c51ad4a488ffb98acac1dab9e');
INSERT INTO "sys_role_menu" VALUES ('7', '264d42fa4c6a4c6bb2a8931c4bb1f8f4');
INSERT INTO "sys_role_menu" VALUES ('7', '27');
INSERT INTO "sys_role_menu" VALUES ('7', '2ecff12b7cb84b07a10884c9dd6228ff');
INSERT INTO "sys_role_menu" VALUES ('7', '3');
INSERT INTO "sys_role_menu" VALUES ('7', '3001e261d2f5420daa42bc7245dbd325');
INSERT INTO "sys_role_menu" VALUES ('7', '32194ca386e04a5b8e924157df607268');
INSERT INTO "sys_role_menu" VALUES ('7', '36248fa585464d4980fe593c636f603a');
INSERT INTO "sys_role_menu" VALUES ('7', '39d949fbf81e4012be55261c71ec0b9b');
INSERT INTO "sys_role_menu" VALUES ('7', '4');
INSERT INTO "sys_role_menu" VALUES ('7', '4a5065fca6b54ae0942e5e2127921bfd');
INSERT INTO "sys_role_menu" VALUES ('7', '5');
INSERT INTO "sys_role_menu" VALUES ('7', '5f9e9bbef9c94b4d884fd4ab71386fcf');
INSERT INTO "sys_role_menu" VALUES ('7', '6');
INSERT INTO "sys_role_menu" VALUES ('7', '6129d8d4114b40499359c93452325aa5');
INSERT INTO "sys_role_menu" VALUES ('7', '686ea863501841ca90cf039485658256');
INSERT INTO "sys_role_menu" VALUES ('7', '699e66e048ce4b4186bdad82d5d5b989');
INSERT INTO "sys_role_menu" VALUES ('7', '6a0ed27b4c5f4f16bb075f20d8dd8d74');
INSERT INTO "sys_role_menu" VALUES ('7', '73c23e3113314dcebe4eb6d234ee3653');
INSERT INTO "sys_role_menu" VALUES ('7', '7b7aae5c21bc4246b00e1f958d8f317c');
INSERT INTO "sys_role_menu" VALUES ('7', '82f1561c52044b04892856512090a9b1');
INSERT INTO "sys_role_menu" VALUES ('7', '8a1246fad5a2404d9615d08fc2167ab3');
INSERT INTO "sys_role_menu" VALUES ('7', '8b15cffed40e4948857efe9a6aa5e377');
INSERT INTO "sys_role_menu" VALUES ('7', '94f2fe4d20984bf8ba1f4cf754a61855');
INSERT INTO "sys_role_menu" VALUES ('7', '9a7fe964a4924965be38478862a587a9');
INSERT INTO "sys_role_menu" VALUES ('7', 'a092c8f7547e4884958dcacdb74c41a4');
INSERT INTO "sys_role_menu" VALUES ('7', 'ad4a9dafccc54dc28823b1f7d325b41e');
INSERT INTO "sys_role_menu" VALUES ('7', 'b959f8ca2f9d4089808533304379efb4');
INSERT INTO "sys_role_menu" VALUES ('7', 'c191500b31ca43daa42f1823197e7411');
INSERT INTO "sys_role_menu" VALUES ('7', 'd8586fcff069459f9bb4ea1745a02c72');
INSERT INTO "sys_role_menu" VALUES ('7', 'e6b56ff783fd43e29515bbd0f8402751');
INSERT INTO "sys_role_menu" VALUES ('7', 'eee9a5db959a47f093daac0f41e78ff6');
INSERT INTO "sys_role_menu" VALUES ('7', 'f7dcbc8cc8d849fc898fa4b18fb41487');
INSERT INTO "sys_role_menu" VALUES ('7', 'fc36c1a2668044aeb34253c9232ad837');
INSERT INTO "sys_role_menu" VALUES ('7', 'fee942d02e7c4bffa8a1b865e68a4333');
INSERT INTO "sys_role_menu" VALUES ('8d193454b99e4a62a6d1e571260c2349', '0991ef2474f242109fa20f8be1cf8fc9');
INSERT INTO "sys_role_menu" VALUES ('8d193454b99e4a62a6d1e571260c2349', '0ad7b66c70674bef9c1a3ee1f11cc253');
INSERT INTO "sys_role_menu" VALUES ('8d193454b99e4a62a6d1e571260c2349', '1');
INSERT INTO "sys_role_menu" VALUES ('8d193454b99e4a62a6d1e571260c2349', '168fc24fb231483f9635dffffaadd4aa');
INSERT INTO "sys_role_menu" VALUES ('8d193454b99e4a62a6d1e571260c2349', '16ef78515d524a81bffc0159bd3b094a');
INSERT INTO "sys_role_menu" VALUES ('8d193454b99e4a62a6d1e571260c2349', '187ab10c1cf2404eb5b621ba5707004c');
INSERT INTO "sys_role_menu" VALUES ('8d193454b99e4a62a6d1e571260c2349', '1c492072ef694f29b42d3711b05676f2');
INSERT INTO "sys_role_menu" VALUES ('8d193454b99e4a62a6d1e571260c2349', '22f7199e005a41be8c73c5a18060ccec');
INSERT INTO "sys_role_menu" VALUES ('8d193454b99e4a62a6d1e571260c2349', '25be531c51ad4a488ffb98acac1dab9e');
INSERT INTO "sys_role_menu" VALUES ('8d193454b99e4a62a6d1e571260c2349', '32194ca386e04a5b8e924157df607268');
INSERT INTO "sys_role_menu" VALUES ('8d193454b99e4a62a6d1e571260c2349', '39d949fbf81e4012be55261c71ec0b9b');
INSERT INTO "sys_role_menu" VALUES ('8d193454b99e4a62a6d1e571260c2349', '6129d8d4114b40499359c93452325aa5');
INSERT INTO "sys_role_menu" VALUES ('8d193454b99e4a62a6d1e571260c2349', '686ea863501841ca90cf039485658256');
INSERT INTO "sys_role_menu" VALUES ('8d193454b99e4a62a6d1e571260c2349', '73c23e3113314dcebe4eb6d234ee3653');
INSERT INTO "sys_role_menu" VALUES ('8d193454b99e4a62a6d1e571260c2349', '94f2fe4d20984bf8ba1f4cf754a61855');
INSERT INTO "sys_role_menu" VALUES ('8d193454b99e4a62a6d1e571260c2349', 'a092c8f7547e4884958dcacdb74c41a4');
INSERT INTO "sys_role_menu" VALUES ('8d193454b99e4a62a6d1e571260c2349', 'c191500b31ca43daa42f1823197e7411');
INSERT INTO "sys_role_menu" VALUES ('8d193454b99e4a62a6d1e571260c2349', 'cca30ab1b0004038b4c2620b64c39d61');
INSERT INTO "sys_role_menu" VALUES ('8d193454b99e4a62a6d1e571260c2349', 'e6b56ff783fd43e29515bbd0f8402751');
INSERT INTO "sys_role_menu" VALUES ('8d193454b99e4a62a6d1e571260c2349', 'e91a9d751d4749c0b4b84ca93cd3ec45');
INSERT INTO "sys_role_menu" VALUES ('8d193454b99e4a62a6d1e571260c2349', 'f7dcbc8cc8d849fc898fa4b18fb41487');
INSERT INTO "sys_role_menu" VALUES ('a76de50fa6a848d8840dfe1d9d9593cd', '0991ef2474f242109fa20f8be1cf8fc9');
INSERT INTO "sys_role_menu" VALUES ('a76de50fa6a848d8840dfe1d9d9593cd', '0ad7b66c70674bef9c1a3ee1f11cc253');
INSERT INTO "sys_role_menu" VALUES ('a76de50fa6a848d8840dfe1d9d9593cd', '1');
INSERT INTO "sys_role_menu" VALUES ('a76de50fa6a848d8840dfe1d9d9593cd', '168fc24fb231483f9635dffffaadd4aa');
INSERT INTO "sys_role_menu" VALUES ('a76de50fa6a848d8840dfe1d9d9593cd', '16ef78515d524a81bffc0159bd3b094a');
INSERT INTO "sys_role_menu" VALUES ('a76de50fa6a848d8840dfe1d9d9593cd', '187ab10c1cf2404eb5b621ba5707004c');
INSERT INTO "sys_role_menu" VALUES ('a76de50fa6a848d8840dfe1d9d9593cd', '1c492072ef694f29b42d3711b05676f2');
INSERT INTO "sys_role_menu" VALUES ('a76de50fa6a848d8840dfe1d9d9593cd', '22f7199e005a41be8c73c5a18060ccec');
INSERT INTO "sys_role_menu" VALUES ('a76de50fa6a848d8840dfe1d9d9593cd', '25be531c51ad4a488ffb98acac1dab9e');
INSERT INTO "sys_role_menu" VALUES ('a76de50fa6a848d8840dfe1d9d9593cd', '32194ca386e04a5b8e924157df607268');
INSERT INTO "sys_role_menu" VALUES ('a76de50fa6a848d8840dfe1d9d9593cd', '39d949fbf81e4012be55261c71ec0b9b');
INSERT INTO "sys_role_menu" VALUES ('a76de50fa6a848d8840dfe1d9d9593cd', '6129d8d4114b40499359c93452325aa5');
INSERT INTO "sys_role_menu" VALUES ('a76de50fa6a848d8840dfe1d9d9593cd', '686ea863501841ca90cf039485658256');
INSERT INTO "sys_role_menu" VALUES ('a76de50fa6a848d8840dfe1d9d9593cd', '73c23e3113314dcebe4eb6d234ee3653');
INSERT INTO "sys_role_menu" VALUES ('a76de50fa6a848d8840dfe1d9d9593cd', '94f2fe4d20984bf8ba1f4cf754a61855');
INSERT INTO "sys_role_menu" VALUES ('a76de50fa6a848d8840dfe1d9d9593cd', 'a092c8f7547e4884958dcacdb74c41a4');
INSERT INTO "sys_role_menu" VALUES ('a76de50fa6a848d8840dfe1d9d9593cd', 'c191500b31ca43daa42f1823197e7411');
INSERT INTO "sys_role_menu" VALUES ('a76de50fa6a848d8840dfe1d9d9593cd', 'cca30ab1b0004038b4c2620b64c39d61');
INSERT INTO "sys_role_menu" VALUES ('a76de50fa6a848d8840dfe1d9d9593cd', 'e6b56ff783fd43e29515bbd0f8402751');
INSERT INTO "sys_role_menu" VALUES ('a76de50fa6a848d8840dfe1d9d9593cd', 'e91a9d751d4749c0b4b84ca93cd3ec45');
INSERT INTO "sys_role_menu" VALUES ('a76de50fa6a848d8840dfe1d9d9593cd', 'f7dcbc8cc8d849fc898fa4b18fb41487');
INSERT INTO "sys_role_menu" VALUES ('d8ed67233dd641a59e6bba9c82c76511', '1');
INSERT INTO "sys_role_menu" VALUES ('d8ed67233dd641a59e6bba9c82c76511', '25be531c51ad4a488ffb98acac1dab9e');
INSERT INTO "sys_role_menu" VALUES ('d8ed67233dd641a59e6bba9c82c76511', 'c4804996c0f64f769e621e9438c19487');

-- ----------------------------
-- Table structure for sys_role_office
-- ----------------------------
DROP TABLE IF EXISTS "sys_role_office";
CREATE TABLE "sys_role_office" (
"role_id" varchar(64) COLLATE "default" NOT NULL,
"office_id" varchar(64) COLLATE "default" NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of sys_role_office
-- ----------------------------

-- ----------------------------
-- Table structure for sys_status
-- ----------------------------
DROP TABLE IF EXISTS "sys_status";
CREATE TABLE "sys_status" (
"id" varchar(255) COLLATE "default" NOT NULL,
"fromsys" varchar(255) COLLATE "default",
"ts" varchar(255) COLLATE "default"
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of sys_status
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS "sys_user";
CREATE TABLE "sys_user" (
"id" varchar(64) COLLATE "default" NOT NULL,
"company_id" varchar(64) COLLATE "default" NOT NULL,
"office_id" varchar(64) COLLATE "default" NOT NULL,
"login_name" varchar(100) COLLATE "default" NOT NULL,
"password" varchar(100) COLLATE "default" NOT NULL,
"no" varchar(100) COLLATE "default",
"name" varchar(100) COLLATE "default" NOT NULL,
"email" varchar(200) COLLATE "default",
"phone" varchar(200) COLLATE "default",
"mobile" varchar(200) COLLATE "default",
"user_type" char(1) COLLATE "default",
"photo" varchar(1000) COLLATE "default",
"login_ip" varchar(100) COLLATE "default",
"login_date" timestamp(6),
"login_flag" varchar(64) COLLATE "default",
"create_by" varchar(64) COLLATE "default" NOT NULL,
"create_date" timestamp(6) NOT NULL,
"update_by" varchar(64) COLLATE "default" NOT NULL,
"update_date" timestamp(6) NOT NULL,
"remarks" varchar(255) COLLATE "default",
"del_flag" char(1) COLLATE "default" DEFAULT '0'::bpchar NOT NULL,
"local_pwd" varchar(100) COLLATE "default" DEFAULT '319dbf89828e897dfc9a9d8db7bf2ce4429bcb190fdb1d8b7044a85d'::character varying
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO "sys_user" VALUES ('1', '1', '2', 'superadmin', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0001', '系统管理员', 'system@163.com', '8675', '8675', null, '1', '127.0.0.1', '2016-01-19 15:23:00.648', '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', '最高管理员', '0', '319dbf89828e897dfc9a9d8db7bf2ce4429bcb190fdb1d8b7044a85d');

-- ----------------------------
-- Table structure for sys_user_category
-- ----------------------------
DROP TABLE IF EXISTS "sys_user_category";
CREATE TABLE "sys_user_category" (
"id" varchar(64) COLLATE "default" NOT NULL,
"user_id" varchar(64) COLLATE "default" NOT NULL,
"category_id" varchar(64) COLLATE "default" NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of sys_user_category
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS "sys_user_role";
CREATE TABLE "sys_user_role" (
"user_id" varchar(64) COLLATE "default" NOT NULL,
"role_id" varchar(64) COLLATE "default" NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO "sys_user_role" VALUES ('1', '031fdd2fe88f4853a92199bf7d7c2ee6');
INSERT INTO "sys_user_role" VALUES ('1', '1');
INSERT INTO "sys_user_role" VALUES ('1', '6');
INSERT INTO "sys_user_role" VALUES ('2', '1');
INSERT INTO "sys_user_role" VALUES ('2', '6');

-- ----------------------------
-- Table structure for test_data
-- ----------------------------
DROP TABLE IF EXISTS "test_data";
CREATE TABLE "test_data" (
"id" varchar(64) COLLATE "default" NOT NULL,
"user_id" varchar(64) COLLATE "default",
"office_id" varchar(64) COLLATE "default",
"area_id" varchar(64) COLLATE "default",
"name" varchar(100) COLLATE "default",
"sex" char(1) COLLATE "default",
"in_date" timestamp(6),
"create_by" varchar(64) COLLATE "default" NOT NULL,
"create_date" timestamp(6) NOT NULL,
"update_by" varchar(64) COLLATE "default" NOT NULL,
"update_date" timestamp(6) NOT NULL,
"remarks" varchar(255) COLLATE "default",
"del_flag" char(1) COLLATE "default" DEFAULT '0'::bpchar NOT NULL
)
WITH (OIDS=FALSE)

;
COMMENT ON TABLE "test_data" IS '业务数据表';
COMMENT ON COLUMN "test_data"."id" IS '编号';
COMMENT ON COLUMN "test_data"."user_id" IS '归属用户';
COMMENT ON COLUMN "test_data"."office_id" IS '归属部门';
COMMENT ON COLUMN "test_data"."area_id" IS '归属区域';
COMMENT ON COLUMN "test_data"."name" IS '名称';
COMMENT ON COLUMN "test_data"."sex" IS '性别';
COMMENT ON COLUMN "test_data"."in_date" IS '加入日期';
COMMENT ON COLUMN "test_data"."create_by" IS '创建者';
COMMENT ON COLUMN "test_data"."create_date" IS '创建时间';
COMMENT ON COLUMN "test_data"."update_by" IS '更新者';
COMMENT ON COLUMN "test_data"."update_date" IS '更新时间';
COMMENT ON COLUMN "test_data"."remarks" IS '备注信息';
COMMENT ON COLUMN "test_data"."del_flag" IS '删除标记';

-- ----------------------------
-- Records of test_data
-- ----------------------------

-- ----------------------------
-- Table structure for test_data_child
-- ----------------------------
DROP TABLE IF EXISTS "test_data_child";
CREATE TABLE "test_data_child" (
"id" varchar(64) COLLATE "default" NOT NULL,
"test_data_main_id" varchar(64) COLLATE "default",
"name" varchar(100) COLLATE "default",
"create_by" varchar(64) COLLATE "default" NOT NULL,
"create_date" timestamp(6) NOT NULL,
"update_by" varchar(64) COLLATE "default" NOT NULL,
"update_date" timestamp(6) NOT NULL,
"remarks" varchar(255) COLLATE "default",
"del_flag" char(1) COLLATE "default" DEFAULT '0'::bpchar NOT NULL
)
WITH (OIDS=FALSE)

;
COMMENT ON TABLE "test_data_child" IS '业务数据子表';
COMMENT ON COLUMN "test_data_child"."id" IS '编号';
COMMENT ON COLUMN "test_data_child"."test_data_main_id" IS '业务主表ID';
COMMENT ON COLUMN "test_data_child"."name" IS '名称';
COMMENT ON COLUMN "test_data_child"."create_by" IS '创建者';
COMMENT ON COLUMN "test_data_child"."create_date" IS '创建时间';
COMMENT ON COLUMN "test_data_child"."update_by" IS '更新者';
COMMENT ON COLUMN "test_data_child"."update_date" IS '更新时间';
COMMENT ON COLUMN "test_data_child"."remarks" IS '备注信息';
COMMENT ON COLUMN "test_data_child"."del_flag" IS '删除标记';

-- ----------------------------
-- Records of test_data_child
-- ----------------------------

-- ----------------------------
-- Table structure for test_data_main
-- ----------------------------
DROP TABLE IF EXISTS "test_data_main";
CREATE TABLE "test_data_main" (
"id" varchar(64) COLLATE "default" NOT NULL,
"user_id" varchar(64) COLLATE "default",
"office_id" varchar(64) COLLATE "default",
"area_id" varchar(64) COLLATE "default",
"name" varchar(100) COLLATE "default",
"sex" char(1) COLLATE "default",
"in_date" timestamp(6),
"create_by" varchar(64) COLLATE "default" NOT NULL,
"create_date" timestamp(6) NOT NULL,
"update_by" varchar(64) COLLATE "default" NOT NULL,
"update_date" timestamp(6) NOT NULL,
"remarks" varchar(255) COLLATE "default",
"del_flag" char(1) COLLATE "default" DEFAULT '0'::bpchar NOT NULL
)
WITH (OIDS=FALSE)

;
COMMENT ON TABLE "test_data_main" IS '业务数据表';
COMMENT ON COLUMN "test_data_main"."id" IS '编号';
COMMENT ON COLUMN "test_data_main"."user_id" IS '归属用户';
COMMENT ON COLUMN "test_data_main"."office_id" IS '归属部门';
COMMENT ON COLUMN "test_data_main"."area_id" IS '归属区域';
COMMENT ON COLUMN "test_data_main"."name" IS '名称';
COMMENT ON COLUMN "test_data_main"."sex" IS '性别';
COMMENT ON COLUMN "test_data_main"."in_date" IS '加入日期';
COMMENT ON COLUMN "test_data_main"."create_by" IS '创建者';
COMMENT ON COLUMN "test_data_main"."create_date" IS '创建时间';
COMMENT ON COLUMN "test_data_main"."update_by" IS '更新者';
COMMENT ON COLUMN "test_data_main"."update_date" IS '更新时间';
COMMENT ON COLUMN "test_data_main"."remarks" IS '备注信息';
COMMENT ON COLUMN "test_data_main"."del_flag" IS '删除标记';

-- ----------------------------
-- Records of test_data_main
-- ----------------------------

-- ----------------------------
-- Table structure for test_tree
-- ----------------------------
DROP TABLE IF EXISTS "test_tree";
CREATE TABLE "test_tree" (
"id" varchar(64) COLLATE "default" NOT NULL,
"parent_id" varchar(64) COLLATE "default" NOT NULL,
"parent_ids" varchar(2000) COLLATE "default" NOT NULL,
"name" varchar(100) COLLATE "default" NOT NULL,
"sort" int8 NOT NULL,
"create_by" varchar(64) COLLATE "default" NOT NULL,
"create_date" timestamp(6) NOT NULL,
"update_by" varchar(64) COLLATE "default" NOT NULL,
"update_date" timestamp(6) NOT NULL,
"remarks" varchar(255) COLLATE "default",
"del_flag" char(1) COLLATE "default" DEFAULT '0'::bpchar NOT NULL
)
WITH (OIDS=FALSE)

;
COMMENT ON TABLE "test_tree" IS '树结构表';
COMMENT ON COLUMN "test_tree"."id" IS '编号';
COMMENT ON COLUMN "test_tree"."parent_id" IS '父级编号';
COMMENT ON COLUMN "test_tree"."parent_ids" IS '所有父级编号';
COMMENT ON COLUMN "test_tree"."name" IS '名称';
COMMENT ON COLUMN "test_tree"."sort" IS '排序';
COMMENT ON COLUMN "test_tree"."create_by" IS '创建者';
COMMENT ON COLUMN "test_tree"."create_date" IS '创建时间';
COMMENT ON COLUMN "test_tree"."update_by" IS '更新者';
COMMENT ON COLUMN "test_tree"."update_date" IS '更新时间';
COMMENT ON COLUMN "test_tree"."remarks" IS '备注信息';
COMMENT ON COLUMN "test_tree"."del_flag" IS '删除标记';

-- ----------------------------
-- Records of test_tree
-- ----------------------------

-- ----------------------------
-- Alter Sequences Owned By 
-- ----------------------------

-- ----------------------------
-- Indexes structure for table act_ge_bytearray
-- ----------------------------
CREATE INDEX "act_idx_bytear_depl" ON "act_ge_bytearray" USING btree ("deployment_id_");

-- ----------------------------
-- Primary Key structure for table act_ge_bytearray
-- ----------------------------
ALTER TABLE "act_ge_bytearray" ADD PRIMARY KEY ("id_");

-- ----------------------------
-- Primary Key structure for table act_ge_property
-- ----------------------------
ALTER TABLE "act_ge_property" ADD PRIMARY KEY ("name_");

-- ----------------------------
-- Indexes structure for table act_hi_actinst
-- ----------------------------
CREATE INDEX "act_idx_hi_act_inst_end" ON "act_hi_actinst" USING btree ("end_time_");
CREATE INDEX "act_idx_hi_act_inst_exec" ON "act_hi_actinst" USING btree ("execution_id_", "act_id_");
CREATE INDEX "act_idx_hi_act_inst_procinst" ON "act_hi_actinst" USING btree ("proc_inst_id_", "act_id_");
CREATE INDEX "act_idx_hi_act_inst_start" ON "act_hi_actinst" USING btree ("start_time_");

-- ----------------------------
-- Primary Key structure for table act_hi_actinst
-- ----------------------------
ALTER TABLE "act_hi_actinst" ADD PRIMARY KEY ("id_");

-- ----------------------------
-- Primary Key structure for table act_hi_attachment
-- ----------------------------
ALTER TABLE "act_hi_attachment" ADD PRIMARY KEY ("id_");

-- ----------------------------
-- Primary Key structure for table act_hi_comment
-- ----------------------------
ALTER TABLE "act_hi_comment" ADD PRIMARY KEY ("id_");

-- ----------------------------
-- Indexes structure for table act_hi_detail
-- ----------------------------
CREATE INDEX "act_idx_hi_detail_act_inst" ON "act_hi_detail" USING btree ("act_inst_id_");
CREATE INDEX "act_idx_hi_detail_name" ON "act_hi_detail" USING btree ("name_");
CREATE INDEX "act_idx_hi_detail_proc_inst" ON "act_hi_detail" USING btree ("proc_inst_id_");
CREATE INDEX "act_idx_hi_detail_task_id" ON "act_hi_detail" USING btree ("task_id_");
CREATE INDEX "act_idx_hi_detail_time" ON "act_hi_detail" USING btree ("time_");

-- ----------------------------
-- Primary Key structure for table act_hi_detail
-- ----------------------------
ALTER TABLE "act_hi_detail" ADD PRIMARY KEY ("id_");

-- ----------------------------
-- Indexes structure for table act_hi_identitylink
-- ----------------------------
CREATE INDEX "act_idx_hi_ident_lnk_procinst" ON "act_hi_identitylink" USING btree ("proc_inst_id_");
CREATE INDEX "act_idx_hi_ident_lnk_task" ON "act_hi_identitylink" USING btree ("task_id_");
CREATE INDEX "act_idx_hi_ident_lnk_user" ON "act_hi_identitylink" USING btree ("user_id_");

-- ----------------------------
-- Primary Key structure for table act_hi_identitylink
-- ----------------------------
ALTER TABLE "act_hi_identitylink" ADD PRIMARY KEY ("id_");

-- ----------------------------
-- Indexes structure for table act_hi_procinst
-- ----------------------------
CREATE INDEX "act_idx_hi_pro_i_buskey" ON "act_hi_procinst" USING btree ("business_key_");
CREATE INDEX "act_idx_hi_pro_inst_end" ON "act_hi_procinst" USING btree ("end_time_");

-- ----------------------------
-- Primary Key structure for table act_hi_procinst
-- ----------------------------
ALTER TABLE "act_hi_procinst" ADD PRIMARY KEY ("id_");

-- ----------------------------
-- Primary Key structure for table act_hi_taskinst
-- ----------------------------
ALTER TABLE "act_hi_taskinst" ADD PRIMARY KEY ("id_");

-- ----------------------------
-- Indexes structure for table act_hi_varinst
-- ----------------------------
CREATE INDEX "act_idx_hi_procvar_name_type" ON "act_hi_varinst" USING btree ("name_", "var_type_");
CREATE INDEX "act_idx_hi_procvar_proc_inst" ON "act_hi_varinst" USING btree ("proc_inst_id_");

-- ----------------------------
-- Primary Key structure for table act_hi_varinst
-- ----------------------------
ALTER TABLE "act_hi_varinst" ADD PRIMARY KEY ("id_");

-- ----------------------------
-- Primary Key structure for table act_id_group
-- ----------------------------
ALTER TABLE "act_id_group" ADD PRIMARY KEY ("id_");

-- ----------------------------
-- Primary Key structure for table act_id_info
-- ----------------------------
ALTER TABLE "act_id_info" ADD PRIMARY KEY ("id_");

-- ----------------------------
-- Indexes structure for table act_id_membership
-- ----------------------------
CREATE INDEX "act_idx_memb_group" ON "act_id_membership" USING btree ("group_id_");
CREATE INDEX "act_idx_memb_user" ON "act_id_membership" USING btree ("user_id_");

-- ----------------------------
-- Primary Key structure for table act_id_membership
-- ----------------------------
ALTER TABLE "act_id_membership" ADD PRIMARY KEY ("user_id_", "group_id_");

-- ----------------------------
-- Primary Key structure for table act_id_user
-- ----------------------------
ALTER TABLE "act_id_user" ADD PRIMARY KEY ("id_");

-- ----------------------------
-- Primary Key structure for table act_re_deployment
-- ----------------------------
ALTER TABLE "act_re_deployment" ADD PRIMARY KEY ("id_");

-- ----------------------------
-- Indexes structure for table act_re_model
-- ----------------------------
CREATE INDEX "act_idx_model_deployment" ON "act_re_model" USING btree ("deployment_id_");
CREATE INDEX "act_idx_model_source" ON "act_re_model" USING btree ("editor_source_value_id_");
CREATE INDEX "act_idx_model_source_extra" ON "act_re_model" USING btree ("editor_source_extra_value_id_");

-- ----------------------------
-- Primary Key structure for table act_re_model
-- ----------------------------
ALTER TABLE "act_re_model" ADD PRIMARY KEY ("id_");

-- ----------------------------
-- Uniques structure for table act_re_procdef
-- ----------------------------
ALTER TABLE "act_re_procdef" ADD UNIQUE ("key_", "version_", "tenant_id_");

-- ----------------------------
-- Primary Key structure for table act_re_procdef
-- ----------------------------
ALTER TABLE "act_re_procdef" ADD PRIMARY KEY ("id_");

-- ----------------------------
-- Indexes structure for table act_ru_event_subscr
-- ----------------------------
CREATE INDEX "act_idx_event_subscr" ON "act_ru_event_subscr" USING btree ("execution_id_");
CREATE INDEX "act_idx_event_subscr_config_" ON "act_ru_event_subscr" USING btree ("configuration_");

-- ----------------------------
-- Primary Key structure for table act_ru_event_subscr
-- ----------------------------
ALTER TABLE "act_ru_event_subscr" ADD PRIMARY KEY ("id_");

-- ----------------------------
-- Indexes structure for table act_ru_execution
-- ----------------------------
CREATE INDEX "act_idx_exe_parent" ON "act_ru_execution" USING btree ("parent_id_");
CREATE INDEX "act_idx_exe_procdef" ON "act_ru_execution" USING btree ("proc_def_id_");
CREATE INDEX "act_idx_exe_procinst" ON "act_ru_execution" USING btree ("proc_inst_id_");
CREATE INDEX "act_idx_exe_super" ON "act_ru_execution" USING btree ("super_exec_");
CREATE INDEX "act_idx_exec_buskey" ON "act_ru_execution" USING btree ("business_key_");

-- ----------------------------
-- Primary Key structure for table act_ru_execution
-- ----------------------------
ALTER TABLE "act_ru_execution" ADD PRIMARY KEY ("id_");

-- ----------------------------
-- Indexes structure for table act_ru_identitylink
-- ----------------------------
CREATE INDEX "act_idx_athrz_procedef" ON "act_ru_identitylink" USING btree ("proc_def_id_");
CREATE INDEX "act_idx_ident_lnk_group" ON "act_ru_identitylink" USING btree ("group_id_");
CREATE INDEX "act_idx_ident_lnk_user" ON "act_ru_identitylink" USING btree ("user_id_");
CREATE INDEX "act_idx_idl_procinst" ON "act_ru_identitylink" USING btree ("proc_inst_id_");
CREATE INDEX "act_idx_tskass_task" ON "act_ru_identitylink" USING btree ("task_id_");

-- ----------------------------
-- Primary Key structure for table act_ru_identitylink
-- ----------------------------
ALTER TABLE "act_ru_identitylink" ADD PRIMARY KEY ("id_");

-- ----------------------------
-- Indexes structure for table act_ru_job
-- ----------------------------
CREATE INDEX "act_idx_job_exception" ON "act_ru_job" USING btree ("exception_stack_id_");

-- ----------------------------
-- Primary Key structure for table act_ru_job
-- ----------------------------
ALTER TABLE "act_ru_job" ADD PRIMARY KEY ("id_");

-- ----------------------------
-- Indexes structure for table act_ru_task
-- ----------------------------
CREATE INDEX "act_idx_task_create" ON "act_ru_task" USING btree ("create_time_");
CREATE INDEX "act_idx_task_exec" ON "act_ru_task" USING btree ("execution_id_");
CREATE INDEX "act_idx_task_procdef" ON "act_ru_task" USING btree ("proc_def_id_");
CREATE INDEX "act_idx_task_procinst" ON "act_ru_task" USING btree ("proc_inst_id_");

-- ----------------------------
-- Primary Key structure for table act_ru_task
-- ----------------------------
ALTER TABLE "act_ru_task" ADD PRIMARY KEY ("id_");

-- ----------------------------
-- Indexes structure for table act_ru_variable
-- ----------------------------
CREATE INDEX "act_idx_var_bytearray" ON "act_ru_variable" USING btree ("bytearray_id_");
CREATE INDEX "act_idx_var_exe" ON "act_ru_variable" USING btree ("execution_id_");
CREATE INDEX "act_idx_var_procinst" ON "act_ru_variable" USING btree ("proc_inst_id_");
CREATE INDEX "act_idx_variable_task_id" ON "act_ru_variable" USING btree ("task_id_");

-- ----------------------------
-- Primary Key structure for table act_ru_variable
-- ----------------------------
ALTER TABLE "act_ru_variable" ADD PRIMARY KEY ("id_");

-- ----------------------------
-- Primary Key structure for table cms_article
-- ----------------------------
ALTER TABLE "cms_article" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table cms_article_att_file
-- ----------------------------
ALTER TABLE "cms_article_att_file" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table cms_article_data
-- ----------------------------
ALTER TABLE "cms_article_data" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table cms_category
-- ----------------------------
CREATE INDEX "cms_category_del_flag_idx" ON "cms_category" USING btree ("del_flag");
CREATE INDEX "cms_category_module_idx" ON "cms_category" USING btree ("module");
CREATE INDEX "cms_category_name_idx" ON "cms_category" USING btree ("name");
CREATE INDEX "cms_category_office_id_idx" ON "cms_category" USING btree ("office_id");
CREATE INDEX "cms_category_parent_id_idx" ON "cms_category" USING btree ("parent_id");
CREATE INDEX "cms_category_parent_ids_idx" ON "cms_category" USING btree ("parent_ids");
CREATE INDEX "cms_category_site_id_idx" ON "cms_category" USING btree ("site_id");
CREATE INDEX "cms_category_sort_idx" ON "cms_category" USING btree ("sort");

-- ----------------------------
-- Primary Key structure for table cms_category
-- ----------------------------
ALTER TABLE "cms_category" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table cms_comment
-- ----------------------------
CREATE INDEX "cms_comment_category_id_idx" ON "cms_comment" USING btree ("category_id");
CREATE INDEX "cms_comment_content_id_idx" ON "cms_comment" USING btree ("content_id");
CREATE INDEX "cms_comment_del_flag_idx" ON "cms_comment" USING btree ("del_flag");

-- ----------------------------
-- Primary Key structure for table cms_comment
-- ----------------------------
ALTER TABLE "cms_comment" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table cms_frontswitch
-- ----------------------------
ALTER TABLE "cms_frontswitch" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table cms_guestbook
-- ----------------------------
CREATE INDEX "cms_guestbook_del_flag_idx" ON "cms_guestbook" USING btree ("del_flag");

-- ----------------------------
-- Primary Key structure for table cms_guestbook
-- ----------------------------
ALTER TABLE "cms_guestbook" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table cms_label_conn_arti
-- ----------------------------
CREATE INDEX "cms_label_conn_arti_article_id_idx" ON "cms_label_conn_arti" USING btree ("article_id");
CREATE INDEX "cms_label_conn_arti_label_id_article_id_idx" ON "cms_label_conn_arti" USING btree ("label_id", "article_id");

-- ----------------------------
-- Primary Key structure for table cms_label_conn_arti
-- ----------------------------
ALTER TABLE "cms_label_conn_arti" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table cms_label_conn_user
-- ----------------------------
ALTER TABLE "cms_label_conn_user" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table cms_label_count
-- ----------------------------
ALTER TABLE "cms_label_count" ADD PRIMARY KEY ("label_id");

-- ----------------------------
-- Indexes structure for table cms_link
-- ----------------------------
CREATE INDEX "cms_link_category_id_idx" ON "cms_link" USING btree ("category_id");
CREATE INDEX "cms_link_create_by_idx" ON "cms_link" USING btree ("create_by");
CREATE INDEX "cms_link_del_flag_idx" ON "cms_link" USING btree ("del_flag");
CREATE INDEX "cms_link_title_idx" ON "cms_link" USING btree ("title");
CREATE INDEX "cms_link_update_date_idx" ON "cms_link" USING btree ("update_date");
CREATE INDEX "cms_link_weight_idx" ON "cms_link" USING btree ("weight");

-- ----------------------------
-- Primary Key structure for table cms_link
-- ----------------------------
ALTER TABLE "cms_link" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table cms_mystore
-- ----------------------------
ALTER TABLE "cms_mystore" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table cms_recommend
-- ----------------------------
ALTER TABLE "cms_recommend" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table cms_share
-- ----------------------------
ALTER TABLE "cms_share" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table cms_site
-- ----------------------------
CREATE INDEX "cms_site_del_flag_idx" ON "cms_site" USING btree ("del_flag");

-- ----------------------------
-- Primary Key structure for table cms_site
-- ----------------------------
ALTER TABLE "cms_site" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table gen_scheme
-- ----------------------------
CREATE INDEX "gen_scheme_del_flag_idx" ON "gen_scheme" USING btree ("del_flag");

-- ----------------------------
-- Primary Key structure for table gen_scheme
-- ----------------------------
ALTER TABLE "gen_scheme" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table gen_table
-- ----------------------------
CREATE INDEX "gen_table_del_flag_idx" ON "gen_table" USING btree ("del_flag");
CREATE INDEX "gen_table_name_idx" ON "gen_table" USING btree ("name");

-- ----------------------------
-- Primary Key structure for table gen_table
-- ----------------------------
ALTER TABLE "gen_table" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table gen_table_column
-- ----------------------------
CREATE INDEX "gen_table_column_del_flag_idx" ON "gen_table_column" USING btree ("del_flag");
CREATE INDEX "gen_table_column_gen_table_id_idx" ON "gen_table_column" USING btree ("gen_table_id");
CREATE INDEX "gen_table_column_name_idx" ON "gen_table_column" USING btree ("name");
CREATE INDEX "gen_table_column_sort_idx" ON "gen_table_column" USING btree ("sort");

-- ----------------------------
-- Primary Key structure for table gen_table_column
-- ----------------------------
ALTER TABLE "gen_table_column" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table gen_template
-- ----------------------------
CREATE INDEX "gen_template_del_flag_idx" ON "gen_template" USING btree ("del_flag");

-- ----------------------------
-- Primary Key structure for table gen_template
-- ----------------------------
ALTER TABLE "gen_template" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table oa_leave
-- ----------------------------
CREATE INDEX "oa_leave_create_by_idx" ON "oa_leave" USING btree ("create_by");
CREATE INDEX "oa_leave_del_flag_idx" ON "oa_leave" USING btree ("del_flag");
CREATE INDEX "oa_leave_process_instance_id_idx" ON "oa_leave" USING btree ("process_instance_id");

-- ----------------------------
-- Primary Key structure for table oa_leave
-- ----------------------------
ALTER TABLE "oa_leave" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table oa_notify
-- ----------------------------
CREATE INDEX "oa_notify_del_flag_idx" ON "oa_notify" USING btree ("del_flag");

-- ----------------------------
-- Primary Key structure for table oa_notify
-- ----------------------------
ALTER TABLE "oa_notify" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table oa_notify_record
-- ----------------------------
CREATE INDEX "oa_notify_record_oa_notify_id_idx" ON "oa_notify_record" USING btree ("oa_notify_id");
CREATE INDEX "oa_notify_record_read_flag_idx" ON "oa_notify_record" USING btree ("read_flag");
CREATE INDEX "oa_notify_record_user_id_idx" ON "oa_notify_record" USING btree ("user_id");

-- ----------------------------
-- Primary Key structure for table oa_notify_record
-- ----------------------------
ALTER TABLE "oa_notify_record" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table oa_test_audit
-- ----------------------------
CREATE INDEX "oa_test_audit_del_flag_idx" ON "oa_test_audit" USING btree ("del_flag");

-- ----------------------------
-- Primary Key structure for table oa_test_audit
-- ----------------------------
ALTER TABLE "oa_test_audit" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table sys_area
-- ----------------------------
CREATE INDEX "sys_area_del_flag_idx" ON "sys_area" USING btree ("del_flag");
CREATE INDEX "sys_area_parent_id_idx" ON "sys_area" USING btree ("parent_id");
CREATE INDEX "sys_area_parent_ids_idx" ON "sys_area" USING btree ("parent_ids");

-- ----------------------------
-- Primary Key structure for table sys_area
-- ----------------------------
ALTER TABLE "sys_area" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table sys_dict
-- ----------------------------
CREATE INDEX "sys_dict_del_flag_idx" ON "sys_dict" USING btree ("del_flag");
CREATE INDEX "sys_dict_label_idx" ON "sys_dict" USING btree ("label");
CREATE INDEX "sys_dict_value_idx" ON "sys_dict" USING btree ("value");

-- ----------------------------
-- Primary Key structure for table sys_dict
-- ----------------------------
ALTER TABLE "sys_dict" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table sys_log
-- ----------------------------
CREATE INDEX "sys_log_create_by_idx" ON "sys_log" USING btree ("create_by");
CREATE INDEX "sys_log_create_date_idx" ON "sys_log" USING btree ("create_date");
CREATE INDEX "sys_log_request_uri_idx" ON "sys_log" USING btree ("request_uri");
CREATE INDEX "sys_log_type_idx" ON "sys_log" USING btree ("type");

-- ----------------------------
-- Primary Key structure for table sys_log
-- ----------------------------
ALTER TABLE "sys_log" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table sys_mdict
-- ----------------------------
CREATE INDEX "sys_mdict_del_flag_idx" ON "sys_mdict" USING btree ("del_flag");
CREATE INDEX "sys_mdict_parent_id_idx" ON "sys_mdict" USING btree ("parent_id");
CREATE INDEX "sys_mdict_parent_ids_idx" ON "sys_mdict" USING btree ("parent_ids");

-- ----------------------------
-- Primary Key structure for table sys_mdict
-- ----------------------------
ALTER TABLE "sys_mdict" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table sys_menu
-- ----------------------------
CREATE INDEX "sys_menu_del_flag_idx" ON "sys_menu" USING btree ("del_flag");
CREATE INDEX "sys_menu_parent_id_idx" ON "sys_menu" USING btree ("parent_id");
CREATE INDEX "sys_menu_parent_ids_idx" ON "sys_menu" USING btree ("parent_ids");

-- ----------------------------
-- Primary Key structure for table sys_menu
-- ----------------------------
ALTER TABLE "sys_menu" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table sys_office
-- ----------------------------
CREATE INDEX "sys_office_del_flag_idx" ON "sys_office" USING btree ("del_flag");
CREATE INDEX "sys_office_parent_id_idx" ON "sys_office" USING btree ("parent_id");
CREATE INDEX "sys_office_parent_ids_idx" ON "sys_office" USING btree ("parent_ids");
CREATE INDEX "sys_office_type_idx" ON "sys_office" USING btree ("type");

-- ----------------------------
-- Primary Key structure for table sys_office
-- ----------------------------
ALTER TABLE "sys_office" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table sys_role
-- ----------------------------
CREATE INDEX "sys_role_del_flag_idx" ON "sys_role" USING btree ("del_flag");
CREATE INDEX "sys_role_enname_idx" ON "sys_role" USING btree ("enname");

-- ----------------------------
-- Primary Key structure for table sys_role
-- ----------------------------
ALTER TABLE "sys_role" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table sys_role_menu
-- ----------------------------
ALTER TABLE "sys_role_menu" ADD PRIMARY KEY ("role_id", "menu_id");

-- ----------------------------
-- Primary Key structure for table sys_role_office
-- ----------------------------
ALTER TABLE "sys_role_office" ADD PRIMARY KEY ("role_id", "office_id");

-- ----------------------------
-- Indexes structure for table sys_user
-- ----------------------------
CREATE INDEX "sys_user_company_id_idx" ON "sys_user" USING btree ("company_id");
CREATE INDEX "sys_user_del_flag_idx" ON "sys_user" USING btree ("del_flag");
CREATE INDEX "sys_user_login_name_idx" ON "sys_user" USING btree ("login_name");
CREATE INDEX "sys_user_office_id_idx" ON "sys_user" USING btree ("office_id");
CREATE INDEX "sys_user_update_date_idx" ON "sys_user" USING btree ("update_date");

-- ----------------------------
-- Primary Key structure for table sys_user
-- ----------------------------
ALTER TABLE "sys_user" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table sys_user_category
-- ----------------------------
ALTER TABLE "sys_user_category" ADD PRIMARY KEY ("category_id", "user_id");

-- ----------------------------
-- Primary Key structure for table sys_user_role
-- ----------------------------
ALTER TABLE "sys_user_role" ADD PRIMARY KEY ("user_id", "role_id");

-- ----------------------------
-- Indexes structure for table test_data
-- ----------------------------
CREATE INDEX "test_data_del_flag_idx" ON "test_data" USING btree ("del_flag");

-- ----------------------------
-- Primary Key structure for table test_data
-- ----------------------------
ALTER TABLE "test_data" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table test_data_child
-- ----------------------------
CREATE INDEX "test_data_child_del_flag_idx" ON "test_data_child" USING btree ("del_flag");

-- ----------------------------
-- Primary Key structure for table test_data_child
-- ----------------------------
ALTER TABLE "test_data_child" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table test_data_main
-- ----------------------------
CREATE INDEX "test_data_main_del_flag_idx" ON "test_data_main" USING btree ("del_flag");

-- ----------------------------
-- Primary Key structure for table test_data_main
-- ----------------------------
ALTER TABLE "test_data_main" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table test_tree
-- ----------------------------
CREATE INDEX "test_tree_del_flag_idx" ON "test_tree" USING btree ("del_flag");
CREATE INDEX "test_tree_parent_id_idx" ON "test_tree" USING btree ("parent_id");
CREATE INDEX "test_tree_parent_ids_idx" ON "test_tree" USING btree ("parent_ids");

-- ----------------------------
-- Primary Key structure for table test_tree
-- ----------------------------
ALTER TABLE "test_tree" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Foreign Key structure for table "act_ge_bytearray"
-- ----------------------------
ALTER TABLE "act_ge_bytearray" ADD FOREIGN KEY ("deployment_id_") REFERENCES "act_re_deployment" ("id_") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "act_ge_bytearray" ADD FOREIGN KEY ("deployment_id_") REFERENCES "act_re_deployment" ("id_") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Key structure for table "act_id_membership"
-- ----------------------------
ALTER TABLE "act_id_membership" ADD FOREIGN KEY ("user_id_") REFERENCES "act_id_user" ("id_") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "act_id_membership" ADD FOREIGN KEY ("group_id_") REFERENCES "act_id_group" ("id_") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Key structure for table "act_re_model"
-- ----------------------------
ALTER TABLE "act_re_model" ADD FOREIGN KEY ("editor_source_extra_value_id_") REFERENCES "act_ge_bytearray" ("id_") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "act_re_model" ADD FOREIGN KEY ("editor_source_value_id_") REFERENCES "act_ge_bytearray" ("id_") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "act_re_model" ADD FOREIGN KEY ("deployment_id_") REFERENCES "act_re_deployment" ("id_") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Key structure for table "act_ru_event_subscr"
-- ----------------------------
ALTER TABLE "act_ru_event_subscr" ADD FOREIGN KEY ("execution_id_") REFERENCES "act_ru_execution" ("id_") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Key structure for table "act_ru_execution"
-- ----------------------------
ALTER TABLE "act_ru_execution" ADD FOREIGN KEY ("proc_def_id_") REFERENCES "act_re_procdef" ("id_") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "act_ru_execution" ADD FOREIGN KEY ("proc_inst_id_") REFERENCES "act_ru_execution" ("id_") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "act_ru_execution" ADD FOREIGN KEY ("parent_id_") REFERENCES "act_ru_execution" ("id_") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "act_ru_execution" ADD FOREIGN KEY ("super_exec_") REFERENCES "act_ru_execution" ("id_") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "act_ru_execution" ADD FOREIGN KEY ("proc_def_id_") REFERENCES "act_re_procdef" ("id_") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "act_ru_execution" ADD FOREIGN KEY ("super_exec_") REFERENCES "act_ru_execution" ("id_") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "act_ru_execution" ADD FOREIGN KEY ("proc_inst_id_") REFERENCES "act_ru_execution" ("id_") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "act_ru_execution" ADD FOREIGN KEY ("parent_id_") REFERENCES "act_ru_execution" ("id_") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Key structure for table "act_ru_identitylink"
-- ----------------------------
ALTER TABLE "act_ru_identitylink" ADD FOREIGN KEY ("proc_inst_id_") REFERENCES "act_ru_execution" ("id_") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "act_ru_identitylink" ADD FOREIGN KEY ("proc_def_id_") REFERENCES "act_re_procdef" ("id_") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "act_ru_identitylink" ADD FOREIGN KEY ("task_id_") REFERENCES "act_ru_task" ("id_") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Key structure for table "act_ru_job"
-- ----------------------------
ALTER TABLE "act_ru_job" ADD FOREIGN KEY ("exception_stack_id_") REFERENCES "act_ge_bytearray" ("id_") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Key structure for table "act_ru_task"
-- ----------------------------
ALTER TABLE "act_ru_task" ADD FOREIGN KEY ("proc_inst_id_") REFERENCES "act_ru_execution" ("id_") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "act_ru_task" ADD FOREIGN KEY ("proc_def_id_") REFERENCES "act_re_procdef" ("id_") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "act_ru_task" ADD FOREIGN KEY ("execution_id_") REFERENCES "act_ru_execution" ("id_") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Key structure for table "act_ru_variable"
-- ----------------------------
ALTER TABLE "act_ru_variable" ADD FOREIGN KEY ("execution_id_") REFERENCES "act_ru_execution" ("id_") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "act_ru_variable" ADD FOREIGN KEY ("bytearray_id_") REFERENCES "act_ge_bytearray" ("id_") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "act_ru_variable" ADD FOREIGN KEY ("proc_inst_id_") REFERENCES "act_ru_execution" ("id_") ON DELETE NO ACTION ON UPDATE NO ACTION;
