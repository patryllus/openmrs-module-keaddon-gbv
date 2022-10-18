/**
 * The contents of this file are subject to the OpenMRS Public License
 * Version 1.0 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://license.openmrs.org
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 * Copyright (C) OpenMRS, LLC.  All Rights Reserved.
 */

package org.openmrs.module.keaddonexample.metadata;

import org.openmrs.module.metadatadeploy.bundle.AbstractMetadataBundle;
import org.springframework.stereotype.Component;

import static org.openmrs.module.metadatadeploy.bundle.CoreConstructors.*;

/**
 * Example metadata bundle
 */
@Component
public class ExampleMetadata extends AbstractMetadataBundle {

	public static class _EncounterType {

		//GBVPHYSICALEMOTIONALFORM Encounter
		public static final String GBVPHYSICALEMOTIONALFORM="39d9350b-6eba-4653-a0cf-c554f44f6e91";
		//GBVLEGALFORM
		public static final String GBVLEGALFORM="8941dc56-afda-4155-866f-e9fc0e71f5fd";
		//GBVPEPFORMMANAGEMENTOFSURVIVORS Encounter
		public static final String GBVPEPFORMMANAGEMENTOFSURVIVORS="133c8398-1fdc-437a-a74a-e73b1254c1d6";
		//GBVPEPFORNONOCCUPATIONEXPOSURE Encounter
		public static  final String GBVPEPFORNONOCCUPATIONEXPOSURE="4f718f68-b414-4e27-803e-b4fbbc959d89";
		//GBVLINKAGE Encounter
		public   static  final  String GBVLINKAGEFORM ="b38c73ee-6949-4f5f-8013-a89e36474d72";
		//GBVCONSENT Encounter
		public   static  final  String GBVCONSENTFORM ="3809b3fc-bcdd-46fe-a461-60a341a842d0";
		//GBVPERPETRATORDETAIL Encounter 189e128f-3212-47ca-9d89-ee1876c394a9
		public   static  final  String GBVPERPETRATORDETAILFORM ="189e128f-3212-47ca-9d89-ee1876c394a9";
		//GBVTRAUMACOUNSELLINGFORM ENCOUNTER
		public  static final String GBVTRAUMACOUNSELLINGFORM ="16048e65-24c6-4833-a342-29000143298f";
		//GBVPOSTRAPECAREFORM ENCOUNTER
		public  static final String GBVPOSTRAPECAREFORM ="e571c807-8fcc-4bc3-bc64-4ed372b348e4";
		//GBVPSYCHOLOGICALASSESSMENTFORM ENCOUNTER
		public  static final String GBVPSYCHOLOGICALASSESSMENTFORM ="b5ab0a6b-9425-44da-b0d9-242f609f1605";

	}

	public static class _Form {
		//GBVPEPFORMMANAGEMENTOFSURVIVORSFOLLOWUP
		//public static final String GBVPEPFORMMANAGEMENTOFSURVIVORSFOLLOWUP="b59f2291-1e99-4c00-840b-6a3ff666ddae";
		//GBVPHYSICALEMOTIONALFORM
		public static final String GBVPHYSICALEMOTIONALFORM="a0943862-f0fe-483d-9f11-44f62abae063";
		//GBVLEGALFORM
		public static final String GBVLEGALFORM="d0c36426-4503-4236-ab5d-39bff77f2b50";
		//GBVPEPFORMMANAGEMENTOFSURVIVORS
		static final String GBVPEPFORMMANAGEMENTOFSURVIVORS="f44b2405-226b-47c4-b98f-b826ea4725ae";
		//GBVPEPFORNONOCCUPATIONEXPOSURE
		public static  final String GBVPEPFORNONOCCUPATIONEXPOSURE="92de9269-6bb4-4c24-8ec9-870aa2c64b5a";
		//GBVLINKAGEFORM
		public   static  final String GBVLINKAGEFORM ="f760e38c-3d2f-4a5d-aa3d-e9682576efa8";
		//GBVCONSENTFORM
		public  static final String GBVCONSENTFORM ="d720a8b3-52cc-41e2-9a75-3fd0d67744e5";
		//GBVPERPETRATORFORM
		public  static final String GBVPERPETRATORDETAILFORM ="f37d7e0e-95e8-430d-96a3-8e22664f74d6";
		//GBVTRAUMACOUNSELLINGFORM
		public  static final String GBVTRAUMACOUNSELLINGFORM ="e983d758-5adf-4917-8172-0f4be4d8116a";
		//GBVPOSTRAPECAREFORM
		public  static final String GBVPOSTRAPECAREFORM ="c46aa4fd-8a5a-4675-90a7-a6f2119f61d8";
		//GBVPSYCHOLOGICALASSESSMENTFORM
		public  static final String GBVPSYCHOLOGICALASSESSMENTFORM ="9d21275a-7657-433a-b305-a736423cc496";


	}

