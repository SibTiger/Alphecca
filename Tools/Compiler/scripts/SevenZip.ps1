<# Seven Zip
 # ------------------------------
 # ==============================
 # ==============================
 # This class holds settings regarding the use of 7Zip
 #  aswell as functions in order to perform specific
 #  operations relating to compacting archive datafiles.
 #  This is an optional setting and must be enabled by
 #  the user in order to use it.
 # NOTE: This is required in order to generate 7Z (PK7)
 #   archive data files.
 # IMPORTANT NOTE:
 #  In order to use 7Zip features in this program, the
 #   end-user must also have 7Zip installed on the host
 #   system.  If the program is not installed, then the
 #   features are not available for use.
 #>




class SevenZip
{
    # Member Variables :: Properties
    # =================================================
    # =================================================


    #region Private Variables (emulated)

    # 7Zip Executable Path
    # ---------------
    # The path in which the executable '7z.exe' resides.
    Hidden [string] $__executablePath;


    # Compression Method
    # ---------------
    # The method in which to compact the archive datafile.
    Hidden [SevenZipCompressionMethod] $__compressionMethod;


    # Algorithm [PK3|Zip]
    # ---------------
    # The algorithm to use when using the Zip Method
    Hidden [SevenZipAlgorithmZip] $__algorithmZip;


    # Algorithm [PK7|7Zip]
    # ---------------
    # The algorithm to use when using the 7Zip Method
    Hidden [SevenZipAlgorithm7Zip] $__algorithm7Zip;


    # Use Multithread
    # ---------------
    # When true, this will allow 7Zip to use multithreaded
    #  operations when available.
    Hidden [bool] $__useMultithread;


    # Compression Level
    # ---------------
    # How tightly to compact the files.
    Hidden [SevenCompressionLevel] $__compressionLevel;


    # Provide Hash
    # ---------------
    # Retrieve the Hash of the archive datafile.
    Hidden [bool] $__provideHash;


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
    SevenZip()
    {
        # 7z.exe Path
        $this.__executablePath = "$($this.Find7Zip())";

        # Compression Method
        $this.__compressionMethod = 0;

        # Algorithm [Zip]
        $this.__algorithmZip = 0;

        # Algorithm [7Zip]
        $this.__algorithm7Zip = 0;

        # Multithread
        $this.__useMultithread = $true;

        # Compress Level
        $this.__compressionLevel = 2;

        # Provide Hash
        $this.__provideHash = $false;

        # Verify Build
        $this.__verifyBuild = $true;

        # Generate Report
        $this.__generateReport = $false;

        # Log Root Directory
        $this.__rootLogPath = "$($global:_PROGRAMDATA_LOGS_PATH_)\7Zip";

        # Report Path
        $this.__reportPath = "$($this.__rootLogPath)\reports";

        # Log Path
        $this.__logPath = "$($this.__rootLogPath)\logs";
    } # Default Constructor




    # User Preference : On-Load
    SevenZip([string] $executablePath,
            [SevenZipCompressionMethod] $compressionMethod,
            [SevenZipAlgorithmZip] $algorithmZip,
            [SevenZipAlgorithm7Zip] $algorithm7Zip,
            [bool] $useMultithread,
            [SevenCompressionLevel] $compressionLevel,
            [bool] $provideHash,
            [bool] $verifyBuild,
            [bool] $generateReport)
    {
        # 7z.exe Path
        $this.__executablePath = $executablePath;

        # Compression Method
        $this.__compressionMethod = $compressionMethod;

        # Algorithm [Zip]
        $this.__algorithmZip = $algorithmZip;

        # Algorithm [7Zip]
        $this.__algorithm7Zip = $algorithm7Zip;

        # Multithread
        $this.__useMultithread = $useMultithread;

        # Compress Level
        $this.__compressionLevel = $compressionLevel;

        # Provide Hash
        $this.__provideHash = $provideHash;

        # Verify Build
        $this.__verifyBuild = $verifyBuild;

        # Generate Report
        $this.__generateReport = $generateReport;

        # Log Root Directory
        $this.__rootLogPath = "$($global:_PROGRAMDATA_LOGS_PATH_)\7Zip";

        # Report Path
        $this.__reportPath = "$($this.__rootLogPath)\reports";

        # Log Path
        $this.__logPath = "$($this.__rootLogPath)\logs";
    } # User Preference : On-Load

