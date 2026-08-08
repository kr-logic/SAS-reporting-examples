/* Az összeg standardizálása és az adatok szétválasztása */
proc stdize data=WORK.IMPORT method=std out=WORK.FRAUD_SCALED;
   var Amount;
run;

data WORK.CSALAS WORK.LEGALIS;
   set WORK.FRAUD_SCALED;
   if Class = 1 then output WORK.CSALAS;
   else output WORK.LEGALIS;
run;

/* Alul-mintavételezés: 492 legális tranzakció kiválasztása és egyesítése a csalásokkal */
proc surveyselect data=WORK.LEGALIS method=srs n=492 out=WORK.LEGALIS_SAMPLE;
run;

data WORK.MODEL_ADAT;
   set WORK.CSALAS WORK.LEGALIS_SAMPLE;
run;

/* Logisztikus regresszió futtatása és a teljes adathalmaz kiértékelése */
proc logistic data=WORK.MODEL_ADAT descending;
   model Class = Amount V1-V28 / selection=stepwise;
   score data=WORK.FRAUD_SCALED out=WORK.SCORED_DATA; 
run;

/* A kiértékelés - Hány csalót fogtunk meg? */
data WORK.EVALUATION;
   set WORK.SCORED_DATA;
   /* A P_1 oszlop tartalmazza a csalás valószínűségét.
      Ha ez nagyobb mint 0.5 (50%), akkor a modell riaszt (1). */
   if P_1 > 0.5 then Predicted_Class = 1;
   else Predicted_Class = 0;
run;

title "Üzleti Eredmény: Tényleges vs. Modell által becsült (Konfúziós Mátrix)";
proc freq data=WORK.EVALUATION;
   tables Class * Predicted_Class / norow nocol nopercent;
run;
title;
