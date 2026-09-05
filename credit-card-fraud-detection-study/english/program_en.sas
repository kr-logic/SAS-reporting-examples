/* Standardizing the amount and splitting the data */
proc stdize data=WORK.IMPORT method=std out=WORK.FRAUD_SCALED;
   var Amount;
run;

data WORK.FRAUD WORK.LEGAL;
   set WORK.FRAUD_SCALED;
   if Class = 1 then output WORK.FRAUD;
   else output WORK.LEGAL;
run;

/* Under-sampling: Selecting 492 legitimate transactions and merging with frauds */
proc surveyselect data=WORK.LEGAL method=srs n=492 out=WORK.LEGAL_SAMPLE;
run;

data WORK.MODEL_DATA;
   set WORK.FRAUD WORK.LEGAL_SAMPLE;
run;

/* Running logistic regression and evaluating the complete dataset */
proc logistic data=WORK.MODEL_DATA descending;
   model Class = Amount V1-V28 / selection=stepwise;
   score data=WORK.FRAUD_SCALED out=WORK.SCORED_DATA; 
run;

/* Evaluation - How many fraudsters did we catch? */
data WORK.EVALUATION;
   set WORK.SCORED_DATA;
   /* The P_1 column contains the probability of fraud.
      If it is greater than 0.5 (50%), the model triggers an alert (1). */
   if P_1 > 0.5 then Predicted_Class = 1;
   else Predicted_Class = 0;
run;

title "Business Result: Actual vs. Model Predicted (Confusion Matrix)";
proc freq data=WORK.EVALUATION;
   tables Class * Predicted_Class / norow nocol nopercent;
run;
title;
