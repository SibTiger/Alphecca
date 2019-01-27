<# Default Compress
 # ------------------------------
 # ==============================
 # ==============================
 # This class holds settings regarding the use of .NET's
 #  System.IO.Compression (aka: .NET Compression).
 #  Because this was part of .NET 4.5 version and later,
 #  it is now possible for end-user's to use the native
 #  Zip provided - without requiring external API's or
 #  3rd party applications.  This should hypothetically
 #  support all targeted versions of Windows platforms.
 # Requirements: .NET Framework 4.5
 #>



class DefaultCompress
{
    # Member Variables :: Properties
    # =================================================
    # =================================================


    #region Private Variables (emulated)

    # Compression Level
    # ---------------
    # The compression level when generating an
    #  archive datafile.
    Hidden [DefaultCompressionLevel] $__compressionLevel;


    # Provide Hash
    # ---------------
    # Retrieve the Hash of the archive datafile.
    Hidden [bool] $__provideHash;


    # Verify Build
    # ---------------
    # Test the archive datafile to assure it is not
    #  corrupted.
    Hidden [bool] $__verifyBuild;


    # Generate Report
    # ---------------
    # Generate a report about the archive datafile.
    Hidden [bool] $__generateReport;


    # Report Path
    # ---------------
    # Store the report at a specific directory.
    Hidden [string] $__reportPath;

    #endregion



    # Member Functions :: Methods
    # =================================================
    # =================================================


    
    #region Constructor Functions
    
    # Default Constructor
    DefaultCompress()
    {
        # Compression Level
        $this.__compressionLevel = 0;

        # Provide Hash
        $this.__provideHash = $false;

        # Verify Build
        $this.__verifyBuild = $true;

        # Generate report
        $this.__generateReport = $false;

        # Report Path
        $this.__reportPath = "$($global:_DIRECTORYLOGROOT_)\dotNET_Compression";
    } # Default Constructor




    # User Preference : On-Load
    DefaultCompress([DefaultCompressionLevel] $compressionLevel,
                    [bool] $provideHash,
                    [bool] $verifyBuild,
                    [bool] $generateReport)
    {
        # Compression Level
        $this.__compressionLevel = $compressionLevel;

        # Provide Hash
        $this.__provideHash = $provideHash;

        # Verify Build
        $this.__verifyBuild = $verifyBuild;

        # Generate report
        $this.__generateReport = $generateReport;

        # Report Path
        $this.__reportPath = "$($global:_DIRECTORYLOGROOT_)\dotNET_Compression";
    } # Default Constructor

    #endregion



    #region Getter Functions

   <# Get Compression Level
    # -------------------------------
    # Documentation:
    #  Returns the value of the Compression Level variable.
    # -------------------------------
    # Output:
    #  [DefaultCompressionLevel] Compression Level
    #   the value of the Compression Level.
    # -------------------------------
    #>
    [DefaultCompressionLevel] GetCompressionLevel()
    {
        return $this.__compressionLevel;
    } # GetCompressionLevel()




   <# Get Provide Hash
    # -------------------------------
    # Documentation:
    #  Returns the value of the Provide Hash variable.
    # -------------------------------
    # Output:
    #  [bool] Provide Hash
    #   the value of the Provide Hash.
    # -------------------------------
    #>
    [bool] GetProvideHash()
    {
        return $this.__provideHash;
    } # GetProvideHash()




   <# Get Verify Build
    # -------------------------------
    # Documentation:
    #  Returns the value of the Verify Build variable.
    # -------------------------------
    # Output:
    #  [bool] Verify Build
    #   the value of the Verify Build.
    # -------------------------------
    #>
    [bool] GetVerifyBuild()
    {
        return $this.__verifyBuild;
    } # GetVerifyBuild()




   <# Get Generate Report
    # -------------------------------
    # Documentation:
    #  Returns the value of the Generate Report variable.
    # -------------------------------
    # Output:
    #  [bool] Generate Report
    #   the value of the Generate Report.
    # -------------------------------
    #>
    [bool] GetGenerateReport()
    {
        return $this.__generateReport;
    } # GetGenerateReport()




   <# Get Report Path
    # -------------------------------
    # Documentation:
    #  Returns the value of the Report Path variable.
    # -------------------------------
    # Output:
    #  [bool] Report Path
    #   the value of the Report Path.
    # -------------------------------
    #>
    [bool] GetReportPath()
    {
        return $this.__reportPath;
    } # GetReportPath()

    #endregion



    #region Setter Functions

   <# Set Compression Level
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Compression Level variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Success; value has been changed.
    #   false = Failure; could not set a new value.
    # -------------------------------
    #>
    [bool] SetCompressionLevel([DefaultCompressionLevel] $newVal)
    {
        # Because the value must fit within the
        #  'DefaultCompressionLevel' datatype, there really is
        #  no point in checking if the new requested value is
        #  'legal'.  Thus, we are going to trust the value and
        #  automatically return success.
        $this.__compressionLevel = $newVal;

        # Successfully updated.
        return $true;
    } # SetCompressionLevel()




   <# Set Provide Hash
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Provide Hash variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Success; value has been changed.
    #   false = Failure; could not set a new value.
    # -------------------------------
    #>
    [bool] SetProvideHash([bool] $newVal)
    {
        # Because the value is either true or false, there
        #  really is no point in checking if the new requested
        #  value is 'legal'.  Thus, we are going to trust the
        #  value and automatically return success.
        $this.__provideHash = $newVal;

        # Successfully updated.
        return $true;
    } # SetProvideHash()




   <# Set Verify Build
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Verify Build variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Success; value has been changed.
    #   false = Failure; could not set a new value.
    # -------------------------------
    #>
    [bool] SetVerifyBuild([bool] $newVal)
    {
        # Because the value is either true or false, there
        #  really is no point in checking if the new requested
        #  value is 'legal'.  Thus, we are going to trust the
        #  value and automatically return success.
        $this.__verifyBuild = $newVal;

        # Successfully updated.
        return $true;
    } # SetVerifyBuild()




   <# Set Generate Report
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Generate Report variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Success; value has been changed.
    #   false = Failure; could not set a new value.
    # -------------------------------
    #>
    [bool] SetGenerateReport([bool] $newVal)
    {
        # Because the value is either true or false, there
        #  really is no point in checking if the new requested
        #  value is 'legal'.  Thus, we are going to trust the
        #  value and automatically return success.
        $this.__generateReport = $newVal;

        # Successfully updated.
        return $true;
    } # SetGenerateReport()




   <# Get Report Path
    # -------------------------------
    # Documentation:
    #  Sets a new value for the Report Path variable.
    # -------------------------------
    # Output:
    #  [bool] Status
    #   true = Success; value has been changed.
    #   false = Failure; could not set a new value.
    # -------------------------------
    #>
    [bool] SetReportPath([string] $newVal)
    {
        # Inspect to see if the path exists
        if (Test-Path $newVal.trim())
        {
            # Path exists; use it as requested
            $this.__reportPath = $newVal;
            return $true;
        } # IF: Path Exists

        # Failure; Path does not exist.
        return $false;
    } # SetReportPath()

    #endregion
} # DefaultCompress




<# Default Compression Level [ENUM]
 # -------------------------------
 # Associated with what type of compression level the
 #  end-user prefers when compacting an archive datafile.
 # -------------------------------
 #>
enum DefaultCompressionLevel
{
    Optimal = 0;         # Best Compression (takes time)
    Fastest = 1;         # Light Compression (little time)
    NoCompression = 2;   # Store [No Compression]
} # DefaultCompressionLevel