﻿# Git Control
# ------------------------------
# ==============================
# ==============================
# This class holds settings regarding the use of Git and
#  its features, but also holds functions to perform various
#  tasks related to using Git.
# NOTE: In order to use git, it must first already be
#  installed within the host system.  We are merely going to
#  use the binary to perform the tasks we want; if the
#  binary is not available - than nothing is used.




class GitControl
{
    # Member Variables :: Properties
    # =================================================
    # =================================================


    #region Private Variables (emulated)

    # Git Executable Path
    # ---------------
    # The path inwhich the executable 'git.exe' resides.
    Hidden [string] $__executablePath;


    # Update Source
    # ---------------
    # When true, try to update the source when possible.
    Hidden [bool] $__updateSource;


    # Length Commit ID
    # ---------------
    # Set how long the commit ID should be when retrieving it.
    Hidden [GitCommitLength] $__lengthCommitID;


    # Fetch Latest Commit ID
    # ---------------
    # When true, try to fetch the latest commit ID.
    Hidden [bool] $__fetchCommitID;

    
    # Fetch Changelog History
    # ---------------
    # When true, try to retrieve a commit history.
    Hidden [bool] $__fetchChangelog;

    
    # Changelog History Limit
    # ---------------
    # The maximum commits to record in the changelog.
    Hidden [int] $__changelogLimit;


    # Requested Branch
    # ---------------
    # The source Branch to work within.
    #  It is advisable to use the Master!
    Hidden [string] $__sourceBranch;


    # Fetch All Collaborators [stats]
    # ---------------
    # Find all collaborators and record them.
    Hidden [bool] $__fetchContributors;


    # Fetch Stats
    # ---------------
    # Record any statistical information regarding
    #  the project.
    Hidden [bool] $__fetchStats;


