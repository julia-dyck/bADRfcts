
system("R CMD Rd2pdf C:/Users/jdyck/sciebo/ADR_bayes_R/bADRfcts") # uni office

              # home office

# if problems occur, try
# system("R CMD Rd2pdf D:/J/Sciebo/Babi_Odile/Paketerstellung/Nehis_Package_akt/EgoCor --no-clean")

### If this does not work, try the following:

# After installing the package, run the following steps from inconsolata README.
# Open a cmd (Windows Eingabeaufforderung) and run:
#
# initexmf --update-fndb
# initexmf --edit-config-file updmap
#
# The latter command should open updmap.cfg in your default editor, commonly Notepad.
# Add the line below, then save and close.
#
# Map zi4.map
#
# Now in the command window, type
#
# initexmf --mkmaps


# Source: https://tex.stackexchange.com/questions/125274/error-font-ts1-zi4r-at-540-not-found
