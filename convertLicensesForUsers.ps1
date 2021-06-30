# Convert one user license type to another License
# Originally this script was used to convert All of our E1 users to F3 and also remove EMS from those users as well.

#License SKUs
$BeforeSku = "Company:STANDARDPACK"
$AfterSku = "Company:SPE_F1"

#Uncomment line below if you maybe want to have another SKU that you may be removing in the loop at the end of the script.
#$OtherSku = "Company:EMS"

# Set services to disable for the new license. Uncomment the Disabled Plans section if you are disabling certain features.
$Options_AfterSku = New-MsolLicenseOptions -AccountSkuId $F3Sku  #-DisabledPlans WINDOWSUPDATEFORBUSINESS_DEPLOYMENTSERVICE,UNIVERSAL_PRINT_01,POWER_VIRTUAL_AGENTS_O365_F1,KAIZALA_O365_P1,WHITEBOARD_FIRSTLINE1,WIN10_ENT_LOC_F1,YAMMER_ENTERPRISE,SWAY,MCOIMP,POWERAPPS_O365_S1,FORMS_PLAN_K,FLOW_O365_S1

# Get Users with E1 license assigned
$BeforeUsers = Get-MsolUser -EnabledFilter EnabledOnly -All | Where-Object {($_.licenses).AccountSkuId -eq $BeforeSku}
$BeforeUsers.Count

#Uncomment the OtherSku if you are removing any other licenses.
foreach($BeforeUser in $BeforeUsers){
    Set-MsolUserLicense -UserPrincipalName $BeforeUser.UserPrincipalName -AddLicenses $AfterSku -LicenseOptions $Options_AfterSku -RemoveLicenses $BeforeSku#,$OtherSku
}
