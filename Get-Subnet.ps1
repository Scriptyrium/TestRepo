rest

Function Get-Subnet(
    [Parameter(Mandatory=$True,Position=1)][string]$IP,
    [Parameter(Mandatory=$True,Position=2)][string]$Mask
)

{

<#
.Synopsis
   Gives subnet information based on IP and subnetmask.
.DESCRIPTION
   Lange Beschreibung
.EXAMPLE
   Get-Subnet -IP 1.2.3.4 -Mask 255.255.255.0
.EXAMPLE
   Get-Subnet 4.3.2.1 255.255.128.0
#>
    
    $WorkMask = ""
    $SubnetIP = ""
    $IPRange = ""
    $BroadcastIP = ""
    $PrefLen = ""

    If (!($Mask.StartsWith("/"))) {

        #### Netzmaske in CIDR Schreibweise umformen ####
        $WorkMask = $Mask.Split(".")
        $oct1s = [System.Convert]::tostring($WorkMask[0],2)
        $oct2s = [System.Convert]::tostring($WorkMask[1],2)
        $oct3s = [System.Convert]::tostring($WorkMask[2],2)
        $oct4s = [System.Convert]::tostring($WorkMask[3],2)
        $oct1 = ([regex]::matches($oct1s,'1')).count
        $oct2 = ([regex]::matches($oct2s,'1')).count
        $oct3 = ([regex]::matches($oct3s,'1')).count
        $oct4 = ([regex]::matches($oct4s,'1')).count
        $WorkMask = $oct1 + $oct2 + $oct3 + $oct4

    } Else {

        $WorkMask = $Mask.Substring(1,($Mask.Length - 1))
        
        try
        {
            $WorkMask = [int]$WorkMask
        }
        catch
        {
            Write-Host "Wrong subnet-mask format." -ForegroundColor Red
        }

    }


    switch ($WorkMask)
    {
        0 { Write-Host "Wildcard subnetmask. The whole range of IP-Addresses." }
        1 {}
        2 {}
        3 {}
        4 {}
        5 {}
        6 {}
        7 {}
        8 {}
        9 {}
        10 {}
        11 {}
        12 {}
        13 {}
        14 {}
        15 {}
        16 {}
        17 {}
        18 {}
        19 {}
        20 {}
        21 {}
        22 {}
        23 {
        
            $TempIP = $IP.Substring(0, $IP.IndexOf(".", ($IP.IndexOf(".") + 1)))
        
            $net = ($IP.Split("."))[2]

            If ($net%2 -ne 0) {
                $net -= 1
            }

            $TempIP += ".$net.0"

            $SubnetIP = ""
            $IPRange = ""
            $BroadcastIP = ""                    
        }
        24 {}
        25 {}
        26 {}
        27 {}
        28 {}
        29 {}
        30 {}
        31 {}
        32 { Write-Host "Single host. No subnet. IP = $IP" }
        Default {}
    }

}