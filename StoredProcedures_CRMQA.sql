******** sp_GetMerchant_pbxForStaging *******

SELECT 
		m_tracking_20210903.mp.*
FROM 
		m_tracking_20210903.merchant_pbx mp
		INNER JOIN m_tracking_20210903.v1_faxes f 
		ON f.customer_id = mp.customer_id 
		AND date(mp.call_date_time) >= date(f.date )
		INNER JOIN m_tracking_20210903.v1_merchant_rep_history mrh 
		ON ( mrh.rep_id = f.opener_id AND f.calendar_date 
		BETWEEN mrh.start_date AND IFNULL(mrh.end_date,'2199-12-31')) 
WHERE 
		m_tracking_20210903.mrh.position_id = 44
;
  ____________________________________________________________________________________________________________


******** sp_GetWorkflowsForStaging *******

SELECT 
		m_tracking_20210903.w.*
FROM 
		m_tracking_20210903.v1_workflows w
		INNER JOIN m_tracking_20210903.v1_faxes f 
		ON f.customer_id = w.customer_id 
		AND date(w.date_from) >= date(f.calendar_date )
		INNER JOIN m_tracking_20210903.v1_merchant_rep_history mrh 
		ON mrh.rep_id = f.opener_id AND f.calendar_date 
		BETWEEN mrh.start_date AND mrh.end_date 
WHERE 
		m_tracking_20210903.mrh.position_id = 44
;
              
__________________________________________________________________________________________________________________

******** sp_GetFaxesForStaging *******

SELECT 
		m_tracking_20210903.f.*
FROM 
		m_tracking_20210903.v1_faxes f
		INNER JOIN m_tracking_20210903.v1_merchant_rep_history mrh 
		ON mrh.rep_id = f.opener_id 
		AND f.calendar_date 
		BETWEEN mrh.start_date 
		AND mrh.end_date 
WHERE 
		m_tracking_20210903.mrh.position_id = 44
;

__________________________________________________________________________________________________________________

****** sp_GetSourcesForStaging *************

SELECT 
		m_tracking_20210903.s.*
FROM 
		m_tracking_20210903.v1_sources s 
		INNER JOIN m_tracking_20210903.v1_faxes f 
		ON f.id = s.record_id 
		INNER JOIN m_tracking_20210903.v1_merchant_rep_history mrh 
		ON mrh.rep_id = f.opener_id 
		AND f.calendar_date BETWEEN mrh.start_date 
		AND IFNULL(mrh.end_date , '2199-12-31')
WHERE 
		s.type_id = 2 AND mrh.position_id = 44


UNION 


SELECT 
		m_tracking_20210903.s.*
FROM 
		m_tracking_20210903.v1_sources s 
		INNER JOIN m_tracking_20210903.v1_workflows wf 
		ON wf.source_id = s.id 
		INNER JOIN m_tracking_20210903.v1_faxes f 
		ON f.customer_id = wf.customer_id 
		AND f.calendar_date <= wf.date_from  
		INNER JOIN m_tracking_20210903.v1_merchant_rep_history mrh 
		ON mrh.rep_id = f.opener_id 
		AND f.calendar_date BETWEEN mrh.start_date 
		AND IFNULL(mrh.end_date , '2199-12-31')
WHERE 
		mrh.position_id = 44
 

UNION 
   
SELECT 
		m_tracking_20210903.s.*
FROM 
		m_tracking_20210903.v1_sources s 
		INNER JOIN m_tracking_20210903.v1_workflows wf 
		ON wf.id = s.record_id 
		INNER JOIN m_tracking_20210903.v1_faxes f 
		ON f.customer_id = wf.customer_id 
		AND f.calendar_date <= wf.date_from  
		INNER JOIN m_tracking_20210903.v1_merchant_rep_history mrh 
		ON mrh.rep_id = f.opener_id 
		AND f.calendar_date BETWEEN mrh.start_date 
		AND IFNULL(mrh.end_date , '2199-12-31')
WHERE 
		mrh.position_id = 44 AND s.type_id = 1
		;




