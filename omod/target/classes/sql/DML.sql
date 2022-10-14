
SET @OLD_SQL_MODE=@@SQL_MODE $$
SET SQL_MODE='' $$

--Populate etl gbvrc consent:
DROP PROCEDURE IF EXISTS sp_populate_etl_gbvrc_consenting$$
CREATE PROCEDURE sp_populate_etl_gbvrc_consenting()
BEGIN
SELECT "Processing GBVRC PRC data", CONCAT("Time: ", NOW());
insert into kenyaemr_etl.etl_gbvrc_consent_prc(
                  uuid,
                  encounter_id,
                  visit_id,
                  patient_id,
                  location_id,
                  visit_date,
                  encounter_provider,
                  date_created,
                  medical_examination,
                  collect_sample,
                  provide_evidence,
                  witness_name,
                  witness_signature,
                  date_consented,
                  voided
)
select
	e.uuid,
	e.encounter_id as encounter_id,
	e.visit_id as visit_id,
	e.patient_id,
	e.location_id,
	date(e.encounter_datetime) as visit_date,
	e.creator as encounter_provider,
	e.date_created as date_created,
    max(if(o.concept_id=165176,(case o.value_coded when 1065 then "Yes" when 1066 then "No" else "" end),null)) as medical_examination,
    max(if(o.concept_id=161934,(case o.value_coded when 1065 then "Yes" when 1066 then "No" else "" end),null)) as collect_sample,
    max(if(o.concept_id=165180,(case o.value_coded when 1065 then "Yes" when 1066 then "No" else "" end),null)) as provide_evidence,
    max(if(o.concept_id=165143,o.value_text,null)) as witness_name,
    max(if(o.concept_id=163258,o.value_text,null)) as witness_signature,
    max(if(o.concept_id=162869,date(o.value_datetime),null)) as date_consented,
    e.voided as voided
from encounter e
	inner join person p on p.person_id=e.patient_id and p.voided=0
	inner join
	(
		select form_id from form where
			uuid in('d720a8b3-52cc-41e2-9a75-3fd0d67744e5')
	) f on f.form_id=e.form_id
	left outer join obs o on o.encounter_id=e.encounter_id and o.voided=0
	and o.concept_id in (165176,161934,165180,165143,163258,162869)
where e.voided=0
group by e.patient_id, e.encounter_id;
SELECT "Completed processing GBVRC PRC data ", CONCAT("Time: ", NOW());
END$$


--Populate etl GBVRC legal forms:
DROP PROCEDURE IF EXISTS sp_populate_etl_gbvrc_legal_encounter$$
CREATE PROCEDURE sp_populate_etl_gbvrc_legal_encounter()
BEGIN
SELECT "Processing GBVRC legal data", CONCAT("Time: ", NOW());
insert into kenyaemr_etl.etl_gbvrc_legal(
                uuid ,
                encounter_id ,
                visit_id,
                patient_id ,
                location_id ,
                visit_date ,
                encounter_provider,
                date_created ,
                ob_number,
                police_station_reported_to,
                perpetrator,
                investigating_officer,
                investigating_officer_phonenumber,
                nature_of_gbv,
                action_taken_description ,
                in_court ,
                criminal_suit_no ,
                case_details,
                alternate_contact_name,
                alternate_phonenumber,
                voided
)
select
	e.uuid,
	e.encounter_id as encounter_id,
	e.visit_id as visit_id,
	e.patient_id,
	e.location_id,
	date(e.encounter_datetime) as visit_date,
	e.creator as encounter_provider,
	e.date_created as date_created,
	max(if(o.concept_id=167133,o.value_text,null)) as ob_number,
	max(if(o.concept_id=165262,o.value_text,null)) as police_station_reported_to,
	max(if(o.concept_id=165230,o.value_text,null)) as perpetrator,
	max(if(o.concept_id=167018,o.value_text,null)) as investigating_officer,
	max(if(o.concept_id=163152,o.value_text,null)) as investigating_officer_phonenumber,
max(if(o.concept_id=165205,(case o.value_coded when 118935 then "FGM" when 118688 then "Emotional"
when 141537 then "Socio-economic" when 145691 then "Defilement" when 127910 then "Rape"
when 126582 then "Sexual assault" when 147944 then "Wife inheritance/cleansing/battered wife"
when 158805 then "Forced Marriage" else "" end),null)) as nature_of_gbv,
    max(if(o.concept_id=161103,o.value_text,null)) as action_taken_description,
    max(if(o.concept_id=1562,(case o.value_coded when 1065 then "Yes" when 1066 then "No" else "" end),null)) as in_court,
    max(if(o.concept_id=162086,o.value_text,null)) as criminal_suit_no,
    max(if(o.concept_id=161011,o.value_text,null)) as case_details,
    max(if(o.concept_id=163258,o.value_text,null)) as alternate_contact_name,
    max(if(o.concept_id=159635,o.value_text,null)) as alternate_phonenumber,
    e.voided as voided
from encounter e
	inner join person p on p.person_id=e.patient_id and p.voided=0
	inner join
	(
		select form_id, uuid,name from form where
			uuid in('d0c36426-4503-4236-ab5d-39bff77f2b50')
	) f on f.form_id=e.form_id
	left outer join obs o on o.encounter_id=e.encounter_id and o.voided=0 and o.concept_id in (165205,167133,165262,165230,167018,163152,162086,161011,159635,163258,161103,1562)
