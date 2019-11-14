function ConvertTo-VolumeUnit{
    <#
	.SYNOPSIS
		Convert Volume value.
	.DESCRIPTION
        Convert Volume value from input unit to output unit. Supported units are liter (l), cubit metre (m3), cubic centimetre (cm3), cubit millimetre (mm3),
        cubit foot (ft3), cubic inch (in3), imperial pint (imperial pt), imperial quart (imperial qt), US pint (US p), US gallon (US gal), US quart (US qt).
    .PARAMETER InputUnit
        The Volume unit of input value.
    .PARAMETER InputValue
        The Volume value to convert.
    .PARAMETER OutputUnit
        The unit to convert into.
    .PARAMETER precision
        The number of decimal digits of converted value
    .EXAMPLE
        ConvertTo-VolumeUnit -InputUnit s -InputValue 200 -OutputUnit min
    .EXAMPLE
        ConvertTo-VolumeUnit -InputUnit h -InputValue 14 -OutputUnit min
	#>
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet('liter','l','cubit metre','m3','cubic centimetre','cm3','cubit millimetre','mm3','cubit foot','ft3','cubic inch','in3','imperial pint','imperial pt','imperial quart','imperial qt','US pint','US p','US gallon','US gal','US quart','US qt')]
        [string] $InputUnit,
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [double] $InputValue,
        [Parameter(Mandatory=$true)]
        [ValidateSet('liter','l','cubit metre','m3','cubic centimetre','cm3','cubit millimetre','mm3','cubit foot','ft3','cubic inch','in3','imperial pint','imperial pt','imperial quart','imperial qt','US pint','US p','US gallon','US gal','US quart','US qt')]
        [string] $OutputUnit,
        [Parameter(Mandatory=$false)]
        [int] $Precision
    )

    #Load UnitConversion dll
    $path = Get-ModulePath "PoshUnitConversion"
    [Reflection.Assembly]::LoadFile("$Path\binary\UnitConversion.dll") | Out-Null
    try{
        $converter = [UnitConversion.VolumeConverter]::new($InputUnit, $OutputUnit)
        if($Precision){
            $retValue = $converter.LeftToRight($InputValue, $Precision)
        }
        else{
            $retValue = $converter.LeftToRight($InputValue)
        }
        return $retValue
    } catch [Exception] {
        $_.Exception.Message
    }
}