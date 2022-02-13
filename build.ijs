NB. Reads content of all files in .jproj as a string
NB. That string can be written into a single file to 
NB. avoid relative path references
NB. readsource_jp_ 'Dev/jdataframe'

NB. Writes content of all files in .jproj into a single file. 
NB. Reads all files listed in .jproj

require 'project'
loc_z_=: 3 : 'jpath > (4!:4 <''y'') { 4!:3 $0'  NB. pathname of script calling it
ProjPath=: fpath_j_ loc ''                      NB. folder containing this file

Proj_Src=: ProjPath
Proj_Tgt=: ProjPath,'/dataframe.ijs'
writesource_jp_ Proj_Src;Proj_Tgt

echo 'Built file: ',Proj_Tgt
echo 'From: ',Proj_Src
