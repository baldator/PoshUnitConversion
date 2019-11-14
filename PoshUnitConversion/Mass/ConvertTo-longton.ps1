function ConvertTo-longton{
    <#
	.SYNOPSIS
		Convert Mass to imperial ton.
	.DESCRIPTION
        Convert Mass to US ton. Input can be in kg, lbs, gram, once, stone, quintal or us ton.
    .PARAMETER kg
        A Mass value in kg
    .PARAMETER lbs
        A Mass value in lbs
    .PARAMETER gram
        A Mass value in gram
    .PARAMETER st
        A Mass value in stone
    .PARAMETER oz
        A Mass value in once
    .PARAMETER quintal
        A Mass value in quintal
    .PARAMETER shortton
        A Mass value in US ton
    .PARAMETER precision
        The number of decimal digits of converted value
    .EXAMPLE
        ConvertTo-longton -kg 200
    .EXAMPLE
        ConvertTo-longton -oz 14 -precision 2
	#>
    param(
        [Parameter(ParameterSetName='kg',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [double] $Kg,
        [Parameter(ParameterSetName='lbs',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [double] $lbs,
        [Parameter(ParameterSetName='gram',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [double] $gram,
        [Parameter(ParameterSetName='st',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [double] $st,
        [Parameter(ParameterSetName='oz',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [double] $oz,
        [Parameter(ParameterSetName='quintal',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [double] $quintal,
        [Parameter(ParameterSetName='shortton',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [double] $shortton,
        [Parameter(Mandatory=$false)]
        [int] $Precision
    )

    $TargetUnit = $PSCmdlet.ParameterSetName
    $value = Get-Variable -Name $PSCmdlet.ParameterSetName -ValueOnly

    #Load Stubble dll
    $path = Get-ModulePath "PoshUnitConversion"
    [Reflection.Assembly]::LoadFile("$Path\binary\UnitConversion.dll") | Out-Null
    try{
        $converter = [UnitConversion.MassConverter]::new($TargetUnit, "longton")
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