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
    # PRIVATE (emulated)

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




    # Member Functions :: Methods
    # =================================================
    # =================================================
    # PUBLIC



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
    [int] GetSourceBranch()
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
} # GitControl




# GIT Commit Type [ENUM]
# -------------------------------
# Associated with what type of commit ID the end-user
#  prefers when retrieving the Commit ID.
# -------------------------------
enum GitCommitLength
{
    short = 0;   # usually contains seven chars.
    long = 1;    # usually about forty-one chars. [Lunacy!]
} # GitCommitType