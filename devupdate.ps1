# Robocopy.exe C:\Users\Ismael\Documents\notes\sites\djismgaming.github.io\documentation\ C:\Users\Ismael\Documents\GitHub\djismgaming.github.io\docs\documentation /mir
# Robocopy.exe C:\Users\Ismael\Documents\notes\sites\djismgaming.github.io\posts\ C:\Users\Ismael\Documents\GitHub\djismgaming.github.io\docs\blog\posts /mir

# looping this script

while ($true) {

    # Loop start

    # Define source and destination paths
    $posts = "C:\Users\Ismael\Documents\notes\sites\djismgaming.github.io\posts\"
    $postsdestination = "C:\Users\Ismael\Documents\GitHub\djismgaming.github.io\docs\blog\posts"

    $documentation = "C:\Users\Ismael\Documents\notes\sites\djismgaming.github.io\documentation\"
    $documentationdestination = "C:\Users\Ismael\Documents\GitHub\djismgaming.github.io\docs\documentation\"

    $images = "C:\Users\Ismael\Documents\notes\sites\djismgaming.github.io\images\"
    $imagesdestination = "C:\Users\Ismael\Documents\GitHub\djismgaming.github.io\docs\images\"

    # Run robocopy with /MIR option
    robocopy $posts $postsdestination /MIR
    robocopy $documentation $documentationdestination /MIR
    robocopy $images $imagesdestination /MIR

    # Wait for 5 seconds to loop
    Start-Sleep -Seconds 5

    # Loop end
}
