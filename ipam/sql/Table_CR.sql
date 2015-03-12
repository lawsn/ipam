INSERT INTO ipam_user 
(user_id
, user_name
, ip_list
, other_desc
, allow_excp
, reg_date
, change_date
) VALUES('hong4'
, 'È«±æµ¿4'
, '127.0.0.1,127.0.0.2'
, 'other_desc'
, 't'
, '2015-03-04 12:29:08'
, '2015-03-04 12:29:07');


/* Formatted on 2015/03/11 ¿ÀÈÄ 8:02:35 (QP5 v5.252.13127.32867) */
SELECT * FROM (
SELECT ROW_NUMBER () OVER (ORDER BY REG_DATE) AS RNUM,
       USER_NAME,
       USER_ID,
       DECODE (ALLOW_EXCP, 't', 'Yes', 'NO') AS ALLOW_EXCP,
       IP_LIST,
       OTHER_DESC
  FROM IPAM_USER
) WHERE rnum BETWEEN 1 AND 10