    #endregion



    #region Getter Functions

    <# Get Executable Path
    # -------------------------------
    # Documentation:
    #  Returns the value of the Executable Path variable.
    # -------------------------------
    # Output:
    #  [string] Executable Path
    #   the value of the Executable Path to 7z.exe.
    # -------------------------------
    #>
    [string] GetExecutablePath()
    {
        return $this.__executablePath;
    } # GetExecutablePath()




   <# Get Compression Method
    # -------------------------------
    # Documentation:
    #  Returns the value of the Compression Method variable.
    # -------------------------------
    # Output:
    #  [SevenZipCompressionMethod] Compression Method
    #   the value of the Compression Method.
    # -------------------------------
    #>
    [SevenZipCompressionMethod] GetCompressionMethod()
    {
        return $this.__compressionMethod;
    } # GetCompressionMethod()




   <# Get Algorithm [PK3|Zip]
    # -------------------------------
    # Documentation:
    #  Returns the value of the Algorithm variable.
    # -------------------------------
    # Output:
    #  [SevenZipAlgorithmZip] Algorithm [ZIP]
    #   the value of the Compression Algorithm.
    # -------------------------------
    #>
    [SevenZipAlgorithmZip] GetAlgorithmZip()
    {
        return $this.__algorithmZip;
    } # GetAlgorithmZip()




   <# Get Algorithm [PK7|7Zip]
    # -------------------------------
    # Documentation:
    #  Returns the value of the Algorithm variable.
    # -------------------------------
    # Output:
    #  [SevenZipAlgorithm7Zip] Algorithm [7Zip]
    #   the value of the Compression Algorithm.
    # -------------------------------
    #>
    [SevenZipAlgorithm7Zip] GetAlgorithm7Zip()
    {
        return $this.__algorithm7Zip;
    } # GetAlgorithm7Zip()




   <# Get Use Multithread
    # -------------------------------
    # Documentation:
    #  Returns the value of the Use Multithread variable.
    # -------------------------------
    # Output:
    #  [bool] Use Multithread
    #   the value of the Use Multithread.
    # -------------------------------
    #>
    [bool] GetUseMultithread()
    {
        return $this.__useMultithread;
    } # GetUseMultithread()




   <# Get Compression Level
    # -------------------------------
    # Documentation:
    #  Returns the value of the Compression Level variable.
    # -------------------------------
    # Output:
    #  [SevenCompressionLevel] Compression Level
    #   the value of the Compression Level.
    # -------------------------------
    #>
    [SevenCompressionLevel] GetCompressionLevel()
    {
        return $this.__compressionLevel;
    } # GetCompressionLevel()




   <# Get Provide Hash
    # -------------------------------
    # Documentation:
    #  Returns the value of the Provide Hash variable.
    # -------------------------------
    # Output:
    #  [bool] Provide Hash
    #   the value of the Provide Hash.
    # -------------------------------
    #>
    [bool] GetProvideHash()
    {
        return $this.__provideHash;
    } # GetProvideHash()




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

   <# Set Executable Path
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Executable Path variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Success; value has been changed.
    #   false = Failure; could not set a new value.
    # -------------------------------
    #>
    [bool] SetExecutablePath([string] $newVal)
    {
        # Declarations and Initializations
        # ----------------------------------------
        [IOCommon] $io = [IOCommon]::new();       # Using functions from IO Common
        # ----------------------------------------

        # Because we are testing for an actual file,
        #  we have to assure that the file really exists
        #  within the host's filesystem.
        if(($io.DetectCommand("$($newVal)", "Application")) -eq $false)
        {
            # Could not find the executable.
            return $false;
        } # If : Command Not Found


        # Set the path
        $this.__executablePath = $newVal;

        # Successfully updated.
        return $true;
    } # SetExecutablePath()




