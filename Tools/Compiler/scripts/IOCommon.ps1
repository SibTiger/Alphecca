<# Common Input\Output Operations
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
 #>




class IOCommon
{
    # Member Functions :: Methods
    # =================================================
    # =================================================


    #region User Input Functions


   <# Fetch User Input
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
    #>
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

   <# Detect Command [Test]
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
    #>
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




   <# Execute Command
    # -------------------------------
    # Documentation:
    #  This function will provide the ability to execute the
    #   requested external command and help to manage how the
    #   logging or redirection of output should be handled.
    #  This function will use several functions in order to
    #   preform the operation, this function is made to help
    #   simplify the operation and keep data organized
    #   efficiently.
    #
    #  Return Code Notes: After the command has been executed,
    #   this function will only return the exit code provided
    #   by the executable.  If the external executable can not
    #   be found or generally fails to execute in vague reasons,
    #   this function will return a specific error code that is
    #   dedicated by this function.
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
    #  [string] Description
    #   Used for logging and for information purposes only.
    #  [bool] Logging
    #   User's request to log
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
    #
    #   -254
    #    Command was not detected.
    #
    #   -253
    #    Project Path was not detected.
    #
    #   -252
    #    Standard Out Path was not detected.
    #
    #   -251
    #    Standard Error Path was not detected.
    # -------------------------------
    #>
    [int] ExecuteCommand([string] $command, `
                        [string] $arguments, `
                        [string] $projectPath, `
                        [string] $stdOutLogPath, `
                        [string] $stdErrLogPath, `
                        [string] $reportPath, `
                        [string] $description, `
                        [bool] $logging, `
                        [bool] $isReport, `
                        [bool] $captureSTDOUT, `
                        [ref] $stringOutput)
    {
        # Declarations and Initializations
        # ----------------------------------------
        [string] $containerStdOut = $null;        # Used to hold the STDOUT
        [string] $containerStdErr = $null;        # Used to hold the STDERR
        [int] $externalCommandReturnCode = $null; # Exit Code from the extCMD.
        [string] $callBack = $null;               # Allocate memory address if the stdout
                                                  #  needs to be relocated, this is our
                                                  #  medium in order to accomplish this.
        # ----------------------------------------



        # Dependency Check
        # - - - - - - - - - - - - - -
        #  Make sure that all of the resources are available before trying to use them
        #   This check is to make sure that nothing goes horribly wrong.
        # ---------------------------

        # Make sure that the executable exists before trying to use it.
        if ($($this.DetectCommand("$($command)", "Application")) -eq $false)
        {
            # Executable was not detected.
            return -254;
        } # if : Executable was not detected


        # Make sure that the Project path exists
        if ($($this.CheckPathExists("$($projectPath)")) -eq $false)
        {
            # Project Path does not exist, return an error.
            return -253;
        } # if : The Project Path does not exist


        # Make sure that the Standard Output Path exists
        if ($($this.CheckPathExists("$($stdOutLogPath)")) -eq $false)
        {
            # Standard Output Path does not exist, return an error.
            return -252;
        } # if : The Standard Output Path does not exist


        # Make sure that the Standard Error path exists
        if ($($this.CheckPathExists("$($stdErrLogPath)")) -eq $false)
        {
            # Standard Error Path does not exist, return an error.
            return -251;
        } # if : The Standard Error Path does not exist


        # Make sure that the description field actually has something
        #  meaningful, if not (by mistake) - use the executable and args
        #  as the description.
        if (("$($description)" -eq "") -or ("$($description)" -eq $null))
        {
            # NOTE: Worst case scenario, we potentially break the filesystem
            #  by either: using illegal characters or long chars.
            #  To avoid this from happening, please use a valid description!
            $description = "$($command) $($arguments)";
        } # if : Description was not populated

        # ---------------------------
        # - - - - - - - - - - - - - -


        # Execute the Command
        $externalCommandReturnCode = $this.__ExecuteCommandRun($command, `
                                                       $arguments, `
                                                       $projectPath, `
                                                       [ref] $containerStdOut, `
                                                       [ref] $containerStdErr)


        # Create the necessary logfiles or capture a specific input
        $this.__ExecuteCommandLog($stdOutLogPath, `
                                $stdErrLogPath, `
                                $reportPath, `
                                $logging, `
                                $isReport, `
                                $captureSTDOUT, `
                                $description, `
                                [ref] $callBack, `
                                [ref] $containerStdOut, `
                                [ref] $containerStdErr)


        # Do we need to copy the STDOUT to the pointer?
        #  Used if wanting the extCMD output in a function.
        if ($captureSTDOUT -eq $true)
        {
            # Copy the stdout to pointer
            $stringOutput.Value = $callBack;
        } # If : Redirect STDOUT to Pointer


        # Return the ExtCMD's exit code
        return $externalCommandReturnCode;
    } # ExecuteCommand()




   <# Execute Command - Logging
    # -------------------------------
    # Documentation:
    #  This function will take the outputs provided by the
    #   extCMD and place them in logfiles or redirect the
    #   output to a specific reference variable upon request.
    # -------------------------------
    # Inputs:
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
    #  [bool] Logging
    #   User's request to log
    #  [bool] Is Report
    #   When true, this will assure that the information
    #    is logged as a report.
    #  [bool] Capture STDOUT
    #   When true, the STDOUT will not be logged in a
    #    text file, instead it will be captured into
    #    a reference string.
    #  [string] Description
    #   Used for logging and for information purposes only.
    #  [ref] {string} Output String
    #   When Capture STDOUT is true, this parameter will
    #    carry the STDOUT from the executable.  The
    #    information provided will be available for use
    #    from the calling function.
    #  [ref] {string} Output Result STDOUT
    #   The STDOUT provided by the extCMD.
    #   - NOTE: Trying to conserve main memory space by using referencing.
    #            Output can be at maximum of 2GB of space. (Defined by CLR)
    #  [ref] {string} Output Result STDERR
    #   The STDOUT provided by the extCMD.
    #   - NOTE: Trying to conserve main memory space by using referencing.
    #            Output can be at maximum of 2GB of space. (Defined by CLR)
    # -------------------------------
    #>
    Hidden [void] __ExecuteCommandLog($stdOutLogPath, `
                                    $stdErrLogPath, `
                                    $reportPath, `
                                    $logging, `
                                    $isReport, `
                                    $captureSTDOUT, `
                                    $description, `
                                    [ref] $stringOutput, `
                                    [ref] $outputResultOut, `
                                    [ref] $outputResultErr)
    {
        # Declarations and Initializations
        # ----------------------------------------
        [string] $logTime        = $(Get-Date -UFormat "%d-%b-%y %H.%M.%S");             # Capture the current date and time.
        [string] $logStdErr      = "$($stdErrLogPath)\$($logTime)-$($description).err";  # Log file: Standard Error
        [string] $logStdOut      = "$($stdOutLogPath)\$($logTime)-$($description).out";  # Log file: Standard Output
        [string] $fileOutput     = if ($isReport -eq $true)                              # Check if the output is a log or a report.
                                   {"$($reportPath)"} else {"$($LogStdOut)"};
        [string] $redirectStdOut = $null;                   # When STDOUT redirection to variable is
                                                            #  requested, this will be our buffer.
        # ----------------------------------------

        
        # Standard Output
        # -------------------
        # +++++++++++++++++++


        # Is there any data in the STDOUT?
        #  If so, we can continue to evaluate it.  Otherwise, skip over.
        if ("$($outputResultOut.Value)" -ne "")
        {
            # Should we store the STDOUT to a variable?
            if ($captureSTDOUT -eq $true)
            {
                # Because we need a memory-address, we will store the contents in a
                #  temporarily variable.  After that, store the value to the pointer.
                $redirectStdOut = $outputResultOut.Value;


                # Now store the information to the pointer; which can be used from
                #  the calling function.
                $stringOutput.Value = $redirectStdOut;
            } # If : Stored in Reference Var.


            # Should we store the STDOUT to a report file?
            ElseIf ($isReport -eq $true)
            {
                # Write the data to the report file.
                $this.WriteToFile("$($reportPath)", "$($outputResultOut.Value)") | Out-Null;
            } # If : Generating a Report


            # Store the STDOUT in a file?
            ElseIf ($logging -eq $true)
            {
                # Store the information to a text file.
                $this.WriteToFile("$($logStdOut)", "$($outputResultOut.Value)") | Out-Null;
            } # Else : Stored in a specific file
        } # If : STDOUT contains data
        


        # Standard Error
        # -------------------
        # +++++++++++++++++++


        # Store the STDERR in a logfile and is there data?
        If (($logging -eq $true) -and ("$($outputResultErr.Value)" -ne ""))
        {
            # Write the STDERR to a file
            $this.WriteToFile("$($logStdErr)", "$($outputResultErr.Value)") | Out-Null;
        } # If : Log the STDERR
    } # ExecuteCommandLog()




   <# Execute Command - Run [Using .NET API]
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
    # -------------------------------
    # Inputs:
    #  [string] Command
    #   The external executable to run by request.
    #  [string] Arguments
    #   Arguments to be used when executing the binary.
    #  [string] Project Path
    #   The absolute path of the project directory.
    #  [ref] {string} STDOUT Container
    #   Placeholder for the STDOUT information
    #    provided by the extCMD.
    #  [ref] {string} STDERR Container
    #   Placeholder for the STDERR information
    #    provided by the extCMD.
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
    #>
    Hidden [int] __ExecuteCommandRun([string] $command, `
                                    [string] $arguments, `
                                    [string] $projectPath, `
                                    [ref] $captureStdOut, `
                                    [ref] $captureStdErr)
    {
        # Declarations and Initializations
        # ----------------------------------------
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

        # Redirection Standard Out (Asynchronous)
        $asyncStdOut = New-Object -TypeName System.Runtime.CompilerServices.AsyncTaskMethodBuilder

        # Redirection Standard Error (Asynchronous)
        $asyncStdErr = New-Object -TypeName System.Runtime.CompilerServices.AsyncTaskMethodBuilder
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

            # Prevent a Deadlock from occurring by capturing
            #  the output and immediately cache before the
            #  buffer is full, once the buffer is full
            #  (which is a few Kilobytes) - a deadlock will
            #  occur.  Once a deadlock has occurred, nothing
            #  more can be done -- the shell itself MUST be
            #  forcefully terminated.
            # Resources that helped on resolving this issue:
            # >> https://stackoverflow.com/a/36539747
            # >> https://stackoverflow.com/a/36539226
            # -------
            # Standard Out (Asynchronous)
            $asyncStdOut = $processExec.StandardOutput.ReadToEndAsync()

            # Standard Error (Asynchronous)
            $asyncStdErr = $processExec.StandardError.ReadToEndAsync()
            # -------

            # Wait for the program to finish.
            $processExec.WaitForExit();
        } # Try : Executing command

        # An error occurred while trying to execute the command
        catch
        {
            # The command failed to be executed
            Write-Host "Failure to execute command upon request!`n`r$($_)";

            # Return an error
            return -255;
        } # Catch : Failed Executing Command


        # Capture the Output (STDOUT && STDERR)
        $captureStdErr.Value = $asyncStdErr.Result; # STDERR
        $captureStdOut.Value = $asyncStdOut.Result; # STDOUT


        # Return the result
        return $processExec.ExitCode;
    } # ExecuteCommandRun()

