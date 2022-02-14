NB.=============================
NB. Initialsie tables/dataframe
cocurrent 'pdataframe'

Note 'Extending inverted table'
This script extends the utilities in general/misc/inverted for working with Inverted Tables
Potentially they could combine to become a new addon tables/inverted ?
)
require 'general/misc/inverted'
require 'general/misc/validate'

NB. see also tassert
isinverted=: (1 = [: #@~. #&>) *. (isscalar +. isvector) *. isboxed

NB.*tmakenumbcol v Convert columns of inverted table to numeric
tmakenumcol=: verb define
  _9999 tmakenumcol y
:
NB.   assert. isinverted y
  tassert y
  dat=. x&". &.> y
  notnum=. x&e.@> dat               NB. mask of boxes containing an error code
  idx=. I. notnum                   NB. index of non-numeric columns
  if. #idx do.
    dat=. (idx{"1 y) idx}dat        NB. amend non-numeric columns
  end.
  dat
)

NB.*tshow v Pretty display of long inverted table
tshow=: verb define
  tassert y
  if. 20 < ttally y do.
    (([: ":@,. 5&{.) , '...' , ([: ":@,. _5&{.))&.> y
  else.
    ":@,.&.> y
  end.
)

Note 'Example Use'
load '~Dev/jdataframe/test/test.ijs'
] Bivt=. ifa }. B
tmakenumcol Bivt
tshow tmakenumcol Bivt
]Ivt=. (<1e6 + 21?100000), ifa 21 5 ?@$ 0   NB. create numeric Inverted table
tshow Ivt
tshow 3&}.&.> Ivt
)

NB.===========================================================
Note 'J DataFrames'
Utilities for working with J DataFrames
J DataFrames consist of an inverted tables laminated with boxed list of column names
)

NB.*isdataframe v Checks if noun is a dataframe
isdataframe=: isinverted@{: *. (2 = #)

NB.*dfftbl v Make a DataFrame from Table with a header row y
dfftbl=: {. ,: ifa@}.

NB.*dfp a Apply verb u on DataFrame y
NB. u is a verb designed to work on an inverted table
NB. dfp will remove the header apply u and then reapply the header row
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
