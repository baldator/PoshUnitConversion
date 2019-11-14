function ConvertTo-MassUnit{
    <#
	.SYNOPSIS
		Convert Volume value.
	.DESCRIPTION
        Convert Volume value from input unit to output unit. Supported units are kilogram (kg), gram (g), pound (lb), stone (st),
        ounce (oz), quintal, short ton (us ton), long ton (imperial ton).
    .PARAMETER InputUnit
        The Volume unit of input value.
    .PARAMETER InputValue
        The Volume value to convert.
    .PARAMETER OutputUnit
        The unit to convert into.
    .PARAMETER precision
        The number of decimal digits of converted value
    .EXAMPLE
        ConvertTo-MassUnit -InputUnit s -InputValue 200 -OutputUnit min
    .EXAMPLE
        ConvertTo-MassUnit -InputUnit h -InputValue 14 -OutputUnit min
	#>
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet('kilogram','kg','gram','g','pound','pounds','lb','lbs','ston','st','ounce','oz','quintal','short ton','net ton','us ton','long ton','weight ton','gross ton','imperial ton')]
        [string] $InputUnit,
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [double] $InputValue,
        [Parameter(Mandatory=$true)]
        [ValidateSet('kilogram','kg','gram','g','pound','pounds','lb','lbs','ston','st','ounce','oz','quintal','short ton','net ton','us ton','long ton','weight ton','gross ton','imperial ton')]
        [string] $OutputUnit,
        [Parameter(Mandatory=$false)]
        [int] $Precision
    )

    #Load UnitConversion dll
    $path = Get-ModulePath "PoshUnitConversion"
    [Reflection.Assembly]::LoadFile("$Path\binary\UnitConversion.dll") | Out-Null
    try{
        $converter = [UnitConversion.MassConverter]::new($InputUnit, $OutputUnit)
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