function Add-DealOnMyDealz {
    param (
        $username,
        $password,
        $url,
        $title,
        $description ,
        $price,
        $nextPrice,
        $voucherCode,
        $shippingPrice,
        #$imageUrl,
        $group
    )
    do{
        $uri = "https://www.mydealz.de/login"
        $ie = New-Object -ComObject 'internetExplorer.Application' -ErrorAction Ignore -ErrorVariable global:Fehler
        $ie.Visible = $true
        $ie.Navigate($uri)
        do{
            Start-Sleep -s 1
        }until($ie.Busy -eq $false)
        try{
        $username_2 = $ie.Document.getElementById("login_form-identity")
        $username_2.click()
        $username_2.value = $username
        }
        catch{
            $login_checksum --
        }
        try{
        $password_2 = $ie.Document.getElementById("login_form-password")
        $password_2.click()
        $password_2.value = $password
        }
        catch{
            $login_checksum --
        }
        try{
        $button_1 = $ie.Document.getElementsByName("form_submit")
        $button_1[0].click()
        do{
            Start-Sleep -s 1
        }until($ie.Busy -eq $false)
        $login_checksum = 0
        }
        catch{
            $login_checksum --
        }
        try{
            $username_error = $ie.Document.body.getElementsByClassName("formList-info formList-info--error")
            if($username_error[0].innerText -match "Bitte gib einen gültigen Benutzernamen/Email ein."){
                write-host $username_error[0].innerText -ForegroundColor Red
            }
        }
        catch{
            $login_checksum ++
        }

        try{
            $password_error = $ie.Document.body.getElementsByClassName("formList-info formList-info--error")
            if($password_error[0].innerText -match "Bitte verwende ein gültiges password."){
                write-host $password_error[0].innerText -ForegroundColor Red
            }
        }
        catch{
            $login_checksum ++
        }
    }until($login_checksum -gt 1 -or $ie.LocationURL -eq "https://www.mydealz.de/")

    if($ie.LocationURL -eq "https://www.mydealz.de/"){
        $login_checksum = 2
    }

    if($login_checksum -gt 1){
        write-host "Login done" -ForegroundColor Green
    }
    $ie.Navigate("https://www.mydealz.de/submission/deals/add")
    do{
        Start-Sleep -s 1
    }until($ie.Busy -eq $false)

    if($url -ne ""){
        $deal_link = $ie.Document.body.getElementsByClassName("input width--all-12 space--l-5")
        $deal_link[0].value = $url
    }
    $button_2 = $ie.Document.body.getElementsByClassName("btn btn--mode-primary")
    $button_2[0].click()

    do{
    Start-Sleep -s 1
    }until($ie.Busy -eq $false)

    $deal_title = $ie.Document.getElementsByName("title")
    $deal_title[0].click()
    $deal_title[0].value = $title

    $deal_description = $ie.Document.getElementById("redactor-editor redactor-placetolder input input--textarea width--all-12 overflow--scrollX-raw overflow--scrollY-raw userHtml userHtml--wysiwyg overflow--wrap-break hide--js-off redactor-linebreaks redactor-placeholder")
    $deal_description[0].click()
    $deal_description[0].value = $description

    $deal_price = $ie.Document.getElementById("price")
    $deal_price.click()
    $deal_price.value = $price

    $deal_nextprice = $ie.Document.getElementById("nextBestPrice")
    $deal_nextprice.click()
    $deal_nextprice.value = $nextprice

    $deal_voucherCode = $ie.Document.getElementsByName("voucherCode")
    $deal_voucherCode[0].click()
    $deal_voucherCode[0].value = $voucherCode

    $deal_shippingPrice = $ie.Document.getElementById("shippingPrice")
    $deal_shippingPrice.click()
    $deal_shippingPrice.value = $shippingPrice

    <#
        Images does not work
    #>

    #$dealimage = $ie.Document.body.getElementsByClassName("thread-image imgFrame-img seal--pointer-on clickable flex--inline boxAlign-jc--all-c boxAlign-ai--all-c width--all-12")
    #$dealimage[0].click()
    #$dealimageurl = $ie.Document.body.getElementsByClassName("input width--all-12")
    #$dealimageurl[12].click()
    #$dealimageurl[12].value = "test.de"#$imageUrl

    $groups = $ie.Document.body.getElementsByClassName("tag--deselected")

    if($group -eq "Elektronik"){
        $groups[0].click()
    }
    if($group -eq "Gaming"){
        $groups[1].click()
    }
    if($group -eq "Lebensmittel & Haushalt"){
        $groups[2].click()
    }
    if($group -eq "Fashion & Accessoires"){
        $groups[3].click()
    }
    if($group -eq "Beauty & Gesundheit"){
        $groups[4].click()
    }
    if($group -eq "Family & Kids"){
        $groups[5].click()
    }
    if($group -eq "Home & Living"){
        $groups[6].click()
    }
    if($group -eq "Garten & Baumarkt"){
        $groups[7].click()
    }
    if($group -eq "Auto & Motorrad"){
        $groups[8].click()
    }
    if($group -eq "Kultur & Freizeit"){
        $groups[9].click()
    }
    if($group -eq "Sport & Outdoor"){
        $groups[10].click()
    }
    if($group -eq "Telefon- & Internet-Verträge"){
        $groups[11].click()
    }
    if($group -eq "Versicherung & Finanzen"){
        $groups[12].click()
    }
    if($group -eq "Dienstleistungen & Verträge"){
        $groups[13].click()
    }
    if($group -eq "Reisen"){
        $groups[14].click()
    }
    $button_3 = $ie.Document.body.getElementsByClassName("dealSubmit")
    $button_3[0].click()
}
Add-DealOnMyDealz -username "karl_heinz_feuermann" -password "*********" -url "url.de" -title "Title" -description "description" -price 120 -nextPrice 125 -voucherCode "voucherCode" -shippingPrice 5 -group "Elektronik"