where e.voided=0
group by e.patient_id, e.encounter_id;

SELECT "Completed processing GBVRC legal encounter data ", CONCAT("Time: ", NOW());
END$$

--Populate etl gbvrc pepmanagementforsurvivor:
DROP PROCEDURE IF EXISTS sp_populate_etl_gbvrc_pepmanagementforsurvivors $$
CREATE PROCEDURE sp_populate_etl_gbvrc_pepmanagementforsurvivors()
BEGIN
SELECT "Processing gbvrc_pepmanagementforsurvivors test data", CONCAT("Time: ", NOW());
insert into kenyaemr_etl.etl_gbvrc_pepmanagementforsurvivors(
      uuid,
      encounter_id,
      visit_id ,
      patient_id ,
      location_id ,
      visit_date,
      encounter_provider,
      date_created,
      date_reported,
      prc_number,
      weight,
      height,
      lmp,
      type_of_violence,
      specify_type_of_violence,
      type_of_assault,
      specify_type_of_assault,
      date_time_incidence,
      perpetrator_name,
      relation_to_perpetrator,
      compulsory_hiv_test,
      compulsory_hiv_test_result,
      perpetrator_file_number,
      state_of_patient ,
      state_of_patient_clothing ,
      examination_genitalia ,
      other_injuries ,
      high_vagina_anal_swab_result,
      RPR_VDRL_result,
      hiv_pre_testcounselling_result,
      given_pep,
      referred_to_psc,
      PDT_result,
      emergency_pills,
      emergency_pills_specify,
      sti_prophylaxis_trx,
      sti_prophylaxis_trx_specify,
      pep_regimen,
      pep_regimen_specify,
      starter_pack_given,
      date_given,
      HBsAG_result,
      LFTs_ALT_result,
      creatinine_result,
      other_specify_result,
      tca_date,
      voided
)
select
	e.uuid,
	e.encounter_id as encounter_id,
	e.visit_id as visit_id,
	e.patient_id,
	e.location_id,
	date(e.encounter_datetime) as visit_date,
	e.creator as encounter_provider,
	e.date_created as date_created,
	max(if(o.concept_id=166848,date(o.value_datetime),null)) as date_reported,
	max(if(o.concept_id=165416,o.value_text,null)) as prc_number,
	max(if(o.concept_id=5089,o.value_numeric,null)) as weight,
	max(if(o.concept_id=5090,o.value_numeric,null)) as height,
	max(if(o.concept_id=1427,date(o.value_datetime),null)) as lmp,
	max(if(o.concept_id=165205,(case o.value_coded when 127910 then "Rape" when 145691 then "Defilement"
	when 5622 then "Other" else "" end),null)) as type_of_violence,
	max(if(o.concept_id=165138,o.value_text,null)) as specify_type_of_violence,
	max(if(o.concept_id=123160,(case o.value_coded when 123385 then "Vaginal" when 148895 then "Anal"
	when 5622 then "Other"  else "" end),null)) as type_of_assault,
	max(if(o.concept_id=165145,o.value_text,null)) as specify_type_of_assault,
	max(if(o.concept_id=165349,o.value_datetime,null)) as date_time_incidence,
    max(if(o.concept_id=165230,o.value_text,null)) as perpetrator_name,
    max(if(o.concept_id=167214,o.value_text,null)) as relation_to_perpetrator,
    max(if(o.concept_id=164848,(case o.value_coded when 1065 then "Done" when 1066 then "Not Done" else "" end),null)) as compulsory_hiv_test
	max(if(o.concept_id=159427,(case o.value_coded when 703 then "Not Reactive" when 664 then "Reactive" else "" end),null)) as compulsory_hiv_test_result
    max(if(o.concept_id=1639,o.value_text,null)) as perpetrator_file_number,
    max(if(o.concept_id=163042,o.value_text,null)) as state_of_patient,
    max(if(o.concept_id=163045,o.value_text,null)) as state_of_patient_clothing,
    max(if(o.concept_id=160971,o.value_text,null)) as examination_genitalia,
    max(if(o.concept_id=165092,o.value_text,null)) as other_injuries,
    max(if(o.concept_id=163045,o.value_text,null)) as state_of_patient_clothing,
    max(if(o.concept_id=166141,(case o.value_coded when 703 then "Reactive" when 664 then "Non Reactive"
    when 1138 then "Indeterminate" else "" end),null)) as high_vagina_anal_swab_result
    max(if(o.concept_id=299,(case o.value_coded when 1229 then "Non Reactive" when 1228 then "Reactive"
    else "" end),null)) as RPR_VDRL_result,
    max(if(o.concept_id=163760,(case o.value_coded when 664 then "Non Reactive" when 703 then "Reactive"
    else "" end),null)) as hiv_pre_testcounselling_result,
    max(if(o.concept_id=165171,(case o.value_coded when 1065 then "Yes" else "" end),null)) as given_pep,
    max(if(o.concept_id=165270,(case o.value_coded when 1065 then "Yes" else "" end),null)) as referred_to_psc,
    max(if(o.concept_id=160888,(case o.value_coded when 664 then "Non Reactive" when 703 then "Reactive"
    else "" end),null)) as PDT_result,
    max(if(o.concept_id=165167,(case o.value_coded when 1065 then "Issued" when 1066 then "Not Issued"
        else "" end),null)) as emergency_pills,
    max(if(o.concept_id=160138,o.value_text,null)) as emergency_pills_specify,
    max(if(o.concept_id=165200,(case o.value_coded when 166536 then "STI prophylaxis"
    when 1065 then "STI Treatment" when 1066 then "Not Issued" else "" end),null)) as sti_prophylaxis_trx,
    max(if(o.concept_id=160953,o.value_text,null)) as sti_prophylaxis_trx_specify,
    max(if(o.concept_id=164845,(case o.value_coded when 1065 then "Issued" when 1066 then "Not Issued"
    else "" end),null)) as pep_regimen,
    max(if(o.concept_id=160954,o.value_text,null)) as pep_regimen_specify,
    max(if(o.concept_id=1263,(case o.value_coded when 1065 then "Issued" when 1066 then "Not Issued"
    else "" end),null)) as starter_pack_given,
    max(if(o.concept_id=166865,date(o.value_datetime),null)) as date_given,
    max(if(o.concept_id=161472,(case o.value_coded when 664 then "Non Reactive" when 1066 then "Reactive"
        else "" end),null)) as HBsAG_result,
    max(if(o.concept_id=654,o.value_numeric,null)) as LFTs_ALT_result,
    max(if(o.concept_id=790,o.value_numeric,null)) as creatinine_result,
    max(if(o.concept_id=160987,o.value_text,null)) as other_specify_result,
    max(if(o.concept_id=160753,date(o.value_datetime),null)) as tca_date,
    e.voided