    # Generate Report
    # ---------------
    # Create a report based on the operations
    #  performed by Git.
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
    GitControl()
    {
        # git.exe Path
        $this.__executablePath = "git.exe";

        # Update Source
        $this.__updateSource = $true;

        # Length Commit ID
        $this.__lengthCommitID = 0;

        # Fetch Commit ID
        $this.__fetchCommitID = $true;

        # Fetch changelog
        $this.__fetchChangelog = $true;

        # Changelog history limits
        $this.__changelogLimit = 50;

        # Repository Branch
        $this.__sourceBranch = "master";

        # Fetch all contributors
        $this.__fetchContributors = $false;

        # Fetch project's statistics
        $this.__fetchStats = $false;

        # Generate a report
        $this.__generateReport = $false;

        # Log Root Directory
        $this.__rootLogPath = "$($global:_PROGRAMDATA_LOGS_PATH_)\git";

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
    GitControl([string]$executablePath,
                [bool]$updateSource,
                [GitCommitLength]$lengthCommitID,
                [bool]$fetchCommitID,
                [bool]$fetchChangelog,
                [int]$changelogLimit,
                [string]$sourceBranch,
                [bool]$fetchContributors,
                [bool]$fetchStats,
                [bool]$generateReport)
    {
        # git.exe Path
        $this.__executablePath = $executablePath;

        # Update Source
        $this.__updateSource = $updateSource;

        # Length of the Commit ID
        $this.__lengthCommitID = $lengthCommitID;

        # Fetch the Commit ID
        $this.__fetchCommitID = $fetchCommitID;

        # Fetch the Changelog History
        $this.__fetchChangelog = $fetchChangelog;

        # Changelog Limit
        $this.__changelogLimit = $changelogLimit;

        # Repo Branch
        $this.__sourceBranch = $sourceBranch;

        # Fetch contributors
        $this.__fetchContributors = $fetchContributors;

        # Fetch Repo Stats
        $this.__fetchStats = $fetchStats;

        # Generate statistical report
        $this.__generateReport = $generateReport;

        # Log Root Directory
        $this.__rootLogPath = "$($global:_PROGRAMDATA_LOGS_PATH_)\git";

        # Report Path
        $this.__reportPath = "$($this.__rootLogPath)\reports";

        # Log Path
        $this.__logPath = "$($this.__rootLogPath)\logs";


        # ==================
        # Functions

        # Create the necessary directories
        $this.__CreateDirectories() | Out-Null;
    } # User Preference : On-Load

    #endregion



    #region Getter Functions

    # Get Executable Path
    # -------------------------------
    # Documentation:
    #  Returns the value of the Executable Path variable.
    # -------------------------------
    # Output:
    #  [string] Executable Path
    #   the value of the Exectable Path to git.exe.
    # -------------------------------
    [string] GetExecutablePath()
    {
        return $this.__executablePath;
    } # GetExecutablePath()




    # Get Update Source Flag
    # -------------------------------
    # Documentation:
    #  Returns the value of the Update Source variable.
    # -------------------------------
    # Output:
    #  [bool] Update Source
    #   the value of the Update Source.
    # -------------------------------
    [bool] GetUpdateSource()
    {
        return $this.__updateSource;
    } # GetUpdateSource()




    # Get Git Commit Length
    # -------------------------------
    # Documentation:
    #  Returns the value of the Git Commit Length variable.
    # -------------------------------
    # Output:
    #  [GitCommitLength] Git Commit Length
    #   the value of the Git Commit Length.
    # -------------------------------
    [GitCommitLength] GetLengthCommitID()
    {
        return $this.__lengthCommitID;
    } # GetLengthCommitID()




    # Get Fetch Commit ID
    # -------------------------------
    # Documentation:
    #  Returns the value of the Fetch Commit ID variable.
    # -------------------------------
    # Output:
    #  [bool] Fetch Commit ID
    #   the value of the Fetch Commit ID.
    # -------------------------------
    [bool] GetFetchCommitID()
    {
        return $this.__fetchCommitID;
    } # GetFetchCommitID()




    # Get Fetch Changelog
    # -------------------------------
    # Documentation:
    #  Returns the value of the Fetch Changelog variable.
    # -------------------------------
    # Output:
    #  [bool] Fetch Changelog
    #   the value of the Fetch Changelog.
    # -------------------------------
    [bool] GetFetchChangelog()
    {
        return $this.__fetchChangelog;
    } # GetFetchChangelog()




    # Get Changelog Limit
    # -------------------------------
    # Documentation:
    #  Returns the value of the Changelog Limit variable.
    # -------------------------------
    # Output:
    #  [int] Changelog Limit
    #   the value of the Changelog Limit.
    # -------------------------------
    [int] GetChangelogLimit()
    {
        return $this.__changelogLimit;
    } # GetChangelogLimit()




    # Get Source Branch
    # -------------------------------
    # Documentation:
    #  Returns the value of the Source Branch variable.
    # -------------------------------
    # Output:
    #  [string] Source Branch
    #   the value of the Source Branch.
    # -------------------------------
    [string] GetSourceBranch()
    {
        return $this.__sourceBranch;
    } # GetSourceBranch()




    # Get Fetch Contributors
    # -------------------------------
    # Documentation:
    #  Returns the value of the Fetch Contributors variable.
    # -------------------------------
    # Output:
    #  [bool] Fetch Contributors
    #   the value of the Fetch Contributors.
    # -------------------------------
    [bool] GetFetchContributors()
    {
        return $this.__fetchContributors;
    } # GetFetchContributors()




    # Get Fetch Stats
    # -------------------------------
    # Documentation:
    #  Returns the value of the Fetch Stats variable.
    # -------------------------------
    # Output:
    #  [bool] Fetch Stats
    #   the value of the Fetch Stats.
    # -------------------------------
    [bool] GetFetchStats()
    {
        return $this.__fetchStats;
    } # GetFetchStats()




    # Get Generate Report
    # -------------------------------
    # Documentation:
    #  Returns the value of the Generate Report variable.
    # -------------------------------
    # Output:
    #  [bool] Generate Report
    #   the value of the Generate Report.
    # -------------------------------
    [bool] GetGenerateReport()
    {
        return $this.__generateReport;
    } # GetGenerateReport()




    # Get Report Path
    # -------------------------------
    # Documentation:
    #  Returns the value of the Report Path variable.
    # -------------------------------
    # Output:
    #  [string] Report Path
    #   the value of the Report Path.
    # -------------------------------
    [string] GetReportPath()
    {
        return $this.__reportPath;
    } # GetReportPath()




    # Get Report Path
    # -------------------------------
    # Documentation:
    #  Returns the value of the Log Path variable.
    # -------------------------------
    # Output:
    #  [string] Log Path
    #   the value of the Log Path.
    # -------------------------------
    [string] GetLogPath()
    {
        return $this.__logPath;
    } # GetLogPath()




    # Get Root Log Path
    # -------------------------------
    # Documentation:
    #  Returns the value of the Root Log Path variable.
    # -------------------------------
    # Output:
    #  [string] Root Log Path
    #   the value of the Log Root Path.
    # -------------------------------
    [string] GetRootLogPath()
    {
        return $this.__rootLogPath;
    } # GetRootLogPath()


    #endregion



    #region Setter Functions

    # Set Executable Path
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Executable Path variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Success; value has been changed.
    #   false = Failure; could not set a new value.
    # -------------------------------
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




    # Set Update Source Flag
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Update Source variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Success; value has been changed.
    #   false = Failure; could not set a new value.
    # -------------------------------
    [bool] SetUpdateSource([bool] $newVal)
    {
        # Because the value is either true or false, there
        #  really is no point in checking if the new requested
        #  value is 'legal'.  Thus, we are going to trust the
        #  value and automatically return success.
        $this.__updateSource = $newVal;

        # Successfully updated.
        return $true;
    } # SetUpdateSource()




    # Set Git Commit Length
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Git Commit Length variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Success; value has been changed.
    #   false = Failure; could not set a new value.
    # -------------------------------
    [bool] SetLengthCommitID([GitCommitLength] $newVal)
    {
        # Because the value must fit within the 'GitCommitLength'
        #  datatype, there really is no point in checking if the
        #  new requested value is 'legal'.  Thus, we are going
        #  to trust the value and automatically return success.
        $this.__lengthCommitID = $newVal;

        # Successfully updated.
        return $true;
    } # SetLengthCommitID()




    # Set Fetch Commit ID
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Fetch Commit ID variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Success; value has been changed.
    #   false = Failure; could not set a new value.
    # -------------------------------
    [bool] SetFetchCommitID([bool] $newVal)
    {
        # Because the value is either true or false, there
        #  really is no point in checking if the new requested
        #  value is 'legal'.  Thus, we are going to trust the
        #  value and automatically return success.
        $this.__fetchCommitID = $newVal;

        # Successfully updated.
        return $true;
    } # SetFetchCommitID()




    # Set Fetch Changelog
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Fetch Changelog variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Success; value has been changed.
    #   false = Failure; could not set a new value.
    # -------------------------------
    [bool] SetFetchChangelog([bool] $newVal)
    {
        # Because the value is either true or false, there
        #  really is no point in checking if the new requested
        #  value is 'legal'.  Thus, we are going to trust the
        #  value and automatically return success.
        $this.__fetchChangelog = $newVal;

        # Successfully updated.
        return $true;
    } # SetFetchChangelog()




    # Set Changelog Limit
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Changelog Limit variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Success; value has been changed.
    #   false = Failure; could not set a new value.
    # -------------------------------
    [bool] SetChangelogLimit([int] $newVal)
    {
        # Make sure the requested change is actually legal.
        #  Prevent negative numbers
        if ($newVal -lt 0)
        {
            # The request was a negative number, we can not
            #  use it.  It must be a zero or non-negative
            #  value.
            return $false;
        } # IF : Negative Value

        # Legal number, we can use it.
        $this.__changelogLimit = $newVal;

        # Successfully updated.
        return $true;
    } # SetChangelogLimit()




    # Set Source Branch
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Source Branch variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Success; value has been changed.
    #   false = Failure; could not set a new value.
    # -------------------------------
    [bool] SetSourceBranch([string] $newVal)
    {
        # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        # TODO - This requires further validation that I
        #  cannot properly setup right now.
        #  Blindly accept it for now, regardless if the
        #  branch exists within the project.
        # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        $this.__sourceBranch = $newVal;

        # Successfully updated.
        return $true;
    } # SetSourceBranch()




    # Set Fetch Contributors
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Fetch Contributors variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Success; value has been changed.
    #   false = Failure; could not set a new value.
    # -------------------------------
    [bool] SetFetchContributors([bool] $newVal)
    {
        # Because the value is either true or false, there
        #  really is no point in checking if the new requested
        #  value is 'legal'.  Thus, we are going to trust the
        #  value and automatically return success.
        $this.__fetchContributors = $newVal;

        # Successfully updated.
        return $true;
    } # SetFetchContributors()




    # Set Fetch Stats
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Fetch Stats variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Success; value has been changed.
    #   false = Failure; could not set a new value.
    # -------------------------------
    [bool] SetFetchStats([bool] $newVal)
    {
        # Because the value is either true or false, there
        #  really is no point in checking if the new requested
        #  value is 'legal'.  Thus, we are going to trust the
        #  value and automatically return success.
        $this.__fetchStats = $newVal;

        # Successfully updated.
        return $true;
    } # SetFetchStats()




    # Set Generate Report
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Generate Report variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Success; value has been changed.
    #   false = Failure; could not set a new value.
    # -------------------------------
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




    # Set Report Path
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Report Path variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Success; value has been changed.
    #   false = Failure; could not set a new value.
    # -------------------------------
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


    # Thrash Logs and Reports
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
     



    # Check Required Directories
    # -------------------------------
    # Documentation:
    #  This function was created to check the directories
    #   that this class requires.
    #
    # ----
    #
    #  Directories to Check:
    #   - \git
    #   - \git\logs
    #   - \git\reports
    # -------------------------------
    # Output:
    #  [bool] Exit code
    #    $false = One or more directories does not exist.
    #    $true = Directories exist
    # -------------------------------
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




    # Create Directories
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
    #   - \git
    #   - \git\logs
    #   - \git\reports
    # -------------------------------
    # Output:
    #  [bool] Exit code
    #    $false = Failure creating the new directories.
    #    $true  = Successfully created the new directories
    #             OR
    #             Directories already existed, nothing to do.
    # -------------------------------
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

        
        # A general error occured, the directories could not be created.
        return $false;
    } # __CreateDirectories()

