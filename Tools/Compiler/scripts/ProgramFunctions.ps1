# Create Program Required Directories
# -------------------------------
# Documentation:
#  This function will create the directories
#   that is required to house program-data.
#  These directories will be paramount for
#   this program to operate successfully.
#  If the directories do not exist, then the
#   directories are to be created on the user's
#   filesystem.
#  If the directories does exist already, then
#   nothing will be created nor changed.
#
# ----
#
#  Directories to Create:
#   - User-Data Domain
#    - %HomePath%\Documents\<PROG_NAME>
#    - %HomePath%\Documents\<PROG_NAME>\Builds
#    - %HomePath%\Documents\<PROG_NAME>\Builds\Release
#    - %HomePath%\Documents\<PROG_NAME>\Builds\Development
#
#   - Program-Data Domain
#    - %LOCALAPPDATA%\<PROG_NAME>
#    - %LOCALAPPDATA%\<PROG_NAME>\Logs
#    - %APPDATA%\<PROG_NAME>
#    - %LOCALAPPDATA%\<PROG_NAME>\Configs
# -------------------------------
# Output:
#  [bool] Exit code
#    $false = Failure creating the new directories.
#    $true  = Successfully created the new directories
#             OR
#             Directories already existed, nothing to do.
# -------------------------------
function CreateDirectories()
{
    # First, check if the special directories exists.
    if((CheckSpecialDirectories) -eq $false)
    {
        # Because one or more special directories does
        #  not exist, we can not create directories where
        #  the special paths does not exist.
        #  Potentially incompatible Operating System or
        #  filesystem structure is not supported by the
        #  system.
        return $false;
    } # If : Special Directories Not Exist.


    # ----


    # Second, check if the directories already exist.
    #  If they exist, than there is nothing to do.
    if ((CheckProgramDirectories) -eq $true)
    {
        # Because the directories exists within the
        #  filesystem, there's nothing todo.
        return $true;
    } # If : Directories Exists
    

    # ----


    # Because one or more directories did not exist, then
    #  we must find it and create them.


    # User-Data Directories
    # ++++++++++++++++++++++++++
    # ++++++++++++++++++++++++++


    # Program Root Directory
    if((MakeDirectory "$($_USERDATA_ROOT_PATH_)") -eq $false)
    {
        # Directory could not be created.
        return $false;
    } # If : Program Root Directory Created

    # ----

    # Program Output Builds Directory
    if((MakeDirectory "$($_USERDATA_BUILDS_PATH_)") -eq $false)
    {
        # Directory could not be created.
        return $false;
    } # If : Program Output Builds Directory Created

    # ----

    # Program Output Release Builds Directory
    if((MakeDirectory "$($_USERDATA_RELEASEBUILDS_PATH_)") -eq $false)
    {
        # Directory could not be created.
        return $false;
    } # If : Program Output Release Builds Directory Created

    # ----

    # Program Output Dev. Builds Directory
    if((MakeDirectory "$($_USERDATA_DEVBUILDS_PATH_)") -eq $false)
    {
        # Directory could not be created.
        return $false;
    } # If : Program Output Dev. Builds Directory Created



    # Program-Data Directories
    # ++++++++++++++++++++++++++
    # ++++++++++++++++++++++++++


    # Program Data Root [Local]
    if((MakeDirectory "$($_PROGRAMDATA_ROOT_LOCAL_PATH_)") -eq $false)
    {
        # Directory could not be created.
        return $false;
    } # If : Program Data Root [Local]

    # ----

    # Program Data Logs [Local]
    if((MakeDirectory "$($_PROGRAMDATA_LOGS_PATH_)") -eq $false)
    {
        # Directory could not be created.
        return $false;
    } # If : Program Data Logs [Local]

    # ----

    # Program Data Root [Roaming]
    if((MakeDirectory "$($_PROGRAMADATA_ROOT_ROAMING_PATH_)") -eq $false)
    {
        # Directory could not be created.
        return $false;
    } # If : Program Data Configs [Local]

    # ----

    # Program Data Configs [Roaming]
    if((MakeDirectory "$($_PROGRAMDATA_CONFIGS_PATH_)") -eq $false)
    {
        # Directory could not be created.
        return $false;
    } # If : Program Data Configs [Local]



    # Return the Exit status if successful
    return $true;
} # CreateDirectories()




