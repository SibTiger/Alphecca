# Fetch User Input
# --------------------------
# Documentation
#    This function will get input from the user.
# --------------------------
# Return [String]
#    The user's given request reflected from the provided menu or confirmation inquiry.
# --------------------------
function FetchUserInput()
{
    # Because I love Python's input prompt, we will emulate it here.
    #  I find this to be easier on the user to unify an action from the end-user.
    Write-Host ">>>>> " -NoNewline

    # Get input from the user.
    Set-Variable -Name "stdInput" -Value $Host.UI.ReadLine()

    # Return the value as a string
    return [string]$stdInput
} # FetchUserInput()