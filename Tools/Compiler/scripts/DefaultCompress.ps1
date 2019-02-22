<# Default Compress
 # ------------------------------
 # ==============================
 # ==============================
 # This class holds settings regarding the use of .NET's
 #  System.IO.Compression (aka: .NET Compression).
 #  Because this was part of .NET 4.5 version and later,
 #  it is now possible for end-user's to use the native
 #  Zip provided - without requiring external API's or
 #  3rd party applications.  This should hypothetically
 #  support all targeted versions of Windows platforms.
 # Requirements: .NET Framework 4.5
 #>



class DefaultCompress
{
    # Member Variables :: Properties
    # =================================================
    # =================================================


    #region Private Variables (emulated)

    # Compression Level
    # ---------------
    # The compression level when generating an
    #  archive datafile.
    Hidden [DefaultCompressionLevel] $__compressionLevel;


    # Verify Build
    # ---------------
    # Test the archive datafile to assure it is not
    #  corrupted.
    Hidden [bool] $__verifyBuild;


    # Generate Report
    # ---------------
    # Generate a report about the archive datafile.
    Hidden [bool] $__generateReport;


    # Log Root
    # ---------------
    # The main root of the log directories.
    Hidden [string] $__rootLogPath;


    # Report Path
    # ---------------
    # The absolute path to store the reports that
    #  has been generated.
    Hidden [string] $__reportPath;


    # Log Root Path
    # ---------------
    # The absolute path to place the logs from the
    #  executable.
    Hidden [string] $__logPath;

    #endregion



    # Member Functions :: Methods
    # =================================================
    # =================================================


    
    #region Constructor Functions
    
    # Default Constructor
    DefaultCompress()
    {
        # Compression Level
        $this.__compressionLevel = 0;

        # Verify Build
        $this.__verifyBuild = $true;

        # Generate report
        $this.__generateReport = $false;

        # Log Root Directory
        $this.__rootLogPath = "$($global:_PROGRAMDATA_LOGS_PATH_)\PSArchive";

        # Report Path
        $this.__reportPath = "$($this.__rootLogPath)\reports";

        # Log Path
        $this.__logPath = "$($this.__rootLogPath)\logs";
        

        # ==================
        # Functions

        # Create the necessary directories
        $this.__CreateDirectories() | Out-Null;
    } # Default Constructor




    # User Preference : On-Load
    DefaultCompress([DefaultCompressionLevel] $compressionLevel,
                    [bool] $verifyBuild,
                    [bool] $generateReport)
    {
        # Compression Level
        $this.__compressionLevel = $compressionLevel;

        # Verify Build
        $this.__verifyBuild = $verifyBuild;

        # Generate report
        $this.__generateReport = $generateReport;

        # Log Root Directory
        $this.__rootLogPath = "$($global:_PROGRAMDATA_LOGS_PATH_)\PSArchive";

        # Report Path
        $this.__reportPath = "$($this.__rootLogPath)\reports";

        # Log Path
        $this.__logPath = "$($this.__rootLogPath)\logs";
        

        # ==================
        # Functions

        # Create the necessary directories
        $this.__CreateDirectories() | Out-Null;
    } # Default Constructor

    #endregion



    #region Getter Functions

   <# Get Compression Level
    # -------------------------------
    # Documentation:
    #  Returns the value of the Compression Level variable.
    # -------------------------------
    # Output:
    #  [DefaultCompressionLevel] Compression Level
    #   the value of the Compression Level.
    # -------------------------------
    #>
    [DefaultCompressionLevel] GetCompressionLevel()
    {
        return $this.__compressionLevel;
    } # GetCompressionLevel()




   <# Get Verify Build
    # -------------------------------
    # Documentation:
    #  Returns the value of the Verify Build variable.
    # -------------------------------
    # Output:
    #  [bool] Verify Build
    #   the value of the Verify Build.
    # -------------------------------
    #>
    [bool] GetVerifyBuild()
    {
        return $this.__verifyBuild;
    } # GetVerifyBuild()




   <# Get Generate Report
    # -------------------------------
    # Documentation:
    #  Returns the value of the Generate Report variable.
    # -------------------------------
    # Output:
    #  [bool] Generate Report
    #   the value of the Generate Report.
    # -------------------------------
    #>
    [bool] GetGenerateReport()
    {
        return $this.__generateReport;
    } # GetGenerateReport()