# Check Program Directories
# -------------------------------
# Documentation:
#  This function will check to make sure that the
#   required directories exists within the user's
#   filesystem.
#
# ----
#
#  Directories to Check:
#   - User-Data Domain
#    - %HomePath%\Documents\<PROG_NAME>
#    - %HomePath%\Documents\<PROG_NAME>\Builds
#    - %HomePath%\Documents\<PROG_NAME>\Builds\Release
#    - %HomePath%\Documents\<PROG_NAME>\Builds\Development
#
#   - Program-Data Domain
#    - %LOCALAPPDATA%\<PROG_NAME>
#    - %LOCALAPPDATA%\<PROG_NAME>\Logs
#    - %APPDATA%\<PROG_NAME>
#    - %LOCALAPPDATA%\<PROG_NAME>\Configs
# -------------------------------
# Output:
#  [bool] Exit code
#    $false = One or more directories does not exist.
#    $true = Directories exist
# -------------------------------
function CheckProgramDirectories()
{
    # User-Data Directories
    # -----

    if (((CheckPathExists "$($_USERDATA_ROOT_PATH_)") -eq $true) -and `
        ((CheckPathExists "$($_USERDATA_BUILDS_PATH_)") -eq $true) -and `
        ((CheckPathExists "$($_USERDATA_RELEASEBUILDS_PATH_)") -eq $true) -and `
        ((CheckPathExists "$($_USERDATA_DEVBUILDS_PATH_)") -eq $true))
    {
        # The directories exists.
        #  Nothing to do.
    } # If : Directories Exists

    else
    {
        # The directories does not exist.
        #  Because one or more directories does not exist,
        #  return an error signal.
        return $false;
    } # Else : Directories not exist


    # =====================
    # ---------------------
    # =====================


    # Program-Data Directories
    # ----

    if (((CheckPathExists "$($_PROGRAMDATA_ROOT_LOCAL_PATH_)") -eq $true) -and `
        ((CheckPathExists "$($_PROGRAMDATA_LOGS_PATH_)") -eq $true) -and `
        ((CheckPathExists "$($_PROGRAMADATA_ROOT_ROAMING_PATH_)") -eq $true) -and `
        ((CheckPathExists "$($_PROGRAMDATA_CONFIGS_PATH_)") -eq $true))
    {
        # The directories exists.
        #  Nothing to do.
    } # If : Directories Exists

    else
    {
        # The directories does not exist.
        #  Because one or more directories does not exist,
        #  return an error signal.
        return $false;
    } # Else : Directories not exist


    # =====================
    # ---------------------
    # =====================


    # If we made it this far, then all the directories exists on the filesystem.
    #  Return a success signal.
    return $true;
} # CheckProgramDirectories()




# Check Special Directories
# -------------------------------
# Documentation:
#  This function will check to make sure that the
#   defined special directories exists within the
#   host system.
#  Special Directories are defined as normally
#   provided by the Operating System and usually
#   required for the user's profile.
# -------------------------------
# Output:
#  [bool] Exit Code
#    $false = One or more special directories
#              could not be detected, possibly missing.
#    $true = All special directories exists; no errors. 
# -------------------------------
function CheckSpecialDirectories()
{
    # Declarations and Initializations
    # ----------------------------------------
    [string] $pathMyDocuments = "$(FetchPathUserDocuments)";    # My Documents
    [string] $pathLocalAppData = "$(FetchPathAppDataLocal)";    # Local AppData
    [string] $pathRoamingAppData = "$(FetchPathAppDataRoaming)";# Roaming AppData
    # ----------------------------------------


    # Check the following:
    # My Documents
    if ((CheckPathExists "$($pathMyDocuments)") -eq $false)
    {
        return $false;
    } # If : My Documents


    # ----


    # Local AppData
    if ((CheckPathExists "$($pathLocalAppData)") -eq $false)
    {
        return $false;
    } # If : Local AppData


    # ----


    # Roaming AppData
    if ((CheckPathExists "$($pathRoamingAppData)") -eq $false)
    {
        return $false;
    } # If : Roaming AppData


    # ----


    # Everything was successful
    return $true;
} # CheckSpecialDirectories()




# Make a New Directory
# -------------------------------
# Documentation:
#  This function will make a new directory with the
#   absolute path provided.
# -------------------------------
# Input:
#  [string] Absolute Path
#   The absolute path of a directory that is to be
#   created by request.
# -------------------------------
# Output:
#  [bool] Exit code
#    $false = Failure to create the directory.
#    $true = Successfully created the directory.
#            OR
#            Directory already exists; nothing to do.
# -------------------------------
function MakeDirectory()
{
    # Parameters for this function
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string] $path
    );


    # Declarations and Initializations
    # ----------------------------------------
    [bool] $exitCode = $true;    # Exit code that will be returned.
    # ----------------------------------------


    # Check to see if the path already exists;
    #  if it already exists - then nothing to do.
    #  If it does not exist, then try to create it.
    if ((CheckPathExists "$($path)") -eq $false)
    {
        # The requested path does not exist, try to create it.
        try
        {
            # Try to create the directory; if failure - stop.
            New-Item -Path "$($path)" -ItemType Directory -ErrorAction Stop;
        } # try : Create directory.
        catch
        {
            # Failure occurred.
            $exitCode = $false;
        } # Catch : Failed to Create Directory
    } # If : Directory does not exist


    # Return the exit code
    return $exitCode;
} # MakeDirectory()




# Check Path Exists
# -------------------------------
# Documentation:
#  This function will check if the provided
#   directory (absolute path) exists on the
#   host's filesystem.
# -------------------------------
# Input:
#  [string] Directory (Absolute Path)
#    The path to check if it exists in the
#     filesystem.
# -------------------------------
# Output:
#  [bool] Exit code
#    $false = Directory does not exist.
#    $true = Directory exist
# -------------------------------
function CheckPathExists()
{
    # Parameters for this function
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string] $path
    );


    # Declarations and Initializations
    # ----------------------------------------
    [bool] $exitCode = $false;    # Exit code that will be returned.
    # ----------------------------------------

    # Check if the path exists
    if((Test-Path -LiteralPath "$($path)" -ErrorAction SilentlyContinue) -eq $true)
    {
        # Directory exists
        $exitCode = $true;
    } # If : Directory exists


    # Return with exit code
    return $exitCode;
} # CheckPathExists()