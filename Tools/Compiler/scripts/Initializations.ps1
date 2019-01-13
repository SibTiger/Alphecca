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

    # PowerShell Version Requirement
    Set-Variable -Name "_POWERSHELLVERSION_" -Value 3 `
        -Option Constant -Scope Global -ErrorAction SilentlyContinue;
} # InitalizationProgramData()




# Initialization Directory Paths
# -------------------------------
# Documentation:
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


    # ----
    # User Data


    # User-Data Parent Directory Path
    # ---------------
    # The root directory where user-data will be stored.
    Set-Variable -Name "_DIRECTORYUSERDATAROOT_" -Value "$(FetchPathUserDocuments)\$($_PROGRAMNAME_)" `
        -Scope Global -Force -Option Constant -ErrorAction SilentlyContinue;


    # Output Parent Directory Path
    # ---------------
    # The root directory that the builds reside.
    Set-Variable -Name "_DIRECTORYOUTPUTROOT_" -Value "$($_DIRECTORYUSERDATAROOT_)\Builds" `
        -Scope Global -Force -Option Constant -ErrorAction SilentlyContinue;


    # Output Release Directory Path
    # ---------------
    # The directory that holds the 'Release' builds.
    Set-Variable -Name "_DIRECTORYOUTPUTRELEASE_" -Value "$($_DIRECTORYOUTPUTROOT_)\Release" `
        -Scope Global -Force -Option Constant -ErrorAction SilentlyContinue;


    # Output Development Directory Path
    # ---------------
    # The directory that holds the 'Development' builds.
    Set-Variable -Name "DIRECTORYOUTPUTDEV_" -Value "$($_DIRECTORYOUTPUTROOT_)\Development" `
        -Scope Global -Force -Option Constant -ErrorAction SilentlyContinue;


    # ----
    # Program Data


    # Program-Data Parent Directory Path
    # ---------------
    # The root directory where program-data will be stored.
    Set-Variable -Name "_DIRECTORYPROGDATAROOT_" -Value "$(FetchPathAppDataLocal)\$($_PROGRAMNAME_)" `
        -Scope Global -Force -Option Constant -ErrorAction SilentlyContinue;


    # Log Directory Path
    # ---------------
    # The directory that will contain the log-files regarding this program and some special
    #  operations.
    Set-Variable -Name "_DIRECTORYPROGLOGS_" -Value "$($_DIRECTORYPROGDATAROOT_)\Logs" `
        -Scope Global -Force -Option Constant -ErrorAction SilentlyContinue;


    # User Data (Configuration)
    # ---------------
    # This directory will hold the user's configurations.
    Set-Variable -Name "_DIRECTORYUSERCONFIGS_" -Value "$($_DIRECTORYPROGDATAROOT_)\Configs" `
        -Scope Global -Force -Option Constant -ErrorAction SilentlyContinue;
} # InitalizationDirectory()




# Fetch Path: AppData Local Directory
# -------------------------------
# Documentation:
#  This function will find the currently logged-in user's
#   AppData Local absolute path and return the value to the
#   respected caller.
# -------------------------------
# Output:
#  [string] Local AppData Absolute Path
#   The current user's Local AppData directory.
# -------------------------------
function FetchPathAppDataLocal()
{
    return "$($env:LOCALAPPDATA)";
} # FetchPathAppDataLocal()




# Fetch Path: AppData Roaming Directory
# -------------------------------
# Documentation:
#  This function will find the currently logged-in user's
#   AppData Roaming absolute path and return the value to the
#   respected caller.
# -------------------------------
# Output:
#  [string] Roaming AppData Absolute Path
#   The current user's Roaming AppData directory.
# -------------------------------
function FetchPathAppDataRoaming()
{
    return "$($env:APPDATA)";
} # FetchPathAppDataRoaming()




# Fetch Path: User's Document Directory
# -------------------------------
# Documentation:
#  This function will find the currently logged-in user's
#   Document's absolute path and return the value to the
#   respected caller.
# -------------------------------
# Output:
#  [string] User's 'My Documents' Absolute Path
#   The current user's Documents directory.
# -------------------------------
function FetchPathUserDocuments()
{
    return "$($env:HOMEPATH)\Documents"
} # FetchPathUserDocuments()