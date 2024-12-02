# Define source and destination paths
$source = "C:\Users\Ismael\Documents\notes\sites\djismgaming.github.io\posts\"
$destination = "C:\Users\Ismael\Documents\GitHub\djismgaming.github.io\docs\blog"

# Run robocopy with /MIR option
robocopy $source $destination /MIR

# Navigate to the Git repository's root
$repoRoot = "C:\Users\Ismael\Documents\GitHub\djismgaming.github.io"
Set-Location $repoRoot

# Stage all changes in Git
git add .

# Create a commit with a message including a timestamp
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$commitMessage = "New post added on $timestamp"
git commit -m $commitMessage

# Optional: Push changes to the remote repository
git push
