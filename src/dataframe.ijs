NB.===========================================================
Note 'J DataFrames'
Utilities for working with J DataFrames
J DataFrames consist of an inverted tables laminated with boxed list of column names
)

NB.*dfftbl v Make a DataFrame from Table with a header row y
dfftbl=: {. ,: ifa@}.

NB.*dfp a Apply verb u on DataFrame y
NB. u is a verb designed to work on an inverted table
NB. dfp will remove the header apply u and then reapply the header row
dfp=: dfpipe=: {{
  ({.y) ,: u {:y
:
  ({.y) ,: x u {:y
}}

dfsort=: tsort dfp  NB. sort DataFrame

NB. Add row of default column labels if inverted table has no header row
noIvtHdr=: ([: 'column_'&,&.> <@":@#\) ,: ]
NB. Add row of default column labels if table has no header row
noTblHdr=: ([: 'column_'&,&.> <@":@#\)@|: , ]


Note 'Example use'
load 'tables/dataframe/test/test'  NB. expect value error (just defining tables)
]Bdf=: dfftbl B
tsort dfp Bdf
dfsort Bdf
tmakenumcol dfp tsort dfp Bdf
]Ivt=. (<1e6 + 21?100000), ifa 21 5 ?@$ 0   NB. create numeric Inverted table
tshow Ivt
tshow dfp noIvtHdr Ivt
tshow dfp noIvtHdr 3&}.&.> Ivt
)
