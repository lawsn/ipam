ALTER TABLE IPAM_USER
 DROP PRIMARY KEY CASCADE;

DROP TABLE IPAM_USER CASCADE CONSTRAINTS;


ALTER TABLE IPAM_AUDIT
 DROP PRIMARY KEY CASCADE;

DROP TABLE IPAM_AUDIT CASCADE CONSTRAINTS;

DROP SEQUENCE ipam_audit_seq;

select * from tab;
