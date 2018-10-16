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
#    This function will display the main menu to the user.
# --------------------------
function MakeCompiler()
{
} # MakeCompiler()




# Create New Script File
# --------------------------
# Documentation
#    This function merely creates the new script file that will hold all of the
#     sub-scripts into one script file.
# --------------------------
function CreateNewScriptFile()
{
    try
    {
        New-Item -Path $SCRIPTPATH -Name $SCRIPTFILENAME -ItemType "File" `
            -Value "# $($PROJECTNAME) Compiler was generated on: $(Get-Date)`r`n`r`n" -ErrorAction Stop | Out-Null;
    }
    catch
    {
        Write-Host "Error was thrown!";
    }
} # CreateNewScriptFile()