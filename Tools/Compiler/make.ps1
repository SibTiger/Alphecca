# Global Variables
# --------------------------
# Script Absolute Script Path
Set-Variable -Name "SCRIPTPATH" -Value $PSScriptRoot `
    -Scope Global -Force -ErrorAction SilentlyContinue;
# Compiler Script File Name
Set-Variable -Name "SCRIPTFILENAME" -Value "compile.ps1" `
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


function CreateNewScriptFile()
{
    New-Item -Path $SCRIPTPATH -Name $SCRIPTFILENAME -ItemType "File";
} # CreateNewScriptFile()