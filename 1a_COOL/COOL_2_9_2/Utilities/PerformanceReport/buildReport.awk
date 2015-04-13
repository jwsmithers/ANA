#----------------------------------------------------------------------------
# Conventions:
# - s_xxx => global variable (common counter/state over all trace files)
# - m_xxx => instance variable (for one specific trace file)
# - xxx   => local variable (e.g. for one given row)
#----------------------------------------------------------------------------
BEGIN { # Keep it inlines to avoid 'END blocks must have an action part'
  s_error=0; s_nfiles=0; s_ctx="";
  s_ora=""; s_ins=""; s_sql=""; s_nbind=0;
  split("",s_files,"");      # index: #file
  split("",s_binds_file,""); # index: file
  split("",s_binds_peek,""); # index: peek
  split("",s_sqls,"");       # index: hint
  split("",s_plans,"");      # index: file
  split("",s_preds,"");      # index: file
  split("",s_outls,"");      # index: file
  split("",s_hintsY,"");     # index: file (used)
  split("",s_hintsN,"");     # index: file (unused)
  split("",s_fullplans,"");  # index: fullplan
  HSPACE="\\\\hspace{3mm}";
  #LATEX="1";      # from awk command line arguments
  #USECASE="SV_R"; # from awk command line arguments
  #COOL="HEAD";    # from awk command line arguments
  #TMPDIR="?";     # from awk command line arguments
  #HOST="?";       # from awk command line arguments
  #PLOTS="?";      # from awk command line arguments
  #SKIPNOHINT="?"; # from awk command line arguments
  #ADOPT="?";      # from awk command line arguments
  if (LATEX=="") { print "ERROR! LATEX not defined"; s_error=1; exit 1; }
  if (USECASE=="") { print "ERROR! USECASE not defined"; s_error=1; exit 1; }
  if (COOL=="") { print "ERROR! COOL not defined"; s_error=1; exit 1; }
  if (TMPDIR=="") { print "ERROR! TMPDIR not defined"; s_error=1; exit 1; }
  if (HOST=="") { print "ERROR! HOST not defined"; s_error=1; exit 1; }
  if (LATEX==1&&PLOTS==""){ print "ERROR! PLOTS not defined"; s_error=1; exit 1; }
  if (SKIPNOHINT=="") { print "ERROR! SKIPNOHINT not defined"; s_error=1; exit 1; }
  if (ADOPT=="") { print "ERROR! ADOPT not defined"; s_error=1; exit 1; }
}
#----------------------------------------------------------------------------
function ltrim(s) { sub(/^[ \t]+/, "", s); return s }
function rtrim(s) { sub(/[ \t]+$/, "", s); return s }
function trim(s)  { return rtrim(ltrim(s)); }
#----------------------------------------------------------------------------
function getPeek(s) { return substr(s,6,6) }
function getHint(s) { return substr(s,12) }
#----------------------------------------------------------------------------
function getOra(s) { split(s,arr); return arr[7]; }
#----------------------------------------------------------------------------
{if ($1=="BEGINFILE")
  {
    m_file=$2; s_files[++s_nfiles]=m_file;
    m_nbind=0; m_bind=""; m_nops=0; m_plan=""; m_pred=""; m_outl=""; 
    m_hintY=""; m_hintN="";
  }
}
#----------------------------------------------------------------------------
{if ($1=="Oracle")
  {
    m_ora=$0;
    if (s_ora=="") s_ora=m_ora;
    else if (s_ora!=m_ora)
    {
      print "ERROR! Files do not all have the same Oracle: '"s_ora"' vs '"m_ora"'";
      s_error=1; exit 1;
    }
  }
}
#----------------------------------------------------------------------------
{if ($1=="Instance")
  {
    m_ins=$1 FS $2 FS $3 FS $4 FS $5 FS $6 FS "on" FS $8;
    if (s_ins=="") s_ins=m_ins;
    else if (s_ins!=m_ins)
    {
      print "ERROR! Files do not all have the same Instance: '"s_ins"' vs '"m_ins"'";
      s_error=1; exit 1;
    }
  }
}
#----------------------------------------------------------------------------
# TODO: dump also the preliminary/auxiliary SQL_ALT queries?
# [check also in this case that each aux query is the same in all files]
{if ($1=="[SQL_REF]" && $2=="SELECT")
  {
    m_sql=substr($0,index($0,"SELECT"));
    # Compare SQL (ignoring hints)
    if (s_sql=="")
    {
      s_sql=m_sql;
      split(s_sql,a,":"); 
      for ( i=2; i<=length(a); i++ )
        s_bsql[i-1]=gensub(/(:)([\"]*)([a-zA-Z0-9\_]*)([\"]*)([^a-zA-Z0-9\_]*)(.*)/,"\\1\\3","g",":"a[i]);
    }
    else if ( gensub(/\/\*([^*]+)\*\//,"",s_sql)!=gensub(/\/\*([^*]+)\*\//,"",m_sql) )
    {
      print "ERROR! Files do not all have the same SELECT (ignoring hints)";
      print "ERROR! "s_sql; print "ERROR! "m_sql;
      s_error=1; exit 1;
    }
    else if (s_sql!=m_sql)
    {
      #print "WARNING! Files do not all have the same SELECT";
      ###print s_sql; print m_sql;
      ###s_error=1; exit 1;
    }
    # Compare SQL (including hints)
    hint=getHint(m_file);
    if ( ! (hint in s_sqls) )
    {
      s_sqls[hint]=m_sql;
      s_sqls_ind[length(s_sqls)]=hint; # map sql# -> hint
    }
    else if ( s_sqls[hint]!=m_sql )
    {
      print "ERROR! Files with hint '"hint"' do not all have the same SQL";
      print "ERROR! "s_sqls[hint]; print "ERROR! "m_sql;
      s_error=1; exit 1;
    } 
  }
}
#----------------------------------------------------------------------------
{
  # Analyse Bind variables
  if (s_ctx=="" && substr($1,1,5)=="Bind#")
  {
    m_nbind++;
    if (LATEX!=1)
    {
      ###sub("Bind#",":B"); # Do not use variable names
      sub(/Bind#[0-9]*/,s_bsql[m_nbind]); # Use variable names
      sub(" value=","=");
      $0 = sprintf("%-9s",$0);
      m_bind = ( m_bind=="" ? $0 : m_bind" | "$0 ); # separator is "|"
    }
    else
    {
      gsub(/Bind#([0-9]+) value=/,"");
      m_bind = ( m_bind=="" ? $0 : m_bind"&"$0 ); # separator is "&"
    }
  }
}
#----------------------------------------------------------------------------
{
  # Analyse Plan Table
  if (s_ctx=="plan" && $1=="|" && $2!="Id")
  {
    if ( (m_nops++)!=$2 )
    {
      print "ERROR! Unexpected Operation Id="$2" (expected "m_nops")";
      s_error=1; exit 1;
    }
    nflds = split($0,flds,"|");
    if ( nflds!=9 )
    {
      print "ERROR! Unexpected #fields="nflds" (expected 9)";
      print "ERROR! "$0;
      s_error=1; exit 1;
    }
    id=trim(flds[2]);
    op=rtrim(flds[3]); # right trim only (keep left indentation!)
    name=trim(flds[4]);
    rows=trim(flds[5]);
    bytes=trim(flds[6]);
    cost=trim(flds[7]);
    time=trim(flds[8]);
    if (LATEX!=1) opname = ( name=="" ? op : op" ["name"]" );
    else 
    {
      do op=gensub(/(^  *)( )([^ ])/,"\\1"HSPACE"\\3","g",(op2=op));
      while (op!=op2);
      opname = op"&"name;
    }
    ###print id, opname;
    m_plan = ( m_plan=="" ? opname : m_plan"|"opname ); # separator is "|"
  }
  if (s_ctx=="plan" && $2=="-")
    m_pred = ( m_pred=="" ? $0 : m_pred"|"$0 ); # separator is "|"
  if ($1$2=="PlanTable") s_ctx="plan";
  # Analyse Outline Data
  if (s_ctx=="outl")
  {
    outl = substr($0,3);
    if (LATEX==1 && $1!="/*+" && $1!="*/" )
    {
      do outl=gensub(/(^ *)( )([^ ])/,"\\1"HSPACE"\\3","g",(outl2=outl));
      while (outl!=outl2);
    }
    m_outl = ( m_outl=="" ? outl : m_outl"|"outl ); # separator is "|"
  }
  if ($1$2=="OutlineData:") s_ctx="outl";
  if ($1=="*/") s_ctx="";
  # Analyse Dumping Hints
  if ($1$2=="Hintsused:") s_ctx="hintsY";
  if ($1$2$3=="HintsNOTused:") s_ctx="hintsN";
  if ($1=="ENDFILE") s_ctx="";
  if (s_ctx=="hintsY")
  {
    hint = substr($0,3);
    m_hintY = ( m_hintY=="" ? hint : m_hintY"|"hint ); # separator is "|"
  }
  if (s_ctx=="hintsN")
  {
    hint = substr($0,3);
    m_hintN = ( m_hintN=="" ? hint : m_hintN"|"hint ); # separator is "|"
  }
}
#----------------------------------------------------------------------------
{if ($1=="ENDFILE")
  {
    #print "NBIND:",m_nbind;
    if ( s_nbind==0 ) s_nbind=m_nbind;
    else if ( s_nbind!=m_nbind )
    {
      print "ERROR! Files do not all have the same number of bind variables: '"s_nbind"' vs '"m_nbind"'";
      s_error=1; exit 1;
    }
    #print "BIND:",m_bind;
    peek=getPeek(m_file);
    s_binds_file[m_file]=m_bind;
    if ( ! ( peek in s_binds_peek ) )
    {
      s_binds_peek[peek]=m_bind;
      if ( peek != "peekhi" && ( "peekhi" in s_binds_peek ) && s_binds_peek[peek] == s_binds_peek["peekhi"] )
      {
        if ( ADOPT==0 )
        {
          print "ERROR! Files ("peek") have the same bind variables as files (peekhi): '"s_binds_peek[peek]"' vs '"s_binds_peek["peekhi"]"'"; s_error=1; exit 1;
        }
        else
        {
          if (LATEX==1)
          {
            split(s_binds_file[m_file],a,"&"); 
            s_binds_file[m_file]="\\colorbox{red}{"a[1]"}";
            for ( i=2; i<=length(a); i++ ) s_binds_file[m_file]=s_binds_file[m_file]"&\\colorbox{red}{"a[i]"}";
          }
          else print "WARNING! Files ("peek") have the same bind variables as files (peekhi): '"s_binds_peek[peek]"' vs '"s_binds_peek["peekhi"]"'";
        }
      }      
    }    
    else if ( s_binds_peek[peek]!=m_bind )
    {
      if ( ADOPT==0 )
      {
        print "ERROR! Files ("peek") do not all have the same bind variables: '"s_binds_peek[peek]"' vs '"m_bind"'"; s_error=1; exit 1;
      }
      else
      {
        if (LATEX==1)
        {
          split(s_binds_file[m_file],a,"&"); 
          s_binds_file[m_file]="\\colorbox{red}{"a[1]"}";
          for ( i=2; i<=length(a); i++ ) s_binds_file[m_file]=s_binds_file[m_file]"&\\colorbox{red}{"a[i]"}";
        }
        else print "WARNING! Files ("peek") do not all have the same bind variables: '"s_binds_peek[peek]"' vs '"m_bind"'";
      }
    }
    #print "PLAN:",m_plan;
    s_plans[m_file]=m_plan;
    #print "PRED:",m_pred;
    s_preds[m_file]=m_pred;
    #print "OUTLINE:",m_outl;
    s_outls[m_file]=m_outl;
    #print "HINTS_USED:",m_hintY;
    #print "HINTS_NOT_USED:",m_hintN;
    s_hintsY[m_file]=m_hintY;
    s_hintsN[m_file]=m_hintN;
    # Check if different trace files have the same full execution plan
    # (NB ignore used/unused hints: SQL with/without hints may have same plan!)
    fullplan = m_plan"%"m_pred"%"m_outl # "%"m_hintY"%"m_hintN
    if ( ! (fullplan in s_fullplans ) )
    {
      s_fullplans_ind[length(s_fullplans)+1]=fullplan; # map iplan -> plan
      s_fullplans[fullplan]=length(s_fullplans_ind); # map plan->iplan
      ###print "PLAN #"length(s_fullplans_ind)": "fullplan
      s_fullplansH[fullplan]=0; # map iplan -> used by test with hints?
    }
    if ( index(m_file,"-nohint")==0 ) s_fullplansH[fullplan]=1;
    s_fullplans_ind_file[m_file]=s_fullplans[fullplan]; # map file -> iplan
  }
}
#----------------------------------------------------------------------------
END { # Keep it inlines to avoid 'END blocks must have an action part'
  if ( s_error!=0 ) exit s_error;
  if (LATEX!=1) 
  {
    print "=== Analyzed "s_nfiles" trace files ==="
    if ( ADOPT==0 ) print s_ora;
    else print s_ora" withAdaptiveOptimization";
    print s_ins;
    print "";
  }  
  else
  {
    if ( COOL=="HEAD" ) COOL="COOL-preview"
    else COOL="COOL "COOL;
    print "\\newpage";
    print "\\ifthenelse{\\isodd{\\thepage}}{}{\\vspace*{1cm}\\newpage}" 
    print "\\section{Use case "USECASE"\\large\\hspace*{\\fill}("COOL" on Oracle "getOra(s_ora)")}\n"
    print "\\flushleft";
    if ( ADOPT==0 ) print s_ora" \\\\";
    else print s_ora" ({\\em withAdaptiveOptimization}) \\\\";
    print s_ins;
    print "\\vspace*{-3mm}\\begin{figure}[htbp]\\begin{center}\\mbox{\\hspace*{-6mm}";
    split(PLOTS,plots,",");
    print "\\includegraphics[height=7cm]{"plots[1]"}"(length(plots)>1?"\\includegraphics[height=7cm]{"plots[2]"}":"");
    print "}\\end{center}\\end{figure}\\vspace*{-6mm}";
    print "\\bigskip";
  }
  print "Primary SQL statement (hint option='"getHint(s_files[1])"'):"
  if (LATEX!=1) 
  {
    print s_sql;
    print "";
  }
  else
  {
    sql=gensub(/( )(FROM)( )/,"\\1{\\\\bf\\\\colorbox{cyan}{\\2}}\\3","g",s_sql);
    sql=gensub(/(SELECT)( )/,"{\\\\bf\\\\colorbox{cyan}{\\1}}\\2","g",sql);
    sql=gensub(/([A-Z0-9_]*)(_F0001)([A-Z0-9_]*)/,"{\\\\bf\\\\colorbox{yellow}{\\1\\2\\3}}","g",sql);    
    print "{\\footnotesize "sql"}";
    print ""; 
    print"\\bigskip";
  }
  for ( i=2; i<=length(s_sqls_ind); i++ )
  {
    hint=s_sqls_ind[i];
    print "Main hint in alternative SQL statement (hint option='"hint"'):";
    ###print s_sqls[hint];
    sql0=s_sqls[hint]; sql="";
    while ( index(sql0,"/*") > 0 )
    {
      sql0=substr(sql0,index(sql0,"/*"));
      sql=substr(sql0,0,index(sql0,"*/")+1);
      if ( index(sql,"QB_NAME(MAIN)") > 0 ) break;
      sql0=substr(sql0,index(sql0,"*/"+2)); sql="";
    }
    if (sql=="") 
    {
      print "[main hint could not be determined - showing the full statement]";
      sql=s_sqls[hint];
    }
    print "{\\footnotesize "sql"}";
    print ""; if (LATEX==1) print"\\bigskip";
  }  
  # Print bind variables in a well defined order
  if (LATEX!=1)
  {
    peek="peeklo"
    if ( peek in s_binds_peek ) print "Bind variables ("peek") | "s_binds_peek[peek];
    peek="peekhi"
    if ( peek in s_binds_peek ) print "Bind variables ("peek") | "s_binds_peek[peek];
    print "";
  }
  # Print exec plans in same order as input trace files (stat-peekhi first)
  if (LATEX!=1)
  {
    print "Identified "length(s_fullplans)" execution plan(s) from "length(s_files)" trace files (in "TMPDIR" on "HOST"):";
    for ( j=1; j<=length(s_files); ++j )
      print s_files[j]" ==> execution plan #"s_fullplans_ind_file[s_files[j]];
  }
  else
  {
    print "Identified "length(s_fullplans)" execution plan(s) from "length(s_files)" trace files (in "TMPDIR" on "HOST"):";
    header=""; i=0; while(i++<s_nbind) header=header"r|";
    print "\\begin{center}\\begin{tabular}{|c|c|"header"c|c|}\\hline";
    print "Trace file&Exec&\\multicolumn{"s_nbind"}{c|}{Bind variables}&\\multicolumn{2}{c|}{Hints}\\\\\\cline{3-"(s_nbind+4)"}"
    ###header=""; i=0; while(i++<s_nbind) header=header"\\multicolumn{1}{c|}{:B"(i-1)"}&"; # Do not use variable names
    header=""; i=0; while(i++<s_nbind) header=header"\\multicolumn{1}{c|}{"s_bsql[i]"}&"; # Use variable names
    print "(stat)-(peek)-(hint)&plan&"header"Used&Unused\\\\\\hline"
    nohint=0
    for ( j=1; j<=length(s_files); ++j )
    {
      file = s_files[j];
      split(s_hintsY[file],arr,"|");
      if ( arr[length(arr)] == "  [NONE]" ) nhY=0; else nhY=length(arr)-1;
      split(s_hintsN[file],arr,"|");
      ###for ( i=1; i<=length(arr); i++ ) print "'"arr[i]"'";
      if ( arr[length(arr)] == "  [NONE]" ) nhN=0; else nhN=length(arr)-1;
      if ( index(file,"-nohint") == 0 )
	nhN="\\colorbox{"(nhN==0?"green":"red")"}{"nhN"}";
      hint=nhY"&"nhN;
      plan="#"s_fullplans_ind_file[file];
      if ( index(file,"-nohint") == 0 )
	plan="\\colorbox{"(plan=="#1"?"green":"orange")"}{"plan"}";
      else if ( (nohint++)==0 ) print "\\hline";
      ###print file"&"plan"&"s_binds[substr(file,6,6)]"&"hint"\\\\";
      print file"&"plan"&"s_binds_file[file]"&"hint"\\\\";
    }
    print "\\hline\\end{tabular}\\end{center}"
  }  
  print "";
  for ( j=1; j<=length(s_fullplans_ind); ++j )
  {
    fullplan=s_fullplans_ind[j];
    if (SKIPNOHINT==1 && s_fullplansH[fullplan]==0) continue;    
    if (LATEX!=1)
    {
      print "-------------------"
      print "Execution plan #"j
      print "-------------------"
    }
    else
    {
      print "\\newpage"; # "\\flushleft\\tolerance=10000"
      print "\\subsection*{"USECASE" / Execution plan #"j"\\hspace*{\\fill}("COOL" on Oracle "getOra(s_ora)")}"
    }    
    split("",files,"");
    for ( i=1; i<=length(s_files); ++i ) 
    {
      if ( s_fullplans_ind_file[s_files[i]] == j ) files[length(files)+1]=s_files[i]
    }
    ###for ( i=1; i<=length(files); ++i ) print "==> "files[i]"";
    ###print fullplan;
    if (LATEX!=1)
    {
      ###print s_plans[files[1]];
      split(s_plans[files[1]],arr,"|");
      for ( i=1; i<=length(arr); ++i ) printf " %2d %s\n",i-1,arr[i];
    }
    else
    {  
      print "\\begin{tabular}{|l|l|l|}\\hline"
      print "Id&Operation&Name\\\\\\hline"
      split(s_plans[files[1]],arr,"|");
      for ( i=1; i<=length(arr); ++i )
	printf "%d&%s\\\\\n",i-1,gensub(/(INDEX)([^&]*)/,"{\\\\bf\\\\colorbox{yellow}{\\1\\2}}","g",arr[i]);
      print "\\hline\\end{tabular}"
    }
    print ""; if (LATEX==1) print"\\bigskip";
    ###print s_preds[files[1]];
    split(s_preds[files[1]],arr,"|");
    for ( i=1; i<=length(arr); ++i ) print arr[i];
    print ""; if (LATEX==1) print"\\bigskip{\\small ";
    ###print s_outls[files[1]];
    split(s_outls[files[1]],arr,"|");
    for ( i=1; i<=length(arr); ++i ) 
      print ( LATEX==1 ? gensub(/(INDEX|PX_JOIN_FILTER)([^(]*)/,"{\\\\bf\\\\em\\\\colorbox{yellow}{\\1\\2}}","g",arr[i]) : arr[i] );
    print ""; if (LATEX==1) print"}\\bigskip";
    if (LATEX!=1)
    {
      ###print s_hintsY[files[1]];
      split(s_hintsY[files[1]],arr,"|");
      for ( i=1; i<=length(arr); ++i ) print arr[i];
      ###print s_hintsN[files[1]];
      split(s_hintsN[files[1]],arr,"|");
      for ( i=1; i<=length(arr); ++i ) print arr[i];
    }
    print "";
  }
}
#-----------------------------------------------------------------------------