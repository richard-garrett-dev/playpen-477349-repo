SELECT
    JSON_VALUE(JSON_QUERY(code_desc,"$.code")) AS code,
    JSON_VALUE(JSON_QUERY(code_desc,"$.description")) AS description,
    concat('(',JSON_VALUE(JSON_QUERY(code_desc,"$.code")),') ',JSON_VALUE(JSON_QUERY(code_desc,"$.description"))) as code_description
  FROM
    `dmn01_cpt_bqd_dpraw.dr_card_auth_ref_raw_s`
  WHERE
    is_active = true AND product_name= 'chip_condition_code'