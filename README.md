# PSTesco
PSTesco is a simple PowerShell module to search for Tesco groceries using the Tesco Labs Developer APIs (https://devportal.tescolabs.com/).

Requirements
============

You **need** to provide your own API key in order to use this.  You can sign up for this on the Tesco Labs site.

Installation (v5+)
============
```powershell
Install-Module PSTesco
```
If you haven't already you will need to change your execution policy (Get-ExecutionPolicy) to RemoteSigned or less security.
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
```

Usage
=====
```powershell
Find-TescoGrocery -ApiKey 123456789 -Query 'search term'
```
Examples
========
Search the grocery site for beef
```powershell
Find-TescoGrocery -ApiKey 123456789 -Query beef
```
Search the grocery site for two items.  These items are enclosed in single quotes as they contain a space between words.  The results are limited to a maximum of 20 listings.
```powershell
Find-TescoGrocery -ApiKey 123456789 -Query 'white wine', 'russian standard vodka' -Limit 20
```