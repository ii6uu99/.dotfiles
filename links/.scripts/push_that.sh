git pull
find -name '#*#' -delete -o -name '*~' -delete -o -name 'vgcore.*' -delete
make fclean
git config --global user.email marc.perez@epitech.eu
git add --all
git commit -a -m "$*"
git push
