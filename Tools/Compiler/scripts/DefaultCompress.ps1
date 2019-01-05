# Default Compress
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


    # Get Hash
    # ---------------
    # Retrieve the Hash of the archive datafile.
    Hidden [bool] $__getHash;


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
} # DefaultCompress




# Default Compression Level [ENUM]
# -------------------------------
# Associated with what type of compression level the
#  end-user prefers when compacting an archive datafile.
# -------------------------------
enum DefaultCompressionLevel
{
    Optimal = 0;         # Best Compression (takes time)
    Fastest = 1;         # Light Compression (little time)
    NoCompression = 2;   # Store [No Compression]
} # GitCommitType