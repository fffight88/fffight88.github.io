-- pay_status에 pay_ok 가 잘 들어가있는지 확인

SELECT `t_o`.`serial` AS `t_order_serial`, `t_o`.`t_serial`, IFNULL(t_o.deadline, '9999-99-99 23') AS deadline, `t_o`.`bo_order_no`, `t_o`.`edu_order_no`, `t_o`.`r7_order_no`, `receipt_b`.`name` AS `receipt_branch_name`, `t_o`.`receipt_branch_id`, `m_c`.`c_biz_com`
FROM `t_order` AS `t_o`
LEFT JOIN `p_order` AS `p_o` ON `t_o`.`t_serial` = `p_o`.`t_serial`
LEFT JOIN `mem_c` AS `m_c` ON `m_c`.`serial` = `t_o`.`c_serial`
LEFT JOIN `branch` AS `receipt_b` ON `receipt_b`.`branch_code` = `t_o`.`receipt_branch_id`
WHERE `p_o`.`t_serial` != ''
AND `t_o`.`pay_status` = 'pay_ok'
AND `t_o`.`c_serial` = '281'
AND `p_o`.`reg_date` >= '2023-05-19 00:00:00'
AND `p_o`.`reg_date` <= '2023-05-19 23:59:59'
AND `t_o`.`is_del` = 'N'
GROUP BY `t_o`.`t_serial`
ORDER BY `p_o`.`pay_ok_date` DESC, `p_o`.`t_serial` ASC, `p_o`.`serial` DESC
 LIMIT 20;
 
SELECT * FROM `t_order` WHERE `c_serial` = 281 AND `reg_date` = '2023-05-19';
SELECT * FROM `p_order` WHERE `t_serial` = 197884447502228;