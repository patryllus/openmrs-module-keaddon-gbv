

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
	${ ui.includeFragment("kenyaemr", "patient/patientSearchResults", [ pageProvider: "keaddonexample", page: "example/patientProfile" ]) }
</div>

<script type="text/javascript">
	jQuery(function() {
		jQuery('input[name="query"]').focus();
	});
</script>



