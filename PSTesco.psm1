function Find-TescoGrocery
<#
.Synopsis
   Search the Tesco grocery website
.DESCRIPTION
   Search the Tesco grocery website using the tescolabs.com developer API.  You must sign up for an account and generate your own personal API
   key in order to use this cmdlet.
.EXAMPLE
   Get-TescoGrocery -ApiKey 123456789 -Query beef
   Search the grocery site for beef
.EXAMPLE
   Get-TescoGrocery -ApiKey 123456789 -Query 'white wine', 'russian standard vodka' -Limit 20
   Search the grocery site for two items.  These items are enclosed in single quotes as they contain a space between words.  The results 
   are limited to a maximum of 20 listings.
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
                $Product.uk.ghs.products.results | ForEach-Object {
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
                        ApiKey = $ApiKey
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

function Get-TescoProductData
<#
.Synopsis
   Search the Tesco grocery website
.DESCRIPTION
   Search the Tesco grocery website using the tescolabs.com developer API.  You must sign up for an account and generate your own personal API
   key in order to use this cmdlet.
.EXAMPLE
   Get-TescoGrocery -ApiKey 123456789 -Query beef
   Search the grocery site for beef
.EXAMPLE
   Get-TescoGrocery -ApiKey 123456789 -Query 'white wine', 'russian standard vodka' -Limit 20
   Search the grocery site for two items.  These items are enclosed in single quotes as they contain a space between words.  The results 
   are limited to a maximum of 20 listings.
#>
{
    [CmdletBinding()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $ApiKey,

        # Param2 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=1)]
        [string[]]$TPNB
    )

    Begin
    {
        
    }
    Process
    {
        Try {
            ForEach ($T in $TPNB) {
                $Header = @{ 'Ocp-Apim-Subscription-Key' = $ApiKey }
                $Product = Invoke-RestMethod -Uri "https://dev.tescolabs.com/product/?tpnb=$TPNB" -Headers $Header -ErrorAction Stop
                $Product.products | ForEach-Object {
                    [PSCustomObject]@{
                        PSTypeName = 'XV5.AJP.TescoProductData'
                        GTIN = $PSItem.gtin
                        TPNB = $PSItem.tpnb
                        TPNC = $PSItem.tpnc
                        Description = $PSItem.description
                        Brand = $PSItem.brand
                        MarketingText = $PSItem.marketingText
                    }
                }#>
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