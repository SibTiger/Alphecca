# Global Variables
# --------------------------
# Script Absolute Script Path
Set-Variable -Name "SCRIPTPATH" -Value $PSScriptRoot `
    -Scope Global -Force -ErrorAction SilentlyContinue;
# Compiler Script File Name
Set-Variable -Name "SCRIPTFILENAME" -Value "compile.ps1" `
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
    # Declarations and Initializations
    # -----------------------------------
    # Combine the path and file name into one string variable
    Set-Variable -Name "ScriptFile" -Value "$($SCRIPTPATH)\$($SCRIPTFILENAME)" `
        -Scope Local;
    # -----------------------------------

    # Help Documentation
    Add-Content -Path $ScriptFile -Value (Get-Content "$($SCRIPTPATH)\scripts\help.ps1");

    # Initializations
    Add-Content -Path $ScriptFile -Value (Get-Content "$($SCRIPTPATH)\scripts\Initializations.ps1");

    # Common
    Add-Content -Path $ScriptFile -Value (Get-Content "$($SCRIPTPATH)\scripts\common.ps1");

    # Compiler
    Add-Content -Path $ScriptFile -Value (Get-Content "$($SCRIPTPATH)\scripts\Compiler.ps1");

    # Main Menu
    Add-Content -Path $ScriptFile -Value (Get-Content "$($SCRIPTPATH)\scripts\MainMenu.ps1");

    # Main (entry point)
    Add-Content -Path $ScriptFile -Value (Get-Content "$($SCRIPTPATH)\scripts\main.ps1");
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
        New-Item -Path $SCRIPTPATH -Name $SCRIPTFILENAME -ItemType "File" `
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
        Remove-Item -Path "$($SCRIPTPATH)\$($SCRIPTFILENAME)" -ErrorAction Stop;
        return 0;
    } # Try
    catch
    {
        return 1;
    } # Error
} # ExpungeOldScriptFile()