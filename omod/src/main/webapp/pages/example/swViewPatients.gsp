<%
	ui.decorateWith("kenyaemr", "standardPage", [ patient: currentPatient ])

	def onEncounterClick = { encounter ->
		"""kenyaemr.openEncounterDialog('${ currentApp.id }', ${ encounter.id });"""
	}
%>

<div class="ke-page-content">
		<table cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr>
				<td width="30%" valign="top">
					${ ui.includeFragment("kenyaemr", "patient/patientSummary", [ patient: currentPatient ]) }
					${ ui.includeFragment("kenyaemr", "patient/patientRelationships", [ patient: currentPatient ]) }
				</td>
				<td width="55%" valign="top" style="padding-left: 5px">
					${ ui.includeFragment("kenyaemr", "visitMenu", [ patient: currentPatient, visit: activeVisit ]) }
					${ ui.includeFragment("kenyaemr", "hivTesting/htsHistory", [ patient: currentPatient]) }

					<% if (activeVisit) { %>
					${ ui.includeFragment("kenyaemr", "visitAvailableForms", [ visit: activeVisit ]) }
					${ ui.includeFragment("kenyaemr", "visitCompletedForms", [ visit: activeVisit ]) }
					<% } %>
				</td>
				<td width="15%" valign="top" style="padding-left: 5px">
					${ ui.includeFragment("kenyaemr", "providerAction/providerActions") }
				</td>
			</tr>
		</table>

</div>



<%
    ui.decorateWith("kenyaemr", "standardPage", [patient: currentPatient])
    ui.includeCss("kenyaemrorderentry", "font-awesome.css")
    ui.includeCss("kenyaemrorderentry", "font-awesome.min.css")
    ui.includeCss("kenyaemrorderentry", "font-awesome.css.map")
    ui.includeCss("kenyaemrorderentry", "../fontawesome-webfont.svg")
    def triageUuid = "37f6bd8d-586a-4169-95fa-5781f987fe62";

    def addTriageFormLink = ui.pageLink("kenyakeypop", "enterForm", [patientId: currentPatient.patientId, formUuid: triageUuid, appId: currentApp.id, returnUrl: ui.thisUrl()])

%>
<script type="text/javascript">


    jq(function () {

    });


</script>
<style>
.dashboard .info-header {
    border-bottom: 6px solid #7f7b72 !important;
}

.dashboard .info-header i {
    font-size: 1.3em;
    color: #7f7b72 !important;
}

.dashboard .info-header h3 {
    display: inline-block;
    font-family: "OpenSansBold";
    font-size: 1em;
    margin: 0;
}
</style>

<div class="clear"></div>

<div id="content" class="container">

    <div class="clear"></div>

    <div class="container">
        <div class="dashboard clear">
            <div class="info-container column">

                <div class="info-section">
                    <div class="info-header">
                        <i class="icon-diagnosis"></i>

                        <h3>Registration Info</h3>
                    </div>

                    <div class="info-body">
                        ${ui.includeFragment("kenyakeypop", "kpClient/patientSummary", [patient: currentPatient])}
                    </div>
                </div>

                <div class="info-section">
                    <div class="info-header">
                        <i class="fa fa-list-ul fa-2x"></i>

                        <h3>Peer - Contact Form</h3>
                    </div>

                    ${ui.includeFragment("kenyakeypop", "kpClient/clientContactForm", [patient: currentPatient])}

                </div>

                <div class="info-section">
                    <div class="info-header">
                        <i class="fa fa-users fa-2x"></i>

                        <h3>Relationship</h3>
                    </div>

                    ${ui.includeFragment("kenyakeypop", "relationship/patientRelationships", [patient: currentPatient])}

                </div>

                <div class="info-section">
                    <div class="info-header">
                        <i class="fa fa-file-o"></i>

                        <h3>Enrollment status</h3>
                    </div>

                    ${ui.includeFragment("kenyakeypop", "program/programHistories", [patient: currentPatient, showClinicalData: true])}
                </div>

            </div>

            <div class="info-container column">
                <div class="info-section allergies">
                    <div class="info-section">
                        <div class="info-header">
                            <i class="fa fa-list-ul fa-2x"></i>

                            <h3>Client Summary</h3>
                        </div>

                        ${ui.includeFragment("kenyakeypop", "kpClient/clientSummary", [patient: currentPatient])}
                        <br>
                    </div>

                    <div class="info-header">
                        <i class="icon-stethoscope"></i>

                        <h3>Vitals</h3>
                        <i class="fa fa-plus-square right" style="color: steelblue" title="Add vitals"
                           onclick="location.href = '${addTriageFormLink}'"></i>
                    </div>

                    <div class="info-body">
                        ${ui.includeFragment("kenyakeypop", "kpClient/currentVitals", [patient: currentPatient])}
                    </div>

                </div>
            </div>

            ${ui.includeFragment("kenyakeypop", "kpClient/actionsPanel", [visit: visit])}

        </div>
    </div>
