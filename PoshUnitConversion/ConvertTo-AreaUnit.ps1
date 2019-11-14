function ConvertTo-AreaUnit{
    <#
	.SYNOPSIS
		Convert Area value.
	.DESCRIPTION
        Convert Area value from input unit to output unit. Supported units are square metre (m2), square kilometre (km2), square centimetre (cm2),
        square millimetre (mm2), square foot (ft2), squeare yard (yd2), are (a), square inch (in2), square mile (mi2).
    .PARAMETER InputUnit
        The Area unit of input value.
    .PARAMETER InputValue
        The Area value to convert.
    .PARAMETER OutputUnit
        The unit to convert into.
    .PARAMETER precision
        The number of decimal digits of converted value
    .EXAMPLE
        ConvertTo-AreaUnit -InputUnit ft2 -InputValue 200 -OutputUnit mm2
    .EXAMPLE
        ConvertTo-AreaUnit -InputUnit yd2 -InputValue 14 -OutputUnit km2 -precision 2
	#>
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet('square metre','m2','square kilometre','km2','square centimetre','cm2','square millimetre','mm2','square foot','ft2','squeare yard','yd2','are','a','square inch','in2','square mile','mi2')]
        [string] $InputUnit,
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [double] $InputValue,
        [Parameter(Mandatory=$true)]
        [ValidateSet('square metre','m2','square kilometre','km2','square centimetre','cm2','square millimetre','mm2','square foot','ft2','squeare yard','yd2','are','a','square inch','in2','square mile','mi2')]
        [string] $OutputUnit,
        [Parameter(Mandatory=$false)]
        [int] $Precision
    )

    #Load UnitConversion dll
    $path = Get-ModulePath "PoshUnitConversion"
    [Reflection.Assembly]::LoadFile("$Path\binary\UnitConversion.dll") | Out-Null
    try{
        $converter = [UnitConversion.AreaConverter]::new($InputUnit, $OutputUnit)
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