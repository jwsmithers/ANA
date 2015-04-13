BEGIN { # Keep it inlines to avoid 'END blocks must have an action part'
  out=0; bind=""; imain=0; ###sql=0;
  sql=1; # FIX BUG #102322: sql=1@start; sql=0@'Reg qb MAIN'; sql=-1@'Current SQL'; then sql=<SQL>    
  split("",sqls,""); # index: sql
  if (NMAIN=="") NMAIN=1; else NMAIN=0+NMAIN; fi # Convert to number explicitly
  if (NMAIN>1) # NB expect NMAIN to be a number (converted otherwise)
  {
    print "WARNING! More than one MAIN ("NMAIN") in this trace file";
    print "WARNING! Will only consider the last MAIN block";
  }
  if (NOPTEST=="") NOPTEST=0; else NOPTEST=0+NOPTEST; fi # Convert to number explicitly
  if (NOPTEST>0) # NB expect NOPTEST to be a number (converted otherwise)
  {
    print "WARNING! OPT_ESTIMATE ("NOPTEST") are present in this trace file";
  }
  # TODO: check that there are no two SQL that are the same
  # TODO: check that the number of SQL is the expected one
}
#----------------------------------------------------------------------------
{if ($1" "$2=="Oracle Database") print $0}
{if ($1" "$2=="System name:") sys=$3}
{if ($1" "$2=="Node name:") {nod=$3; sub(".cern.ch","",nod)}}
{if ($1=="Machine:") mac=$2}
{if ($1" "$2=="Instance name:") ins=$3}
{if ($1" "$2=="*** SESSION") { dat=$4" "$5; print "Instance "ins" ("sys" "mac" on "nod") at "dat"\n"; }
}
#----------------------------------------------------------------------------
{if (substr($1,0,5)=="Bind#") bind=substr($1,6)}
{if (bind!="" && substr($1,0,6)=="value=") 
  {if (imain==NMAIN) print "Bind#"bind" value="substr($1,7); bind=""}
}
#----------------------------------------------------------------------------
{if (sql==-1) 
  {
    if (imain==NMAIN) { dumpHints(); print ""; }
    sql=$0; imain++; 
    if (imain==NMAIN) print "[SQL_REF] "sql"\n"
    else print "[SQL_ALT#"imain"] "sql"\n"
    if ( ! (sql in sqls) ) sqls[sql]=1;
    else if ( NOPTEST==0 ) print "ERROR! The same SQL statement is registered more than once in this trace file"; 
    else print "WARNING! The same SQL statement is registered more than once in this trace file (OPT_ESTIMATE was seen)"; 
  }
}
{if (sql==0 && $1" "$2=="Current SQL") sql=-1} # Oracle 10g traces
{if (sql==0 && $2" "$3=="Current SQL") sql=-1} # Oracle 11g and 12c traces
{if ($1" "$2" "$3=="Registered qb: MAIN") sql=0;}
#----------------------------------------------------------------------------
{if ($0=="Plan Table") {out=3; if (imain==NMAIN) print "\n"$0}}
{if ($0=="Predicate Information:") {out=3}}
{if ($0=="Content of other_xml column") out=0}
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
{if ($1" "$2=="Outline Data:") {$1=$1; out=1}}
{if ($0=="Optimizer environment:") out=0} # Closes outline data on 10g
{if ($0=="Optimizer state dump:") out=0}  # Closes outline data on 11g
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
###{if ($0=="Dumping Hints") {out=3; print $0}}
###{if ($2" "$3" "$4" "$5=="END SQL Statement Dump") out=0}
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
{if (out==1 && imain==NMAIN) print $0}
{if (out>1) out--}
#----------------------------------------------------------------------------
{if ($0=="Dumping Hints" && imain==NMAIN) {print $0}}
{if (substr($1,0,10)=="atom_hint=" && imain==NMAIN) 
  { 
    used=$4; hint=""; for (i=8;i<=NF;i++) hint=hint$i; 
    gsub("\"\"","\" \"",hint);
    gsub("txt=","",hint);
    lh=length(hint); hint=substr(hint,0,lh-1); 
    if (substr(hint,lh-2,2)=="()") hint=substr(hint,0,lh-3); 
    if ( used=="used=0" ) 
    {
      if (hint not in hints0) hints0[hint]=0;
      hints0[hint]++;
    }
    else
    {
      if (hint not in hints1) hints1[hint]=0;
      hints1[hint]++;
    }
    ###print "    "used" "hint;
  }
}
#----------------------------------------------------------------------------
function dumpHints()
{
  # Remove used hints from the list of unused hints
  for ( hint in hints1 ) 
  {
    if ( hint in hints0 ) delete hints0[hint];
  }
  # Sort alphabetically the list of hints ('for' is not sorted in awk!)
  i=1; for ( hint in hints1 ) hints1_ind[i++]=hint;
  i=1; for ( hint in hints0 ) hints0_ind[i++]=hint;
  asort(hints1_ind);
  asort(hints0_ind);
  # Print the sorted lists of hints
  print "  Hints used:"
  if (length(hints1)==0) print "    [NONE]"
  else for ( i=1; i<=length(hints1); i++ ) 
  {
    hint = hints1_ind[i];
    print "    "hint;
    ###printf("    %-60s (x%1d)\n", hint, hints1[hint]);
  }
  print "  Hints NOT used:"
  if (length(hints0)==0) print "    [NONE]";
  else for ( i=1; i<=length(hints0); i++ ) 
  {
    hint = hints0_ind[i];
    print "    "hint;    
    ###printf("    %-60s (x%1d)\n", hint, hints0[hint]);
  }
}
#----------------------------------------------------------------------------
END { # Keep it inlines to avoid 'END blocks must have an action part'
  if (imain==NMAIN) dumpHints();
  else print "ERROR! More MAIN ("imain") than expected ("NMAIN") in this trace file";
}
#----------------------------------------------------------------------------