    #endregion
    

    #region Writing File Functions

   <# Write to File
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
    #>
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
        } # Try : Write to file

        catch
        {
            # Operation failed
            Write-Host "Operation Failed: $_";

            # Operation failed
            return $false;
        } # Catch : Failure to write


        # Assurance Fail-Safe; make sure that the file
        #  was successfully created on the filesystem.
        if ($this.CheckPathExists("$($file)") -eq $false)
        {
            # Operation failed because the file does not
            #  exist on the secondary storage.
            return $false;
        } # if : file didn't exist (after write)


        # Operation was successful
        return $true;
    } # WriteToFile()




   <# Create a Protable Document File (PDF)
    # -------------------------------
    # Documentation:
    #  This function will provide the ability to
    #   create a PDF file by taking the existing
    #   text-document as the main source, the
    #   output file that will be generated - is
    #   the PDF file.
    #
    #  NOTE: This function requires Microsoft Word
    #         to be installed on the host-system.
    #
    #  DEV.NOTE: iTextSharp is possible to use
    #         instead of MSWord, but you'll need
    #         to use 3rd party API's.  You are
    #         free to use it, if necessary.
    #         Please be sure to keep licensing
    #         in mind when implementing that
    #         dependency.
    #
    #  Resources:
    #   This help greatly with how to implement
    #    feature.
    #   - https://stackoverflow.com/a/23894977
    #   Microsoft Word API Commands
    #   - https://docs.microsoft.com/en-us/office/vba/api/word.application
    # -------------------------------
    # Input:
    #  [string] Source File
    #   The source text document that will be
    #    reflected to the PDF file.
    #  [string] Destination File
    #   The destination path and filename of the
    #    PDF file.
    # -------------------------------
    # Output:
    #  [bool] Exit code
    #    $false = Failure to create the PDF file.
    #    $true = Successfully created the PDF file.
    # -------------------------------
    #>
    [bool] CreatePDFFile([string] $sourceFile, [string] $destinationFile)
    {
        # Declarations and Initializations
        # ----------------------------------------
        [float] $wordVersion = 0.0;         # Microsoft Word Version
                                            #  May not be needed, but incase
                                            #  differences between versions
                                            #  causes problems, we can try to
                                            #  deter that from happening.
        [string] $txtContent = $null;       # This will hold the source text
                                            #  file's contents.
        [int] $wordPDFCode = 17;            # The code to export a document in
                                            #  PDF format.
            # https://docs.microsoft.com/en-us/office/vba/api/word.wdexportformat
        # ----------------------------------------



        # Dependency Check
        # - - - - - - - - - - - - - -
        #  Make sure that all of the resources are available before trying to use them
        #   This check is to make sure that nothing goes horribly wrong.
        # ---------------------------

        # Check to make sure that the source file actually exists.
        if ($this.CheckPathExists("$($sourceFile)") -eq $false)
        {
            # The source file does not exist.
            return $false;
        } # if : source file didn't exist
        
        # ---------------------------
        # - - - - - - - - - - - - - -


        # Detect Microsoft Word
        # -------------------
        # +++++++++++++++++++


        # First try to see if the user has Microsoft Word installed,
        #  if so, we can proceed through the rest of this function,
        #  otherwise - immediately stop.
        if ($(Test-Path HKLM:SOFTWARE\Classes\Word.Application) -eq $true)
        {
            # Microsoft Word was detected; try to create a new instance
            #  of the process.
            try
            {
                # Try to create the object instance
                [System.__ComObject]$msWord = New-Object -ComObject Word.Application;
            } # Try : Create MS Word Instance

            catch
            {
                # The host system may not have Microsoft Word ready to be
                #  use or has a Microsoft Word version that is not
                #  compatible with PowerShell integration.
                return $false;
            } # Catch : Failure to create MS Word Instance
        } # If : Microsoft Word Installed \ Ready

        # Microsoft Word was not detected or is not compatible with PowerShell
        #  integration.
        else
        {
            return $false;
        } # Else : Failure to find Microsoft Word



        # Setup the Environment
        # -------------------
        # +++++++++++++++++++


        # Get the version of MS Word.
        $wordVersion = $msWord.Version;


        # Hide the instance; user does not need to see it.
        $msWord.Visible = $false;



        # Setup the Document
        # -------------------
        # +++++++++++++++++++


        # Dev. Notes:
        #    Caching the data to a string (Document.TypeText) is far too taxing and
        #    causes more problems while solving - bare minimum.
        #     > Not ALL of the document will be cached, if the file is too big - contents
        #       will be missing from the TypeText.
        #     > New Lines are not appended to the document, unless 'Get-Content -Raw' is
        #       used.
        #     > Font properties must be adjusted.
        #    It is far better to open the existing document and work with that directly.

        # Open the document directly.
        $wordDocument = $msWord.Documents.Open("$($sourceFile)");

        

        # Resource to change the document's orientation to Landscape.
        #  > https://blogs.technet.microsoft.com/heyscriptingguy/2006/08/31/how-can-i-set-the-document-orientation-in-microsoft-word-to-landscape/
        
        # Set the document's orientation to 'Landscape'.
        $wordDocument.PageSetup.Orientation = 1;



        # Export the Document
        # -------------------
        # +++++++++++++++++++


        # Export the document
        $wordDocument.ExportAsFixedFormat($destinationFile, $wordPDFCode);
        


        # Finishing Up
        # -------------------
        # +++++++++++++++++++


        # Close the document without saving the document.
        $wordDocument.Close(0);


        # Destroy the Word instance cleanly
        $msWord.Quit();



        # Finalizing
        # -------------------
        # +++++++++++++++++++


        # Check to make sure that the PDF file was saved properly.
        if ($this.CheckPathExists("$($destinationFile)") -eq $false)
        {
            # The PDF file was not found
            return $false;
        } # if : file didn't exist


        # Successfully created the document
        return $true;
    } # CreatePDFFile()

    #endregion


    #region Directory and File Management Functions

   <# Make a New Directory
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
    #>
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




   <# Check Path Exists
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
    #>
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




   <# Delete Directory
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
    #>
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




   <# Delete File
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
    #>
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


    #region File Integrity

   <# File Hash
    # -------------------------------
    # Documentation:
    #  This function will provide the hash value
    #   in regards to a specific data-file.
    # -------------------------------
    # Input:
    #  [string] Absolute Path
    #   The absolute path of a data-file.
    #  [string] Hash Algorithm
    #   Typical values can be: "MD5" or "SHA1".
    #    For a complete list of hash algorithms, please check the documentation:
    #    https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-filehash
    # -------------------------------
    # Output:
    #  [string] Hash Value code
    #    $null = Error for File does not exist.
    #    All other values will be the hash code.
    # -------------------------------
    #>
    [string] FileHash([string] $path, [string] $hashAlgorithm)
    {
        # Declarations and Initializations
        # ----------------------------------------
        [string] $hashValue = $null;      # The hash value regarding specified file.

        # SPECIAL OBJECTS
        # - - - - - - - -

        # FileHashInfo; used for capturing the hash information from a specific data file.
        $hashInfo = New-Object -TypeName Microsoft.PowerShell.Commands.FileHashInfo;
        # ----------------------------------------


        # First check if the file actually exists within the user's filesystem
        if ($this.CheckPathExists("$($path)") -eq $false)
        {
            # Because the file was not on the user's filesystem at the specified
            #  path, return null to signify an error.
            return $null;
        } # if : File not found
        

        # Try to get the hash of the file
        try
        {
            # Try to get the hash of the file and cache it.
            #  NOTE: Do not try to out-right store the 'hash' value explicitly as
            #        this causes a performance degrade when an issue creeps up.
            $hashInfo = Get-FileHash -LiteralPath "$($path)" -Algorithm "$($hashAlgorithm)" -ErrorAction Stop;

            # From the cache data, get the hash and save it.
            $hashValue = $hashInfo.Hash;
        } # Try : Get hash value

        # Catch if an error occured
        catch
        {
            # Failure to obtain the hash value.
            $hashValue = $null;
        } # Catch : Failure to fetch value


        # Return the value of the hash data, if it was present.
        return "$($hashValue)";
    } # FileHash()

    #endregion
} # IOCommon