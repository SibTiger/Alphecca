﻿# Global Variables
# --------------------------
# Script Absolute Script Path
Set-Variable -Name "SCRIPTPATH" -Value $PSScriptRoot `
    -Scope Global -Force -ErrorAction SilentlyContinue;
# Compiler Script File Name
Set-Variable -Name "SCRIPTFILENAME" -Value "compile.ps1" `
    -Scope Global -Force -ErrorAction SilentlyContinue;
# Subscripts Directory
Set-Variable -Name "SCRIPTSDIRECTORY" -Value "$($SCRIPTPATH)\Scripts\" `
    -Scope Global -Force -ErrorAction SilentlyContinue;
# Output Compiler Directory
Set-Variable -Name "OUTPUTDIRECTORY" -Value "..\..\" `
    -Scope Global -Force -ErrorAction SilentlyContinue;
# Output Script File
Set-Variable -Name "OUTPUTFILE" -Value "$($OUTPUTDIRECTORY)\$($SCRIPTFILENAME)" `
    -Scope Global -Force -ErrorAction SilentlyContinue;
# Project Name
Set-Variable -Name "PROJECTNAME" -Value "Alphecca" `
    -Scope Global -Force -ErrorAction SilentlyContinue;
# --------------------------




# Make Compiler
# --------------------------
# Documentation
#    This function will combine all of the sub-scripts into one script.
# --------------------------
function MakeCompiler()
{
    # Help Documentation
    Add-Content -Path $OUTPUTFILE -Value (Get-Content "$($SCRIPTSDIRECTORY)help.ps1");

    # Initializations
    Add-Content -Path $OUTPUTFILE -Value (Get-Content "$($SCRIPTSDIRECTORY)Initializations.ps1");

    # Common
    Add-Content -Path $OUTPUTFILE -Value (Get-Content "$($SCRIPTSDIRECTORY)common.ps1");

    # Compiler
    Add-Content -Path $OUTPUTFILE -Value (Get-Content "$($SCRIPTSDIRECTORY)Compiler.ps1");

    # Main Menu
    Add-Content -Path $OUTPUTFILE -Value (Get-Content "$($SCRIPTSDIRECTORY)MainMenu.ps1");

    # Main (entry point)
    Add-Content -Path $OUTPUTFILE -Value (Get-Content "$($SCRIPTSDIRECTORY)main.ps1");
} # MakeCompiler()




# Create New Script File
# --------------------------
# Documentation
#    This function merely creates the new script file that will hold all of the
#     sub-scripts into one script file.
# --------------------------
# Return [int]
#    0 = Created file successfully
#    1 = Error occurred; vague
# --------------------------
function CreateNewScriptFile()
{
    # Try to create the file; if we are unable to - then return with an error signal.
    try
    {
        New-Item -Path $OUTPUTDIRECTORY -Name $SCRIPTFILENAME -ItemType "File" `
            -Value "# $($PROJECTNAME) Compiler was generated on: $(Get-Date)`r`n`r`n" -ErrorAction Stop | Out-Null;
        return 0;
    } # Try
    catch
    {
        return 1;
    } # Error
} # CreateNewScriptFile()




# Expunge Old Script File
# --------------------------
# Documentation
#    This function will delete the old script file that was previously compiled.
# --------------------------
# Return [int]
#    0 = Deleted file successfully
#    1 = Error occurred; vague
# --------------------------
function ExpungeOldScriptFile()
{
    # Try to delete the file, if we are unable to - then return with an error signal.
    try
    {
        Remove-Item -Path $OUTPUTFILE -ErrorAction Stop;
        return 0;
    } # Try
    catch
    {
        return 1;
    } # Error
} # ExpungeOldScriptFile()




# Detect Existing Script File
# --------------------------
# Documentation
#    This function will check for an existing compile script.
# --------------------------
# Return [int]
#    0 = File does not exist
#    1 = File exist
# --------------------------
function DetectExistingScriptFile()
{
    if(Test-Path -Path $OUTPUTFILE)
    {
        return 1;
    } # if:File Exists
    else
    {
        return 0;
    } # else: File does not exist
} # DetectExistingScriptFile()




# Main [Entry Point]
# --------------------------
# Documentation
#    This function is our main program entry point.
# --------------------------
function main()
{
    # Check if the script file already exists
    DetectExistingScriptFile;

    # Delete the script
    ExpungeOldScriptFile;

    # Create the script
    CreateNewScriptFile;

    # Generate the script
    MakeCompiler;
} # main()




# Start the program
main;