    #endregion



    #region Public Functions

    # Detect Git Executable
    # -------------------------------
    # Documentation:
    #  This function will check if the Git executable
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
    [bool] DetectGitExist()
    {
        # Declarations and Initializations
        # ----------------------------------------
        [IOCommon] $io = [IOCommon]::new();       # Using functions from IO Common
        # ----------------------------------------

        # Check if the git executable was found
        if (($io.DetectCommand("$($this.__executablePath)", "Application")) -eq $true)
        {
            return $true;
        } # If : Detected
        else
        {
            return $false;
        } # Else : Not Detected
    } # DetectGitExist()




    # Update Local Working Copy
    # -------------------------------
    # Documentation:
    #  This function will update the project's Local
    #   Working Copy by fetching any of the latest
    #   changes made to the centralized repository
    #   server. 
    # -------------------------------
    # Input:
    #  [string] Project Path
    #   The path to the project's root directory that
    #   contains the .git directory.  If that directory
    #   lacks that specific '.git' directory, this
    #   will fail to work.
    # -------------------------------
    # Output:
    #  [bool] Status
    #    $false = Failure to detect the external executable.
    #    $true  = Successfully detected the external executable.
    # -------------------------------
    [bool] UpdateLocalWorkingCopy([string] $projectPath)
    {
        # Declarations and Initializations
        # ----------------------------------------
        [IOCommon] $io = [IOCommon]::new();       # Using functions from IO Common

        # This will help shorten the long statement request to a small var.
        [string] $runCMD = $io.ExecuteCommand("$($this.__executablePath)", `
                                              "pull", `
                                              "$($projectPath)", `
                                              "$($this.__logPath)", `
                                              "$($this.__logPath)", `
                                              "$($this.__reportPath)", `
                                              $false, `
                                              $false, `
                                              $null);
        # ----------------------------------------


        # Try to update the LWC
        if (($runCMD) -eq 0)
        {
            return $true;
        } # If : Detected
        else
        {
            return $false;
        } # Else : Not Detected
    } # UpdateLocalWorkingCopy()

    #endregion
} # GitControl




# Git Commit Type [ENUM]
# -------------------------------
# Associated with what type of commit ID the end-user
#  prefers when retrieving the Commit ID.
# -------------------------------
enum GitCommitLength
{
    short = 0;   # usually contains seven chars.
    long = 1;    # usually about forty-one chars. [Lunacy!]
} # GitCommitType