	/**
	 * @see org.openmrs.module.metadatadeploy.bundle.AbstractMetadataBundle#install()
	 */
	@Override
	public void install() {

		//GBVPHYSICALEMOTIONALFORM
		install(encounterType("GBVPHYSICALEMOTIONALFORM Encounter", "GBVPHYSICALEMOTIONALFORM Encounter", _EncounterType.GBVPHYSICALEMOTIONALFORM));
		install(form("PHYSICAL/EMOTIONAL VIOLENCE FORM", null, _EncounterType.GBVPHYSICALEMOTIONALFORM, "1", _Form.GBVPHYSICALEMOTIONALFORM));

		//GBVLEGALFORM
		install(encounterType("GBVLEGALFORM Encounter", "GBVLEGALFORM Encounter", _EncounterType.GBVLEGALFORM));
		install(form("GBV LEGAL ENCOUNTER FORM", null, _EncounterType.GBVLEGALFORM, "1", _Form.GBVLEGALFORM));

		//GBVPEPFORMFORMANAGEMENTOFSURVIVORS
		install(encounterType("GBVPEPFORMFORMANAGEMENTOFSURVIVOR Form Encounter", "GBVPEPFORMFORMANAGEMENTOFSURVIVORS Encounter", _EncounterType.GBVPEPFORMMANAGEMENTOFSURVIVORS));
		install(form("PEP MANAGEMENT FORM FOR SURVIVORS", null, _EncounterType.GBVPEPFORMMANAGEMENTOFSURVIVORS, "1", _Form.GBVPEPFORMMANAGEMENTOFSURVIVORS));

		//GBVPEPFORNONOCCUPATIONEXPOSURE
		install(encounterType("GBVPEPFORNONOCCUPATIONALEXPOSURE Form Encounter", "GBVPEPFORNONOCCUPATIONALEXPOSURE Encounter", _EncounterType.GBVPEPFORNONOCCUPATIONEXPOSURE));
		install(form("PEP MANAGEMENT FORM FOR NON-OCCUPATIONAL EXPOSURE", null, _EncounterType.GBVPEPFORNONOCCUPATIONEXPOSURE, "1", _Form.GBVPEPFORNONOCCUPATIONEXPOSURE));

		//GBVLINKAGEFORM
		install(encounterType("GBVLINKAGE Form Encounter", "GBVLINKAGE Encounter", _EncounterType.GBVLINKAGEFORM));
		install(form("GBV COMMUNITY LINKAGE FORM", null, _EncounterType.GBVLINKAGEFORM, "1", _Form.GBVLINKAGEFORM));

		//GBVCONSENTFORM
		install(encounterType("GBVCONSENT Form Encounter", "GBVCONSENT Encounter", _EncounterType.GBVCONSENTFORM));
		install(form("GBV PRC CONSENT FORM", null, _EncounterType.GBVCONSENTFORM, "1", _Form.GBVCONSENTFORM));

		//GBVPERPETRATORDETAILFORM
		install(encounterType("GBV Perpetrator Details", "GBVPERPETRATORDETAILFORM Encounter", _EncounterType.GBVPERPETRATORDETAILFORM ));
		install(form("GBV PERPETRATOR DETAILS FORM", null, _EncounterType.GBVPERPETRATORDETAILFORM, "1", _Form.GBVPERPETRATORDETAILFORM));

		//GBVTRAUMACOUNSELLINGFORM
		install(encounterType("GBV Trauma Counselling", "GBVTRAUMACOUNSELLINGFORM Encounter", _EncounterType.GBVTRAUMACOUNSELLINGFORM));
		install(form("SGBV TRAUMA COUNSELLING FORM", null, _EncounterType.GBVTRAUMACOUNSELLINGFORM, "1", _Form.GBVTRAUMACOUNSELLINGFORM));

		//GBVPOSTRAPECAREFORM
		install(encounterType("GBV Post Rape Care", "GBVPOSTRAPECAREFORM Encounter", _EncounterType.GBVPOSTRAPECAREFORM));
		install(form("SGBV POST RAPE CARE FORM (PART A MOH-363)", null, _EncounterType.GBVPOSTRAPECAREFORM, "1", _Form.GBVPOSTRAPECAREFORM));

		//GBVPSYCHOLOGICALASSESSMENTFORM
		install(encounterType("GBV Psychological Assessment", "GBVPSYCHOLOGICALASSESSMENTFORM Encounter", _EncounterType.GBVPSYCHOLOGICALASSESSMENTFORM));
		install(form("SGBV PSYCHOLOGICAL ASSESSMENT (PART B MOH-363 )", null, _EncounterType.GBVPSYCHOLOGICALASSESSMENTFORM, "1", _Form.GBVPSYCHOLOGICALASSESSMENTFORM));

	}
}