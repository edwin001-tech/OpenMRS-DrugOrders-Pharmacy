<%
    ui.decorateWith("appui", "standardEmrPage");
    ui.includeCss("drugorders", "drugorders.css")
    ui.includeJavascript("drugorders", "drugorders.js")
    def editAction = false;
%>

<div id="pageRedirect"></div>
<script type="text/javascript">
    var breadcrumbs = [
        { icon: "icon-home", link: '/' + OPENMRS_CONTEXT_PATH + '/index.htm' },
        { label: "${ ui.format(patient.familyName) }, ${ ui.format(patient.givenName) }" , link: '${ui.pageLink("coreapps", "clinicianfacing/patient", [patientId: patient.id])}'},
        { label: "${ ui.message("drugorders.drugorders") }" }
    ];

    var patient = { id: ${ patient.id } };

</script>

${ ui.includeFragment("coreapps", "patientHeader", [ patient: patient ]) }

<div class="info-body">
    
    <div id="allergyList">
        <strong>Drug Allergies:</strong>
        <% if (allergicDrugs == "null") { %>
            ${ ui.message("drugorders.allergies") }
        <% } else { %>
            <% allergicDrugs.each { allergy -> %>
                ${ allergy } 
            <% } %>
        <% } %>
    </div>

    <br/><br/>
        
    <div id="orderList">
 
        <div id="activeOrderWindow">
            
            <div id="pageLabel"> 
                <div id="line-break"></div>
                <h3>
                    <i class="icon-medicine"></i>
                    <strong>${ ui.message("ACTIVE INDIVIDUAL DRUG ORDERS") }</strong>
                    <i class="icon-plus edit-action right" title="${ ui.message("CREATE DRUG ORDER") }" onclick="showSingleOrderDetailsWindow('CREATE DRUG ORDER')"></i>
                </h3>
                <div id="line-break"></div>
            </div><br/>
        
            ${ ui.includeFragment("drugorders", "drugOrderSingle") } <br/><br/>
            
            <i class="icon-plus-sign edit-action" title="${ ui.message("Show") }"> Discontinued/Canceled/Fulfilled Orders</i>
            <i class="icon-minus-sign edit-action" title="${ ui.message("Hide") }"> Discontinued/Canceled/Fulfilled Orders</i> <br/><br/>
        
            <div class="nonActiveOrderWindow">
                ${ ui.includeFragment("drugorders", "drugOrderSingleNonActive") } <br/>
            </div><br/>
        
        </div>
        
        ${ ui.includeFragment("drugorders", "saveDraftOrders") }
        
        <div id="activePlanWindow">
            
            <div id="pageLabel">
                <div id="line-break"></div>
                <h3>
                    <i class="icon-medicine"></i>
                    <strong>${ ui.message("ACTIVE MEDICATION PLAN ORDERS") }</strong>
                    <i class="icon-plus edit-action right" title="${ ui.message("CREATE MEDICATION PLAN") }" onclick="showMedicationPlanOrderWindow()"></i>
                </h3>
                <div id="line-break"></div>
            </div><br/>
            
            ${ ui.includeFragment("drugorders", "medicationPlans") } <br/><br/>
            
            <i class="icon-plus-sign edit-action" title="${ ui.message("View Details") }"> Discontinued/Canceled/Fulfilled Orders</i>
            <i class="icon-minus-sign edit-action" title="${ ui.message("Hide Details") }"> Discontinued/Canceled/Fulfilled Orders</i> <br/><br/>
        
            <div class="nonActiveOrderWindow">
                ${ ui.includeFragment("drugorders", "medicationPlansNonActive") }
            </div>
        
        </div>  
        
    </div>
    
    <div id="orderExecute">
        
        <div id="medPlan">
            ${ ui.includeFragment("drugorders", "addNewOrder") }
        </div>
        
        <div id="createOrder">
            ${ ui.includeFragment("drugorders", "addDrugOrderSingleDetails") }  
        </div>
        
        <div id="editOrder">
            ${ ui.includeFragment("drugorders", "editDrugOrder") }
        </div>
               
    </div>
</div>


<script type="text/javascript">
    jq(".icon-plus-sign").click(function(){
        jq(this).nextAll(".nonActiveOrderWindow").first().show();
        jq(this).hide();
        jq(this).nextAll(".icon-minus-sign").show();
    });
</script>

<script type="text/javascript">
    jq(".icon-minus-sign").click(function(){
        jq(this).nextAll(".nonActiveOrderWindow").first().hide();
        jq(this).hide();
        jq(this).prevAll(".icon-plus-sign").show();
    });
</script>