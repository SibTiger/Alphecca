# Program Entry Point (Spine)
# --------------------------
# Documentation:
#     This is the main spine of the program.
# --------------------------
function main()
{
    # Display PowerShell Version
    PSVersion;

    # Determine if the PowerShell process is executed in a 64bit environment or 32bit environment
    PSProcessWidth;

    # Prevent destroying the window process before the user sees the results
    Read-Host -Prompt "Press Enter to close"
} # main()




# PowerShell Version
# --------------------------
# Documentation:
#     This function will display the Host's PowerShell version
#     that is available.  This is important as some CMDLets are
#     not available older versions.
# --------------------------
function PSVersion()
{
    Write-Host "Power Shell Version: " -NoNewLine;
    Write-Host $PSVersionTable.PSVersion;
} # PSVersion()





# PowerShell 32/64 Bit-Width
# --------------------------
# Documentation
#    This function will display the PowerShell's process
#    word-width.  This could be important later on, depending
#    on specialized operations.
# --------------------------
function PSProcessWidth()
{
    # Declarations and Initializations
    # -----------------------------------
    # Detect the current environment.
    Set-Variable -Name "detectedProcess" -Value [Environment]::Is64BitProcess;
    # Used for displaying the results nicely to the user.
    Set-Variable -Name "detectedProcessNice"
    # -----------------------------------
    
    # With the environment detected, determine the process environment
    #  and prepare to show the results to the user.
    if ($detectedProcess)
    {
        Set-Variable -Name "detectedProcessNice" -Value "64bit"
    }
    else
    {
        Set-Variable -Name "detectedProcessNice" -Value "32bit"
    }


    Write-Host "This PowerShell instance is running under a" `
               $detectedProcessNice "environment"
} # PSProcessWidth()




# Execute the main
main

# Exit
Exit