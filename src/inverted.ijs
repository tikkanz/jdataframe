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

