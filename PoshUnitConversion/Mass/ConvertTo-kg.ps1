function ConvertTo-Kg{
    <#
	.SYNOPSIS
		Convert Mass to Kg.
	.DESCRIPTION
        Convert Mass to Kg. Input can be in lbs, gram, stone, once, quintal, us ton or imperial ton.
    .PARAMETER lbs
        A Mass value in pounds
    .PARAMETER gram
        A Mass value in gram
    .PARAMETER st
        A Mass value in Stone
    .PARAMETER oz
        A Mass value in once
    .PARAMETER quintal
        A Mass value in quintal
    .PARAMETER shortton
        A Mass value in US ton
    .PARAMETER longton
        A Mass value in imperial ton
    .PARAMETER precision
        The number of decimal digits of converted value
    .EXAMPLE
        ConvertTo-Kg -lbs 200
    .EXAMPLE
        ConvertTo-Kg -quintal 14 -precision 2
	#>
    param(
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
        [Parameter(ParameterSetName='longton',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [double] $longton,
        [Parameter(Mandatory=$false)]
        [int] $Precision
    )

    $TargetUnit = $PSCmdlet.ParameterSetName
    $value = Get-Variable -Name $PSCmdlet.ParameterSetName -ValueOnly

    #Load Stubble dll
    $path = Get-ModulePath "PoshUnitConversion"
    [Reflection.Assembly]::LoadFile("$Path\binary\UnitConversion.dll") | Out-Null
    try{
        $converter = [UnitConversion.MassConverter]::new($TargetUnit, "kg")
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