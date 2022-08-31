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
isInverted=: (1 = [: #@~. #&>) *. (isscalar +. isvector) *. isboxed

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

NB.*tshow v Pretty-print a long inverted table
tshow=: verb define
  tassert y
  if. 20 < ttally y do.
    ((datatype , '---' , [: ":@,. 5&{.) , '...' , ([: ":@,. _5&{.))&.> y
  else.
    (datatype , '---' , ":@,.)&.> y
  end.
)

Note 'Example Use'
load 'tables/dataframe/test/test'  NB. expect value error (just defining tables)
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

NB.*isDataFrame v Checks if noun is a DataFrame
isDataFrame=: isInverted@{: *. (2 = #)
isTable=: ismatrix *. isboxed     NB. table with boxed atoms
isArray=: ismatrix *. -.@isboxed  NB. unboxed table

NB.*dfFromTable v Make a DataFrame from Table with a header row y
dfFromTable=: ({. ,: ifa@}.) :. dftoTable

NB.*dftoTable v Convert a DataFrame (y) to a Table with a header row
dftoTable=: ({. , afi@{:) :. dfFromTable

NB.*dfToArray v Catenate columns of DataFrame (y) as an unboxed table without headers
dfToArray=: >@(,.&.>/)@{:

NB.*dfFromArray v Convert columns of a simple table to columns of a Dataframe
dfFromArray=: [ ,: <"1@|:@]

NB.*defaultHdr v Create default list of boxed column names for a 
defaultHdr=: ([: ('column_' , ":)&.> >:@i.)@{:@$

NB.*makeDataFrame v Create a Dataframe from a table representation (y) and optional header (x)
NB. y is: one of inverted-table, boxed-table, unboxed-array
NB. x is: optional list of boxed column names, or 1 if a boxed-table already has a header row
makeDataFrame=:{{
  (defaultHdr makeDataFrame ]) y
:
  tbltype=. I.@(isInverted , isTable, isArray) y
  select. ,/ tbltype
    case. 0 do.
      df=. x ,: y
    case. 1 do.
      if. x = 1 do.
        df=. dfFromTable y
      else.
        df=. dfFromTable x , y
      end.
    case. 2 do.
      df=. x dfFromArray y
    case. do.
    echo 'Unsupported right argument'
    df=. empty''
  end.
  df
}}

NB.*dfp a Apply inverted table verb u on DataFrame y
NB. u is a verb designed to work on an inverted table
NB. dfp will remove the column header, apply u y (or x u y)
NB. and then reapply the header row, if appropriate
dfp=: dfPipe=: {{
  res=. u {:y
  if. (isInverted res) +. tshow f.`'' -: u f.`'' do.
    ({.y) ,: res
  end.
:
  xa=. x
  if. isDataFrame x do.
    xa=. {:x
  end.
  res=. xa u {:y
  if. isInverted res do.
    ({.y) ,: res
  end.
}}

NB.*dfShow v Pretty-print a DataFrame
dfShow=: tshow dfp

NB.*dfSort v Sort a DataFrame
dfSort=: tsort dfp

NB.*dfSelect v Select column(s) (x) of a DataFrame (y)
dfSelect=: {{
  if. (isinteger *. -.@isboxed) x do.
    colidx=. x    NB. left arg is column indexes
  else.
    colidx=. (boxopen x) (i.~ {.) y
  end.
  colidx {"1 y
}}

NB.*dfSelect v Drop column(s) (x) from a DataFrame (y)
dfDrop=: {{
  if. (isinteger *. -.@isboxed) x do.
    colidx=. x    NB. left arg is column indexes
  else.
    colidx=. (boxopen x) (i.~ {.) y
  end.
  (<<<colidx) {"1 y
}}


Note 'Example use'
load 'tables/dataframe/test/test'  NB. expect value error (just defining tables)
]Bdf=: dfFromTable B
tsort dfp Bdf
dfSort Bdf
tmakenumcol dfp tsort dfp Bdf
]Ivt=. (<1e6 + 21?100000), ifa 21 5 ?@$ 0   NB. create numeric Inverted table
tshow Ivt
tshow dfp makeDataFrame Ivt
dfShow makeDataFrame 3&}.&.> Ivt
)
