# Git Control
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


    # Report Path
    # ---------------
    # The absolute path to store the reports that
    #  has been generated.
    Hidden [string] $__reportPath;

    #endregion

    

    # Member Functions :: Methods
    # =================================================
    # =================================================


    #region Getter Functions

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

    #endregion



    #region Setter Functions

    # Set Update Source Flag
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Update Source variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Failure; could not set a new value.
    #   false = Success; value has been changed.
    # -------------------------------
    [bool] SetUpdateSource([bool] $newVal)
    {
        # Because the value is either true or false, there
        #  really is no point in checking if the new requested
        #  value is 'legal'.  Thus, we are going to trust the
        #  value and automatically return success.
        $this.__updateSource = $newVal;

        # Successfully updated.
        return $false;
    } # SetUpdateSource()




    # Set Git Commit Length
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Git Commit Length variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Failure; could not set a new value.
    #   false = Success; value has been changed.
    # -------------------------------
    [bool] SetLengthCommitID([GitCommitLength] $newVal)
    {
        # Because the value must fit within the 'GitCommitLength'
        #  datatype, there really is no point in checking if the
        #  new requested value is 'legal'.  Thus, we are going
        #  to trust the value and automatically return success.
        $this.__lengthCommitID = $newVal;

        # Successfully updated.
        return $false;
    } # SetLengthCommitID()




    # Set Fetch Commit ID
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Fetch Commit ID variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Failure; could not set a new value.
    #   false = Success; value has been changed.
    # -------------------------------
    [bool] SetFetchCommitID([bool] $newVal)
    {
        # Because the value is either true or false, there
        #  really is no point in checking if the new requested
        #  value is 'legal'.  Thus, we are going to trust the
        #  value and automatically return success.
        $this.__fetchCommitID = $newVal;

        # Successfully updated.
        return $false;
    } # SetFetchCommitID()




    # Set Fetch Changelog
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Fetch Changelog variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Failure; could not set a new value.
    #   false = Success; value has been changed.
    # -------------------------------
    [bool] SetFetchChangelog([bool] $newVal)
    {
        # Because the value is either true or false, there
        #  really is no point in checking if the new requested
        #  value is 'legal'.  Thus, we are going to trust the
        #  value and automatically return success.
        $this.__fetchChangelog = $newVal;

        # Successfully updated.
        return $false;
    } # SetFetchChangelog()




    # Set Changelog Limit
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Changelog Limit variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Failure; could not set a new value.
    #   false = Success; value has been changed.
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
            return $true;
        } # IF : Negative Value

        # Legal number, we can use it.
        $this.__changelogLimit = $newVal;

        # Successfully updated.
        return $false;
    } # SetChangelogLimit()




    # Set Source Branch
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Source Branch variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Failure; could not set a new value.
    #   false = Success; value has been changed.
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
        return $false;
    } # SetSourceBranch()




    # Set Fetch Contributors
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Fetch Contributors variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Failure; could not set a new value.
    #   false = Success; value has been changed.
    # -------------------------------
    [bool] SetFetchContributors([bool] $newVal)
    {
        # Because the value is either true or false, there
        #  really is no point in checking if the new requested
        #  value is 'legal'.  Thus, we are going to trust the
        #  value and automatically return success.
        $this.__fetchContributors = $newVal;

        # Successfully updated.
        return $false;
    } # SetFetchContributors()




    # Set Fetch Stats
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Fetch Stats variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Failure; could not set a new value.
    #   false = Success; value has been changed.
    # -------------------------------
    [bool] SetFetchStats([bool] $newVal)
    {
        # Because the value is either true or false, there
        #  really is no point in checking if the new requested
        #  value is 'legal'.  Thus, we are going to trust the
        #  value and automatically return success.
        $this.__fetchStats = $newVal;

        # Successfully updated.
        return $false;
    } # SetFetchStats()




    # Set Generate Report
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Generate Report variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Failure; could not set a new value.
    #   false = Success; value has been changed.
    # -------------------------------
    [bool] SetGenerateReport([bool] $newVal)
    {
        # Because the value is either true or false, there
        #  really is no point in checking if the new requested
        #  value is 'legal'.  Thus, we are going to trust the
        #  value and automatically return success.
        $this.__generateReport = $newVal;

        # Successfully updated.
        return $false;
    } # SetGenerateReport()




    # Set Report Path
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Report Path variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Failure; could not set a new value.
    #   false = Success; value has been changed.
    # -------------------------------
    [bool] SetReportPath([string] $newVal)
    {
        # Inspect to see if the path exists
        if (Test-Path $newVal.trim())
        {
            # Path exists; use it as requested
            $this.__reportPath = $newVal;
            return $false;
        } # IF: Path Exists

        # Failure; Path does not exist.
        return $true;
    } # SetReportPath()

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