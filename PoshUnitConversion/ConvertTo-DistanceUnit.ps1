function ConvertTo-DistanceUnit{
    <#
	.SYNOPSIS
		Convert Distance value.
	.DESCRIPTION
        Convert Distance value from input unit to output unit. Supported units are metre (m), Kilometre (km), millimetre (mm), foot feet (ft),
        yard (yd), mile, inch (in).
    .PARAMETER InputUnit
        The Distance unit of input value.
    .PARAMETER InputValue
        The Distance value to convert.
    .PARAMETER OutputUnit
        The unit to convert into.
    .PARAMETER precision
        The number of decimal digits of converted value
    .EXAMPLE
        ConvertTo-DistanceUnit -InputUnit m -InputValue 200 -OutputUnit cm
    .EXAMPLE
        ConvertTo-DistanceUnit -InputUnit in -InputValue 14 -OutputUnit yd
	#>
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet('m', 'metre', 'km', 'kilometre', 'cm', 'centimetre', 'mm', 'millimetre', 'ft', 'foot', 'feet', 'yd', 'yard', 'mile', 'in', 'inch')]
        [string] $InputUnit,
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [double] $InputValue,
        [Parameter(Mandatory=$true)]
        [ValidateSet('m', 'metre', 'km', 'kilometre', 'cm', 'centimetre', 'mm', 'millimetre', 'ft', 'foot', 'feet', 'yd', 'yard', 'mile', 'in', 'inch')]
        [string] $OutputUnit,
        [Parameter(Mandatory=$false)]
        [int] $Precision
    )

    #Load UnitConversion dll
    $path = Get-ModulePath "PoshUnitConversion"
    [Reflection.Assembly]::LoadFile("$Path\binary\UnitConversion.dll") | Out-Null
    try{
        $converter = [UnitConversion.DistanceConverter]::new($InputUnit, $OutputUnit)
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