﻿# Project Information
# ------------------------------
# ==============================
# ==============================
# This class holds all information regarding the desired project
#  that we will be essentially compiling.  Such information is
#  essentially basic, such as: project name, code name, output -
#  filename, and project URLs.  This is going to be helpful for
#  the program to be much more moduler and yet also helpful for
#  the end-user that will be using this program tool.




class ProjectInformation
{
    # Member Variables :: Properties
    # =================================================
    # =================================================
    # PRIVATE (emulated)


    # Project's Name
    # ---------------
    # The formal name of the project.
    Hidden [String] $__projectName;


    # Project's Code Name (or Version Code Name)
    # ---------------
    # The code name of the project or of that version.
    Hidden [String] $__codeName;


    # Output Filename
    # ---------------
    # The filename of the archive data file in which this program
    # will create as requested by the end-user.
    Hidden [String] $__fileName;


    # Project's Website
    # ---------------
    # The project's official website; which can be accessed by the
    # end-user by request.  This can be helpful to the user, in-which
    # they may check out the project's latest public announcements
    # and insights regarding the project.
    Hidden [String] $__urlWebsite;


    # Project's Help Documentation
    # ---------------
    # The project's official wikipedia; which can be accessed by the
    # end-user by request.  This can greatly be helpful to the user,
    # as they may view the project's help-documentation for abroad
    # reasons but not limited to using this very tool.
    #  NOTE: Wiki's are usually provided in some Developer\Repo
    #  Web-Services, such as GitHub.
    Hidden [String] $__urlWiki;


    # Project's Repository
    # ---------------
    # The project's official repository; which can be accessed by the
    # end-user by request.  This can allow the user to view the project's
    # source code via their preferred web-browser.
    # Prime example of Repositories:
    #  GitHub, SourceForge, BitBucket, GitLab, and many more.
    Hidden [String] $__urlSource;
    



    # Member Functions :: Methods
    # =================================================
    # =================================================
    # PUBLIC


    # Get Project Name
    # -------------------------------
    # Documentation:
    #  Returns the value of the Project Name variable.
    # -------------------------------
    # Output:
    #  [string] Project Name
    #   The name of the project.
    # -------------------------------
    [String] GetProjectName()
    {
        return $this.__projectName;
    } # GetProjectName()



    # Get Project's Code Name
    # -------------------------------
    # Documentation:
    #  Returns the value of the Code Name variable.
    # -------------------------------
    # Output:
    #  [string] Project's Code Name
    #   The code name of the project or version.
    # -------------------------------
    [String] GetCodeName()
    {
        return $this.__codeName;
    } # GetCodeName()



    # Get Filename
    # -------------------------------
    # Documentation:
    #  Returns the value of the filename variable.
    # -------------------------------
    # Output:
    #  [string] Archive datafile filename
    #   The filename to be used for the archive datafile.
    # -------------------------------
    [String] GetFilename()
    {
        return $this.__fileName;
    } # GetFilename()



    # Get Project's Official Website
    # -------------------------------
    # Documentation:
    #  Returns the value of the Website variable.
    # -------------------------------
    # Output:
    #  [string] Project's Website
    #   The project's official website.
    # -------------------------------
    [String] GetProjectWebsite()
    {
        return $this.__urlWebsite;
    } # GetProjectWebsite()



    # Get Project's Official Documentation
    # -------------------------------
    # Documentation:
    #  Returns the value of the Wiki\Documentation variable.
    # -------------------------------
    # Output:
    #  [string] Project's Wikipedia
    #   The project's official wikipedia\documentation webpage.
    # -------------------------------
    [String] GetProjectWiki()
    {
        return $this.__urlWiki;
    } # GetProjectWiki()



    # Get Project's Official Repository
    # -------------------------------
    # Documentation:
    #  Returns the value of the Source variable.
    # -------------------------------
    # Output:
    #  [string] Project's Repository
    #   The project's official repository (web view) path.
    # -------------------------------
    [String] GetProjectSource()
    {
        return $this.__urlSource;
    } # GetProjectSource()
} # ProjectInformation