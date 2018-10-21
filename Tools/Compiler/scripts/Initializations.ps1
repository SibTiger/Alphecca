# Initializations
# --------------------------
# Documentation
#     This function will declare and initialize all global variables that will be available
#     within this program.
# --------------------------
function Initializations()
{
    # Project Information
    InitializationsProjectData;

    # Directory Locations
    InitializationsDirectory;
} # Initializations()




# Initialization Project Data
# --------------------------
# Documentation
#     Project information
# --------------------------
function InitializationsProjectData()
{
    # Project Name (sometimes the codename)
    Set-Variable -Name "PROJECTNAME" -Value "Alphecca" `
        -Option Constant -Scope Global -ErrorAction SilentlyContinue;

    # Project Name (short)
    Set-Variable -Name "PROJECTNAMESHORT" -Value "Alphecca" `
        -Option Constant -Scope Global -ErrorAction SilentlyContinue;

    # Project Name (Compacted; /idgames Standards)
    Set-Variable -Name "PROJECTNAMECOMPACT" -Value "Alphecca" `
        -Option Constant -Scope Global -ErrorAction SilentlyContinue;

    # Project Known Version
    Set-Variable -Name "PROJECTVERSION" -Value 1 `
        -Option Constant -Scope Global -ErrorAction SilentlyContinue;

    # Project Website
    Set-Variable -Name "PROJECTWEBSITE" -Value "https://github.com/SibTiger/Alphecca" `
        -Option Constant -Scope Global -ErrorAction SilentlyContinue;

    # Help Documentation
    Set-Variable -Name "PROJECTHELP" -Value "https://github.com/SibTiger/Alphecca/wiki" `
        -Option Constant -Scope Global -ErrorAction SilentlyContinue;
} # InitializationsProjectData()




# Initialization Directory Paths
# --------------------------
# Documentation
#     Directory locations
# --------------------------
function InitializationsDirectory()
{
    # Script Absolute Script Path
    Set-Variable -Name "SCRIPTPATH" -Value $PSScriptRoot `
        -Scope Global -Force -Option Constant -ErrorAction SilentlyContinue;
} # InitializationsDirectory()