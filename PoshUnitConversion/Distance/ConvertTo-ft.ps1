function ConvertTo-ft{
    <#
	.SYNOPSIS
		Convert distance to feet.
	.DESCRIPTION
        Convert distance to feet. Input can be in m, km, cm, mm, yard, mile or in.
    .PARAMETER m
        A distance value in meter
    .PARAMETER km
        A distance value in kilometer
    .PARAMETER cm
        A distance value in centimeter
    .PARAMETER mm
        A distance value in millimeter
    .PARAMETER yd
        A distance value in yard
    .PARAMETER mile
        A distance value in mile
    .PARAMETER in
        A distance value in inch
    .PARAMETER precision
        The number of decimal digits of converted value
    .EXAMPLE
        ConvertTo-meter -km 200
    .EXAMPLE
        ConvertTo-meter -in 14 -precision 2
	#>
    param(
        [Parameter(ParameterSetName='m',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [double] $m,
        [Parameter(ParameterSetName='km',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [double] $km,
        [Parameter(ParameterSetName='cm',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [double] $cm,
        [Parameter(ParameterSetName='mm',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [double] $ft,
        [Parameter(ParameterSetName='yd',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [double] $yd,
        [Parameter(ParameterSetName='mile',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [double] $mile,
        [Parameter(ParameterSetName='in',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [double] $in,
        [Parameter(Mandatory=$false)]
        [int] $Precision
    )

    $TargetUnit = $PSCmdlet.ParameterSetName
    $value = Get-Variable -Name $PSCmdlet.ParameterSetName -ValueOnly

    #Load Stubble dll
    $path = Get-ModulePath "PoshUnitConversion"
    [Reflection.Assembly]::LoadFile("$Path\binary\UnitConversion.dll") | Out-Null
    try{
        $converter = [UnitConversion.distanceConverter]::new($TargetUnit, "ft")
        if($Precision){
            $retValue = $converter.LeftToRight($value, $Precision)
        }
        else{
            $retValue = $converter.LeftToRight($value)
        }
        return $retValue
    } catch [Exception] {
        $_.Exception.Message
    }
}