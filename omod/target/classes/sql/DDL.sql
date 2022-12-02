DROP PROCEDURE IF EXISTS create_gbv_etl_tables $$
CREATE PROCEDURE create_gbv_etl_tables()
BEGIN
DECLARE script_id INT(11);

-- I have included statements like SELECT "Successfully created gbvrc  table" after creation of every table
-- without them, execution of the sp fail with RESULTSET  is from UPDATE. No Data
-- Let's therefore use it as a convention to get the SQL executed by OpenMRS Context

-- Log start time
INSERT INTO kenyaemr_etl.etl_script_status(script_name, start_time) VALUES('create_gbv_etl_tables', NOW());
SET script_id = LAST_INSERT_ID();

DROP TABLE IF EXISTS kenyaemr_etl.etl_gbv_prc_consenting;
DROP TABLE IF EXISTS kenyaemr_etl.etl_gbv_physicalemotional_violence;
DROP TABLE IF EXISTS kenyaemr_etl.etl_gbv_legal;
DROP TABLE IF EXISTS kenyaemr_etl.etl_gbv_linkage;
DROP TABLE IF EXISTS kenyaemr_etl.etl_gbv_pepmanagementforsurvivors;
DROP TABLE IF EXISTS kenyaemr_etl.etl_gbv_pepmanagement_nonoccupationalexposure;
DROP TABLE IF EXISTS kenyaemr_etl.etl_gbv_pepmanagement_occupationalexposure;
DROP TABLE IF EXISTS kenyaemr_etl.etl_gbv_pepmanagement_followup;
DROP TABLE IF EXISTS kenyaemr_etl.etl_gbv_counsellingencounter;
DROP TABLE IF EXISTS kenyaemr_etl.etl_gbv_perpetratorencounter;
DROP TABLE IF EXISTS kenyaemr_etl.etl_gbv_psychologicalassessment;
DROP TABLE IF EXISTS kenyaemr_etl.etl_gbv_postrapecare;

-------------- create table kenyaemr_etl.etl_gbv_prc_consenting-----------------------
CREATE TABLE kenyaemr_etl.etl_gbv_prc_consenting(
      uuid CHAR(38),
      encounter_id INT(11) NOT NULL PRIMARY KEY,
      visit_id INT(11) DEFAULT NULL,
      patient_id INT(11) NOT NULL ,
      location_id INT(11) DEFAULT NULL,
      visit_date DATE,
      encounter_provider INT(11),
      medical_examination VARCHAR(10),
      collect_sample VARCHAR(10),
      provide_evidence VARCHAR(10),
      client_signature VARCHAR(50),
      witness_name VARCHAR(100),
      witness_signature VARCHAR(50),
      provider_name VARCHAR(100),
      provider_signature VARCHAR(50),
      date_consented DATE,
      voided INT(11),
      CONSTRAINT FOREIGN KEY (patient_id) REFERENCES kenyaemr_etl.etl_patient_demographics(patient_id),
      CONSTRAINT unique_uuid UNIQUE(uuid),
      INDEX(visit_date),
      INDEX(visit_id),
      INDEX(encounter_id),
      INDEX(patient_id),
      INDEX(patient_id, visit_date)
    );
  SELECT "Successfully created gbv prc consenting table";
-------------- create table kenyaemr_etl.etl_gbv_physicalemotional_violence-----------------------

CREATE TABLE kenyaemr_etl.etl_gbv_physicalemotional_violence(
      uuid CHAR(38),
      encounter_id INT(11) NOT NULL PRIMARY KEY,
      visit_id INT(11) DEFAULT NULL,
      patient_id INT(11) NOT NULL ,
      location_id INT(11) DEFAULT NULL,
      visit_date DATE,
      encounter_provider INT(11),
      date_created DATE,
      gbv_no VARCHAR(20),
      referred_from VARCHAR(10),
      referred_from_specify VARCHAR(100),
      type_of_violence VARCHAR(10),
      specify_type_of_violence VARCHAR(100),
      trauma_counselling VARCHAR(10),
      trauma_counselling_comment VARCHAR(255),
      sti_screening_tx VARCHAR(10),
      sti_screening_tx_comment VARCHAR(255),
      lab_test VARCHAR(10),
      lab_test_comment VARCHAR(255),
      rapid_hiv_test VARCHAR(10),
      rapid_hiv_test_comment VARCHAR(255),
      legal_counsel VARCHAR(10),
      legal_counsel_comment VARCHAR(255),
      child_protection VARCHAR(10),
      child_protection_comment VARCHAR(255),
      referred_to VARCHAR(10),
      scheduled_appointment_date DATE,
      voided INT(11),
      CONSTRAINT FOREIGN KEY (patient_id) REFERENCES kenyaemr_etl.etl_patient_demographics(patient_id),
      CONSTRAINT unique_uuid UNIQUE(uuid),
      INDEX(visit_date),
      INDEX(visit_id),
      INDEX(encounter_id),
      INDEX(patient_id),
      INDEX(patient_id, visit_date)
    );

  SELECT "Successfully created physical_emotional violence table";
