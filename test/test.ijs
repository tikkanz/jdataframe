coinsert 'pdataframe'
require 'tables/csv'
B=: fixcsv noun define
Id,Name,Job,Status
3,Jerry,Unemployed,Married
6,Jan,CEO,Married
5,Frieda,student,Single
1,Alex,Waiter,Separated
)

Bdf=: dfftbl B
Ivt=. (<1e6 + 21?100000), ifa 21 5 ?@$ 0   NB. create numeric Inverted table

echo tsort dfp Bdf
echo dfsort Bdf
echo tmakenumcol dfp tsort dfp Bdf
echo tshow Ivt
echo tshow dfp noIvtHdr Ivt
echo tshow dfp noIvtHdr 3&}.&.> Ivt


