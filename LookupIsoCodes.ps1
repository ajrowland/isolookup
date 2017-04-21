$countries = Get-Content -Raw -Path "isodatabyid.json" -Encoding UTF8 | ConvertFrom-Json
$xml = [xml](Get-Content "locations-tax-global-english.xml")

$countriestotal = 0
$countriesmatched = 0
$statestotal = 0;
$statesmatched = 0

foreach ($region in $xml.list.region) {
    Write-Host - $region.shortname

    foreach ($country in $region.country) {

        $countriestotal++

        if ($countries."$($country.code)") {
            Write-Host - - $country.shortname - $countries."$($country.code)".'alpha-2' - $countries."$($country.code)".'alpha-3'
            $countriesmatched++
        } else {
            Write-Host - - $country.shortname - NO MATCH
        }

        foreach ($state in $country.state) {

            $statestotal++

            if ($countries."$($country.code)".'AdministrativeAreas'."$($state.shortname)") {
                Write-Host - - - $state.shortname - $countries."$($country.code)".'AdministrativeAreas'."$($state.shortname)"
                $statesmatched++
            } else {
                Write-Host - - - $state.shortname - NO MATCH
            }
        }
    }
}

Write-Host Matched $countriesmatched / $countriestotal countries
Write-Host Matched $statesmatched / $statestotal states