</div>










<%
	ui.decorateWith("kenyaemr", "standardPage", [ patient: patient ])
%>

<div class="ke-page-content">
	${ ui.decorate("kenyaui", "panel", [ heading: "Welcome" ], "This is an example page added by this module") }
</div>


<%
	ui.decorateWith("kenyaemr", "standardPage", [ layout: "sidebar" ])

	def menuItems = [
			[ label: "View mUzima Queue", iconProvider: "kenyaemr", icon: "queue-icon.jpg", label: "View mUzima Queue", href: ui.pageLink("kenyaemr", "hivTesting/muzimaQueueHome") ]
	]
%>

<div class="ke-page-sidebar">
	${ ui.includeFragment("kenyaemr", "patient/patientSearchForm", [ defaultWhich: "all" ]) }
	${ ui.includeFragment("kenyaui", "widget/panelMenu", [ heading: "mUzima Queue", items: menuItems ]) }
</div>

<div class="ke-page-content">
	${ ui.includeFragment("kenyaemr", "patient/patientSearchResults", [ pageProvider: "keaddonexample", page: "example/swViewPatients" ]) }
</div>

<script type="text/javascript">
	jQuery(function() {
		jQuery('input[name="query"]').focus();
	});
</script>








<%
	ui.decorateWith("kenyaemr", "standardPage", [ patient: currentPatient ])
%>

<div class="ke-page-content">

	${ /*ui.includeFragment("kenyaui", "widget/tabMenu", [ items: [
			[ label: "Overview", tabid: "overview" ],
			[ label: "Lab Tests", tabid: "labtests" ],
			[ label: "Prescriptions", tabid: "prescriptions" ]
	] ])*/ "" }

	<!--<div class="ke-tab" data-tabid="overview">-->
	<table cellpadding="0" cellspacing="0" border="0" width="100%">
		<tr>
			<td width="30%" valign="top">
				${ ui.includeFragment("kenyaemr", "patient/patientSummary", [ patient: currentPatient ]) }
				${ ui.includeFragment("kenyaemr", "patient/patientRelationships", [ patient: currentPatient ]) }
				${ ui.includeFragment("kenyaemr", "program/programHistories", [ patient: currentPatient, showClinicalData: true ]) }
			</td>
			<td width="55%" valign="top" style="padding-left: 5px">
				${ ui.includeFragment("kenyaemr", "visitMenu", [ patient: currentPatient, visit: activeVisit ]) }

				${ ui.includeFragment("kenyaemr", "program/programCarePanels", [ patient: currentPatient, complete: false, activeOnly: true ]) }

				<% if (activeVisit) { %>
				${ ui.includeFragment("kenyaemr", "visitAvailableForms", [ visit: activeVisit ]) }
				${ ui.includeFragment("kenyaemr", "visitCompletedForms", [ visit: activeVisit ]) }
				<% } %>
			</td>
			<td width="15%" valign="top" style="padding-left: 5px">
				${ ui.includeFragment("kenyaemr", "providerAction/providerActions") }
			</td>
		</tr>
	</table>
	<!--</div>-->

</div>


