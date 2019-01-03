﻿# Initializations
# --------------------------
# Documentation
#     This function will declare and initialize all global variables that will be available
#     within this program.
# --------------------------
function Initializations()
{
    # Program Information
    InitalizationProgramData;

    # Directory Locations
    InitializationsDirectory;
} # Initializations()



# Initialiation Program Data
# -------------------------------
# Documentation:
#  This function will initialize all variables related to the program.
# -------------------------------
function InitalizationProgramData()
{
    # Program Name
    Set-Variable -Name "_PROGRAMNAME_" -Value "PowerShell Compact-Archive Tool" `
        -Option Constant -Scope Global -ErrorAction SilentlyContinue;

    # Version
    Set-Variable -Name "_VERSION_" -Value "0.000001-Alpha" `
        -Option Constant -Scope Global -ErrorAction SilentlyContinue;

    # Version Name
    Set-Variable -Name "_VERSIONNAME_" -Value "Cordis" `
        -Option Constant -Scope Global -ErrorAction SilentlyContinue;

    # Release Date
    Set-Variable -Name "_RELEASEDATE_" -Value "DD.MM.YYYY" `
        -Option Constant -Scope Global -ErrorAction SilentlyContinue;

    # .NET Framework Requirement
    Set-Variable -Name "_DOTNETFRAMEWORK_" -Value 5 `
        -Option Constant -Scope Global -ErrorAction SilentlyContinue;
} # InitalizationProgramData()




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




# Initialization Build Output
# --------------------------
# Documentation
#     Build Output
# --------------------------
function InitializationsOutput()
{
    # Output Directory Name
    Set-Variable -Name "OUTPUTDIRECTORYNAME" -Value "BUILDS" `
        -Scope Global -Force -Option Constant -ErrorAction SilentlyContinue;
            
    # Build Output Path
    Set-Variable -Name "OUTPUTDIRECTORY" -Value "$(Resolve-Path "$($PSScriptRoot)\BUILDS" | select -ExpandProperty Path)" `
        -Scope Global -Force -Option Constant -ErrorAction SilentlyContinue;
} # InitializationsOutput()