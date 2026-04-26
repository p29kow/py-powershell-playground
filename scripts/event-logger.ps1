<#
.Synopsis
EventProcessor EventLog Capture Automation

- User specifies target EventLog
- User specifies the number of newest log entries to report
- User specifies the entry type to target, for example warning, info etc.
- User specifies the target computer or computers to extract the logs
- User specifies the HTML report title

The script will produce an HTML output containing details of the EventLog acquisition.

.Description
This script automates the extraction of info from the specified log file
.parameter targetLogName
Specifies the name of the log ile to process
.parameter eventCount
Specifies the maximum umber of newest events to consider
.parameter eventType
Specifies the evnt type of interest
.parameter targetComputer
Specifies the computer or computers to obtain the logs from
.parameter reportTitle
Specifies the HTML report title
#>

#Parameter Definition
param(
    [string]$targetLogName = "system",
    [int]$eventCount = 20,
    [string]$eventType = "Error",
    [string]$reportTitle = "Event Log Daily Report",
    [string[]]$targetComputer = $env:COMPUTERNAME
)

$rptDate = Get-Date
$epoch = ([System.DateTimeOffset]$rptDate).ToUnixTimeSeconds()

#HTML Header
$Header = @"
<style>
TABLE {border: 1px solid black; border-collapse: collapse;}
</style>
<p>
<b>$reportTitle $rptDate</b>
</p>
<p>
Event Log Selection: <b>$targetLogName</b>
</p>
<p>
Target Computer(s) Selection: <b>$targetComputer</b>
</p>
<p>
Event Type Filter: <b>$eventType</b>
</p>
"@

$reportFile = ".\Report-" + $epoch + ".html"

Get-EventLog 
-ComputerName $targetComputer 
-LogName $targetLogName 
-Newest $eventCount 
-EntryType $eventType |
ConvertTo-Html 
-Head $Header 
-Property TimeGenerated, EntryType, Message |
Out-File $reportFile