   <# Get Report Path
    # -------------------------------
    # Documentation:
    #  Returns the value of the Report Path variable.
    # -------------------------------
    # Output:
    #  [string] Report Path
    #   the value of the Report Path.
    # -------------------------------
    #>
    [string] GetReportPath()
    {
        return $this.__reportPath;
    } # GetReportPath()




   <# Get Log Path
    # -------------------------------
    # Documentation:
    #  Returns the value of the Log Path variable.
    # -------------------------------
    # Output:
    #  [string] Log Path
    #   the value of the Log Path.
    # -------------------------------
    #>
    [string] GetLogPath()
    {
        return $this.__logPath;
    } # GetLogPath()




   <# Get Root Log Path
    # -------------------------------
    # Documentation:
    #  Returns the value of the Root Log Path variable.
    # -------------------------------
    # Output:
    #  [string] Root Log Path
    #   the value of the Log Root Path.
    # -------------------------------
    #>
    [string] GetRootLogPath()
    {
        return $this.__rootLogPath;
    } # GetRootLogPath()

    #endregion



    #region Setter Functions

   <# Set Compression Level
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Compression Level variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Success; value has been changed.
    #   false = Failure; could not set a new value.
    # -------------------------------
    #>
    [bool] SetCompressionLevel([DefaultCompressionLevel] $newVal)
    {
        # Because the value must fit within the
        #  'DefaultCompressionLevel' datatype, there really is
        #  no point in checking if the new requested value is
        #  'legal'.  Thus, we are going to trust the value and
        #  automatically return success.
        $this.__compressionLevel = $newVal;

        # Successfully updated.
        return $true;
    } # SetCompressionLevel()




   <# Set Verify Build
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Verify Build variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Success; value has been changed.
    #   false = Failure; could not set a new value.
    # -------------------------------
    #>
    [bool] SetVerifyBuild([bool] $newVal)
    {
        # Because the value is either true or false, there
        #  really is no point in checking if the new requested
        #  value is 'legal'.  Thus, we are going to trust the
        #  value and automatically return success.
        $this.__verifyBuild = $newVal;

        # Successfully updated.
        return $true;
    } # SetVerifyBuild()




   <# Set Generate Report
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Generate Report variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Success; value has been changed.
    #   false = Failure; could not set a new value.
    # -------------------------------
    #>
    [bool] SetGenerateReport([bool] $newVal)
    {
        # Because the value is either true or false, there
        #  really is no point in checking if the new requested
        #  value is 'legal'.  Thus, we are going to trust the
        #  value and automatically return success.
        $this.__generateReport = $newVal;

        # Successfully updated.
        return $true;
    } # SetGenerateReport()




   <# Set Root Log Path
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Root Log Path variable.
    #
    # WARNING:
    #  CHANGING THE PATH CAN CAUSE CONSISTENCY ISSUES!
    #   IT IS RECOMMENDED TO _NOT_ REVISE THIS VARIABLE
    #   UNLESS IT IS ABSOLUTELY NECESSARY!
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Success; value has been changed.
    #   false = Failure; could not set a new value.
    # -------------------------------
    #>
    [bool] SetRootLogPath([string] $newVal)
    {
        # Inspect to see if the path exists
        if (Test-Path $newVal.trim())
        {
            # Path exists; use it as requested
            $this.__rootLogPath = $newVal;
            return $true;
        } # IF: Path Exists

        # Failure; Path does not exist.
        return $false;
    } # SetRootLogPath()




   <# Set Log Path
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Log Path variable.
    #
    # WARNING:
    #  CHANGING THE PATH CAN CAUSE CONSISTENCY ISSUES!
    #   IT IS RECOMMENDED TO _NOT_ REVISE THIS VARIABLE
    #   UNLESS IT IS ABSOLUTELY NECESSARY!
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Success; value has been changed.
    #   false = Failure; could not set a new value.
    # -------------------------------
    #>
    [bool] SetLogPath([string] $newVal)
    {
        # Inspect to see if the path exists
        if (Test-Path $newVal.trim())
        {
            # Path exists; use it as requested
            $this.__logPath = $newVal;
            return $true;
        } # IF: Path Exists

        # Failure; Path does not exist.
        return $false;
    } # SetLogPath()




