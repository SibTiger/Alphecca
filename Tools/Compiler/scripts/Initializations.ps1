# Initializations Driver
# -------------------------------
# Documentation:
#  This function is essentially the driver to setting up the declarations and
#   initializations for the heart of the program.  Most of the declarations
#   housed within this script are global but constant, thus the variables can
#   be used anywhere within this program but not mutable once initialized.
# -------------------------------
function Initializations()
{
    # Program Information
    InitalizationProgramData;

    # Directory Locations
    InitalizationDirectory;
} # Initializations()



# Initialization Program Data
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




# Initialization Directory Paths
# -------------------------------
# Documentation
#  This function will setup the directory paths that will be used
#   when handling files within this program.
# -------------------------------
function InitalizationDirectory()
{
    # Script Absolute Script Path
    # ---------------
    # The path that this script currently resides from.
    #  Highly useful for 'absolute' paths.
    # BUG POSSIBLE: If the path has been disrupted at program's runtime,
    #  then it is possible that this path will be broken - thus causing
    #  problems when trying to throw or recall files from specific directories
    #  from an absolute directory.
    Set-Variable -Name "_SCRIPTPATH_" -Value $PSScriptRoot `
        -Scope Global -Force -Option Constant -ErrorAction SilentlyContinue;


    # Output Parent Directory Path
    # ---------------
    # The root directory that the builds reside.
    Set-Variable -Name "_DIRECTORYOUTPUTROOT_" -Value "$(_SCRIPTPATH_)\Builds" `
        -Scope Global -Force -Option Constant -ErrorAction SilentlyContinue;


    # Output Release Directory Path
    # ---------------
    # The directory that holds the 'Release' builds.
    Set-Variable -Name "_DIRECTORYOUTPUTRELEASE_" -Value "$(_DIRECTORYOUTPUTROOT_)\Release" `
        -Scope Global -Force -Option Constant -ErrorAction SilentlyContinue;


    # Output Development Directory Path
    # ---------------
    # The directory that holds the 'Development' builds.
    Set-Variable -Name "DIRECTORYOUTPUTDEV_" -Value "$(_DIRECTORYOUTPUTROOT_)\Development" `
        -Scope Global -Force -Option Constant -ErrorAction SilentlyContinue;


    # Log Directory Path
    # ---------------
    # The directory that will contain the log-files regarding this program and some special
    #  operations.
    Set-Variable -Name "_DIRECTORYLOGROOT_" -Value "$(_SCRIPTPATH_)\Logs" `
        -Scope Global -Force -Option Constant -ErrorAction SilentlyContinue;
} # InitalizationDirectory()