# PSTesco
PSTesco is a simple PowerShell module to search for Tesco groceries using the Tesco Labs Developer APIs (https://devportal.tescolabs.com/).

Requirements
============

You need to provide your own API key in order to use this.  You can sign up for this on the Tesco Labs site.

Usage
=====
```powershell
Find-TescoGrocery -ApiKey 123456789 -Query 'search term'
```
Search the grocery site for beef

```powershell
Find-TescoGrocery -ApiKey 123456789 -Query 'white wine', 'russian standard vodka' -Limit 20
```
Search the grocery site for two items.  These items are enclosed in single quotes as they contain a space between words.  The results are limited to a maximum of 20 listings.