   <# Set Compression Method
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Compression Method variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Success; value has been changed.
    #   false = Failure; could not set a new value.
    # -------------------------------
    #>
    [bool] SetCompressionMethod([SevenZipCompressionMethod] $newVal)
    {
        # Because the value must fit within the
        #  'SevenZipCompressionMethod' datatype, there really is
        #  no point in checking if the new requested value is
        #  'legal'.  Thus, we are going to trust the value and
        #  automatically return success.
        $this.__compressionMethod = $newVal;

        # Successfully updated.
        return $true;
    } # SetCompressionMethod()




   <# Set Algorithm [PK3|Zip]
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Algorithm variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Success; value has been changed.
    #   false = Failure; could not set a new value.
    # -------------------------------
    #>
    [bool] SetAlgorithmZip([SevenZipAlgorithmZip] $newVal)
    {
        # Because the value must fit within the
        #  'SevenZipAlgorithmZip' datatype, there really is
        #  no point in checking if the new requested value is
        #  'legal'.  Thus, we are going to trust the value and
        #  automatically return success.
        $this.__algorithmZip = $newVal;

        # Successfully updated.
        return $true;
    } # SetAlgorithmZip()




   <# Set Algorithm [PK7|7Zip]
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Algorithm variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Success; value has been changed.
    #   false = Failure; could not set a new value.
    # -------------------------------
    #>
    [bool] SetAlgorithm7Zip([SevenZipAlgorithm7Zip] $newVal)
    {
        # Because the value must fit within the
        #  'SevenZipAlgorithm7Zip' datatype, there really is
        #  no point in checking if the new requested value is
        #  'legal'.  Thus, we are going to trust the value and
        #  automatically return success.
        $this.__algorithm7Zip = $newVal;

        # Successfully updated.
        return $true;
    } # SetAlgorithm7Zip()




   <# Set Use Multithread
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Use Multithread variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Success; value has been changed.
    #   false = Failure; could not set a new value.
    # -------------------------------
    #>
    [bool] SetUseMultithread([bool] $newVal)
    {
        # Because the value is either true or false, there
        #  really is no point in checking if the new requested
        #  value is 'legal'.  Thus, we are going to trust the
        #  value and automatically return success.
        $this.__useMultithread = $newVal;

        # Successfully updated.
        return $true;
    } # SetUseMultithread()




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
    [bool] SetCompressionLevel([SevenCompressionLevel] $newVal)
    {
        # Because the value must fit within the
        #  'SevenCompressionLevel' datatype, there really is
        #  no point in checking if the new requested value is
        #  'legal'.  Thus, we are going to trust the value and
        #  automatically return success.
        $this.__compressionLevel = $newVal;

        # Successfully updated.
        return $true;
    } # SetCompressionLevel()




   <# Set Provide Hash
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Provide Hash variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Success; value has been changed.
    #   false = Failure; could not set a new value.
    # -------------------------------
    #>
    [bool] SetProvideHash([bool] $newVal)
    {
        # Because the value is either true or false, there
        #  really is no point in checking if the new requested
        #  value is 'legal'.  Thus, we are going to trust the
        #  value and automatically return success.
        $this.__provideHash = $newVal;

        # Successfully updated.
        return $true;
    } # SetProvideHash()




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


   <# Check Required Directories
    # -------------------------------
    # Documentation:
    #  This function was created to check the directories
    #   that this class requires.
    #
    # ----
    #
    #  Directories to Check:
    #   - \7Zip
    #   - \7Zip\logs
    #   - \7Zip\reports
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
    #   - \7Zip
    #   - \7Zip\logs
    #   - \7Zip\reports
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
    



   <# Supported Hash Algorithms
    # -------------------------------
    # Documentation:
    #  This function will check to make sure
    #   that hash algorithm is supported in 7Zip.
    #
    #  List of available Hash Algorithms:
    #   https://sevenzip.osdn.jp/chm/cmdline/commands/hash.htm
    # -------------------------------
    # Input:
    #  [string] Requested Hash Algorithm
    #    This will contain the requested algorithm to be used
    #     in 7Zip.  This will be checked against a list of
    #     available algorithms known to be supported.
    # -------------------------------
    # Output:
    #  [bool] Supported Status
    #    $false = The hash algorithm requested is not supported.
    #    $true  = The hash algorithm requested is supported.
    # -------------------------------
    #>
    hidden [bool] __SupportedHashAlgorithms([string] $hashAlgo)
    {
        # Declarations and Initializations
        # ----------------------------------------
        [string[]] $knownAlgos = @("crc32", `
                                   "crc64", `
                                   "sha1", `
                                   "sha256", `
                                   "blake2sp");
        # ----------------------------------------


        # Scan the list against the requested hash algorithm
        foreach ($algo in $knownAlgos)
        {
            # Scan through the list and compare each algorithm
            #  against the requested hash algorithm.
            if ("$($algo)" -eq "$($hashAlgo)")
            {
                # The requested algo is supported.
                return $true
            } # if : Algos Matches
        } # foreach : Compare Algos


        # We didn't find a match, return false.
        return $false;
    } # __SupportedHashAlgorithms()

