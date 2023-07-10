SELECT * FROM `mem_table` WHERE `c_serial` = '363' ORDER BY `serial` DESC;

-- 계정아이디 중복 검사

SELECT * FROM `mem_table` WHERE `mem_id` = 'yklee';

-- 계정아이디로 검색

SELECT * FROM `mem_table` WHERE `c_serial` = 363 AND `mem_id` IN ('jmson','jihyekwon','sylim','suhwankim','myshim','dsnoh','sybae','yekim2');

-- 계정 이용정지(삭제) : where_in절안에 계정아이디 입력

UPDATE `mem_table` SET `mem_yn` = 'N' WHERE 1=1
AND `c_serial` = 363
AND `mem_id` IN ('');

-- 계정 생성
-- my_depth_info : 서울Center-9137, 경인강Center-9139, 중남부Center-9141, 부울경Center-9142
-- pay_mem_serial : 노용진-18924, 윤주성-18932, 박영균-18922(탈퇴계정), 강정수-18940
-- 보통 부울경-강정수, 중남부-윤주성, 경인강-노용진/박영균, 서울-노용진
-- author_serial : 마스터-1118, 관리자-1119, 사원-1120
-- 관리자권한이면 author_serial=1119, pay_mem_serial=''

INSERT INTO `mem_table` (`c_serial`, `my_depth_info`, `level`, `pay_mem_serial`, `author_serial`, `mem_id`, 	`mem_pwd`	 , `mem_name`, 	`mem_hp`	, 	`mem_email`		, `mem_icon` , `mem_yn`, `mem_agree`, `reg_date`) 
		VALUES  (   363    , 	9137	    ,	0    ,	       18924	,     1120	, 'wsjung', PASSWORD("retail9876"),   '정원석' , '010-2396-9876'	, 'wsjung@businessinsight.co.kr', 'pf_00.png',	'Y'    ,    'Y'     ,	NOW()	);

-- 결재선변경(서울센터, 노용진)
UPDATE `mem_table` SET `my_depth_info` = 9137, `pay_mem_serial` = 18924, `author_serial` = 1120, `modify_id` = 'retailninsight_admin', `modified` = NOW() WHERE 1=1
AND `c_serial` = 363
AND `mem_id` IN ('jmson','jihyekwon','sylim','suhwankim','myshim','dsnoh','sybae','yekim2');

-- 결재선변경(중남부, 윤주성)
UPDATE `mem_table` SET `my_depth_info` = 9141, `pay_mem_serial` = 18932, `author_serial` = 1120, `modify_id` = 'retailninsight_admin', `modified` = NOW()  WHERE 1=1
AND `c_serial` = 363
AND `mem_id` IN ('dsshin','minjukwon','jwyun','shhan2','jwlee','smlee2','gwhan','yscho','hsjang','skim');