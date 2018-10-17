# Lock Compile Program
# =========================
# This program is designed to lock the compile shellscript.
#  This is intended for debugging with the make shellscript.
#  The error that should be provided from the make program
#   will relate to the unability to delete or write to the
#   file.  Without this, I have to fiddle around with the ACL.
#   Locking the file is much easier and less time consuming.
# =========================




# Main [Entry Point]
# --------------------------
# Documentation
#    This function is our main program entry point.
# --------------------------
# Return [int]
#    0 = Program finished successfully
#    1 = Program finished with errors
# --------------------------
function main()
{
    # Declarations and Initializations
    # ---------------------------------
    # File name that we want to lock
    Set-Variable -Name "fileName" -Value "compile.ps1" `
        -Scope Local;
    # Path of the Compile Script that we want to lock
    Set-Variable -Name "path" -Value "$($PSScriptRoot)\..\..\..\$($fileName)" `
        -Scope Local;
    # File Mode
    Set-Variable -Name "mode" -Value "Open" `
        -Scope Local;
    # File Access
    Set-Variable -Name "access" -Value "Read" `
        -Scope Local;
    # File Share
    Set-Variable -Name "share" -Value "None" `
        -Scope Local;
    # ---------------------------------
    
    # Check if the file exists and then execute the appropriate statements.
    if (Test-Path -Path $path)
    {
        # Lock the file
        $fd = [System.IO.File]::Open($path, $mode, $access, $share);

        # Tell the user that the file has been locked
        Write-Host "$($fileName) has been locked!";

        # What for the user to press the 'enter' key.
        Read-Host -Prompt "Press Enter key to unlock $($fileName). . .";

        # Unlock the file
        $fd.close();

        # Close with success signal
        return 0;
    } # File exists
    else
    {
        # Warn the user that the file was not found
        Write-Host "<!> Unable to find $($fileName) <!>";
        write-Host "Assure that the $($fileName) exists within the root of the project source.";
        
        # Close with a failure signal
        return 1;
    } # File does not exist
} # main()




# Start the program
$errorSignal = $(main);

# Terminate the program and provide the Error Code to the OS
exit $errorSignal;