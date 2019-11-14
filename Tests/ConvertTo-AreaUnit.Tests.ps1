$ModuleName   = "PoshUnitConversion"
$ModulePath = "$PSScriptRoot\..\$ModuleName\$ModuleName.psm1"

Import-module $ModulePath -Force

Describe 'ConvertTo-AreaUnit' {

    Context 'InvalidInput' {
        It 'Invalid InputUnit' {
            {
                ConvertTo-AreaUnit -InputUnit 'InvalidUnit' -InputValue 21 -OutputUnit 'm2'
            } | Should throw
        }

        It 'Invalid OutputUnit' {
            {
                ConvertTo-AreaUnit -InputUnit 'km2' -InputValue 21 -OutputUnit 'Not'
            } | Should throw
        }


        It 'Invalid InputValue' {
            {
                ConvertTo-AreaUnit -InputUnit 'km2' -InputValue 'Invalid' -OutputUnit 'km2'
            } | Should throw
        }
    }

    Context 'Check Values'{
        It 'Convert m2 to cm2' {
            ConvertTo-AreaUnit -InputUnit 'm2' -InputValue 1 -OutputUnit 'cm2' | Should Be 10000
        }
        It 'Convert cm2 to m2 with precision' {
            ConvertTo-AreaUnit -InputUnit 'cm2' -InputValue 1 -OutputUnit 'm2' -Precision 2 | Should Be 0
        }
    }

}