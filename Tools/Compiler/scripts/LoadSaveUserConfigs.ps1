<# Load \ Save User Configuration
 # ------------------------------
 # ==============================
 # ==============================
 # This class will provide the ability to load and save the
 #  user's configurations to or from a specific file location.
 #  This will allow the ability for the user's preferences
 #  and settings from this program to be saved - making it
 #  usable for the next session.  Furthermore, loading from
 #  the user's preferences and settings - essentially picks
 #  up where the user last saved the program.
 #  This process is to be painless and easy as possible,
 #  having the user to reconfigure their settings and
 #  preferences is not only inconvienent but will be extremely
 #  frustrating.  If this functionality doesn't work flawlessly
 #  - then people will no longer use this program.
 #
 # DEVELOPER NOTE: This class does NOT have a 
 #  Default Constructor.  This is because we must have a
 #  legitimate path that is unique to the program.
 #>



 class LoadSaveUserConfiguration
 {
    # Member Variables :: Properties
    # =================================================
    # =================================================


    #region Private Variables (emulated)

    # User Configuration Path
    # ---------------
    # The path in which the user configuration file will be located.
    Hidden [string] $__configPath;


    # User Configuration File
    # ---------------
    # The file name of the user configuration file.
    Hidden [string] $__configFileName;

    #endregion



    # Member Functions :: Methods
    # =================================================
    # =================================================


    #region Constructor Functions

    # User Configuration : On-Load
    LoadSaveUserConfiguration([string] $configPath)
    {
        # Configuration Path
        $this.__configPath = "$($configPath)";
        
        # Configuration Filename
        $this.__configFileName = "UserConfig.xml";


        # ==================
        # Functions

        # Create the necessary directories
        $this.__CreateDirectories() | Out-Null;
    } # User Configuration : On-Load

    #endregion



    #region Getter Functions

   <# Get Configuration File Path
    # -------------------------------
    # Documentation:
    #  Returns the value of the Configuration Path variable.
    # -------------------------------
    # Output:
    #  [string] Path of the Configuration file
    #   the value of the Configuration file.
    # -------------------------------
    #>
    [string] GetConfigPath()
    {
        return $this.__configPath;
    } # GetConfigPath()




   <# Get Configuration Filename
    # -------------------------------
    # Documentation:
    #  Returns the value of the Configuration Filename variable.
    # -------------------------------
    # Output:
    #  [string] Filename of the Configuration file
    #   the value of the Configuration filename.
    # -------------------------------
    #>
    [string] GetConfigFileName()
    {
        return $this.__configFileName;
    } # GetConfigFileName()

    #endregion



    #region Setter Functions

   <# Set Configuration File Path
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Configuration Path variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Success; value has been changed.
    #   false = Failure; could not set a new value.
    # -------------------------------
    #>
    [bool] SetConfigPath([string] $newVal)
    {
        # Declarations and Initializations
        # ----------------------------------------
        [IOCommon] $io = [IOCommon]::new();       # Using functions from IO Common
        # ----------------------------------------


        # Before we can use the newly requested directory, we
        #  must first create it to assure that we can use that
        #  requested path.
        if (($io.MakeDirectory("$($newVal)")) -eq $true)
        {
            # Directory was successfully created, we will now
            #  use that path as requested.
            $this.__configPath = $newVal;

            # Successfully updated
            return $true
        } # If : Successfully Updated Path
                

        # Failure to change value.
        return $false;
    } # SetConfigPath()




    <# Set Configuration Filename
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Configuration Filename variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Success; value has been changed.
    #   false = Failure; could not set a new value.
    # -------------------------------
    #>
    [bool] SetConfigFileName([string] $newVal)
    {
        # Filename of the output file.
        $this.__configFileName = $newVal;

        # Successfully updated.
        return $true;
    } # SetConfigFileName()

    #endregion



    #region Private Functions

   <# Create Directories
    # -------------------------------
    # Documentation:
    #  This function will create the necessary directories
    #   required for this class to operate successfully.
    #  If the directories do not exist, then the directories
    #   are to be created on the user's filesystem.
    #  If the directories does exist, then nothing will be
    #   created nor changed.
    #
    # ----
    #
    #  Directories to be created:
    #   - User Configuration Path <Internal Program Defined>
    # -------------------------------
    # Output:
    #  [bool] Exit code
    #    $false = Failure creating the new directories.
    #    $true  = Successfully created the new directories
    #             OR
    #             Directories already existed, nothing to do.
    # -------------------------------
    #>
    Hidden [bool] __CreateDirectories()
    {
        # Declarations and Initializations
        # ----------------------------------------
        [IOCommon] $io = [IOCommon]::new();       # Using functions from IO Common
        # ----------------------------------------


        # First, check if the directories already exist?
        if(($this.__CheckRequiredDirectories())-eq $true)
        {
            # The directories exist, no action is required.
            return $true;
        } # IF : Check if Directories Exists


        # ----


        # Because one or all of the directories does not exist, we must first
        #  check which directory does not exist and then try to create it.

        # User Configuration Path
        if(($io.CheckPathExists("$($this.__configPath)")) -eq $false)
        {
            # The User Configuration Directory does not exist, try to create it.
            if (($io.MakeDirectory("$($this.__configPath)")) -eq $false)
            {
                # Failure occurred.
                return $false;
            } # If : Failed to Create Directory
        } # User Configuration Path


        # ----


        # Fail-safe; final assurance that the directories have been created successfully.
        if(($this.__CheckRequiredDirectories())-eq $true)
        {
            # The directories exist
            return $true;
        } # IF : Check if Directories Exists

        
        # A general error occurred, the directories could not be created.
        return $false;
    } # __CreateDirectories()




   <# Check Required Directories
    # -------------------------------
    # Documentation:
    #  This function was created to check the directories
    #   that this class requires.
    #
    # ----
    #
    #  Directories to Check:
    #   - User Configuration Path <Internal Program Defined>
    # -------------------------------
    # Output:
    #  [bool] Exit code
    #    $false = One or more directories does not exist.
    #    $true = Directories exist
    # -------------------------------
    #>
    Hidden [bool] __CheckRequiredDirectories()
    {
        # Declarations and Initializations
        # ----------------------------------------
        [IOCommon] $io = [IOCommon]::new();       # Using functions from IO Common
        # ----------------------------------------


        # Check Configuration Path
        if ($io.CheckPathExists("$($this.__configPath)") -eq $true)
        {
            # Required directories exists
            return $true;
        } # If : Check Directories Exists

        else
        {
            # Directories does not exist.
            return $false;
        } # Else : Directories does not exist
    } # __CheckRequiredDirectories()

    #endregion



    #region Public Functions

   <# Save User Configuration
    # -------------------------------
    # Documentation:
    #  This function will allow the ability to save
    #  all of the user's settings and preferences to
    #  a specific file.
    #
    # NOTE:
    #  All program data and objects must be known in
    #   order to use this function!
    # -------------------------------
    # Parameters:
    #  [UserPreferences] User Preferences
    #     User's general preferences when interacting
    #      within the program.
    #  [GitControl] Git Object
    #     User's preferences and settings for using the
    #      Git functionality.
    #  [SevenZip] 7Zip Object
    #     User's preferences and settings for using the
    #      7Zip functionality.
    #  [DefaultCompress] PowerShell's Archive Object
    #     User's preferences and settings for using the
    #      PowerShell Archive functionality.
    # -------------------------------
    # Output:
    #  [bool] Exit code
    #   $false = Failure to write save file.
    #   $true = Successfully wrote the save file.
    # -------------------------------
    #>
    [bool] Save([UserPreferences] $userPref, `
                [GitControl] $gitObj, `
                [SevenZip] $sevenZipObj, `
                [DefaultCompress] $psArchive)
    {
        # Declarations and Initializations
        # ----------------------------------------
        [bool] $exitCode = $false;      # Operation status of the execution performed.
        # ----------------------------------------



        # Dependency Check
        # - - - - - - - - - - - - - -
        #  Make sure that all of the resources are available before trying to use them
        #   This check is to make sure that nothing goes horribly wrong.
        # ---------------------------

        # Make sure that the user config. directory exists
        if ($this.__CheckRequiredDirectories() -eq $false)
        {
            # Because the directory does not exist, try to create it.
            if ($this.__CreateDirectories() -eq $false)
            {
                # Because we could not create the directory, we
                #  can not save the user's configuration.

                # Nothing more can be done, return an error.
                return $false;
            } # Inner-If : Try to Create Directories
        } # If : User Config. Directory Exists

        # ---------------------------
        # - - - - - - - - - - - - - -


        # Try to export the preferences and settings to the requested file.
        try{
            Export-Clixml -Path "$($this.__configPath)\$($this.__configFileName)" `
                          -InputObject @($userPref, $gitObj, $sevenZipObj, $psArchive) `
                          -Encoding UTF8NoBOM `
                          -ErrorAction Stop;

            # Update the status as successful
            $exitCode = $true;
        } # TRY : EXECUTION

        catch
        {
            # Print a message that there was an error
            Write-Host "Error Caught: $($_)";

            # Update the status as failure
            $exitCode = $false;
        } # CATCH : ERROR


        # Return the results
        return $exitCode;
    } # Save()




   <# Load User Configuration
    # -------------------------------
    # Documentation:
    #  This function will allow the ability to load
    #   all of the user's settings and preferences
    #   that was previously stored in a specific
    #   file.
    #
    # NOTE:
    #  All program data and objects will be updated
    #   to adjust to user's preferred settings and
    #   configurations.
    # -------------------------------
    # Parameters:
    #  [ref] {UserPreferences} User Preferences
    #     User's general preferences when interacting
    #      within the program.
    #  [ref] {GitControl} Git Object
    #     User's preferences and settings for using the
    #      Git functionality.
    #  [ref] {SevenZip} 7Zip Object
    #     User's preferences and settings for using the
    #      7Zip functionality.
    #  [ref] {DefaultCompress} PowerShell's Archive Object
    #     User's preferences and settings for using the
    #      PowerShell Archive functionality.
    # -------------------------------
    # Output:
    #  [bool] Exit code
    #   $false = Failure to properly load configuration
    #             file.
    #   $true = Successfully loaded user's configurations.
    # -------------------------------
    #>
    [bool] Load([UserPreferences] $userPref, `
                [GitControl] $gitObj, `
                [SevenZip] $sevenZipObj, `
                [DefaultCompress] $psArchive)
    {
        # Declarations and Initializations
        # -----------------------------------------
        [IOCommon] $io = [IOCommon]::new();     # Using functions from IO Common
        [bool] $exitCode = $false;              # Operation status of the execution performed.
        [Object[]] $cacheUserConfig = $null;    # This will hold the deserialized XML data
                                                #  containing the user's preferred settings and
                                                #  configurations regarding each object.
        # - - - - - - - - - - - - - - - - - - - - -
        # Objects:

        # User Preferences
        [UserPreferences] $userPrefNew = [UserPreferences]::new();

        # Git Settings
        [GitControl] $gitObjNew = [GitControl]::new();

        # 7Zip Settings
        [SevenZip] $sevenZipObjNew = [SevenZip]::new();

        # PowerShell's Archive Settings
        [DefaultCompress] $psArchiveNew = [DefaultCompress]::new();
        # -----------------------------------------



        # Dependency Check
        # - - - - - - - - - - - - - -
        #  Make sure that all of the resources are available before trying to use them
        #   This check is to make sure that nothing goes horribly wrong.
        # ---------------------------

        # Make sure that the file exists at the given location.
        if ($io.CheckPathExists("$($this.__configPath)\$($this.__configFileName)") -eq $false)
        {
            # Because either the file or directory does not exist
            #  at the provided location, we simply can not load
            #  anything.

            # return an error
            return $false;
        } # If : Path exists

        # ---------------------------
        # - - - - - - - - - - - - - -


        # Try to import the preferences and settings from the requested file.
        #  Then try to update all settings to match with user's request.
        try
        {
            $cacheUserConfig = Import-Clixml -Path "$($this.__configPath)\$($this.__configFileName)" `
                                             -ErrorAction Stop;

            # Try to load the user's configuration into the objects safely.
            if ($this.LoadStepWise($cacheUserConfig, `
                                   $userPref, `
                                   $gitObj, `
                                   $sevenZipObj, `
                                   $psArchive) -eq $true)
            {

                # Update the status as successful
                $exitCode = $true;
            } # if : Successfully loaded environment

            # If there was a general failure while loading the environment,
            #  immedately stop - use the current environment.  User might
            #  have to redo the entire environment again and re-save the file.
            else
            {
                # Display error message
                Write-Host "General Error: A failure occurred when trying to " + `
                            "load previously saved user configuration file!";

                # Update the status as failure
                $exitCode = $false;
            } # else : Failure to load environment
        } # TRY : EXECUTION

        catch
        {
            # Print a message that there was an error
            Write-Host "Error Caught: $($_)";

            # Update the status as failure
            $exitCode = $false;
        } # CATCH : ERROR


        # Return the results
        return $exitCode;
    } # Load()




   <# Load User Configuration - Stepwise
    # -------------------------------
    # Documentation:
    #  This function will try to properly load the user's
    #  configuration to the program through a stepwise
    #  process, this is a tedious process but assures that
    #  the settings are accurately loaded into the environment.
    #
    # NOTE:
    #  This function will require validation to assure the
    #  values are 'correct' to the program's specifications,
    #  yet are also what the user wants.  The point of
    #  validation is to assure that if the user variables
    #  changed or contain data that does not meet with the
    #  program's constraints, then the program will
    #  automatically adjust the variables to meet with the
    #  needs that the program is expecting.
    # -------------------------------
    # Parameters:
    #  [Object[]] Cached User Configuration
    #     The user's configuration that was deserialized.
    #  [ref] {UserPreferences} User Preferences
    #     User's general preferences when interacting
    #      within the program.
    #  [ref] {GitControl} Git Object
    #     User's preferences and settings for using the
    #      Git functionality.
    #  [ref] {SevenZip} 7Zip Object
    #     User's preferences and settings for using the
    #      7Zip functionality.
    #  [ref] {DefaultCompress} PowerShell's Archive Object
    #     User's preferences and settings for using the
    #      PowerShell Archive functionality.
    # -------------------------------
    # Output:
    #  [bool] Exit code
    #   $false = Failure to properly load configuration
    #             file.
    #   $true = Successfully loaded user's configurations.
    # -------------------------------
    #>
    [bool] LoadStepWise([Object[]]$cachedUserConfig, `
                        [UserPreferences] $userPref, `
                        [GitControl] $gitObj, `
                        [SevenZip] $sevenZipObj, `
                        [DefaultCompress] $psArchive)
    {
        # STEPWISE ALGORITHM
        # =====================================
        # - - - - - - - - - - - - - - - - - - -
        # =====================================

        # STEP 1 - USER PREFERENCES
        $userPref.__compressionTool      = [int32]  $cachedUserConfig[0][0].__compressionTool;
        $userPref.__logging              = [bool]   $cachedUserConfig[0][0].__logging;
        $userPref.__notificationType     = [int32]  $cachedUserConfig[0][0].__notificationType;
        $userPref.__outputBuildsPath     = [string] $cachedUserConfig[0][0].__outputBuildsPath;
        $userPref.__projectPath          = [string] $cachedUserConfig[0][0].__projectPath;
        $userPref.__ringMyDingaling      = [bool]   $cachedUserConfig[0][0].__ringMyDingaling;
        $userPref.__useGitFeatures       = [bool]   $cachedUserConfig[0][0].__useGitFeatures;
        $userPref.__useWindowsExplorer   = [bool]   $cachedUserConfig[0][0].__useWindowsExplorer;

        write-host "$($([int32]$cachedUserConfig[0][1].__changelogLimit))"
        # STEP 2 - GIT SETTINGS
        $gitObj.__changelogLimit         = [int32]  $cachedUserConfig[0][1].__changelogLimit;
        $gitObj.__executablePath         = [string] $cachedUserConfig[0][1].__executablePath;
        $gitObj.__fetchChangelog         = [bool]   $cachedUserConfig[0][1].__fetchChangelog;
        $gitObj.__fetchCommitID          = [bool]   $cachedUserConfig[0][1].__fetchCommitID;
        $gitObj.__generateReport         = [bool]   $cachedUserConfig[0][1].__generateReport;
        $gitObj.__lengthCommitID         = [int32]  $cachedUserConfig[0][1].__lengthCommitID;
        $gitObj.__logPath                = [string] $cachedUserConfig[0][1].__logPath;
        $gitObj.__reportPath             = [string] $cachedUserConfig[0][1].__reportPath;
        $gitObj.__rootLogPath            = [string] $cachedUserConfig[0][1].__rootLogPath;
        $gitObj.__updateSource           = [bool]   $cachedUserConfig[0][1].__updateSource;


        # STEP 3 - 7ZIP SETTINGS
        $sevenZipObj.__algorithm7Zip     = [int32]  $cachedUserConfig[0][2].__algorithm7Zip;
        $sevenZipObj.__algorithmZip      = [int32]  $cachedUserConfig[0][2].__algorithmZip;
        $sevenZipObj.__compressionLevel  = [int32]  $cachedUserConfig[0][2].__compressionLevel;
        $sevenZipObj.__compressionMethod = [int32]  $cachedUserConfig[0][2].__compressionMethod;
        $sevenZipObj.__executablePath    = [string] $cachedUserConfig[0][2].__executablePath;
        $sevenZipObj.__generateReport    = [bool]   $cachedUserConfig[0][2].__generateReport;
        $sevenZipObj.__logPath           = [string] $cachedUserConfig[0][2].__logPath;
        $sevenZipObj.__reportPath        = [string] $cachedUserConfig[0][2].__reportPath;
        $sevenZipObj.__rootLogPath       = [string] $cachedUserConfig[0][2].__rootLogPath;
        $sevenZipObj.__useMultithread    = [bool]   $cachedUserConfig[0][2].__useMultithread;
        $sevenZipObj.__verifyBuild       = [bool]   $cachedUserConfig[0][2].__verifyBuild;


        # STEP 4 - POWERSHELL'S ARCHIVE SETTINGS
        $psArchive.__compressionLevel    = [int32]  $cachedUserConfig[0][3].__compressionLevel;
        $psArchive.__generateReport      = [bool]   $cachedUserConfig[0][3].__generateReport;
        $psArchive.__logPath             = [string] $cachedUserConfig[0][3].__logPath;
        $psArchive.__reportPath          = [string] $cachedUserConfig[0][3].__reportPath;
        $psArchive.__rootLogPath         = [string] $cachedUserConfig[0][3].__rootLogPath;
        $psArchive.__verifyBuild         = [bool]   $cachedUserConfig[0][3].__verifyBuild;


        # Everything was okay, return successful operation
        return $true;
    } # LoadStepWise()
    #endregion
 } # LoadSaveUserConfiguration