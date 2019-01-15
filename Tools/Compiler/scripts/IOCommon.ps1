﻿# Common Input\Output Operations
# ------------------------------
# ==============================
# ==============================
# This function is designed to centralize common
#  input\output and to provide minimal maintanence.
# Functions housed in this class are based on
#  common Input\Output tasks, such as: checking for
#  a specific directory\file\executable, executing
#  a specific command while providing return code,
#  executing a specific command to return a literal
#  string, browsing for specific directory, and
#  much more.




class IOCommon
{
    # Member Functions :: Methods
    # =================================================
    # =================================================


    #region Public Functions
    # Execute Command [Exit Code]
    # -------------------------------
    # Documentation:
    #  This function will allow a specific executable to run
    #   with the required parameters.
    #
    #  Return Code Notes: After the command has been executed,
    #   this function will only return the exit code provided
    #   by the executable.  If the external executable can not
    #   be found or generally fails to execute in vague reasons,
    #   this function will return a specific error code that is
    #   dedicated by this function.
    #
    #  Logging Notes: This function requires the use of logging
    #   when executing the external command.  During execution,
    #   this function will log the activities and redirect
    #   STDOUT and STDERR in the provided logfiles.
    # -------------------------------
    # Inputs:
    #  [string] Command
    #   The external executable to run by request.
    #  [string] Arguments
    #   Arguments to be used when executing the binary.
    #  [string] Project Path
    #   The absolute path of the project directory.
    #  [string] STDOUT Log Path
    #   Absolute path to store the log file containing
    #    the program's STDOUT output.
    #   - NOTE: Filename is provided by this function.
    #  [string] STDERR Log Path
    #   Absolute path to store the log file containing
    #    the program's STDERR output.
    #   - NOTE: Filename is provided by this function.
    #  [string] Report Path
    #   Absolute path to store the report file.
    #   - NOTE: Filename is provided by this function.
    #  [bool] Is Report
    #   When true, this will assure that the information
    #    is logged as a report.
    # -------------------------------
    # Output:
    #  [int] Exit Code
    #   The error code provided from the executable.
    #   This can be helpful to diagnose if the external command
    #    reached an error or was successful.
    #   ERROR VALUES
    #   -255
    #    The executable could not execute; may not exist.
    # -------------------------------
    [int] ExecuteCommand([string] $command, `
                        [string] $arguments, `
                        [string] $projectPath, `
                        [string] $stdOutLogPath, `
                        [string] $stdErrLogPath, `
                        [string] $reportPath, `
                        [bool] $isReport)
    {
        # Declarations and Initializations
        # ----------------------------------------
        [string] $executable = "$($command)";                         # Executable file name
        [string] $executableArgument = "$($arguments)";               # Executable Parameters
        [string] $workingDirectory = "$($projectPath)";               # Working Directory
        [string] $runTime = $(Get-Date -UFormat "%d-%b-%y %H.%M.%S"); # Capture the current date and time.
        [string] $logStdErr = "$($stdErrLogPath)\$($runTime).err";    # Log file: Standard Error
        [string] $logStdOut = "$($stdOutLogPath)\$($runTime).out";    # Log file: Standard Output
        [string] $logReport = "$($reportPath)\$($runTime).txt";       # Report File: Information regarding the repo.
        [string] $fileOutput = if ($isReport -eq $true)               # Check if the output is a log or a report.
                            {"$($logReport)"} else {"$($LogStdOut)"};
        [int] $exitCode = -255;                                       # The exit code that will be returned from
                                                                      #  this function. 
        # ----------------------------------------

        # Execute the binary
        try
        {
            # Execute the command
            $returnCode = Start-Process -FilePath "$($executable)" `
                                        -ArgumentList "$($executableArgument)" `
                                        -WorkingDirectory "$($workingDirectory)" `
                                        -RedirectStandardOutput "$($fileOutput)" `
                                        -RedirectStandardError "$($logStdErr)" `
                                        -NoNewWindow `
                                        -Wait `
                                        -UseNewEnvironment;

            # Capture the exit status from the command.
            $exitCode = $returnCode.ExitCode;
        } # Try : Executing command

        # An error occurred while trying to execute the command
        catch
        {
            # The command failed to be executed
            throw "Command was not found or execution failed to run.";
        } # Catch : Failed Executing Command


        # Return the exit code
        return $exitCode;
    } # ExecuteCommand()




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
    [bool] MakeDirectory([string] $path)
    {
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
    [bool] CheckPathExists([string] $path)
    {
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

    #endregion
} # IOCommon