from encounter e
	inner join person p on p.person_id=e.patient_id and p.voided=0
	inner join form f on f.form_id=e.form_id and f.uuid in ('f44b2405-226b-47c4-b98f-b826ea4725ae')
	left outer join obs o on o.encounter_id=e.encounter_id and o.voided=0 and o.concept_id in
	(166848,165416,5090,5089,1427,165205,165138,123160,165349,165230,167214,164848,159427,
	1639,163042,163045,160971,165092,166141,299,163760,165171,165270,160888,165167,160138,160968,165200
	160953,164845,160954,1263,166865,161472,654,790,160987,160753)
where e.voided=0
group by e.patient_id, e.encounter_id;


SELECT "Completed processing gbvrc_pepmanagementforsurvivors data ", CONCAT("Time: ", NOW());
END$$

--Populate etl_gbvrc_pepmanagement_nonoccupationalexposure
DROP PROCEDURE IF EXISTS sp_populate_etl_gbvrc_pepmanagement_nonoccupationalexposure $$
CREATE PROCEDURE sp_populate_etl_gbvrc_pepmanagement_nonoccupationalexposure()
BEGIN
SELECT "Processing gbvrc_pepmanagement_nonoccupationalexposure data", CONCAT("Time: ", NOW());
insert into kenyaemr_etl.etl_gbvrc_pepmanagement_nonoccupationalexposure(
                  uuid,
                  encounter_id,
                  visit_id,
                  patient_id,
                  location_id,
                  visit_date,
                  encounter_provider,
                  date_created,
                  ocn_number,
                  weight,
                  height,
                  type_of_exposure,
                  hiv_test_result,
                  starter_pack_given,
                  pep_regimen,
                  pep_regimen_specify,
                  HBsAG_result,
                  LFTs_ALT_result,
                  creatinine_result,
                  tca_date,
                  voided
)
select
	e.uuid,
	e.encounter_id as encounter_id,
	e.visit_id as visit_id,
	e.patient_id,
	e.location_id,
	date(e.encounter_datetime) as visit_date,
	e.creator as encounter_provider,
	e.date_created as date_created,
	max(if(o.concept_id=165416,o.value_text,null)) as ocn_number,
    max(if(o.concept_id=5089,o.value_numeric,null)) as weight,
    max(if(o.concept_id=5090,o.value_numeric,null)) as height,
    max(if(o.concept_id=165248,o.value_text,null)) as type_of_exposure,
    max(if(o.concept_id=159427,case o.value_coded when 703 then "Reactive" when 664 then "Non Reactive" else "" end,null)) as hiv_test_result,
    max(if(o.concept_id=1263,case o.value_coded when 1065 then "Yes" when 1066 then "No" else "" end,null)) as starter_pack_given,
    max(if(o.concept_id=166655,case o.value_coded when 162326 then "RegCat:Children 25-34.9kg"
    when 162323 then "RegCat:Adults and Children > 34.9Kg"
    when 162321 then "RegCat:Children 20-24.9kg"  when 162322 then "RegCat:Children < 20kg"
     else "" end,null)) as pep_regimen,
    max(if(o.concept_id=163104,o.value_text,null)) as pep_regimen_specify,
    max(if(o.concept_id=161472,(case o.value_coded when 664 then "Non Reactive" when 1066 then "Reactive"
            else "" end),null)) as HBsAG_result,
    max(if(o.concept_id=654,o.value_numeric,null)) as LFTs_ALT_result,
    max(if(o.concept_id=790,o.value_numeric,null)) as creatinine_result,
    max(if(o.concept_id=160753,date(o.value_datetime),null)) as tca_date,
    e.voided
