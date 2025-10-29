# Robocopy.exe C:\Users\Ismael\Documents\notes\sites\djismgaming.github.io\documentation\ C:\Users\Ismael\Documents\GitHub\djismgaming.github.io\docs\documentation /mir
# Robocopy.exe C:\Users\Ismael\Documents\notes\sites\djismgaming.github.io\posts\ C:\Users\Ismael\Documents\GitHub\djismgaming.github.io\docs\blog\posts /mir

# Define source and destination paths
$posts = "C:\Users\Ismael\notes\sites\djismgaming.github.io\posts"
$postsdestination = "C:\Users\Ismael\Documents\GitHub\djismgaming.github.io\docs\blog\posts"

$documentation = "C:\Users\Ismael\notes\sites\djismgaming.github.io\documentation"
$documentationdestination = "C:\Users\Ismael\Documents\GitHub\djismgaming.github.io\docs\documentation\"

# $images = "C:\Users\Ismael\Documents\notes\sites\djismgaming.github.io\images\"
# $imagesdestination = "C:\Users\Ismael\Documents\GitHub\djismgaming.github.io\docs\images\"

# Run robocopy with /MIR option
robocopy $posts $postsdestination /MIR
robocopy $documentation $documentationdestination /MIR
# robocopy $images $imagesdestination /MIR

# Navigate to the Git repository's root
$repoRoot = "C:\Users\Ismael\Documents\GitHub\djismgaming.github.io"
Set-Location $repoRoot

# Stage all changes in Git
git add .

# Create a commit with a message including a timestamp
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$commitMessage = "$timestamp"
git commit -m $commitMessage

# Optional: Push changes to the remote repository
git push
