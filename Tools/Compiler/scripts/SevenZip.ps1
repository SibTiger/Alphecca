# Seven Zip
# ------------------------------
# ==============================
# ==============================
# This class holds settings regarding the use of 7Zip
#  aswell as functions in order to perform specific
#  operations relating to compacting archive datafiles.
#  This is an optional setting and must be enabled by
#  the user in order to use it.
# NOTE: This is required in order to generate 7Z (PK7)
#   archive data files.
# IMPORTANT NOTE:
#  In order to use 7Zip features in this program, the
#   end-user must also have 7Zip installed on the host
#   system.  If the program is not installed, then the
#   features are not available for use.




class SevenZip
{
    # Member Variables :: Properties
    # =================================================
    # =================================================


    #region Private Variables (emulated)

    # Method
    # ---------------
    # The method in which to compact the archive datafile.
    Hidden [SevenZipCompressionMethod] $__Method;


    # Algorithm [PK3|Zip]
    # ---------------
    # The algorithm to use when using the Zip Method
    Hidden [SevenZipAlgorithmZip] $__algorithmZip;


    # Algorithm [PK7|7Zip]
    # ---------------
    # The algorithm to use when using the 7Zip Method
    Hidden [SevenZipAlgorithmZip] $__algorithm7Zip;


    # Use Multithread
    # ---------------
    # When true, this will allow 7Zip to use multithreaded
    #  operations when available.
    Hidden [bool] $__useMultithread;


    # Compression Level
    # ---------------
    # How tightly to compact the files.
    Hidden [SevenCompressionLevel] $__compressionLevel;


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


    #region Getter Functions

    # Get Compression Method
    # -------------------------------
    # Documentation:
    #  Returns the value of the Compression Method variable.
    # -------------------------------
    # Output:
    #  [SevenZipCompressionMethod] Compression Method
    #   the value of the Compression Method.
    # -------------------------------
    [SevenZipCompressionMethod] GetCompressionMethod()
    {
        return $this.__Method;
    } # GetCompressionMethod()




    # Get Algorithm [PK3|Zip]
    # -------------------------------
    # Documentation:
    #  Returns the value of the Algorithm variable.
    # -------------------------------
    # Output:
    #  [SevenZipAlgorithmZip] Algorithm [ZIP]
    #   the value of the Compression Algorithm.
    # -------------------------------
    [SevenZipAlgorithmZip] GetAlgorithmZip()
    {
        return $this.__algorithmZip;
    } # GetAlgorithmZip()




    # Get Algorithm [PK7|7Zip]
    # -------------------------------
    # Documentation:
    #  Returns the value of the Algorithm variable.
    # -------------------------------
    # Output:
    #  [SevenZipAlgorithmZip] Algorithm [7Zip]
    #   the value of the Compression Algorithm.
    # -------------------------------
    [SevenZipAlgorithmZip] GetAlgorithm7Zip()
    {
        return $this.__algorithm7Zip;
    } # GetAlgorithm7Zip()




    # Get Use Multithread
    # -------------------------------
    # Documentation:
    #  Returns the value of the Use Multithread variable.
    # -------------------------------
    # Output:
    #  [bool] Use Multithread
    #   the value of the Use Multithread.
    # -------------------------------
    [bool] GetUseMultithread()
    {
        return $this.__useMultithread;
    } # GetUseMultithread()




    # Get Compression Level
    # -------------------------------
    # Documentation:
    #  Returns the value of the Compression Level variable.
    # -------------------------------
    # Output:
    #  [SevenCompressionLevel] Compression Level
    #   the value of the Compression Level.
    # -------------------------------
    [SevenCompressionLevel] GetCompressionLevel()
    {
        return $this.__compressionLevel;
    } # GetCompressionLevel()




    # Get Provide Hash
    # -------------------------------
    # Documentation:
    #  Returns the value of the Provide Hash variable.
    # -------------------------------
    # Output:
    #  [bool] Provide Hash
    #   the value of the Provide Hash.
    # -------------------------------
    [bool] GetProvideHash()
    {
        return $this.__provideHash;
    } # GetProvideHash()




    # Get Verify Build
    # -------------------------------
    # Documentation:
    #  Returns the value of the Verify Build variable.
    # -------------------------------
    # Output:
    #  [bool] Verify Build
    #   the value of the Verify Build.
    # -------------------------------
    [bool] GetVerifyBuild()
    {
        return $this.__verifyBuild;
    } # GetVerifyBuild()




    # Get Generate Report
    # -------------------------------
    # Documentation:
    #  Returns the value of the Generate Report variable.
    # -------------------------------
    # Output:
    #  [bool] Generate Report
    #   the value of the Generate Report.
    # -------------------------------
    [bool] GetVerifyBuild()
    {
        return $this.__generateReport;
    } # GetVerifyBuild()




    # Get Report Path
    # -------------------------------
    # Documentation:
    #  Returns the value of the Report Path variable.
    # -------------------------------
    # Output:
    #  [string] Report Path
    #   the value of the Report Path.
    # -------------------------------
    [string] GetReportPath()
    {
        return $this.__reportPath;
    } # GetReportPath()

    #endregion
} # SevenZip




# 7Zip Compression Method [ENUM]
# -------------------------------
# Associated with what type of 7Z Method the end-user
#  prefers when compacting an archive datafile.
# -------------------------------
enum SevenZipCompressionMethod
{
    Zip = 0;      # Zip format [PK3]
    SevenZip = 1; # 7Zip format [PK7]
} # SevenZipCompressionMethod




# 7Zip Algorithm Zip [ENUM]
# -------------------------------
# Associated with what type of 7Z Compression Algorithm
#  the end-user prefers when compacting an archive
#  datafile.
# -------------------------------
enum SevenZipAlgorithmZip
{
    Deflate = 0;  # Default
    LZMA = 1;     # LZMA Algo.
    BZip2 = 2;    # BZip2 Algo.
} # SevenZipAlgorithmZip




# 7Zip Algorithm 7Zip [ENUM]
# -------------------------------
# Associated with what type of 7Z Compression Algorithm
#  the end-user prefers when compacting an archive
#  datafile.
# -------------------------------
enum SevenZipAlgorithm7Zip
{
    LZMA2 = 0;    # Default
    LZMA = 1;     # LZMA Algo.
    BZip2 = 2;    # BZip2 Algo.
    PPMd = 3;     # PPMd Algo.
} # SevenZipAlgorithm7Zip




# 7Zip Compression Level [ENUM]
# -------------------------------
# Associated with what type of compression level the
#  end-user prefers when compacting an archive datafile.
# -------------------------------
enum SevenCompressionLevel
{
    Store = 0;    # Store [No Compression] {0}
    Minimal = 1;  # Minimal compression    {3}
    Normal = 2;   # Standard compression   {5}
    Maximum = 3;  # Maximum compression    {9}
} # DefaultCompressionLevel