<#
.SYNOPSIS
    Generates the compile program for this project.

.DESCRIPTION
    This program is designed to create the project compiler.
    In order to play this project with GZDoom or its children
    ports, this project's source hierarchy must meet with the
    ZDoom PK3 and PK7 standards.  The compiler, which this
    program generates, will allow the user to easily create
    a build of the project and is readable to the GZDoom
    engine.

.NOTES
    Author: Nicholas Gautier
    Email: Nicholas.Gautier.Tiger@GMail.com
    Project Website: https://github.com/SibTiger/Alphecca

.INPUTS
    Nothing is to be given or to be provided from a command\pipe.

.OUTPUTS
    Exit Codes:
        0 = Program finished successfully
        1 = Program finished with errors

.EXAMPLE
    .\make.ps1

.LINK
    https://github.com/SibTiger/Alphecca
    https://zdoom.org/wiki/Using_ZIPs_as_WAD_replacement
#>




# Global Variables
# --------------------------
# Script Absolute Script Path
Set-Variable -Name "SCRIPTPATH" -Value $PSScriptRoot `
    -Scope Global -Force -Option Constant -ErrorAction SilentlyContinue;
# Compiler Script File Name
Set-Variable -Name "SCRIPTFILENAME" -Value "compile.ps1" `
    -Scope Global -Force -Option Constant -ErrorAction SilentlyContinue;
# Subscripts Directory
Set-Variable -Name "SCRIPTSDIRECTORY" -Value "$($SCRIPTPATH)\Scripts\" `
    -Scope Global -Force -Option Constant -ErrorAction SilentlyContinue;
# Output Compiler Directory
Set-Variable -Name "OUTPUTDIRECTORY" -Value "..\..\" `
    -Scope Global -Force -Option Constant -ErrorAction SilentlyContinue;
# Output Script File
Set-Variable -Name "OUTPUTFILE" -Value "$($OUTPUTDIRECTORY)\$($SCRIPTFILENAME)" `
    -Scope Global -Force -Option Constant -ErrorAction SilentlyContinue;
# Project Name
Set-Variable -Name "PROJECTNAME" -Value "Alphecca" `
    -Scope Global -Force -Option Constant -ErrorAction SilentlyContinue;