    <# Set Report Path
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Report Path variable.
    #
    # WARNING:
    #  CHANGING THE PATH CAN CAUSE CONSISTENCY ISSUES!
    #   IT IS RECOMMENDED TO _NOT_ REVISE THIS VARIABLE
    #   UNLESS IT IS ABSOLUTELY NECESSARY!
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Success; value has been changed.
    #   false = Failure; could not set a new value.
    # -------------------------------
    #>
    [bool] SetReportPath([string] $newVal)
    {
        # Inspect to see if the path exists
        if (Test-Path $newVal.trim())
        {
            # Path exists; use it as requested
            $this.__reportPath = $newVal;
            return $true;
        } # IF: Path Exists

        # Failure; Path does not exist.
        return $false;
    } # SetReportPath()

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
    #   - \PSArchive
    #   - \PSArchive\logs
    #   - \PSArchive\reports
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

        # Root Log Directory
        if(($io.CheckPathExists("$($this.__rootLogPath)")) -eq $false)
        {
            # Root Log Directory does not exist, try to create it.
            if (($io.MakeDirectory("$($this.__rootLogPath)")) -eq $false)
            {
                # Failure occurred.
                return $false;
            } # If : Failed to Create Directory
        } # Root Log Directory


        # ----


        # Log Directory
        if(($io.CheckPathExists("$($this.__logPath)")) -eq $false)
        {
            # Root Log Directory does not exist, try to create it.
            if (($io.MakeDirectory("$($this.__logPath)")) -eq $false)
            {
                # Failure occurred.
                return $false;
            } # If : Failed to Create Directory
        } # Log Directory


        # ----


        # Report Directory
        if(($io.CheckPathExists("$($this.__reportPath)")) -eq $false)
        {
            # Root Log Directory does not exist, try to create it.
            if (($io.MakeDirectory("$($this.__reportPath)")) -eq $false)
            {
                # Failure occurred.
                return $false;
            } # If : Failed to Create Directory
        } # Report Directory


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
    #   - \PSArchive
    #   - \PSArchive\logs
    #   - \PSArchive\reports
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


        # Check Root Log Directory
        if ((($io.CheckPathExists("$($this.__rootLogPath)")) -eq $true) -and `

        # Check Report Path
        (($io.CheckPathExists("$($this.__reportPath)")) -eq $true) -and `

        # Check Log Path
        (($io.CheckPathExists("$($this.__logPath)") -eq $true)))
        {
            # All of the directories exists
            return $true;
        } # If : Check Directories Exists

