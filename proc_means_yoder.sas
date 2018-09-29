/************/
/*proc means*/
/************/

/*
library_name.dataset_name
work.dataset_name=dataset_name
*/

data cars;
set sashelp.cars;
run;

/*Calculate basic stats*/

proc means data=cars;
run;

/*Calculate stats for only one variable*/
proc means data=cars;
var Invoice;
run;

/*Caluculate specific stats for one variable*/
proc means data=cars N MEAN;
var Invoice;
run; 

/*Calculate stats with reduced decimal points*/
proc means data=cars MEAN MEDIAN maxdec=2;
var Horsepower; 
run;

/*Calculate stats for each group (car makes)*/
proc means data=cars; by Make; run;

proc means data=cars MEAN MEDIAN N;
var Invoice;
by Make;
run; 

/*Calculate stats for each group by multiple variables*/
proc sort data=cars; by Make Type; run;

proc means data=cars MEAN MEDIAN N;
var Invoice;
by Make Type;
run; 

/*Calculate stats for subset (sedan)*/
proc sort data=cars; by Make; run;

proc means data=cars MEAN MEDIAN N;
var Invoice;
by Make;
where Type="Sedan";
run;

/* Save stats to a new data set*/
proc sort data=cars; by Make; run;

proc means data=cars;
var Invoice;
by Make;
output out=cars_ver8;
run;

/* Add a no-print option to save memory */
proc sort data=cars; by Make; run;

proc means data=cars noprint;
var Invoice;
by Make;
output out=cars_var9;
run; 

/* Write specific stats to a new data set*/
proc sort data=cars; by Make; run;

proc means data=cars noprint;
var Invoice;
by Make;
output out=cars_ver10 mean=;
run;

/* Create unique variable names automatically for an output stat*/
proc sort data=cars; by Make; run;

proc means data=cars noprint;
var Invoice;
by Make;
output out=cars_ver11 mean= median= / autoname;
run; 

/*Create fixed variable names*/
proc sort data=cars; by Make; run;

proc means data=cars noprint;
var Invoice;
by Make;
output out=cars_ver12 mean=Avg std=StandardDev;
run; 

/*Calculate different stats for different variables + autoname*/
proc sort data=cars; by Make; run;

proc means data=cars noprint;
var Invoice EngineSize;
by Make;
output out=cars_ver13 mean(invoice)= n(EngineSize)= / autoname;
run; 

/*Calculate different stats for different variables + fixed variable names, drop auto columns for type and frequency*/
proc sort data=cars; by Make; run;

proc means data=cars noprint;
var Invoice EngineSize;
by Make;
output out=cars_ver14(drop= _type_ _Freq_) mean(invoice)= n(EngineSize)=Nobs_Enginesize;
run; 

/*Calculate non-standard percentiles*/
/*version1*/
proc sort data=cars; by Make; run:

proc means data=cars noprint;
var Invoice Enginesize Horsepower;
by Make;
where Type="Sedan";
output out=cars_ver15_1 p25= p75=/ autoname;
run; 

/*version2*/
proc sort data=cars; by Make; run;

proc means data=cars Stackodsoutput p25 p75;
var Invoice Enginesize Horsepower;
by Make;
where Type="Sedan";
ods output summary=cars_ver15_2 (drop=Label);
run; 