from encounter e
	inner join person p on p.person_id=e.patient_id and p.voided=0
	inner join form f on f.form_id=e.form_id and f.uuid = '92de9269-6bb4-4c24-8ec9-870aa2c64b5a'
	left outer join obs o on o.encounter_id=e.encounter_id and o.voided=0 and o.concept_id in (165416,5089,
	5090,165248,159427,1263,166655,163104,161472,654,790,160753)
where e.voided=0
group by e.patient_id, e.encounter_id;


SELECT "Completed processing gbvrc_pepmanagement_nonoccupationalexposure data ", CONCAT("Time: ", NOW());
END$$

--Populate etl gbvrc_linkage:
DROP PROCEDURE IF EXISTS sp_populate_etl_gbvrc_linkage $$
CREATE PROCEDURE sp_populate_etl_gbvrc_linkage()
BEGIN
SELECT "Processing gbvrc_linkage data", CONCAT("Time: ", NOW());
insert into kenyaemr_etl.etl_gbvrc_linkage(
        uuid,
        encounter_id ,
        patient_id  ,
        location_id ,
        visit_date,
        encounter_provider ,
        date_created ,
        date_of_violence,
        nature_of_violence,
        action_taken ,
        any_special_need ,
        comment_specialneed,
        date_contacted_at_community,
        number_of_interractive_session,
        date_referred_GBVRC,
        date_clinically_seen_at_GBVRC,
        mobilizer_name,
        mobilizer_phonenumber ,
        received_by,
        voided
)
select
	e.uuid,
	e.encounter_id as encounter_id,
	e.visit_id as visit_id,
	e.patient_id,
	e.location_id,
	date(e.encounter_datetime) as visit_date,
	e.creator as encounter_provider,
	e.date_created as date_created,
	max(if(o.concept_id=165349,date(o.value_datetime),null)) as date_of_violence,
	max(if(o.concept_id=165205,case o.value_coded when 158358 then "Physical"
	when 152370 then "Sexual" when 117510 then "Emotional" when 124824 then "Financial"
	when 141815 then "IPV" else "" end,null)) as nature_of_violence,
    max(if(o.concept_id=159639,case o.value_coded when 161189 then "Go to hospital"
    when 151316 then "Take over the counter medicine" when 167254 then "Reported to local Authority"
    when 165227 then "Moved to safe place" when 165183 then "Received counselling"
    when 148502 then "Perpetrator apprehended" when 5622 then "Other (specify)" else "" end,null)) as action_taken,
    max(if(o.concept_id=161601,case o.value_coded when 118686 then "Elderly"
    when 161597 then "OVC" when 161599 then "Person living with disability"
    when 166043 then "Adolescent" when 5622 then "Other (specify)" else "" end,null)) as any_special_need,
    max(if(o.concept_id=161011,o.value_text,null)) as comment_specialneed,
    max(if(o.concept_id=165144,date(o.value_datetime),null)) as date_contacted_at_community,
    max(if(o.concept_id=1639,o.value_numeric,null)) as number_of_interractive_session,
    max(if(o.concept_id=161560,date(o.value_datetime),null)) as date_referred_GBVRC,
    max(if(o.concept_id=163260,date(o.value_datetime),null)) as date_clinically_seen_at_GBVRC,
    max(if(o.concept_id=164141,o.value_text,null)) as mobilizer_name,
    max(if(o.concept_id=159635,o.value_text,null)) as mobilizer_phonenumber,
    max(if(o.concept_id=1473,o.value_text,null)) as received_by,
    e.voided
from encounter e
	inner join person p on p.person_id=e.patient_id and p.voided=0
	inner join form f on f.form_id=e.form_id and f.uuid = 'f760e38c-3d2f-4a5d-aa3d-e9682576efa8'
	left outer join obs o on o.encounter_id=e.encounter_id and o.voided=0 and o.concept_id in
	(165349,165205,159639,161601,161011,165144,1639,161560,163260,164141,159635,1473)
where e.voided=0
group by e.patient_id, e.encounter_id;


SELECT "Completed processing gbvrc_linkage data ", CONCAT("Time: ", NOW());
END$$


