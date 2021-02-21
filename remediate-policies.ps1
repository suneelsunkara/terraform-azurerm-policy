Login-AzAccount

# in case you have multiple subscriptions...
select-azsubscription -SubscriptionName "Pay-As-You-Go"

# get all non-compliant policies that can be remediated
$nonCompliantPolicies = Get-AzPolicyState | Where-Object { $_.ComplianceState -eq "NonCompliant" } -and $_.PolicyDefinitionAction -eq "deployIfNotExists" }

# loop through ans start individual tasks per policy 
foreach ($policy in $nonCompliantPolicies) {

    $remediationName = "rem." + $policy.PolicyDefinitionName
    #Write-Host $remediationName
    Start-AzPolicyRemediation -Name $remediationName -PolicyAssignmentId $policy.PolicyAssignmentId -PolicyDefinitionReferenceId $policy.PolicyDefinitionReferenceId
}