-------------- create kenyaemr_etl.etl_gbv_linkage-----------------------

CREATE TABLE kenyaemr_etl.etl_gbv_linkage(
      uuid CHAR(38),
      encounter_id INT(11) NOT NULL PRIMARY KEY,
      visit_id INT(11) DEFAULT NULL,
      patient_id INT(11) NOT NULL ,
      location_id INT(11) DEFAULT NULL,
      visit_date DATE,
      encounter_provider INT(11),
      date_created DATE,
      date_of_violence DATE,
      nature_of_violence VARCHAR(50),
      action_taken VARCHAR(10),
      other_action_taken VARCHAR(50),
      any_special_need VARCHAR(50),
      comment_special_need VARCHAR(255),
      date_contacted_at_community DATE,
      number_of_interactive_session VARCHAR(10),
      date_referred_GBVRC DATE,
      date_clinically_seen_at_GBVRC DATE,
      mobilizer_name VARCHAR(100),
      mobilizer_phonenumber VARCHAR(50),
      received_by VARCHAR(50),
      voided INT(11),
      CONSTRAINT FOREIGN KEY (patient_id) REFERENCES kenyaemr_etl.etl_patient_demographics(patient_id),
      CONSTRAINT unique_uuid UNIQUE(uuid),
      INDEX(visit_date),
      INDEX(visit_id),
      INDEX(encounter_id),
      INDEX(patient_id),
      INDEX(patient_id, visit_date)
    );

  SELECT "Successfully created etl_gbv_linkage table";
    ------------- create table etl_gbv_linkage-----------------------
CREATE TABLE kenyaemr_etl.etl_gbv_legal(
      uuid CHAR(38),
      encounter_id INT(11) NOT NULL PRIMARY KEY,
      visit_id INT(11) DEFAULT NULL,
      patient_id INT(11) NOT NULL ,
      location_id INT(11) DEFAULT NULL,
      visit_date DATE,
      encounter_provider INT(11),
      date_created DATE,
      ob_number VARCHAR(20),
      police_station_reported_to VARCHAR(30),
      perpetrator VARCHAR(50),
      investigating_officer VARCHAR(50),
      investigating_officer_phonenumber INT(11),
      nature_of_action_taken VARCHAR(10),
      action_taken_description VARCHAR(255),
      referral_from_gbvrc VARCHAR(11),
      in_court VARCHAR(11),
      criminal_suit_no INT(11),
      case_details VARCHAR(1024),
      alternate_contact_name VARCHAR(255),
      alternate_phonenumber VARCHAR(40),
      voided INT(11),
      CONSTRAINT FOREIGN KEY (patient_id) REFERENCES kenyaemr_etl.etl_patient_demographics(patient_id),
      CONSTRAINT unique_uuid UNIQUE(uuid),
      INDEX(visit_date),
      INDEX(visit_id),
      INDEX(encounter_id),
      INDEX(patient_id),
      INDEX(patient_id, visit_date)
    );

  SELECT "Successfully created gbv_legal review table";

    ------------- create table kenyaemr_etl.etl_gbv_pepmanagementforsurvivors-----------------------
 CREATE TABLE kenyaemr_etl.etl_gbv_pepmanagementforsurvivors(
      uuid CHAR(38),
      encounter_id INT(11) NOT NULL PRIMARY KEY,
      visit_id INT(11) DEFAULT NULL,
      patient_id INT(11) NOT NULL ,
      location_id INT(11) DEFAULT NULL,
      visit_date DATE,
      encounter_provider INT(11),
      date_created DATE,
      date_reported DATE,
      prc_number VARCHAR(50),
      weight INT(10),
      height INT(10),
      lmp DATE,
      type_of_violence VARCHAR(10),
      specify_type_of_violence VARCHAR(255),
      type_of_assault VARCHAR(10),
      specify_type_of_assault VARCHAR(255),
      date_time_incidence DATE,
      perpetrator_name VARCHAR(100),
      relation_to_perpetrator VARCHAR(50),
      compulsory_hiv_test VARCHAR(10),
      compulsory_hiv_test_result VARCHAR(10),
      perpetrator_file_number INT(11),
      state_of_patient VARCHAR(100),
      state_of_patient_clothing VARCHAR(100),
      examination_genitalia VARCHAR(100),
      other_injuries VARCHAR(100),
      high_vagina_anal_swab_result VARCHAR(10),
      RPR_VDRL_result VARCHAR(10),
      hiv_pre_test_counselling_result VARCHAR(10),
      given_pep VARCHAR(10),
      referred_to_psc VARCHAR(10),
      PDT_test_result VARCHAR(10),
      emergency_pills VARCHAR(10),
      emergency_pills_specify VARCHAR(255),
      sti_prophylaxis_trx VARCHAR(10),
      sti_prophylaxis_trx_specify VARCHAR(255),
      pep_regimen VARCHAR(10),
      pep_regimen_specify VARCHAR(255),
      starter_pack_given VARCHAR(10),
      date_given DATE,
      HBsAG_result VARCHAR(10),
      LFTs_ALT_result VARCHAR(50),
      creatinine_result VARCHAR(50),
      other_specify_result VARCHAR(50),
      tca_date DATE,
      voided INT(11),
      CONSTRAINT FOREIGN KEY (patient_id) REFERENCES kenyaemr_etl.etl_patient_demographics(patient_id),
      CONSTRAINT unique_uuid UNIQUE(uuid),
      INDEX(visit_date),
      INDEX(visit_id),
      INDEX(encounter_id),
      INDEX(patient_id),
      INDEX(patient_id, visit_date)
    );

  SELECT "Successfully created kenyaemr_etl.etl_gbv_pepmanagementforsurvivors table";

    ------------- create table kenyaemr_etl.etl_gbv_pepmanagement_nonoccupationalexposure-----------------------