--Populate etl gbvrc_physicalemotional_violence:GBVRC
DROP PROCEDURE IF EXISTS sp_populate_etl_gbvrc_physicalemotional_violence$$
CREATE PROCEDURE sp_populate_etl_gbvrc_physicalemotional_violence()
BEGIN
SELECT "Processing etl_gbvrc_physicalemotional_violence data", CONCAT("Time: ", NOW());
insert into kenyaemr_etl.etl_gbvrc_physicalemotional_violence(
            uuid,
            encounter_id,
            visit_id,
            patient_id ,
            location_id ,
            visit_date ,
            encounter_provider,
            date_created ,
            gbv_no,
            referred_from,
            referred_from_specify,
            rri_test ,
            pr_test,
            type_of_violence,
            specify_type_of_violence,
            trauma_counselling,
            trauma_counselling_comment,
            sti_screening_tx,
            sti_screening_tx_comment,
            lab_test,
            lab_test_comment,
            rapid_hiv_test,
            rapid_hiv_test_comment,
            legal_counsel,
            legal_counsel_comment,
            child_protection,
            child_protection_comment,
            referred_to,
            scheduled_appointment_date,
            voided
)
select
	e.uuid,
	e.encounter_id as encounter_id,
	e.visit_id as visit_id,
	e.patient_id,
	e.location_id,
	date(e.encounter_datetime) as visit_date,
	e.creator as encounter_provider,
	e.date_created as date_created,
	max(if(o.concept_id=165416,o.value_text,null)) as gbv_no,
	max(if(o.concept_id=1272,case o.value_coded when 5486 then "police" when 1275 then "Health facility"
	when 978 then "Self" when 160543 then "Community outreach" when 5622 then "other"
	else "" end,null)) as referred_from,
    max(if(o.concept_id=165092,o.value_text,null)) as referred_from_specify,
    max(if(o.concept_id=161103,o.value_text,null)) as rri_test,
	max(if(o.concept_id=165092,o.value_text,null)) as pr_test,
    max(if(o.concept_id=165205,case o.value_coded when 158358 then "physical violence" when 117510 then "Emotional"
	when 5622 then "other" else "" end,null)) as type_of_violence,
    max(if(o.concept_id = 160632,o.value_text,null)) as specify_type_of_violence,
    max(if(o.concept_id=165184,case o.value_coded when 1065 then "Yes" when 1066 then "No" else "" end,null)) as trauma_counselling,
	max(if(o.concept_id=161011,o.value_text,null)) as trauma_counselling_comment,
	max(if(o.concept_id=165172,case o.value_coded when 1065 then "Yes" when 1066 then "No" else "" end,null)) as sti_screening_tx,
	max(if(o.concept_id=160632,o.value_text,null)) as sti_screening_tx_comment,
	max(if(o.concept_id=167229,case o.value_coded when 1065 then "Yes" when 1066 then "No" else "" end,null)) as lab_test,
    max(if(o.concept_id=165435,o.value_text,null)) as lab_test_comment,
    max(if(o.concept_id=164848,case o.value_coded when 1065 then "Yes" when 1066 then "No" else "" end,null)) as rapid_hiv_test,
    max(if(o.concept_id=164963,o.value_text,null)) as rapid_hiv_test_comment,
    max(if(o.concept_id=1379,case o.value_coded when 1065 then "Yes" when 1066 then "No" else "" end,null)) as legal_counsel,
    max(if(o.concept_id=165426,o.value_text,null)) as legal_counsel_comment,
    max(if(o.concept_id=161601,case o.value_coded when 1065 then "Yes" when 1066 then "No" else "" end,null)) as child_protection,
    max(if(o.concept_id=167214,o.value_text,null)) as child_protection_comment,
    max(if(o.concept_id=1885,case o.value_coded when 165192 then "police" when 165227 then "safe space" when 165227 then "ADR" else "" end,null)) as referred_to,
	e.voided
from encounter e
	inner join person p on p.person_id=e.patient_id and p.voided=0
	inner join form f on f.form_id=e.form_id and f.uuid ="9d21275a-7657-433a-b305-a736423cc496"
	left outer join obs o on o.encounter_id=e.encounter_id and o.voided=0 and o.concept_id in (165416,1272,165092,165205,160632,165184,161011,165172,160632,167229,165435
	,164848,164963,1379,165426,161601,167214,1885)
where e.voided=0
group by e.patient_id, e.encounter_id;


SELECT "Completed processing physicalemotional_violence data ", CONCAT("Time: ", NOW());
END$$


