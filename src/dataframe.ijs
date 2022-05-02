NB.===========================================================
Note 'J DataFrames'
Utilities for working with J DataFrames
J DataFrames consist of an inverted tables laminated with boxed list of column names
)

NB.*isdataframe v Checks if noun is a dataframe
isdataframe=: isinverted@{: *. (2 = #)

NB.*dfftbl v Make a DataFrame from Table with a header row y
dfftbl=: {. ,: ifa@}.

NB.*dfp a Apply inverted table verb u on DataFrame y
NB. u is a verb designed to work on an inverted table
NB. dfp will remove the column header, apply u y (or x u y)
NB. and then reapply the header row, if appropriate
dfp=: dfpipe=: {{
  res=. u {:y
  if. isinverted res do.
    ({.y) ,: res
  end.
:
  xa=. x
  if. isdataframe x do.
    xa=. {:x
  end.
  res=. xa u {:y
  if. isinverted res do.
    ({.y) ,: res
  end.
}}

dfshow=: tshow dfp  NB. show DataFrame

dfsort=: tsort dfp  NB. sort DataFrame

NB. select column(s) of a dataframe
dfselect=: {{
  if. (isinteger *. -.@isboxed) x do.
    colidx=. x    NB. left arg is column indexes
  else.
    colidx=. (boxopen x) (i.~ {.) y
  end.
  colidx {"1 y
}}


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
