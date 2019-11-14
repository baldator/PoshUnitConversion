$ModuleName   = "PoshUnitConversion"
$ModulePath = "$PSScriptRoot\..\$ModuleName\$ModuleName.psm1"

Import-module $ModulePath -Force

Describe 'ConvertTo-VolumeUnit' {

    Context 'InvalidInput' {
        It 'Invalid InputUnit' {
            {
                ConvertTo-VolumeUnit -InputUnit 'InvalidUnit' -InputValue 21 -OutputUnit 'm3'
            } | Should throw
        }

        It 'Invalid OutputUnit' {
            {
                ConvertTo-VolumeUnit -InputUnit 'cm3' -InputValue 21 -OutputUnit 'Not'
            } | Should throw
        }


        It 'Invalid InputValue' {
            {
                ConvertTo-VolumeUnit -InputUnit 'mm3' -InputValue 'Invalid' -OutputUnit 'cm3'
            } | Should throw
        }
    }

    Context 'Check Values'{
        It 'Convert m3 to mm3' {
            ConvertTo-VolumeUnit -InputUnit 'm3' -InputValue 1 -OutputUnit 'mm3' | Should Be 1000000000
        }
        It 'Convert mm3 to cm3 with precision' {
            ConvertTo-VolumeUnit -InputUnit 'mm3' -InputValue 200 -OutputUnit 'cm3' -Precision 2 | Should Be 0.2
        }
    }

}