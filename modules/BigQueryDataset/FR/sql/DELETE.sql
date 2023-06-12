
--Truncate table emea-crunch-gbl-emea-dv.d_crunch_fr_dom_dv.F_CAF_E_Com_Marionnaud;
--Truncate table emea-crunch-gbl-emea-dv.d_crunch_fr_stg_dv.CAF_E_Com_MARIONNAUD;
delete from `{0}.{1}.{2}`
where run_id = '{3}';