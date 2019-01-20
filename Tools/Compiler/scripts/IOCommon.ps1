# Common Input\Output Operations
# ------------------------------
# ==============================
# ==============================
# This function is designed to centralize common
#  input\output and to provide minimal maintenance.
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


    #region User Input Functions


    # Fetch User Input
    # -------------------------------
    # Documentation:
    #  This function will fetch input provided by the
    #   the user using STDIN (keyboard).
    #  This function will display a prompt that is
    #   adjacent to Python's prompt.  I prefer this
    #   prompt style as it is clear that the program
    #   is waiting for some sort of feedback from the
    #   user.  If the program is not clear when it is
    #   ready for feedback from the user - yet the
    #   program is in a block state because it is
    #   waiting for user feedback, the user will
    #   believe that the program is broken\frozen and
    #   the user will exit the program.  Because of
    #   this, I believe that it is important to have
    #   a clear indication when the program is waiting
    #   for feedback from the user.
    # -------------------------------
    # Output:
    #  [string] User's Input Request
    #    Returns the user's request.
    # -------------------------------
    [string] FetchUserInput()
    {
        # Because I love Python's input prompt, we will emulate it here.
        #  I find this to be easier on the user to unify an action from the end-user.
        Write-Host ">>>>> " -NoNewline;

        # Get input from the user.
        [string] $stdInput = (Get-Host).UI.ReadLine();

        # Return the value as a string
        return [string]$stdInput;
    } # FetchUserInput()

    #endregion


    #region External Command Functions

    # Detect Command [Test]
    # -------------------------------
    # Documentation:
    #  This function will help to test if the executable could
    #   run successfully.  This can be helpful to determine if
    #   the program can detect the executable or if the executable
    #   is usable.  This function is merely for testing if the
    #   external software will run properly, do not use this
    #   function for major operations.
    # -------------------------------
    # Inputs:
    #  [string] Command
    #   The external executable to run by request.
    #  [string] Type
    #   The type of command that will be executed.
    #    See Get-Command "CommandType"
    #    https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/get-command
    # -------------------------------
    # Output:
    #  [bool] Detected Code
    #    $false = Failure to detect the external executable.
    #    $true  = Successfully detected the external executable.
    # -------------------------------
    [bool] DetectCommand([string] $command, [string] $type)
    {
        if ((Get-Command -Name "$($command)" -CommandType $($type) -ErrorAction SilentlyContinue) -eq $null)
        {
            # Command was not detected.
            return $false;
        } # If : Command Not Detected

        # Command was found
        return $true;
    } # DetectCommand()




    # Execute Command [.NET API]
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
    #   STDOUT and STDERR in the provided logfiles.  HOWEVER,
    #   it is also possibly to use the STDOUT for functional
    #   purposes.  When the required settings are configured,
    #   it is possibly to capture the STDOUT in a reference
    #   parameter - allowing for the string to be used within
    #   the program.
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
    #   Absolute path and filename to store the report file.
    #   - NOTE: Filename MUST BE INCLUDED!
    #  [bool] Is Report
    #   When true, this will assure that the information
    #    is logged as a report.
    #  [bool] Capture STDOUT
    #   When true, the STDOUT will not be logged in a
    #    text file, instead it will be captured into
    #    a reference string.
    #  [string] (REFERENCE) stringOutput
    #   When Capture STDOUT is true, this parameter will
    #   carry the STDOUT from the executable.  The
    #   information provided will be available for use
    #   from the calling function.
    # -------------------------------
    # Output:
    #  [int] Exit Code
    #   The error code provided from the executable.
    #   This can be helpful to diagnose if the external command
    #    reached an error or was successful.
    #   ERROR VALUES
    #   -255
    #    The executable could not execute; may not exist.
    #   -254
    #    Command was not detected.
    # -------------------------------
    [int] ExecuteCommand([string] $command, `
                        [string] $arguments, `
                        [string] $projectPath, `
                        [string] $stdOutLogPath, `
                        [string] $stdErrLogPath, `
                        [string] $reportPath, `
                        [bool] $isReport, `
                        [bool] $captureSTDOUT, `
                        [ref] $stringOutput)
    {
        # Declarations and Initializations
        # ----------------------------------------
        # Logging
        # - - - -
        [string] $logTime    = $(Get-Date -UFormat "%d-%b-%y %H.%M.%S"); # Capture the current date and time.
        [string] $logStdErr  = "$($stdErrLogPath)\$($logTime).err";      # Log file: Standard Error
        [string] $logStdOut  = "$($stdOutLogPath)\$($logTime).out";      # Log file: Standard Output
        [string] $fileOutput = if ($isReport -eq $true)                  # Check if the output is a log or a report.
                            {"$($reportPath)"} else {"$($LogStdOut)"};

        # Capturing Output from Process
        # - - - -
        [string] $outputResultErr = ""; # Standard Error
        [string] $outputResultOut = ""; # Standard Out
        
        # .NET Special Objects
        # - - - -
        # Because Start-Process CMDLet does NOT redirect to a variable, but only to files.
        #  instead, we will use the 'ProcessStartInfo' class.
        #  Helpful Resources
        #  Stackoverflow Help:
        #   https://stackoverflow.com/a/24227234
        #  ProcessStartInfo Help:
        #   https://docs.microsoft.com/en-us/dotnet/api/system.diagnostics.processstartinfo
        [System.Diagnostics.ProcessStartInfo] $processInfo = `              # Instantiate Process Start Info Obj.
                            [System.Diagnostics.ProcessStartInfo]::new();
        [System.Diagnostics.Process] $processExec = `                       # Instantiate Process Obj.
                            [System.Diagnostics.Process]::new();
        # ----------------------------------------


        # Check to see if the external command exists; if not - leave this function immediately.
        if(($this.DetectCommand("$($command)", "Application")) -eq $false)
        {
            return -254;
        } # If : Command does not exist


        # Setup the ProcessStartInfo Obj.
        $processInfo.FileName = "$($command)";             # Executable
        $processInfo.Arguments = "$($arguments)";          # Argument(s)
        $processInfo.RedirectStandardOutput = $true;       # Maintain STDOUT
        $processInfo.RedirectStandardError = $true;        # Maintain STDERR
        $processInfo.UseShellExecute = $false;             # Use the shell
        $processInfo.CreateNoWindow = $true;               # Use the current console
        $processInfo.WorkingDirectory = "$($projectPath)"; # Execute in the Working Dir.


        # Setup the Process Obj.
        $processExec.StartInfo = $processInfo;             # Instantiate the Process object.


        # Execute the command
        try
        {
            # Start the process; do not output anything.
            $processExec.Start() | Out-Null;

            # Wait for the program to finish.
            $processExec.WaitForExit();
        } # Try : Executing command

        # An error occurred while trying to execute the command
        catch
        {
            # The command failed to be executed
            throw "Failure to execute command upon request!";

            # Return an error
            return -255;
        } # Catch : Failed Executing Command


        # Capture the Output (STDOUT && STDERR)
        $outputResultErr = $processExec.StandardError.ReadToEnd();  # STDERR
        $outputResultOut = $processExec.StandardOutput.ReadToEnd(); # STDOUT


        # Determine where to throw the STDOUT
        #  Store the STDOUT in the reference var?
        if ($captureSTDOUT -eq $true)
        {
            # Store the information to the reference variable that will be
            #  used from the calling function.
            $stringOutput.Value = $outputResultOut;
        } # If : Stored in Reference Var.

        # Creating a report
        ElseIf ($isReport -eq $true)
        {
            # Write the data to the report file.
            $this.WriteToFile("$($reportPath)", "$($outputResultOut)") | Out-Null;
        } # If : Generating a Report

        # Store the STDOUT in a file?
        else
        {
            # Store the information to a text file.
            $this.WriteToFile("$($logStdOut)", "$($outputResultOut)") | Out-Null;
        } # Else : Stored in a specific file
        

        # Write the STDERR to a file
        $this.WriteToFile("$($logStdErr)", "$($outputResultErr)") | Out-Null;


        # Return the result
        return $processExec.ExitCode;
    } # ExecuteCommand()

    #endregion
    

    #region Writing File Functions

    # Write to File
    # -------------------------------
    # Documentation:
    #  This function will write contents to a
    #  specific file.
    #
    #  NOTE: The encoding will be set as Default.
    #   Default, at the time of writing this, is
    #   Unicode.
    # -------------------------------
    # Input:
    #  [string] File
    #   The file to be written.
    #  [ref] Contents
    #   The information (or data) that is to be
    #   written to a file.
    # -------------------------------
    # Output:
    #  [bool] Exit code
    #    $false = Failure to create and\or write to file.
    #    $true = Successfully wrote to the file.
    # -------------------------------
    [bool] WriteToFile([string] $file, [ref] $contents)
    {
        # Try to write contents to the file.
        try
        {
            # Try to write the information to the file
            Out-File -LiteralPath "$($file)" `
                     -Encoding default `
                     -InputObject "$($contents.Value.ToString())" `
                     -NoClobber `
                     -Append;

            # Operation was successful
            return $true;
        } # Try : Write to file

        catch
        {
            # Operation failed
            Write-Host "Operation Failed: $_";

            # Operation failed
            return $false;
        } # Catch : Failure to write
    } # WriteToFile()

    #endregion


    #region Directory and File Management Functions

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




    # Delete Directory
    # -------------------------------
    # Documentation:
    #  This function will forcefully and recursively
    #   thrash the target directory and all sub-
    #   directories following within the hierarchy.
    #   Thus meaning, anything within the target
    #   directory - will be expunged.  Use this
    #   function carefully!
    #
    #  NOTES:
    #   - Recursive
    #   - Forceful
    # -------------------------------
    # Input:
    #  [string] Directory (Absolute Path)
    #    The directory that we want to delete.
    # -------------------------------
    # Output:
    #  [bool] Exit code
    #    $false = Failed to delete directory.
    #    $true = Successfully deleted directory
    # -------------------------------
    [bool] DeleteDirectory([string] $path)
    {
        # First check to see if the directory actually exists,
        #  if not, then there is nothing to do.
        if((CheckPathExists("$($path)")) -eq $false)
        {
            # The directory does not exist, there's nothing to do.
            return $true;
        } # Check if Directory Exists.


        # Try to delete the directory
        try
        {
            # Remove the directory.
            Remove-Item -LiteralPath "$($path)" -Force -Recurse -ErrorAction Stop;
        } # Try : Delete Directory

        catch
        {
            return $false;
        } # Catch : Error Deleting Directory


        # Successfully deleted the directory.
        return $true;
    } # DeleteDirectory()




    # Delete File
    # -------------------------------
    # Documentation:
    #  This function will forcefully delete an
    #   individual file or a specific set of
    #   files given by a specific criteria.
    #   This function cane be useful to delete
    #   superfluous log files and the like.
    #   Use this function carefully!
    #
    #  NOTES:
    #   - Forceful
    # -------------------------------
    # Input:
    #  [string] Directory (Absolute Path)
    #    The directory that we want to inspect
    #     the file contents.
    #    - NOTE: DO NOT PUT THE ACTUAL FILE PATH OR
    #            PATH OF FILES HERE, USE 'Includes'
    #            FOR THIS!
    #  [string[]] Includes
    #    What specific requirements must a file have
    #     in order to be classified to be deleted.
    # -------------------------------
    # Output:
    #  [bool] Exit code
    #    $false = Failed to delete directory.
    #    $true = Successfully deleted directory
    # -------------------------------
    [bool] DeleteFile([string] $path, [string[]] $includes)
    {
        # First check to see if the directory actually exists,
        #  if not, then there is nothing to do.
        if((CheckPathExists("$($path)")) -eq $false)
        {
            # The directory does not exist, there's nothing to do.
            return $true;
        } # Check if Directory Exists.

        # Try to delete the requested files from specific directory.
        try
        {
            # Remove the requested files.
            Remove-Item -Path "$($path)\*" -Include $($includes) -Force -ErrorAction Stop;
        } # Try : Delete Files

        catch
        {
            return $false;
        } # Catch : Error Deleting Files


        # Successfully deleted the files.
        return $true;
    } # DeleteFile

    #endregion
} # IOCommon