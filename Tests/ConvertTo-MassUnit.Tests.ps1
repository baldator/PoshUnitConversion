$ModuleName   = "PoshUnitConversion"
$ModulePath = "$PSScriptRoot\..\$ModuleName\$ModuleName.psm1"

Import-module $ModulePath -Force

Describe 'ConvertTo-MassUnit' {

    Context 'InvalidInput' {
        It 'Invalid InputUnit' {
            {
                ConvertTo-MassUnit -InputUnit 'InvalidUnit' -InputValue 21 -OutputUnit 'kg'
            } | Should throw
        }

        It 'Invalid OutputUnit' {
            {
                ConvertTo-MassUnit -InputUnit 'us ton' -InputValue 21 -OutputUnit 'Not'
            } | Should throw
        }


        It 'Invalid InputValue' {
            {
                ConvertTo-MassUnit -InputUnit 'us ton' -InputValue 'Invalid' -OutputUnit 'g'
            } | Should throw
        }
    }

    Context 'Check Values'{
        It 'Convert pokgund to net g' {
            ConvertTo-MassUnit -InputUnit 'kg' -InputValue 1 -OutputUnit 'g' | Should Be 1000
        }
        It 'Convert oz to min with kilogram' {
            ConvertTo-MassUnit -InputUnit 'oz' -InputValue 200 -OutputUnit 'kilogram' -Precision 2 | Should Be 5.67
        }
    }

}