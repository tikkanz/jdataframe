loc_z_=: 3 : 'jpath > (4!:4 <''y'') { 4!:3 $0'  NB. pathname of script calling it
ProjPath=: fpath_j_ loc ''                      NB. folder containing this file

NB. =========================================================
NB. Build & Test
NB. =========================================================
load ProjPath,'/build.ijs'   NB. rebuild
load ProjPath,'/dataframe.ijs'   NB. reload
NB. run tests here
echo 'Running tests...'
NB. load ProjPath,'/test/test1.ijs'
