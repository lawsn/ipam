create table iebk_e_chnl_menu_ptcl
(
e_chnl_biz_cd varchar2(3),
e_chnl_sub_biz_cd varchar2(3),
menu_no varchar2(5),
menu_nm varchar2(100),
menu_lvl number(2),
hgrk_menu_no varchar2(5),
actv_yn char(1),
use_yn char(1),
srt_seq number(5),
url_adr varchar2(100),
sys_reg_dtm timestamp(6),
sys_upd_dtm timestamp(6),
reg_emp_no varchar2(7),
upd_emp_no varchar2(7)
)


select * from iebk_e_chnl_menu_ptcl;

insert into iebk_e_chnl_menu_ptcl (e_chnl_biz_cd, e_chnl_sub_biz_cd, menu_no, menu_nm, menu_lvl, hgrk_menu_no, actv_yn, use_yn) values (
'PBK', 'OPB', '10001', '¸Þ´º1', 1, '10000'
)


