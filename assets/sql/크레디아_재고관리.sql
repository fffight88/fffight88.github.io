-- 관련테이블 : goods, stock_log

-- MOQ = Minimum Order Quantity = `goods`.`goods_minimum`

-- 크레디아 웹페이지의 db관리 화면과 같은 순서로 데이터 정렬

SELECT * FROM goods WHERE c_serial='281' AND is_del='n' ORDER BY DOC_ID ASC;

-- 재고량 = `goods`.`inner_stock` 을 변경하여 조정한다.

-- 여기서 필요한 제품의 serial 번호를 가져다가 밑의 stock_log에서 해당 시리얼로 로그 검색

SELECT * FROM stock_log WHERE c_serial='281' AND p_serial='328' ORDER BY 1 ASC;

-- 여기서 새로운 레코드를 insert하여 수량을 조절할 수 있다. kind에 stock=누적입고량, sale=출고량, cancel=출고량(주문취소)

-- ==========================================================================================================================================================================


-- 누적입고량 조정 : select절의 kind, before_stock, now_stock, where절의 p_serial 만 수정하여 실행

INSERT INTO `stock_log` (c_serial, p_code, p_serial, p_title, `type`, kind, before_stock, now_stock, `status`,	 user_id, 	modified_id, created, modified)
	SELECT 		   '281', p_code, p_serial, p_title, `type`, 'stock', 	  '', 		'',  `status`, 'credia_admin', modified_id, NOW(), modified
		     FROM `stock_log` 
		     WHERE `c_serial` = 281 AND `p_serial` = '328' ORDER BY `serial` DESC LIMIT 1;

-- 재고량 조정 : 메일로 받은 제품명을 like절에 붙여넣고, 원하는 현재재고량을 `inner_stock`에 기재하여 실행

UPDATE `goods` SET `inner_stock` = '2', `modify_staff_id` = 'credia_admin', modified = NOW() WHERE `c_serial` = 281 AND `goods_name` LIKE '%타이틀리스트 PRO V1 12구%';
