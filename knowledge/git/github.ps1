git add . 
git commit -m "message"
git push

# add only one or two folders/files
git add filename foldername/ 
# check status afterwards to see which files are now staged
git status

# delete staged files
git restore --staged pfad/zur/datei

# check for gitignore expression that ignores file:
git check-ignore -v file
git check-ignore -v foldername/