--Populate etl gbvrc_postrapecare:
DROP PROCEDURE IF EXISTS sp_populate_etl_gbvrc_postrapecare $$
CREATE PROCEDURE sp_populate_etl_gbvrc_postrapecare()
BEGIN
SELECT "Processing etl_gbvrc_postrapecare data", CONCAT("Time: ", NOW());
insert into kenyaemr_etl.etl_gbvrc_postrapecare(
            uuid,
            encounter_id,
            visit_id,
            patient_id ,
            location_id ,
            visit_date ,
            encounter_provider,
            date_created ,
            date_of_examination,
            date_of_incident,
            no_alleged_perpetrators,
            alleged_perpetrator ,
            specify_the_rship ,
            county,
            subcounty ,
            landmark,
            indicate_observation,
            indicate_reported,
            circumstantial_incident,
            type_of_sexual_violence,
            specify_type_of_sexual_violence,
            use_of_condom,
            attended_health_facility,
            facility_name,
            date_time,
            were_you_treated,
            given_referral_notes,
            reported_to_police,
            police_station,
            date_reported,
            medical_history,
            observation_remark,
            physical_examination,
            parity,
            contraception_type,
            lmp,
            known_pregnancy ,
            consensual_sex_date,
            blood_pressure,
            pulse_rate,
            RR ,
            temperature,
            demeanor,
            survivor_change_cloth,
            state_of_clothes,
            clothes_transported,
            other_clothes_details,
            clothes_handed_to_police,
            survivor_goto_toilet,
            survivor_bathe,
            yes_bathe_details,
            perpetrators_mark,
            yes_perpetrator_details,
            physical_injuries,
            outer_genitalia,
            vagina,
            hymen,
            anus,
            other_orifices,
            pep_1st_dose,
            ecp_given,
            stitching,
            yes_comment,
            sti_txt_given,
            yes_comment_sti_trx,
            medication_comment,
            referrals_to,
            other_referral_specify,
            lab_type,
            comment,
            samples_packed_issued,
            examining_officer,
            police_officer,
            voided
)
select
	e.uuid,
	e.encounter_id as encounter_id,
	e.visit_id as visit_id,
	e.patient_id,
	e.location_id,
	date(e.encounter_datetime) as visit_date,
	e.creator as encounter_provider,
	e.date_created as date_created,
	max(if(o.concept_id=159948,o.value_datetime,null)) as date_of_examination,
	max(if(o.concept_id=162869,o.value_datetime,null)) as date_of_incident,
	max(if(o.concept_id=1639,o.value_numeric,null)) as no_alleged_perpetrators,
	max(if(o.concept_id=1119,case o.value_coded when 1066 then 'unknown' when 1065 then 'known' else ,null)) as alleged_perpetrator,
	max(if(o.concept_id=165092,o.value_text,null)) as specify_the_rship,
    max(if(o.concept_id=167131,o.value_text,null)) as county,
    max(if(o.concept_id=161564,o.value_text,null)) as subcounty,
    max(if(o.concept_id=159942,o.value_text,null)) as landmark,
    max(if(o.concept_id=160945,o.value_text,null)) as indicate_observation,
    max(if(o.concept_id=166846,o.value_text,null)) as indicate_reported,
    max(if(o.concept_id=160303,o.value_text,null)) as circumstantial_incident,
	max(if(o.concept_id=123160,case o.value_coded when 166060 then "oral" when 123385 then "vaginal" when 148895 then "Anal" when 5622 then "Other (specify)"
	else "" end,null)) as type_of_sexual_violence,
	max(if(o.concept_id=160979,o.value_text,null)) as specify_type_of_sexual_violence,
	max(if(o.concept_id=1357,case o.value_coded when 1066 then 'No' when 1065 then 'Yes' when 1067 then 'Unknown' else ,null)) as use_of_condom,
	max(if(o.concept_id=166484,case o.value_coded when 1066 then 'No' when 1065 then 'Yes' else ,null)) as attended_health_facility,
	max(if(o.concept_id=162724,o.value_text,null)) as facility_name,
	max(if(o.concept_id=164093,o.value_datetime,null)) as date_time,
	max(if(o.concept_id=165052,case o.value_coded when 1066 then 'No' when 1065 then 'Yes' else ,null)) as were_you_treated,
	max(if(o.concept_id=165152,case o.value_coded when 1066 then 'No' when 1065 then 'Yes' else ,null)) as given_referral_notes,
	max(if(o.concept_id=165193,case o.value_coded when 1066 then 'No' when 1065 then 'Yes' else ,null)) as reported_to_police,
	max(if(o.concept_id=161550,o.value_text,null)) as police_station,
	max(if(o.concept_id=165144,o.value_datetime,null)) as date_reported,
    max(if(o.concept_id=160221,o.value_text,null)) as medical_history,
    max(if(o.concept_id=163677,o.value_text,null)) as observation_remark,
    max(if(o.concept_id=1391,o.value_text,null)) as physical_examination,
    max(if(o.concept_id=1053,o.value_text,null)) as  parity,
    max(if(o.concept_id=163400,case o.value_coded when 1066 then 'No' when 1065 then 'Yes' else ,null)) as contraception_type,
    max(if(o.concept_id=1427,o.value_datetime,null)) as lmp,
    max(if(o.concept_id=5272,case o.value_coded when 1066 then 'No' when 1065 then 'Yes' else ,null)) as known_pregnancy,
    max(if(o.concept_id=163724,o.value_datetime,null)) as consensual_sex_date,
    max(if(o.concept_id=163375,o.value_numeric,null)) as blood_pressure,
    max(if(o.concept_id=163381,o.value_text,null)) as  pulse_rate,
    max(if(o.concept_id=5242,o.value_numeric,null)) as   RR,
    max(if(o.concept_id=5088,o.value_numeric,null)) as temperature,
    max(if(o.concept_id=162056,case o.value_coded when 1066 then 'No' when 1065 then 'Yes' else ,null)) as demeanor,
    max(if(o.concept_id=162676,case o.value_coded when 1066 then 'No' when 1065 then 'Yes' else ,null)) as survivor_change_cloth,
    max(if(o.concept_id=161031,o.value_text,null)) as  state_of_clothes,
    max(if(o.concept_id=161239,case o.value_coded when 159310 then 'plastic bag' when 161240 then 'non plastic bag' when 5622 then 'other' else ,null)) as clothes_transported,
    max(if(o.concept_id=166363,o.value_text,null)) as  other_clothes_details,
    max(if(o.concept_id=165180,case o.value_coded when 1066 then 'No' when 1065 then 'Yes' else ,null)) as clothes_handed_to_police,
    max(if(o.concept_id=160258,case o.value_coded when 1065 then 'long_call' when 1066 then 'short_call' else ,null)) as survivor_goto_toilet,
    max(if(o.concept_id=162997,case o.value_coded when 1066 then 'No' when 1065 then 'Yes' else ,null)) as survivor_bathe,
    max(if(o.concept_id=163048,o.value_text,null)) as yes_bathe_details,
    max(if(o.concept_id=165241,case o.value_coded when 1066 then 'No' when 1065 then 'Yes' else ,null)) as perpetrators_mark,
    max(if(o.concept_id=161031,o.value_text,null)) as yes_perpetrator_details,
    max(if(o.concept_id=165035,o.value_text,null)) as physical_injuries,
    max(if(o.concept_id=160971,o.value_text,null)) as outer_genitalia,
    max(if(o.concept_id=160969,o.value_text,null)) as vagina,
    max(if(o.concept_id=160981,o.value_text,null)) as hymen,
    max(if(o.concept_id=160962,o.value_text,null)) as anus,
    max(if(o.concept_id=160943,o.value_text,null)) as other_orifices,
    max(if(o.concept_id=165060,case o.value_coded when 1066 then 'No' when 1065 then 'Yes' else ,null)) as pep_1st_dose,
    max(if(o.concept_id=374,case o.value_coded when 1066 then 'No' when 1065 then 'Yes' else ,null)) as ecp_given,
    max(if(o.concept_id=1670,case o.value_coded when 1066 then 'No' when 1065 then 'Yes(comment)' else ,null)) as stitching,
    max(if(o.concept_id=165440,o.value_text,null)) as yes_comment,
    max(if(o.concept_id=165200,case o.value_coded when 1066 then 'No' when 1065 then 'Yes(comment)' else ,null)) as sti_txt_given,
    max(if(o.concept_id=167214,o.value_text,null)) as yes_comment_sti_trx,
    max(if(o.concept_id=160632,o.value_text,null)) as medication_comment,
    max(if(o.concept_id=1272,case o.value_coded when 165192 then 'police_station' when 1370 then 'hiv test' when 164422 then 'lab'
    when 135914 then 'legal' when 5460 then 'trauma counselling' when 167254 then 'safe shelter'
    when 160542 then 'opd'  when 5622 then 'other (specify)' else ,null)) as referrals_to,
    max(if(o.concept_id=165138,o.value_text,null)) as other_referral_specify,
    max(if(o.concept_id=164217,case o.value_coded when 160480 then 'National_government lab' when 1537 then 'Health facility lab' else ,null)) as lab_type,
    max(if(o.concept_id=161011,o.value_text,null)) as comment,
    max(if(o.concept_id=165435,o.value_text,null)) as samples_packed_issued,
    max(if(o.concept_id=165225,o.value_text,null)) as examining_officer,
    max(if(o.concept_id=165142,o.value_text,null)) as  police_officer,
    e.voided
