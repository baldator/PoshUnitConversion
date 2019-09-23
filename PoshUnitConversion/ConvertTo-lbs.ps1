function ConvertTo-Lbs{
    <#
	.SYNOPSIS
		Convert Mass to Lbs.
	.DESCRIPTION
        Convert Mass to Lbs. Input can be in kg.
    .PARAMETER kg
        A
    .PARAMETER InputFile
        The path of the file containing the template
    .PARAMETER ParametersObject
        A JSON String containing mustache parameters
    .EXAMPLE
        ConvertTo-PoshstacheTemplate -InputString "Hi {{name}}!" -ParameterObject @{name:'bob'}
    .EXAMPLE
        ConvertTo-PoshstacheTemplate -InputFile .\myInputFile.txt -ParameterObject @{name:'bob'}
	#>
    param(
        [Parameter(ParameterSetName='kg',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [double] $Kg,
        [Parameter(Mandatory=$false)]
        [int] $Precision
    )

    $TargetUnit = $PSCmdlet.ParameterSetName
    $value = Get-Variable -Name $PSCmdlet.ParameterSetName -ValueOnly

    #Load Stubble dll
    $path = Get-ModulePath "PoshUnitConversion"
    [Reflection.Assembly]::LoadFile("$Path\binary\UnitConversion.dll") | Out-Null
    try{
        [Reflection.Assembly]::LoadFile("$Path\binary\UnitConversion.dll")

        if($Precision){
            $converter = [UnitConversion.MassConverter]::new($TargetUnit, "lbs", $Precision)
        }
        else{
                $converter = [UnitConversion.MassConverter]::new($TargetUnit, "lbs")
        }
        return $converter.LeftToRight($value)
    } catch [Exception] {
        $_.Exception.Message
    }
}