# DEBUG MODE [Verbose Mode]
Set-Variable -Name "DEBUGMODE" -Value $false `
    -Scope Global -Force -Option Constant -ErrorAction SilentlyContinue;
# --------------------------




# Print with Formatting
# --------------------------
# Documentation
#    This function display text with the necessary formatting.
#    With the formatting, the messages will be much easier to
#     signify to the user between a successful, warning, and
#     error message.
# --------------------------
# Parameters
#    msgLevel [int]
#     The level of the message to be formatted:
#      0 = Normal
#      1 = Successful
#      2 = Error
#      3 = DEBUG MODE
#    msgString [string]
#     The message to display on the terminal buffer.
# --------------------------
function Printf([int] $msgLevel, [string] $msgString)
{
    # Declarations and Initializations
    # ----------------------------------
    # Sub-Script File (with path)
    Set-Variable -Name "msgBackColor" -Scope Local;
    Set-Variable -Name "msgForeColor" -Scope Local;
    # ----------------------------------

    # Determine the formatting of the message
    switch($msgLevel)
    {
        # Normal
        0
        {
            $msgBackColor = "Black";
            $msgForeColor = "White";
            Break;
        } # Normal

        # --------------

        # Successfull
        1
        {
            $msgBackColor = "Black";
            $msgForeColor = "Green";
            Break;
        } # Successfull
        
        # --------------

        # Error
        2
        {
            $msgBackColor = "Black";
            $msgForeColor = "Red";
            Break;
        } # Error

        # --------------

        # DEBUG MODE
        3
        {
            $msgBackColor = "Black";
            $msgForeColor = "Yellow";
        } # DEBUG MODE

        # --------------

        # Default (Bad Key)
        default
        {
            $msgBackColor = "Black";
            $msgForeColor = "Gray";
            Break;
        } # Default (Bad key)
    } # Switch : Message Level

    # Display the message with the formatting
    Write-Host $msgString -BackgroundColor $msgBackColor -ForegroundColor $msgForeColor;
} # Printf()




# Make Compiler
# --------------------------
# Documentation
#    This function will combine all of the sub-scripts into one script.
# --------------------------
# Return [int]
#    0 = Operation was successful
#    1 = Operation failed
# --------------------------
function MakeCompiler()
{
    # Declarations and Initializations
    # ----------------------------------
    # Sub-Script File (with path)
    Set-Variable -Name "scriptFile" -Scope Local;
    # ----------------------------------


    # Help Documentation
    $scriptFile = "$($SCRIPTSDIRECTORY)help.ps1";
    if (!($(FileDetection $scriptFile) -and $(AppendContent $OUTPUTFILE $scriptFile)))
    {
        Printf 2 "Unable to include file: help.ps1";
        return 1;
    } # If : File does not exist


    # =========================


    # Initializations
    $scriptFile = "$($SCRIPTSDIRECTORY)Initializations.ps1";
    if (!($(FileDetection $scriptFile) -and $(AppendContent $OUTPUTFILE $scriptFile)))
    {
        Printf 2 "Unable to include file: Initializations.ps1";
        return 1;
    } # If : File does not exist


    # =========================


    # Common
    $scriptFile = "$($SCRIPTSDIRECTORY)common.ps1";
    if (!($(FileDetection $scriptFile) -and $(AppendContent $OUTPUTFILE $scriptFile)))
    {
        Printf 2 "Unable to include file: common.ps1";
        return 1;
    } # If : File does not exist


    # =========================


    # Compiler
    $scriptFile = "$($SCRIPTSDIRECTORY)Compiler.ps1";
    if (!($(FileDetection $scriptFile) -and $(AppendContent $OUTPUTFILE $scriptFile)))
    {
        Printf 2 "Unable to include file: Compiler.ps1";
        return 1;
    } # If : File does not exist


    # =========================


    # Main Menu
    $scriptFile = "$($SCRIPTSDIRECTORY)MainMenu.ps1";
    if (!($(FileDetection $scriptFile) -and $(AppendContent $OUTPUTFILE $scriptFile)))
    {
        Printf 2 "Unable to include file: MainMenu.ps1";
        return 1;
    } # If : File does not exist


    # =========================


    # Main
    $scriptFile = "$($SCRIPTSDIRECTORY)main.ps1";
    if (!($(FileDetection $scriptFile) -and $(AppendContent $OUTPUTFILE $scriptFile)))
    {
        Printf 2 "Unable to include file: main.ps1";
        return 1;
    } # If : File does not exist



    # Operation was successful
    return 0;
} # MakeCompiler()




# Append Content to File
# --------------------------
# Documentation
#    This function will append information provided from
#     a specific file and append the data to the destination file.
# --------------------------
# Parameters
#    outputFile [string]
#     The destination file that the data will be appended.
#    targetFile [string]
#     The target file that contains the data that we want
#      to mirror to another file.
# --------------------------
# Return [int]
#    0 = Operation was successful
#    1 = Operation failed
# --------------------------
function AppendContent([string] $outputFile, [string] $targetFile)
{
    if((Add-Content -Path $outputFile -Value (Get-Content $targetFile) -ErrorAction SilentlyContinue))
    {
        return 0;
    } # If:Successful
    else
    {
        return 1;
    } # Else:Failure
} # AppendContent()




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




# Detect if File Exists
# --------------------------
# Documentation
#    This function will check if a specific file exists
#     with the provided path and file.
# --------------------------
# Parameters
#    target [string]
#     The path and filename
# --------------------------
# Return [int]
#    0 = File does not exist
#    1 = File exist
# --------------------------
function FileDetection([string]$path)
{
    if(Test-Path -Path $path)
    {
        return 1;
    } # if : File Exists
    else
    {
        return 0;
    } # else : File does not exist
} # FileDetection()




# Existing File Protocol
# --------------------------
# Documentation
#    This function will perform the protocol in assuring that
#     the older script file is removed properly.
# --------------------------
# Return [int]
#    0 = Operation was successful
#    1 = Operation failed; vague
# --------------------------
function ExistingFileProtocol()
{
    if($(FileDetection($OUTPUTFILE)))
    {
        if (ExpungeOldScriptFile)
        {
            return 1;
        } # Expunge failure
    } # Check existing script
    else
    {
        return 0;
    }
} # ExistingFileProtocol()




# Inspector
# --------------------------
# Documentation
#    DEBUG MODE ONLY
#    This function displays all of the global variables.
# --------------------------
function Inspector()
{
    # Create a Hash Table to display the contents; nicer output
    $inspectorTable = @{}

    # Add in the Global Vars. to our HashTable
    $inspectorTable.Add("SCRIPTPATH", "$($SCRIPTPATH)");
    $inspectorTable.Add("SCRIPTFILENAME", "$($SCRIPTFILENAME)");
    $inspectorTable.Add("SCRIPTSDIRECTORY", "$($SCRIPTSDIRECTORY)");
    $inspectorTable.Add("OUTPUTDIRECTORY", "$($OUTPUTDIRECTORY)");
    $inspectorTable.Add("OUTPUTFILE", "$($OUTPUTFILE)");
    $inspectorTable.Add("PROJECTNAME", "$($PROJECTNAME)");

    # Display the Table Header
    Printf 3 "GLOBAL VARIABLE TABLE";

    # Display our table
    Printf 3 ($inspectorTable|Format-Table -AutoSize|Out-String);
    
    # Tell the user how many Global Vars exists
    Printf 3 "Global Variables in used: $($inspectorTable.Count)";

    # Add some extra spacing to make the output nicer -- separating data
    Printf 0 "`n`n";
} # Inspector()




# Main [Entry Point]
# --------------------------
# Documentation
#    This function is our main program entry point.
# --------------------------
function main()
{
    # Output all of the Global Variables [DEBUG MODE]
    if($DEBUGMODE)
    {
        Inspector;
    } # Inspect Global Vars

    # First, check if the script file already exists
    if(ExistingFileProtocol)
    {
        Printf 2 "Unable to successfully delete the old compile script";
        return 1;
    } # Check existing script

    # Second, create a new script file
    if(CreateNewScriptFile)
    {
        Printf 2 "Failure to create the script file";
        return 1;
    } # Create the script

    # Third, append all of the sub-scripts into one script file
    if(MakeCompiler)
    {
        Printf 2 "Failure to generate the script file";
        return 1;
    } # Generate the script

    # Display a message that the build has been generated
    Printf 1 "$($SCRIPTFILENAME) has been successfully created!";
    Printf 1 "You may find the $($SCRIPTFILENAME) in this path:";
    Printf 1 "$(Resolve-Path $OUTPUTFILE | select -ExpandProperty Path)";

    # Successful operation
    return 0;
} # main()




# Start the program
$errorSignal = $(main);

# Terminate the program and provide the Error Code to the OS
exit $errorSignal;