from encounter e
	inner join person p on p.person_id=e.patient_id and p.voided=0
	inner join form f on f.form_id=e.form_id and f.uuid ="c46aa4fd-8a5a-4675-90a7-a6f2119f61d8"
	left outer join obs o on o.encounter_id=e.encounter_id and o.voided=0 and o.concept_id in (159948,162869,1639,165229,165092,167131,161564,159942,
	160945,166846,160303,123160,160979,1357,166484,162724,164093,165052,165152,165193,161550,165144,160221,163677,1391,1053,163400,1427,5272,163724,
	163375,163381,5242,5088,162056,162676,161031,161239,166363,165180,160258,162997,163048,165241,161031,165035,160971,160969,160981,160962,160943,
	165060,374,1670,165440,165200,167214,160632,1272,165138,164217,161011,165435,165225,165142)
where e.voided=0
group by e.patient_id, e.encounter_id;


SELECT "Completed processing gbvrc_postrapecare data ", CONCAT("Time: ", NOW());
END$$

--Populate etl gbvrc_psychologicalassessment:
DROP PROCEDURE IF EXISTS sp_populate_etl_gbvrc_psychologicalassessment $$
CREATE PROCEDURE sp_populate_etl_gbvrc_psychologicalassessment()
BEGIN
SELECT "Processing etl_gbvrc_psychologicalassessment data", CONCAT("Time: ", NOW());
insert into kenyaemr_etl.etl_gbvrc_psychologicalassessment(
            uuid,
            encounter_id,
            visit_id,
            patient_id ,
            location_id ,
            visit_date ,
            encounter_provider,
            date_created ,
            general_appearance,
            rapport,
            mood,
            affect,
            speech,
            perception,
            thought_content,
            thought_process,
            art_therapy,
            child_experience ,
            memory,
            orientation,
            concentration,
            intelligence,
            judgement,
            insight_level,
            recommendation,
            referral_point,
            examining_officer,
            police_officer,
            voided
)
select
	e.uuid,
	e.encounter_id as encounter_id,
	e.visit_id as visit_id,
	e.patient_id,
	e.location_id,
	date(e.encounter_datetime) as visit_date,
	e.creator as encounter_provider,
	e.date_created as date_created,
	max(if(o.concept_id=1119,case o.value_coded when 460 then 'appear older or younger' when 5201 then 'gait'
	when 5243 then 'dressing' when 136443 then 'grooming (unkempt)' when 159438 then 'grooming(neat)' else ,null)) as general_appearance,
	max(if(o.concept_id=122943,case o.value_coded when 160281 then "easy to establish" when 160282 then "Initially difficult but easier over time"
	when 141762 then "Difficult to establish" else "" end,null)) as rapport,
	max(if(o.concept_id=165159,case o.value_coded when 166050 then "elevated" when 119539 then "sad" when 140487 then "happy" when 163468 then "hopeless"
    when 141611 then "euphoric" when 165536 then "depressed" when 118296 then "irritable" when 140468 then 'anxious'
    when 122996 then "angry"  when 118879 then "easily upset" else "" end,null)) as mood,

    max(if(o.concept_id=167099,case o.value_coded when 136204 then "labile" when 153557 then "blunt/flat" when 162980 then "appropriate to content"
    when 137668 then "Inappropriate to content" else "" end,null)) as affect,

    max(if(o.concept_id=167201,case o.value_coded when 145046 then "Speak rapidly & frenziedly" when 159539 then "Speak clearly"
    when 126351 then "Mumbling" when 137646 then "Monosyllables" when 112842 then "Hesitant" else "" end,null)) as speech,

    max(if(o.concept_id=159707,case o.value_coded when 139146 then "Hallucination" when 126456 then "Feeling of unreality"
    when 150881 then "Hesitant"  else "" end,null)) as perception,

    max(if(o.concept_id=167112,case o.value_coded when 160847 then "Ideas but no plan or intent" when 160848 then "clear plan but no intent"
    when 160849 then "Unclear plan but no intent" when 160844 then "Ideas coupled with clear plan and intent to carry it out" else "" end, null)) as thought_content,

    max(if(o.concept_id=167106,case o.value_coded when 167108 then "Goal-directed/Logical ideas" when 1097 then "Loosened association/flight ideas"
    when 1099 then "Relevant" when 1090 then "Circumstantial" when 1100 then "Ability to abstract" when 1098 then "Perseveration"
    when 167020 then "art_therapy" when 165427 then "child_experience" else "" end, null)) as thought_process,
    max(if(o.concept_id=167020,o.value_text,null)) as art_therapy,
    max(if(o.concept_id=165427,o.value_text,null)) as child_experience,
    max(if(o.concept_id=165295,case o.value_coded when 129507 then "Recent memory" when 121657 then "Long-term memory"
    when 134145 then "Short-term memory"  else "" end,null)) as memory,

    max(if(o.concept_id=167084,case o.value_coded when 167083 then "verily oriented" when 167081 then "oriented"
    when 161427 then "poorly oriented"  else "" end,null)) as orientation,

    max(if(o.concept_id=161427,case o.value_coded when 161565 then "above average" when 114412 then "average"
    when 167082 then "Below average"  else "" end,null)) as concentration,

    max(if(o.concept_id=165241,case o.value_coded when 161565 then "above average" when 114412 then "average"
    when 167082 then "Below average"  else "" end,null)) as intelligence,

    max(if(o.concept_id=167116,case o.value_coded when 159407 then "poor" when 164077 then "very good"
    when 159406 then "fair"  else "" end,null)) as judgement,

    max(if(o.concept_id=167115,case o.value_coded when 159405 then "present" when 159406 then "fair"
    when 1107 then "not present"  else "" end,null)) as insight_level,
    max(if(o.concept_id=164359,o.value_text,null)) as recommendation,
    max(if(o.concept_id=166485,o.value_text,null)) as referral_point,
	max(if(o.concept_id=165225,o.value_text,null)) as examining_officer,
	max(if(o.concept_id=165142,o.value_text,null)) as police_officer,
    e.voided
