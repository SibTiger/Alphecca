# User Preferences
# ------------------------------
# ==============================
# ==============================
# This class holds the User Preferences within this
#  program.  The user's preferences will give rise
#  to what the user wants to do with this program
#  and perform the task as the user's demands with
#  minimal configuration after the first initial
#  setup.  The goal of this program is to assure
#  that the user can merely 'click-and-forget',
#  thus the program should NOT stand in the way
#  of the user's tasks.  With that in mind, it
#  is paramount that the User Preferences should
#  provide little headache as necessary; in-fact,
#  all of the configurations within the classes
#  provides that same principle.




class UserPreferences
{
    # Member Variables :: Properties
    # =================================================
    # =================================================


    #region Private Variables (emulated)

    # Compression Choice
    # ---------------
    # The choice of which tool to generate an archive-datafile.
    Hidden [UserPreferencesCompressTool] $__compressionTool;


    # Project Path
    # ---------------
    # The ZDoom based project in-which to compile.
    Hidden [string] $__projectPath;


    # Project Builds Path
    # ---------------
    # The builds output path.
    Hidden [string] $__outputBuildsPath;


    # Use Git Features
    # ---------------
    # When true, this program will try to use Git's features.
    Hidden [bool] $__useGitFeatures;


    # Use Windows Explorer
    # ---------------
    # When true, this program will try to use Windows Explorer
    #  to open directory paths; useful to show where the builds
    #  are located within the user's filesystem.
    Hidden [bool] $__useWindowsExplorer;


    # Logging
    # ---------------
    # When true, this will log all activity within the operations
    #  taken place by the program as well as capturing all messages
    #  from the tools used by this program.
    Hidden [bool] $__logging;


    # Use Bell [Alarm]
    # ---------------
    # When true, this program will send a 'ding' sound when an
    #  event takes place; errors, warnings, and\or successful
    #  operations.
    Hidden [bool] $__ringMyDingaling;


    # Bell Events
    # ---------------
    # The user can be able to pick which event is giving with an
    #  audiable notification.
    Hidden [UserPreferencesEventAlarm] $__NotificationType;

    #endregion
} # UserPreferences




# User Preferences Compress Tool [ENUM]
# -------------------------------
# Associated with what type of compression tool
#  should be used when wanting to compact a data
#  into an archive-file.
# -------------------------------
enum UserPreferencesCompressTool
{
    Default = 0;   # .NET
    SevenZip = 1;  # 7Za (CLI)
} # UserPreferencesCompressTool




# User Preferences Event Alarm [ENUM]
# -------------------------------
# Associated with what type of audiable notification
#  the user wishes to recieve.  These notifications
#  are based on certain events that can occur during
#  the program's run-time.
# -------------------------------
enum UserPreferencesEventAlarm
{
    Everything = 0;    # Everything will sound an alarm.
    Success = 1;       # Only successful operations will
                       #  sound an alarm.
    Errors = 2;        # Only errors will sound an alarm.
    Warnings = 3;      # Only warnings will sound an alarm.
} # UserPreferencesEventAlarm