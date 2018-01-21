blih -u marc.perez@epitech.eu repository create $1
blih -u marc.perez@epitech.eu repository setacl $1 ramassage-tek r
echo "ramassage-tek:r"
git clone git@git.epitech.eu:/marc.perez@epitech.eu/$1
