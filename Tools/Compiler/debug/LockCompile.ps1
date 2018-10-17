# Main [Entry Point]
# --------------------------
# Documentation
#    This function is our main program entry point.
# --------------------------
function main()
{
    # Declarations and Initializations
    # ---------------------------------
    # File name that we want to lock
    Set-Variable -Name "fileName" -Value "compile.ps1" `
        -Scope Local;
    # Path of the Compile Script that we want to lock
    Set-Variable -Name "path" -Value "..\..\..\$($fileName)" `
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

    # Lock the file
    $fd = [System.IO.File]::Open($path, $mode, $access, $share);

    # Tell the user that the file has been locked
    Write-Host "$($fileName) has been locked!";

    # What for the user to press the 'enter' key.
    Read-Host -Prompt "Press Enter key to unlock $($fileName). . .";

    # Unlock the file
    $fd.close();
} # main()




# Start the program
main; 