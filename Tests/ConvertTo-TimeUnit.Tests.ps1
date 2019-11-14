$ModuleName   = "PoshUnitConversion"
$ModulePath = "$PSScriptRoot\..\$ModuleName\$ModuleName.psm1"

Import-module $ModulePath -Force

Describe 'ConvertTo-TimeUnit' {

    Context 'InvalidInput' {
        It 'Invalid InputUnit' {
            {
                ConvertTo-TimeUnit -InputUnit 'InvalidUnit' -InputValue 21 -OutputUnit 's'
            } | Should throw
        }

        It 'Invalid OutputUnit' {
            {
                ConvertTo-TimeUnit -InputUnit 'min' -InputValue 21 -OutputUnit 'Not'
            } | Should throw
        }


        It 'Invalid InputValue' {
            {
                ConvertTo-TimeUnit -InputUnit 'min' -InputValue 'Invalid' -OutputUnit 'year'
            } | Should throw
        }
    }

    Context 'Check Values'{
        It 'Convert y to h' {
            ConvertTo-TimeUnit -InputUnit 'y' -InputValue 1 -OutputUnit 'h' | Should Be 8760
        }
        It 'Convert s to min with precision' {
            ConvertTo-TimeUnit -InputUnit 's' -InputValue 200 -OutputUnit 'min' -Precision 2 | Should Be 3.33
        }
    }

}