%let pgm=utl-conditionally-stop-a-running-interactive-job-without-ending-the-sas-session;

Conditionally stop a running interactive job without ending the sas session

Just call this macro between datasteps

%macro stop_submission;

  %if &syserr ne 0 %then %do;
     %abort cancel;
  %end;

%mend stop_submission;

May only work in the 1980s classic DMS Editor?

I thought there was a DMS option to stop processing on error without ending the session (ie option dmsStopError)

GitHub
https://tinyurl.com/z25m3v7c
https://github.com/rogerjdeangelis/utl-conditionally-stop-a-running-interactive-job-without-ending-the-sas-session

StackOverflow
https://tinyurl.com/6uvds8xs
https://stackoverflow.com/questions/64767651/stop-statement-outside-a-sas-data-step

Richard
https://stackoverflow.com/users/1249962/richard

You cannot remove the macro and insert %abort cancel within an open code if statement.;

This does not work in open code.

%if &syserr ne 0 %then %do;
   %abort cancel;
%end;

/*        _
 ___  ___| |_ _   _ _ __
/ __|/ _ \ __| | | | `_ \
\__ \  __/ |_| |_| | |_) |
|___/\___|\__|\__,_| .__/
                   |_|
*/

* put this macro in your autocall library;

%macro stop_submission;

  %if &syserr ne 0 %then %do;
     %abort cancel;
  %end;

%mend stop_submission;

/*
  ___ __ _ ___  ___   _ __   ___     ___ _ __ _ __ ___  _ __
 / __/ _` / __|/ _ \ | `_ \ / _ \   / _ \ `__| `__/ _ \| `__|
| (_| (_| \__ \  __/ | | | | (_) | |  __/ |  | | | (_) | |
 \___\__,_|___/\___| |_| |_|\___/   \___|_|  |_|  \___/|_|

*/


* no error in this datastep;
data one;
  set sashelp.class;
run;

%put **&=syserr**;

%stop_submission;

data two;
  set sashelp.class;
run;

data three;
  set sashelp.class;
run;

/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
*/

1868  * no error in this datastep;
1869  data one;
1870    set sashelp.class;
1871  run;

1872  %put **&=syserr**;
**SYSERR=0**

1873  %stop_submission;
1874  data two;
1875    set sashelp.class;
1876  run;

NOTE: There were 19 observations read from the data set SASHELP.CLASS.

1877  data three;
1878    set sashelp.class;
1879  run;

NOTE: There were 19 observations read from the data set SASHELP.CLASS.

/*
  ___ __ _ ___  ___    ___ _ __ _ __ ___  _ __
 / __/ _` / __|/ _ \  / _ \ `__| `__/ _ \| `__|
| (_| (_| \__ \  __/ |  __/ |  | | | (_) | |
 \___\__,_|___/\___|  \___|_|  |_|  \___/|_|

*/

/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
*/

* error in this datastep;
data one;
  set missing sashelp.class;
run;

%put **&=syserr**;

%stop_submission;

data two;
  set sashelp.class;
run;

data three;
  set sashelp.class;
run;


2320  * error in this datastep;
2321  data one;
ERROR: File WORK.MISSING.DATA does not exist.
2322    set missing sashelp.class;
2323  run;

NOTE: The SAS System stopped processing this step because of errors.
WARNING: The data set WORK.ONE may be incomplete.  When this step was stopped there were 0 observations and 5 variables.
WARNING: Data set WORK.ONE was not replaced because this step was stopped.
NOTE: DATA statement used (Total process time):

**SYSERR=1012**

ERROR: Execution canceled by an %ABORT CANCEL statement.
NOTE: The SAS System stopped processing due to receiving a CANCEL request.

NO Further Processing and back to Display Manage


run;quit;

/*
  ___ __ _ ___  ___    ___ _ __ _ __   _ __   ___    _ __ ___   __ _  ___ _ __ ___
 / __/ _` / __|/ _ \  / _ \ `__| `__| | `_ \ / _ \  | `_ ` _ \ / _` |/ __| `__/ _ \
| (_| (_| \__ \  __/ |  __/ |  | |    | | | | (_) | | | | | | | (_| | (__| | | (_) |
 \___\__,_|___/\___|  \___|_|  |_|    |_| |_|\___/  |_| |_| |_|\__,_|\___|_|  \___/

*/

* In this case it just runs all the code;

* error in this datastep;
data one;
  set missing sashelp.class;
run;

%put **&=syserr**;

data two;
  set sashelp.class;
run;

data three;
  set sashelp.class;
run;

/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
*/

2560  * error in this datastep;
2561  data one;
ERROR: File WORK.MISSING.DATA does not exist.
2562    set missing sashelp.class;
2563  run;

NOTE: The SAS System stopped processing this step because of errors.
WARNING: The data set WORK.ONE may be incomplete.  When this step was stopped there were 0 observations and 5 variables.
WARNING: Data set WORK.ONE was not replaced because this step was stopped.


SYMBOLGEN:  Macro variable SYSERR resolves to 1012
2564  %put **&=syserr**;
**SYSERR=1012**
2565  data two;
2566    set sashelp.class;
2567  run;

NOTE: There were 19 observations read from the data set SASHELP.CLASS.

2568  data three;
2569    set sashelp.class;
2570  run;

NOTE: There were 19 observations read from the data set SASHELP.CLASS.












