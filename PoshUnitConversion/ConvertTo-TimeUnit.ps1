function ConvertTo-TimeUnit{
    <#
	.SYNOPSIS
		Convert Time value.
	.DESCRIPTION
        Convert Time value from input unit to output unit. Supported units are second (s), decisencond (ds), centisecond (cs), millisencond (ms), microsecond (us),
        nanosecond (ns), minute (min), hour (h), day (d), year (y), leap-year (leap year).
    .PARAMETER InputUnit
        The time unit of input value.
    .PARAMETER InputValue
        The time value to convert.
    .PARAMETER OutputUnit
        The unit to convert into.
    .PARAMETER precision
        The number of decimal digits of converted value
    .EXAMPLE
        ConvertTo-TimeUnit -InputUnit s -InputValue 200 -OutputUnit min
    .EXAMPLE
        ConvertTo-TimeUnit -InputUnit h -InputValue 14 -OutputUnit min
	#>
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet('second','s','decisecond','ds','centisecond','cs','millisecond','ms','microsecond','us','nanosecond','ns','minute','min','hour','h','day','d','year','y','leap-year','leap year')]
        [string] $InputUnit,
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [double] $InputValue,
        [Parameter(Mandatory=$true)]
        [ValidateSet('second','s','decisecond','ds','centisecond','cs','millisecond','ms','microsecond','us','nanosecond','ns','minute','min','hour','h','day','d','year','y','leap-year','leap year')]
        [string] $OutputUnit,
        [Parameter(Mandatory=$false)]
        [int] $Precision
    )

    #Load UnitConversion dll
    $path = Get-ModulePath "PoshUnitConversion"
    [Reflection.Assembly]::LoadFile("$Path\binary\UnitConversion.dll") | Out-Null
    try{
        $converter = [UnitConversion.TimeConverter]::new($InputUnit, $OutputUnit)
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