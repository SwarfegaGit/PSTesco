function Find-TescoGrocery
<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
{
    [CmdletBinding()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   Position=0)]
        $ApiKey,

        # Param2 help description
        [Parameter(Mandatory=$true,
                   Position=1)]
        [string[]]$Query,

        [Parameter(Position=2)]
        [string]$Offset = 0,

        [Parameter(Position=3)]
        [string]$Limit = 10
    )

    Begin
    {
        $Header = @{ 'Ocp-Apim-Subscription-Key' = $ApiKey }
    }
    Process
    {
        Try {
            ForEach ($Q in $Query) {
                $Product = Invoke-RestMethod -Uri "https://dev.tescolabs.com/grocery/products/?query=$Q&offset=$Offset&limit=$Limit" -Headers $Header -ErrorAction Stop
                $Product.uk.ghs.products.results | ForEach {
                    [PSCustomObject]@{
                        PSTypeName = 'XV5.AJP.TescoGrocery'
                        Image = $PSItem.image
                        TPNB = $PSItem.tpnb
                        ContentsMeasureType = $PSItem.ContentsMeasureType
                        Name = $PSItem.name
                        UnitOfSale = $PSItem.UnitOfSale
                        Description = $PSItem.description
                        AverageSellingUnitWeight = $PSItem.AverageSellingUnitWeight
                        UnitQuantity = $PSItem.UnitQuantity
                        ContentsQuantity = $PSItem.ContentsQuantity
                        UnitPrice = $PSItem.unitprice
                        Price = $PSItem.price
                        IsSpecialOffer = $PSItem.IsSpecialoffer
                        PromotionDescription = $PSItem.PromotionDescription
                    }
                }
            }
        }
        Catch {
            Write-error $PSItem.Exception.HResult
        }
    }
    End
    {
    }
}