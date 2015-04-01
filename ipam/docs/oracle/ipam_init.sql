INSERT INTO ipam_user (user_id, user_name, ip_list, other_desc, allow_excp, reg_date, change_date) VALUES('hong1', 'ȫ�浿1', '127.0.0.1,127.0.0.2', 'other_desc', 'f', '2015-03-04 12:29:07', '2015-03-04 12:29:07');

//sequence test
insert into ipam_audit (event_no,audit_type,operator_id,ip_list,other_desc,allow_excp,reg_date,audit_detail) values(ipam_audit_seq.NEXTVAL, '1','1','1','1','1','1','1');
insert into ipam_audit (event_no,audit_type,operator_id,ip_list,other_desc,allow_excp,reg_date,audit_detail) values(ipam_audit_seq.NEXTVAL, '2','2','2','2','2','2','2');
insert into ipam_audit (event_no,audit_type,operator_id,ip_list,other_desc,allow_excp,reg_date,audit_detail) values(ipam_audit_seq.NEXTVAL, '2','2','2','2','2','2','3');