from encounter e
	inner join person p on p.person_id=e.patient_id and p.voided=0
	inner join form f on f.form_id=e.form_id and f.uuid ="9d21275a-7657-433a-b305-a736423cc496"
	left outer join obs o on o.encounter_id=e.encounter_id and o.voided=0 and o.concept_id in (165142,165225,166485,164359,167115,167116,165241,161427,
	167084,165295,167020,165427,167106,167112,159707,167201,167099,165159,122943,1119)
where e.voided=0
group by e.patient_id, e.encounter_id;


SELECT "Completed processing gbvrc_psychologicalassessment data ", CONCAT("Time: ", NOW());
END$$

		-- end of dml procedures

		SET sql_mode=@OLD_SQL_MODE $$

-- ------------------------------------------- running all procedures -----------------------------

DROP PROCEDURE IF EXISTS sp_build_gbvrc_tables $$
CREATE PROCEDURE sp_build_gbvrc_tables()
BEGIN
DECLARE populate_script_id INT(11);
SELECT "Beginning first time setup", CONCAT("Time: ", NOW());
INSERT INTO kenyaemr_etl.etl_script_status(script_name, start_time) VALUES('initial_population_of_gbvrc_tables', NOW());
SET populate_script_id = LAST_INSERT_ID();

CALL sp_populate_etl_gbvrc_consenting();
CALL sp_populate_etl_gbvrc_legal_encounter();
CALL sp_populate_etl_gbvrc_pepmanagementforsurvivors();
CALL sp_populate_etl_gbvrc_pepmanagement_nonoccupationalexposure();
CALL sp_populate_etl_gbvrc_linkage();
CALL sp_populate_etl_gbvrc_physicalemotional_violence();
CALL sp_populate_etl_gbvrc_postrapecare();
CALL sp_populate_etl_gbvrc_psychologicalassessment();

UPDATE kenyaemr_etl.etl_script_status SET stop_time=NOW() where id= populate_script_id;

SELECT "Completed first time setup", CONCAT("Time: ", NOW());
END $$