CREATE TABLE kenyaemr_etl.etl_gbv_pepmanagement_nonoccupationalexposure(
            uuid CHAR(38),
            encounter_id INT(11) NOT NULL PRIMARY KEY,
            visit_id INT(11) DEFAULT NULL,
            patient_id INT(11) NOT NULL ,
            location_id INT(11) DEFAULT NULL,
            visit_date DATE,
            encounter_provider INT(11),
            date_created DATE,
            ocn_number VARCHAR(50),
            weight VARCHAR(10),
            height VARCHAR(10),
            type_of_exposure VARCHAR(50),
            specify_other_exposure VARCHAR(100),
            hiv_test_result VARCHAR(10),
            starter_pack_given VARCHAR(10),
            pep_regimen VARCHAR(50),
            pep_regimen_specify VARCHAR(255),
            HBsAG_result VARCHAR(10),
            LFTs_ALT_result VARCHAR(50),
            creatinine_result VARCHAR(50),
            tca_date DATE,
            voided INT(11),
            CONSTRAINT FOREIGN KEY (patient_id) REFERENCES kenyaemr_etl.etl_patient_demographics(patient_id),
            CONSTRAINT unique_uuid UNIQUE(uuid),
            INDEX(visit_date),
            INDEX(visit_id),
            INDEX(encounter_id),
            INDEX(patient_id),
            INDEX(patient_id, visit_date)
    );
  SELECT "Successfully created kenyaemr_etl.etl_gbv_pepmanagement_nonoccupationalexposure";

      ------------- create table kenyaemr_etl.etl_gbv_pepmanagement_occupationalexposure-----------------------
  CREATE TABLE kenyaemr_etl.etl_gbv_pepmanagement_occupationalexposure(
              uuid CHAR(38),
              encounter_id INT(11) NOT NULL PRIMARY KEY,
              visit_id INT(11) DEFAULT NULL,
              patient_id INT(11) NOT NULL ,
              location_id INT(11) DEFAULT NULL,
              visit_date DATE,
              encounter_provider INT(11),
              date_created DATE,
              location_during_exposure VARCHAR(100),
              date_time_exposure DATE,
              cadre VARCHAR(50),
              type_of_exposure VARCHAR(10),
              specify_other_exposure VARCHAR(100),
              severity_exposure VARCHAR(10),
              device_causing_exposure VARCHAR(10),
              specify_other_device VARCHAR(10),
              device_safety VARCHAR(10),
              procedure_device_used VARCHAR(100),
              description_how_injury VARCHAR(200),
              hiv_test_result VARCHAR(10),
              HBsAG_result VARCHAR(10),
              HCV_result VARCHAR(10),
              accident_exposure VARCHAR(10),
              pep_last_exposure VARCHAR(10),
              how_many_days INT(10),
              reason_incomplete_dose VARCHAR(100),
              HB_immunization VARCHAR(10),
              reason_no_partial_vaccine VARCHAR(100),
              regimen_ARVs_datetime DATE,
              wish_to_take_PEP VARCHAR(10),
              pregnant VARCHAR(10),
              breastfeeding VARCHAR(10),
              underlying_health_problem VARCHAR(10),
              specify_health_problem VARCHAR(100),
              hcw_on_medication VARCHAR(10),
              preliminary_classification_risk VARCHAR(10),
              arv_regimen_post_assessment VARCHAR(100),
              date_dispense DATE,
              tca_date DATE,
              voided INT(11),
              CONSTRAINT FOREIGN KEY (patient_id) REFERENCES kenyaemr_etl.etl_patient_demographics(patient_id),
              CONSTRAINT unique_uuid UNIQUE(uuid),
              INDEX(visit_date),
              INDEX(visit_id),
              INDEX(encounter_id),
              INDEX(patient_id),
              INDEX(patient_id, visit_date)
      );
  SELECT "Successfully created kenyaemr_etl.etl_gbv_pepmanagement_occupationalexposure";
  ------------- create table kenyaemr_etl.etl_gbv_pepmanagement_followup-----------------------
  CREATE TABLE kenyaemr_etl.etl_gbv_pepmanagement_followup(
              uuid CHAR(38),
              encounter_id INT(11) NOT NULL PRIMARY KEY,
              visit_id INT(11) DEFAULT NULL,
              patient_id INT(11) NOT NULL ,
              location_id INT(11) DEFAULT NULL,
              visit_date DATE,
              encounter_provider INT(11),
              date_created DATE,
              visit_no VARCHAR(10),
              HBsAG_test VARCHAR(10),
              HBsAG_result VARCHAR(10),
              hiv_test VARCHAR(10),
              hiv_test_result VARCHAR(10),
              lfts_test_result VARCHAR(20),
              cretinine_test_result VARCHAR(20),
              specify_other_test VARCHAR(100),
              pep_completed VARCHAR(10),
              reason_for_incomplete_pep VARCHAR(100),
              patient_assessment VARCHAR(100),
              hiv_serology VARCHAR(10),
              tca_date DATE,
              voided INT(11),
              CONSTRAINT FOREIGN KEY (patient_id) REFERENCES kenyaemr_etl.etl_patient_demographics(patient_id),
              CONSTRAINT unique_uuid UNIQUE(uuid),
              INDEX(visit_date),
              INDEX(visit_id),
              INDEX(encounter_id),
              INDEX(patient_id),
              INDEX(patient_id, visit_date)
      );
    SELECT "Successfully created kenyaemr_etl.etl_gbv_pepmanagement_followup";
        ------------- create table etl_gbv_counsellingencounter-----------------------
    CREATE TABLE kenyaemr_etl.etl_gbv_counsellingencounter(
          uuid CHAR(38),
          encounter_id INT(11) NOT NULL PRIMARY KEY,
          visit_id INT(11) DEFAULT NULL,
          patient_id INT(11) NOT NULL ,
          location_id INT(11) DEFAULT NULL,
          visit_date DATE,
          encounter_provider INT(11),
          date_created DATE,
          prc_number VARCHAR(20),
          type_of_exposure VARCHAR(30),
          visit_no VARCHAR(10),
          presenting_issue VARCHAR(200),
          emerging_issue VARCHAR(200),
          hiv_test_result VARCHAR(10),
          plan_of_action VARCHAR(200),
          tca_date DATE,
          voided INT(11),
          CONSTRAINT FOREIGN KEY (patient_id) REFERENCES kenyaemr_etl.etl_patient_demographics(patient_id),
          CONSTRAINT unique_uuid UNIQUE(uuid),
          INDEX(visit_date),
          INDEX(visit_id),
          INDEX(encounter_id),
          INDEX(patient_id),
          INDEX(patient_id, visit_date)
        );

      SELECT "Successfully created gbv_counsellingencounter review table";

          ------------- create table etl_gbv_perpetratorencounter-----------------------
      CREATE TABLE kenyaemr_etl.etl_gbv_perpetratorencounter(
            uuid CHAR(38),
            encounter_id INT(11) NOT NULL PRIMARY KEY,
            visit_id INT(11) DEFAULT NULL,
            patient_id INT(11) NOT NULL ,
            location_id INT(11) DEFAULT NULL,
            visit_date DATE,
            encounter_provider INT(11),
            date_created DATE,
            perpetrator_number VARCHAR(20),
            phonenumber VARCHAR(30),
            residence VARCHAR(30),
            occupation VARCHAR(10),
            other_occupation_specify VARCHAR(100),
            presenting_issue VARCHAR(200),
            action_plan_presenting_issue VARCHAR(200),
            pep_given VARCHAR(10),
            pep_given_no VARCHAR(100),
            ecp_given VARCHAR(10),
            ecp_given_no VARCHAR(100),
            sti_treatment_given VARCHAR(10),
            voided INT(11),
            CONSTRAINT FOREIGN KEY (patient_id) REFERENCES kenyaemr_etl.etl_patient_demographics(patient_id),
            CONSTRAINT unique_uuid UNIQUE(uuid),
            INDEX(visit_date),
            INDEX(visit_id),
            INDEX(encounter_id),
            INDEX(patient_id),
            INDEX(patient_id, visit_date)
          );

  SELECT "Successfully created gbv_perpetratorencounter review table";
  UPDATE kenyaemr_etl.etl_script_status SET stop_time=NOW() where id= script_id;

END $$
