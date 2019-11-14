$ModuleName   = "PoshUnitConversion"
$ModulePath = "$PSScriptRoot\..\$ModuleName\$ModuleName.psm1"

Import-module $ModulePath -Force

Describe 'ConvertTo-DistanceUnit' {

    Context 'InvalidInput' {
        It 'Invalid InputUnit' {
            {
                ConvertTo-DistanceUnit -InputUnit 'InvalidUnit' -InputValue 21 -OutputUnit 'metre'
            } | Should throw
        }

        It 'Invalid OutputUnit' {
            {
                ConvertTo-DistanceUnit -InputUnit 'cm' -InputValue 21 -OutputUnit 'Not'
            } | Should throw
        }


        It 'Invalid InputValue' {
            {
                ConvertTo-DistanceUnit -InputUnit 'mm' -InputValue 'Invalid' -OutputUnit 'cm'
            } | Should throw
        }
    }

    Context 'Check Values'{
        It 'Convert cm to mm' {
            ConvertTo-DistanceUnit -InputUnit 'cm' -InputValue 1 -OutputUnit 'mm' | Should Be 10
        }
        It 'Convert m to km with precision' {
            ConvertTo-DistanceUnit -InputUnit 'm' -InputValue 200 -OutputUnit 'km' -Precision 2 | Should Be 0.2
        }
    }

}