        else
        {
            # Directories does not exist.
            return $false;
        } # Else : Directories does not exist
    } # __CheckRequiredDirectories()




   <# Thrash Logs and Reports
    # -------------------------------
    # Documentation:
    #  This function will expunge the log files as well
    #   as the reports generated by user's request.
    # -------------------------------
    # Input:
    #  [bool] Expunge reports
    #   When true, the reports will be thrashed.
    # -------------------------------
    # Output:
    #  [bool] Exit code
    #   $false = One or more operations failed
    #   $true = Successfully expunged the files.
    #           OR
    #           Directories were not found
    # -------------------------------
    #>
    Hidden [bool] __ThrashLogs([bool] $expungeReports)
    {
        # Declarations and Initializations
        # ----------------------------------------
        [IOCommon] $io = [IOCommon]::new();          # Using functions from IO Common
        [string[]] $extLogs = @('*.err', '*.out');   # Array of log extensions
        [string[]] $extReports = @('*.txt');         # Array of report extensions
        # ----------------------------------------


        # First, make sure that the directories exist.
        #  If the directories are not available, than there
        #  is nothing that can be done.
        if (($this.__CheckRequiredDirectories()) -eq $false)
        {
            # This is not really an error, however the directories simply
            #  does not exist -- nothing can be done.
            return $true;
        } # IF : Required Directories Exists


        # Because the directories exists, lets try to thrash the logs.
        if(($io.DeleteFile("$($this.__logPath)", $extLogs)) -eq $false)
        {
            # Failure to remove the requested files
            return $false;
        } # If : failure to delete files


        # ----


        # Did the user also wanted to thrash the reports?
        if (($($expungeReports) -eq $true) -and `
        ($io.DeleteFile("$($this.__reportPath)", $extReports)) -eq $false)
        {
            # Failure to remove the requested files
            return $false;
        } # If : thrash the reports



        # If we made it here, then everything went okay!
        return $true;
    } # __ThrashLogs()

    #endregion


    #region Public Functions


   <# Detect Compression Module
    # -------------------------------
    # Documentation:
    #  This function will try to detect if the host
    #   system has the Archive module installed.
    #   This validation is required in order to
    #   utilize the Archive functionality within
    #   the PowerShell and .NET Framework.
    # -------------------------------
    # Output:
    #  [bool] Exit code
    #   $false = Archive module was not detected.
    #   $true = Archive module was successfully detected.
    # -------------------------------
    #>
    [bool] DetectCompressModule()
    {
        # We are going to try to detect if the module
        #  itself is installed and ready within this
        #  PowerShell instance.  If not, we will have
        #  to return 'false'.
        # NOTE: If there is ANY output, than this function will return true.
        # Reference: https://stackoverflow.com/a/28740512
        if ($(Get-Module -ListAvailable -Name Microsoft.PowerShell.Archive))
        {
            # Detected the module
            return $true;
        } # if : Module is installed


        # Because the module was not detected.
        return $false;
    } # DetectCompressModule()



    #region Inspect Archive



   <# Fetch Hash Information
    # -------------------------------
    # Documentation:
    #  This function will retrieve and return
    #   all hash values that is associated with
    #   the archive data file.  Hash values are
    #   essentially a finger print of a specific
    #   file that was generated at a specific time.
    #   If the hash value differs to a specific
    #   file, that could mean that the file is
    #   different (overall) or corrupted.
    # -------------------------------
    # Input:
    #  [string] Archive datafile Path
    #   The archive file that will be inspected.
    #    The path provided should be in absolute
    #    form.
    # -------------------------------
    # Output:
    #  [string] Hash Values
    #    A string list of all hash values
    #    associated with that specific archive
    #    file.
    # -------------------------------
    #>
    [string] FetchHashInformation([string] $file)
    {
        # Declarations and Initializations
        # ----------------------------------------
        [IOCommon] $io = [IOCommon]::new(); # Using functions from IO Common
        [string] $archiveInfo = $null;      # This will hold our list of hash values
        # ----------------------------------------

        # Get all of the hash values that is associated with the archive file.
        $archiveInfo =
                "SHA256:`r`n" + `
                "  $($io.FileHash("$($file)", "sha256"))`r`n`r`n" + `
                "SHA384:`r`n" + `
                "  $($io.FileHash("$($file)", "sha384"))`r`n`r`n" + `
                "SHA512:`r`n" + `
                "  $($io.FileHash("$($file)", "sha512"))`r`n`r`n" + `
                "MD5:`r`n" + `
                "  $($io.FileHash("$($file)", "md5"))`r`n`r`n";


        # Return all of the hash values
        return $archiveInfo;
    } # FetchHashInformation()




   <# Verify Archive
    # -------------------------------
    # Documentation:
    #  This function will test the archive data file by making
    #   sure that all of the contents within the archive are
    #   readable.  If the files within the archive are corrupted
    #   or damaged, the test will fail - as the integrity of the
    #   archive file has been compromised.
    #
    # NOTE: Because the .NET Framework does not include a test
    #        functionality, the only way to really perform an
    #        integrity test - we have to extract all of the data.
    #       - Some individuals suggest using 'listing' as a way to
    #         check if the archive file was corrupted.  With my
    #         testing of manipulating an archive file via HexEditor,
    #         I can safely say that it isn't enough.  The best way
    #         to tell if the archive file is corrupted, is to
    #         extract all the contents.  If the extract operation
    #         fails, then the archive file is damaged or corrupted.
    #
    # Extract Information:
    #    https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.archive/Expand-Archive
    # -------------------------------
    #  [string] Target File
    #   The archive file that will be tested upon through the
    #    verification process.
    #  [bool] Logging
    #   User's preference in logging information.
    #    When true, the program will log the
    #    operations performed.
    #   - Does not effect main program logging.
    # -------------------------------
    # Output:
    #  [bool] Exit code
    #    $false = Archive file failed verification process.
    #    $true = Archive file passed verification process
    #             or user did not request the file archive
    #             to be tested.
    # -------------------------------
    #>
    [bool] VerifyArchive([string] $targetFile, [bool] $logging)
    {
        # Declarations and Initializations
        # ----------------------------------------
        [IOCommon] $io = [IOCommon]::new();     # Using functions from IO Common
        [string] $tmpDirectory = $null;         # This will hold the directory path in
                                                #  %TEMP% that we will use to temporarily
                                                #  extract the contents.
        [bool] $testResult = $true;             # This will hold our test result if the
                                                #  operation was successful or failed.
        [string] $pipeErr = $null;              # When an error occurs, this will hold
                                                #  the error message that will be displayed
                                                #  on screen.
        # - - - - - - - - - - -
        # The archive file name; used for the description of the logfiles.
        [string] $targetFileName = "$($(Get-Item $targetFile).Name)";

        # Description; used for logging.
        [string] $execReason = "Verifying $($targetFileName)";

        # This will hold the STDOUT Obj. from PowerShell's CMDLet.
        [System.Object] $execSTDOUT = [System.Object]::new();

        # This will hold the STDERR Obj. from PowerShell's CMDLet.
        [System.Object] $execSTDERR = [System.Object]::new();

        # This will hold the STDOUT as a normal string datatype;
        #  converted output result from the STDOUT Object.
        [string] $strSTDOUT = $null;

        # This will hold the STDERR as a normal string datatype;
        #  Converted output result from the STDERR Object.
        [string] $strSTDERR = $null;
        # ----------------------------------------



        # Dependency Check
        # - - - - - - - - - - - - - -
        #  Make sure that all of the resources are available before trying to use them
        #   This check is to make sure that nothing goes horribly wrong.
        # ---------------------------

        # Check to make sure that the host-system support the archive functionality.
        if ($this.DetectCompressModule() -eq $false)
        {
            # Because the archive support functionality was not found, we can
            #  not proceed.  For the validation process.
            return $false;
        } # if : PowerShell Archive Support Missing


        # Make sure that the target file actually exists
        if ($($io.CheckPathExists("$($targetFile)")) -eq $false)
        {
            # The archive data file does not exist, we can not
            #  test something that simply doesn't exist.  Return
            #  a failure.
            return $false;
        } # if : Target file does not exist

        # ---------------------------
        # - - - - - - - - - - - - - -
        


        # First, lets request a new directory in the %TEMP%;
        #  this is necessary to extract the contents from the
        #  archive file.
        if ($($io.MakeTempDirectory("Verify", [ref] $tmpDirectory)) -eq $false)
        {
            # Because we couldn't make a temporary directory, we
            #  cannot test the archive data file.
            return $false;
        } # if : Failure creating Temp. Directory


        # Secondly, now lets test the archive file by actually extracting all of the contents.
        try
        {
            # Extract the contents
            Expand-Archive -LiteralPath "$($targetFile)" `
                           -DestinationPath "$($tmpDirectory)" `
                           -ErrorAction Stop `
                           -PassThru `
                           -OutVariable execSTDOUT `
                           -ErrorVariable execSTDERR;
        } # try : Execute Extract Task

        # - Error
        catch
        {
            # A failure occurred while extracting the contents, we
            #  will assume that the archive file was corrupted.
            $testResult = $false;

            # Display error
            Write-Host "ERROR CAUGHT: $($_)";
        } # catch : Caught Error in Extract Task

        # - Finally-Do
        finally
        {
            # Thrash the temporary directory, we no longer need it.
            $io.DeleteDirectory("$($tmpDirectory)") | Out-Null;
        } # Final : Delete the temporary data



        # Logging Section
        # =================
        # - - - - - - - - -

        # If the STDOUT contains an array-list, then we will
        #  convert it as a typical string.  If necessary,
        #  add any remarks that should be in the logfile.
        if ($execSTDOUT -ne $null)
        {
            # Because some data exists in the STDOUT, we will
            #  now try to make it readable in the logfile.  We
            #  want to assure that if the user does look over
            #  the logfile - they should be able to understand
            #  it clearly.
                
            # HEADER
            # - - - - - -
            # Logfile Header

            $strSTDOUT = "Successfully verified archive data file named $($targetFileName).`r`n" + `
                            "Below is a list files that resides within the archive file and has been tested:`r`n" + `
                            "`r`n" + `
                            " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -`r`n" + `
                            "`r`n";

            # BODY
            # - - - - - -
            # Logfile Body (List of files)

            foreach ($item in $execSTDOUT)
            {
                $strSTDOUT = "$($strSTDOUT)" + `
                                "File: $([string]$($item))`r`n";
            } # foreach : File in List

            # FOOTER
            # - - - - - -
            # Logfile Footer
            $strSTDOUT = "$($strSTDOUT)" + `
                            "`r`n" + `
                            "`r`n" + `
                            " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -`r`n";
        } # if : STDOUT Is not null



        # If the STDERR contains information, then store
        #  it as a standard string datatype.  Luckily the
        #  informaiton provided within the object requires
        #  no real changes or data manipulation, we can
        #  just cast it and it works like magic!  I love
        #  the simplicity!
        if ($execSTDERR -ne $null)
        {
            # No need to filter or manipulate the data, just
            #  cast it as is.  Everything we need is already
            #  available and readable.
            $strSTDERR = "$([string]$($execSTDERR))";
        } # if : STDERR Is not null


        # Create the logfiles
        $io.PSCMDLetLogging($this.__logPath, `
                            $this.__logPath, `
                            $this.__reportPath, `
                            $logging, `
                            $false, `
                            $false, `
                            "$($execReason)", `
                            $null, `
                            [ref] $strSTDOUT, `
                            [ref] $strSTDERR );

        
        # - - - - - - - - -
        # =================


        # Return the results
        return $testResult;
    } # VerifyArchive()




   <# List Files in Archive
    # -------------------------------
    # Documentation:
    #  This function will list all of the files that are
    #   within the target archive data file.
    #
    #  List Files Information:
    #    https://stackoverflow.com/a/14204577
    # -------------------------------
    # Input:
    #  [string] Target File
    #   The archive file that will contain the files that we
    #    want to list.
    #  [bool] Show Technical Information
    #   When true, this will show all of the technical
    #    information regarding each file within the data
    #    archive file.
    #   Technical Information will contain some of the following:
    #    - CRC32 checksum
    #    - FullName
    #    - Name
    #    - Compressed Size
    #    - Size
    #    - Last Write-Time
    #  [bool] Logging
    #   User's preference in logging information.
    #    When true, the program will log the
    #    operations performed.
    #   - Does not effect main program logging.
    # -------------------------------
    # Output:
    #  [string] File List
    #    List of files that exists within the archive data file.
    #    NOTE: "ERR" signifies that an error occurred.
    # -------------------------------
    #>
    [string] ListFiles([string] $file, [bool] $showTechInfo, [bool] $logging)
    {
        # Declarations and Initializations
        # ----------------------------------------
        [IOCommon] $io = [IOCommon]::new();                         # Using functions from IO Common
        [System.IO.Compression.ZipArchive] $archiveData = $null;    # This will hold the archive data file information
        [string] $strFileList = $null;                              # This will contain a list of files that is within
                                                                    #  the source archive file, with or without
                                                                    #  technical information.
        # ----------------------------------------


        # Dependency Check
        # - - - - - - - - - - - - - -
        #  Make sure that all of the resources are available before trying to use them
        #   This check is to make sure that nothing goes horribly wrong.
        # ---------------------------

        # Check to make sure that the host-system support the archive functionality.
        if ($this.DetectCompressModule() -eq $false)
        {
            # Because the archive support functionality was not found, we can
            #  not proceed.  For the validation process.
            return "ERR";
        } # if : PowerShell Archive Support Missing


        # Make sure that the archive file actually exists
        if ($($io.CheckPathExists("$($file)")) -eq $false)
        {
            # The archive data file does not exist, we can not
            #  examine something that simply doesn't exist.  Return
            #  a failure.
            return "ERR";
        } # if : Target file does not exist

        # ---------------------------
        # - - - - - - - - - - - - - -


        # Read the file information that currently exists within the source
        #  archive data file.
        $archiveData = $([IO.Compression.ZipFile]::OpenRead("$($file)"));


        # Now determine what kind of information was requested:
        # Technical Information
        if ($showTechInfo -eq $true)
        {
            # The user requested to view the technical information.
            foreach ($item in $archiveData.Entries)
            {
                # Iterate through each object in the ZipArchive type
                #  and save all information regarding each entry.
                $strFileList = "$($strFileList)" + `
                                $($item | Out-String | Foreach-Object {$_});
            } # foreach : Get technical info. for each file entry
        } # if : Technical Information

        # Simple File Information
        else
        {
            # The user requested to view only the list of files.
            foreach ($item in $archiveData.Entries)
            {
                # Save the file name.
                $strFileList = "$($strFileList)" + `
                                "File: " + $item.FullName + `
                                "`r`n";
            } # foreach : Get files in each file entry
        } # else : Standard File List


        # Return the file list
        return $strFileList;
    } # ListFiles()


    #endregion
    #endregion
} # DefaultCompress




<# Default Compression Level [ENUM]
 # -------------------------------
 # Associated with what type of compression level the
 #  end-user prefers when compacting an archive datafile.
 # -------------------------------
 #>
enum DefaultCompressionLevel
{
    Optimal = 0;         # Best Compression (takes time)
    Fastest = 1;         # Light Compression (little time)
    NoCompression = 2;   # Store [No Compression]
} # DefaultCompressionLevel