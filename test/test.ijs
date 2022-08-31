coinsert 'pdataframe'
require 'tables/csv'
B=: fixcsv noun define
Id,Name,Job,Status
3,Jerry,Unemployed,Married
6,Jan,CEO,Married
5,Frieda,student,Single
1,Alex,Waiter,Separated
)

Bdf=: 1 makeDataFrame B
assert Bdf -: ({. makeDataFrame }.) B
Ivt=. (<1e6 + ?~1e5), ifa 1e5 5 ?@$ 0   NB. create numeric Inverted table

echo tsort dfp Bdf
echo dfSort Bdf
echo tmakenumcol dfp tsort dfp Bdf
echo ('9';'Brian';'Scientist';'Divorced') tappend~ dfp Bdf
echo (('9';'Mary';'Manager';'Divorced') ,~ ])&.dftoTable Bdf
echo tshow Ivt
echo tshow dfp makeDataFrame Ivt
echo tshow dfp makeDataFrame 3&}.&.> Ivt
echo dfShow makeDataFrame 3&}.&.> Ivt
echo dfShow 1 3 dfSelect makeDataFrame Ivt
echo dfShow ('column_2';'column_4') dfSelect makeDataFrame Ivt
echo dfShow ('column_2';'column_4') dfDrop makeDataFrame Ivt
echo dfShow 'column_2' dfDrop makeDataFrame Ivt

NB. Tests from Inverted Table Essay
x0=. ];._1 ' Smith Jones Chan Wilson Saxon Angelo Smith Wilson'
x1=. ];._1 ' John Dakota Wilson Diana Joan Roberto John John'
x2=. 0 1 0 1 1 0 0 1
x3=. 23 29 47 23 31 19 23 23
x4=. 1.25 0.97 2.11 1.25 2.8 1.11 1.25 1.25
Xivt=: x0;x1;x2;x3;x4

X=: fixcsv noun define
Smith,John,0,23,1.25
Jones,Dakota,1,29,0.97
Chan,Wilson,0,47,2.11
Wilson,Diana,1,23,1.25
Saxon,Joan,1,31,2.8
Angelo,Roberto,0,19,1.11
Smith,John,0,23,1.25
Wilson,John,1,23,1.25
)

Xivt -: tmakenumcol ifa X  NB. reconstruct X (from Essay) using csv.

cnames=. ;:'lastname firstname sex age score'
Xdf=: tmakenumcol dfp cnames makeDataFrame X

echo ttally dfp Xdf
echo tshow dfp Ydf=: 3 1 1 2 tfrom dfp Xdf NB. From
echo Xdf tindexof dfp Ydf NB. Index of
echo Xdf tmemberof dfp Ydf  NB. Member of
echo tshow dfp Xdf tless dfp Ydf  NB. Less
echo tshow dfp tnub dfp Xdf  NB. Nub
echo tshow dfp (0 1 {"1 Xdf) +/ tkey dfp 2 3 4 {"1 Xdf  NB. Key
echo tshow dfp (<tgrade dfp Xdf) {&.> dfp Xdf  NB. Grade
echo tshow dfp (<tgradedown dfp Xdf) {&.> dfp Xdf  NB. Gradedown
echo tshow dfp tsort dfp Xdf  NB. Sort
echo tselfie dfp Xdf NB. Selfie
echo dfToArray (;:'sex age score') dfSelect Xdf
echo dfShow makeDataFrame dfToArray (;:'sex age score') dfSelect Xdf
echo dfShow (;:'sex age score') ([ dfFromArray dfToArray@dfSelect) Xdf
echo dfShow (;:'sex age score') ([ makeDataFrame dfToArray@dfSelect) Xdf