    #endregion
    
    
    #region Public Functions
    
    #region 7Zip Detection

   <# Detect 7Zip Executable
    # -------------------------------
    # Documentation:
    #  This function will check if the 7Zip executable
    #   was detected.  To accomplish this, we will
    #   investigate the dedicated variable that
    #   contains the path and determine if the path
    #   is valid or not.
    # -------------------------------
    # Output:
    #  [bool] Detected Code
    #    $false = Failure to detect the external executable.
    #    $true  = Successfully detected the external executable.
    # -------------------------------
    #>
    [bool] Detect7ZipExist()
    {
        # Declarations and Initializations
        # ----------------------------------------
        [IOCommon] $io = [IOCommon]::new();       # Using functions from IO Common
        # ----------------------------------------

        # Make sure that it is not null
        if ($this.__executablePath -eq $null)
        {
            # Executable does not exist or was not set properly.
            #  Return false to signify that it doesn't exist.
            return $false;
        } # if : Executable Path is Null
        
        
        # Check if the 7Zip executable was found
        if (($io.DetectCommand("$($this.__executablePath)", "Application")) -eq $true)
        {
            return $true;
        } # If : Detected
        else
        {
            return $false;
        } # Else : Not Detected
    } # Detect7ZipExist()




   <# Find 7Zip
    # -------------------------------
    # Documentation:
    #  This function will try to find the 7Zip executable by
    #   checking the common locations within the host's
    #   filesystem.
    # -------------------------------
    # Output:
    #  [string] 7Zip.exe Absolute Path
    #    $null = When the path was not discoverable,
    #             then '$null' will be returned.
    # -------------------------------
    #>
    [string] Find7Zip()
    {
        # Declarations and Initializations
        # ----------------------------------------
        [IOCommon] $io = [IOCommon]::new();                         # Using functions from IO Common
        [string[]] $path = @("7z.exe",`                             # Location: %PATH%
                             "7za.exe", `                           # Location: %PATH% {7Zip CLI; Stand-Alone}
                         "${env:PROGRAMFILES}\7-Zip\7z.exe", `      # Location: %ProgramFiles%       {x86_32}
                         "${env:PROGRAMFILES(x86)}\7-Zip\7z.exe");  # Location: %ProgramFiles(x86)%  {x86_64}
        # ----------------------------------------


        # Inspect each path in the array
        foreach ($index in $path)
        {
            # Test if the executable exists at the given path
            if($io.DetectCommand("$($index)", "Application") -eq $true)
            {
                # We found the executable, return its location.
                return "$($index)";
            } # if : Command Detected
        } # Foreach : Path


        # If and only if the executable was not found,
        #  than will signify that we couldn't find it.
        return $null;
    } # Find7Zip()

    #endregion


    #region Archive File Management

   <# Archive-File Hash
    # -------------------------------
    # Documentation:
    #  This function will try to get the archive data
    #   file's hash value directly from 7Zip.  In addition,
    #   if the archive file is corrupted or the output
    #   provided is not what we are expecting, this algorithm
    #   will return an error message or 'ERR'.
    #
    # NOTE: Because 7Zip does NOT have a simple clean
    #       way of just outputting the hash value only, we
    #       have to manipulate the text a bit by using some
    #       RegEx!
    # -------------------------------
    # Input:
    #  [string] Target File
    #   The archive file that will be used by 7Zip to get the hash value.
    #  [string] Hashing Algorithm
    #   The supported Hash Algorithm that will be used in 7Zip.
    #    NOTE: For a list of supported algorithms, please check this website:
    #          https://sevenzip.osdn.jp/chm/cmdline/commands/hash.htm
    #  [bool] Logging
    #   User's preference in logging information.
    #    When true, the program will log the
    #    operations performed.
    #   - Does not effect main program logging.
    # -------------------------------
    # Output:
    #  [string] Hash Value
    #    ERR = Error; Unable to get the hash-value or the
    #             archive data file is corrupted.
    # -------------------------------
    #>
    [string] ArchiveHash([string] $file, [string] $hashAlgorithm, [bool] $logging)
    {
        # Declarations and Initializations
        # ----------------------------------------
        [IOCommon] $io = [IOCommon]::new();                         # Using functions from IO Common
        [string] $sourceDir = "$($(Get-Item $file).DirectoryName)"  # Working Directory when executing the
                                                                    #  extCMD.
        [string] $extCMDArgs = "h -scrc$($hashAlgorithm) $($file)"; # Arguments for the external command
                                                                    #  This will get 7zip to generate the
                                                                    #  requested hash value.
        [string] $outputResult = $null;                             # Holds the hash value provided by the
                                                                    #  extCMD 7z
        [string] $execReason = "Generate $($hashAlgorithm) Hash";   # Description; used for logging
        # ----------------------------------------



        # Dependency Check
        # - - - - - - - - - - - - - -
        #  Make sure that all of the resources are available before trying to use them
        #   This check is to make sure that nothing goes horribly wrong.
        # ---------------------------

        # Make sure that the 7Zip executable was detected.
        if ($($this.Detect7ZipExist()) -eq $false)
        {
            # 7Zip was not detected.
            return "ERR";
        } # if : 7Zip was not detected


        # Make sure that the requested hash algorithm is
        #  supported before trying to use it.
        if ($this.__SupportedHashAlgorithms($hashAlgorithm) -eq $false)
        {
            # The requested hash algorithm is not supported;
            #  we can not use it.
            return "ERR";
        } # if : Hash Algorithm not Supported

        # ---------------------------
        # - - - - - - - - - - - - - -


        # Execute the command and cache the value
        if ($($io.ExecuteCommand("$($this.__executablePath)", `
                            "$($extCMDArgs)", `
                            "$($sourceDir)", `
                            "$($this.__logPath)", `
                            "$($this.__logPath)", `
                            "$($this.__reportPath)", `
                            "$($execReason)", `
                            $logging, `
                            $false, `
                            $true, `
                            [ref]$outputResult)) -ne 0)
        {
            # 7Zip closed with an error
            return "ERR";
        } # if : 7Zip Closed with Error


        # Evaluation Requirement Check
        # - - - - - - - - - - - - - -
        # Before we perform some various operations using Regular Expression,
        #  we first need to make sure that the output result meets the basic
        #  requirements.  Requirements are the following:
        #   - The data is NOT null or empty
        #   - The data contains an expected key phrase, which is necessary to
        #      recognize that the output is correct.  All other values could mean
        #      that the file was corrupted, unsupported hash value, or anything else.
        #  If the requirements are not meant, then it is not possibly to get the
        #   hash value.
        # ---------------------------

        # Just for assurance, make sure that we actually have some
        #  sort of data to work with before trying to evaluate it.
        if ("$($outputResult)" -eq "$($null)")
        {
            # The output cannot be evaluated; there's nothing to
            #  inspect.
            return "ERR";
        } # if : Output Result is Empty


        # The most important part, can we try to pick up the key-phrase?
        #  If we have that key-phrase - we have the correct output to evaluate
        # KEY-PHRASE(RegEx): Everything\ is\ Ok\r\n$
        if ($($($outputResult) -match "Everything Is Ok`r`n$") -eq $false)
        {
            # The key-phrase was not detected, we cannot evaluate the text.
            return "ERR";
        } # if : Key-Phrase not Detected

        # ---------------------------
        # - - - - - - - - - - - - - -


        # Now, to do some RegEx'ing!
        # - - - - - - - - - - - - - -
        # ---------------------------
        # To make this easier to follow, we will do one step at a time.
        #  This is essentially a brute-force method, but best for post-maintenance.
        #  This might be a bit costly in performance - but it is also important
        #  to know how the algorithm is implemented.  If something breaks in the
        #  future we need to know how to resolve the issue, and step-wise is more
        #  easier to work with in this matter - especially more with RegEx operations.


        # REGEX PASS 1
        # Replace 'Everything is Okay' with nothing
        #  NOTE: PowerShell RegEx Commands
        #   `r`n = New Line
        #      $ = End of Line
        $outputResult = $($outputResult -replace "`r`n`r`nEverything Is Ok`r`n$", "")


        # REGEX PASS 2
        # We now want to home-in on our target, which is our Hash Value.
        #  Check to make sure we are locked into the hash value explicitly,
        #  if not - we got something else unexpectedly.
        if ("$($($outputResult) -match "\s\w+$")" -eq $false)
        {
            # We got a value that was not expected, immediately leave
            #  and return an error.
            return "ERR";
        } # if : Unexpected Value Reached - Error


        # FINAL
        # Get the final result, which should now only be the hash value itself.
        # Because we reached the end and we have the hash value, simply return it.
        return "$($matches[0])"
    } # ArchiveHash()




   <# Verify Archive
    # -------------------------------
    # Documentation:
    #  This function will test the archive datafile by making sure
    #   that it is not damaged or corrupted.  To do this, we will
    #   use 7Zip's Verification functionality.
    #
    #  Test Integrity Informatoin:
    #    https://sevenzip.osdn.jp/chm/cmdline/commands/test.htm
    # -------------------------------
    # Input:
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
    #    $true = Archive file passed verification process.
    # -------------------------------
    #>
    [bool] VerifyArchive([string] $file, [bool] $logging)
    {
        # Declarations and Initializations
        # ----------------------------------------
        [IOCommon] $io = [IOCommon]::new();                         # Using functions from IO Common
        [string] $fileName = "$(Split-Path $file -leaf)";           # Get only the filename from $file, 
                                                                    #  while omitting the entire path to
                                                                    #  get to that file.
        [string] $sourceDir = "$($(Get-Item $file).DirectoryName)"  # Working Directory when executing the
                                                                    #  extCMD.
        [string] $extCMDArgs = "t $($file)";                        # Arguments for the external command
                                                                    #  This will get 7zip to test the
                                                                    #  requested archive datafile.
        [string] $execReason = "Verifing $($fileName)";             # Description; used for logging
        # ----------------------------------------


        # Dependency Check
        # - - - - - - - - - - - - - -
        #  Make sure that all of the resources are available before trying to use them
        #   This check is to make sure that nothing goes horribly wrong.
        # ---------------------------

        # Make sure that the 7Zip executable was detected.
        if ($($this.Detect7ZipExist()) -eq $false)
        {
            # 7Zip was not detected.
            return $false;
        } # if : 7Zip was not detected


        # Make sure that the target file actually exists
        if ($($io.CheckPathExists("$($file)")) -eq $false)
        {
            # The archive data file does not exist, we can not
            #  test something that simply doesn't exist.  Return
            #  a failure.
            return $false;
        } # if : Target file does not exist

        # ---------------------------
        # - - - - - - - - - - - - - -


        # Execute the command
        if ($($io.ExecuteCommand("$($this.__executablePath)", `
                            "$($extCMDArgs)", `
                            "$($sourceDir)", `
                            "$($this.__logPath)", `
                            "$($this.__logPath)", `
                            "$($this.__reportPath)", `
                            "$($execReason)", `
                            $logging, `
                            $false, `
                            $false, `
                            $null)) -ne 0)
        {
            # Archive file did not pass the verification test
            return $false;
        } # if : Verification Test Failed


        # Verification Test Passed!
        return $true;
    } # VerifyArchive()




   <# List Files in Archive
    # -------------------------------
    # Documentation:
    #  This function will list all of the files that are
    #   within the target archive file.
    #
    #  List Files Information:
    #    https://sevenzip.osdn.jp/chm/cmdline/commands/list.htm
    # -------------------------------
    # Input:
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
    #  [string] File List
    #    List of files that exists within the archive data file.
    # -------------------------------
    #>
    [string] ListFiles([string] $file, [bool] $logging)
    {
        # Declarations and Initializations
        # ----------------------------------------
        [IOCommon] $io = [IOCommon]::new();                         # Using functions from IO Common
        [string] $fileName = "$(Split-Path $file -leaf)";           # Get only the filename from $file, 
                                                                    #  while omitting the entire path to
                                                                    #  get to that file.
        [string] $sourceDir = "$($(Get-Item $file).DirectoryName)"  # Working Directory when executing the
                                                                    #  extCMD.
        [string] $extCMDArgs = "l $($file) -slt";                   # Arguments for the external command
                                                                    #  This will get 7zip to list all of
                                                                    #  the files within the requested
                                                                    #  archive datafile.
        [string] $outputResult = $null;                             # This will hold the value of all of
                                                                    #  the files that are within the archive
                                                                    #  datafile.
        [string] $execReason = "List From $($fileName)";            # Description; used for logging
        # ----------------------------------------


        # Dependency Check
        # - - - - - - - - - - - - - -
        #  Make sure that all of the resources are available before trying to use them
        #   This check is to make sure that nothing goes horribly wrong.
        # ---------------------------

        # Make sure that the 7Zip executable was detected.
        if ($($this.Detect7ZipExist()) -eq $false)
        {
            # 7Zip was not detected.
            return "ERR";
        } # if : 7Zip was not detected


        # Make sure that the target file actually exists
        if ($($io.CheckPathExists("$($file)")) -eq $false)
        {
            # The archive data file does not exist, we can not
            #  test something that simply doesn't exist.  Return
            #  a failure.
            return "ERR";
        } # if : Target file does not exist

        # ---------------------------
        # - - - - - - - - - - - - - -


        # Execute the command
        $io.ExecuteCommand("$($this.__executablePath)", `
                            "$($extCMDArgs)", `
                            "$($sourceDir)", `
                            "$($this.__logPath)", `
                            "$($this.__logPath)", `
                            "$($this.__reportPath)", `
                            "$($execReason)", `
                            $logging, `
                            $false, `
                            $true, `
                            [ref]$outputResult) | Out-Null;


        # Just for assurance; make sure that we have an actual list
        #  from the archive file.  If in case the list was not
        #  retrieved successfully, then place 'ERR' to signify that
        #  an issue occurred, but still providing a value.
        if ("$($outputResult)" -eq "$($null)")
        {
            $outputResult = "ERR";
        } # If : List was not valid


        # Output the final result
        return $outputResult;
    } # ListFiles()
    #endregion

    #endregion
} # SevenZip




<# 7Zip Compression Method [ENUM]
 # -------------------------------
 # Associated with what type of 7Z Method the end-user
 #  prefers when compacting an archive datafile.
 # -------------------------------
 #>
enum SevenZipCompressionMethod
{
    Zip = 0;      # Zip format [PK3]
    SevenZip = 1; # 7Zip format [PK7]
} # SevenZipCompressionMethod




<# 7Zip Algorithm Zip [ENUM]
 # -------------------------------
 # Associated with what type of 7Z Compression Algorithm
 #  the end-user prefers when compacting an archive
 #  datafile.
 # -------------------------------
 #>
enum SevenZipAlgorithmZip
{
    Deflate = 0;  # Default
    LZMA = 1;     # LZMA Algo.
    BZip2 = 2;    # BZip2 Algo.
} # SevenZipAlgorithmZip




<# 7Zip Algorithm 7Zip [ENUM]
 # -------------------------------
 # Associated with what type of 7Z Compression Algorithm
 #  the end-user prefers when compacting an archive
 #  datafile.
 # -------------------------------
 #>
enum SevenZipAlgorithm7Zip
{
    LZMA2 = 0;    # Default
    LZMA = 1;     # LZMA Algo.
    BZip2 = 2;    # BZip2 Algo.
    PPMd = 3;     # PPMd Algo.
} # SevenZipAlgorithm7Zip




<# 7Zip Compression Level [ENUM]
 # -------------------------------
 # Associated with what type of compression level the
 #  end-user prefers when compacting an archive datafile.
 # -------------------------------
 #>
enum SevenCompressionLevel
{
    Store = 0;    # Store [No Compression] {0}
    Minimal = 1;  # Minimal compression    {3}
    Normal = 2;   # Standard compression   {5}
    Maximum = 3;  # Maximum compression    {9}
} # DefaultCompressionLevel