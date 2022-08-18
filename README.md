# DataFrame addon for J
Experimenting with a DataFrame-like structure in J

Reuses verbs from 'general/misc/inverted' addon via the `dfpipe` adverb.
## Install
To install addon, from a J session:
```j
   install 'github:tikkanz/jdataframe'
```
## Usage
```j
   load 'tables/dataframe'
   coinsert 'pdataframe'
   require 'tables/csv'
   ]B=: fixcsv noun define
Id,Name,Job,Status
3,Jerry,Unemployed,Married
6,Jan,CEO,Married
5,Frieda,student,Single
1,Alex,Waiter,Separated
)
┌──┬──────┬──────────┬─────────┐
│Id│Name  │Job       │Status   │
├──┼──────┼──────────┼─────────┤
│3 │Jerry │Unemployed│Married  │
├──┼──────┼──────────┼─────────┤
│6 │Jan   │CEO       │Married  │
├──┼──────┼──────────┼─────────┤
│5 │Frieda│student   │Single   │
├──┼──────┼──────────┼─────────┤
│1 │Alex  │Waiter    │Separated│
└──┴──────┴──────────┴─────────┘

   NB. A DataFrame is a list of boxed column labels, laminated to an inverted table.
   ]Bdf=: dfftbl B
┌──┬──────┬──────────┬─────────┐
│Id│Name  │Job       │Status   │
├──┼──────┼──────────┼─────────┤
│3 │Jerry │Unemployed│Married  │
│6 │Jan   │CEO       │Married  │
│5 │Frieda│student   │Single   │
│1 │Alex  │Waiter    │Separated│
└──┴──────┴──────────┴─────────┘

   NB. `dfpipe` is an adverb that applies inverted table verbs to a DataFrame.
   tsort dfpipe Bdf
┌──┬──────┬──────────┬─────────┐
│Id│Name  │Job       │Status   │
├──┼──────┼──────────┼─────────┤
│1 │Alex  │Waiter    │Separated│
│3 │Jerry │Unemployed│Married  │
│5 │Frieda│student   │Single   │
│6 │Jan   │CEO       │Married  │
└──┴──────┴──────────┴─────────┘

   NB. `dfp` is an alias for `dfpipe`
   tmakenumcol dfp tsort dfp Bdf
┌───────┬──────┬──────────┬─────────┐
│Id     │Name  │Job       │Status   │
├───────┼──────┼──────────┼─────────┤
│1 3 5 6│Alex  │Waiter    │Separated│
│       │Jerry │Unemployed│Married  │
│       │Frieda│student   │Single   │
│       │Jan   │CEO       │Married  │
└───────┴──────┴──────────┴─────────┘
   0 2 3 tfrom dfp ('Id';'Job') dfselect tmakenumcol dfp tsort dfp Bdf
┌─────┬──────────┐
│Id   │Job       │
├─────┼──────────┤
│1 5 6│Waiter    │
│     │student   │
│     │CEO       │
└─────┴──────────┘

NB. Working with bigger tables
   $Ivt=. (<1e6 + ?~1e5), ifa 1e5 5 ?@$ 0   NB. create 6 column numeric Inverted table
6
   NB. `tshow` is a verb for formatting inverted tables to display a sample
   tshow Ivt
┌───────┬─────────┬────────┬─────────┬─────────┬────────┐
│1075046│ 0.577324│0.326908│0.513408 │0.0404037│0.796914│
│1049892│0.0993946│0.998484│ 0.64112 │ 0.534353│0.853303│
│1071469│ 0.152675│ 0.46638│0.961524 │  0.69655│0.887527│
│1097164│ 0.430858│ 0.12542│0.688066 │ 0.605572│ 0.27933│
│1097134│ 0.513834│0.984058│0.661339 │ 0.736824│0.575513│
│...    │...      │...     │...      │...      │...     │
│1081526│0.116691 │0.778937│ 0.610106│ 0.921476│0.440309│
│1003592│0.421378 │0.922601│  0.73872│ 0.448878│0.876693│
│1014189│ 0.19164 │ 0.31856│0.0756206│ 0.755682│0.456555│
│1098643│0.272687 │0.183623│  0.95511│0.0746902│0.996458│
│1020349│ 0.67446 │ 0.64529│ 0.600252│ 0.180631│0.922642│
└───────┴─────────┴────────┴─────────┴─────────┴────────┘

   NB. `noIvtHdr` adds default header names to an inverted table, creating a DataFrame
   tshow dfp noIvtHdr Ivt
┌────────┬─────────┬────────┬─────────┬─────────┬────────┐
│column_1│column_2 │column_3│column_4 │column_5 │column_6│
├────────┼─────────┼────────┼─────────┼─────────┼────────┤
│1075046 │ 0.577324│0.326908│0.513408 │0.0404037│0.796914│
│1049892 │0.0993946│0.998484│ 0.64112 │ 0.534353│0.853303│
│1071469 │ 0.152675│ 0.46638│0.961524 │  0.69655│0.887527│
│1097164 │ 0.430858│ 0.12542│0.688066 │ 0.605572│ 0.27933│
│1097134 │ 0.513834│0.984058│0.661339 │ 0.736824│0.575513│
│...     │...      │...     │...      │...      │...     │
│1081526 │0.116691 │0.778937│ 0.610106│ 0.921476│0.440309│
│1003592 │0.421378 │0.922601│  0.73872│ 0.448878│0.876693│
│1014189 │ 0.19164 │ 0.31856│0.0756206│ 0.755682│0.456555│
│1098643 │0.272687 │0.183623│  0.95511│0.0746902│0.996458│
│1020349 │ 0.67446 │ 0.64529│ 0.600252│ 0.180631│0.922642│
└────────┴─────────┴────────┴─────────┴─────────┴────────┘
```
