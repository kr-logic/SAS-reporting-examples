/* Adapted from adatgeneralas.sas (ALAPANYAGOK + BESZALLITO blocks) +
   feladat_megoldasok.sas (feladat 6). Generates the ALAPANYAGOK (materials/
   hardware) and BESZALLITO (suppliers) datasets, then reproduces the
   student's data-quality check: elementary statistics (PROC MEANS) and
   frequency tables (PROC FREQ) on both, used in the repo to confirm the
   generated distributions matched the coded probability thresholds.
   One line is adjusted from the original: SZALL_DATUM used date() (today's
   date), which would make PROC MEANS' mean shift every day this bundle is
   re-run; it's pinned to a fixed reference date ('01JAN2026'd) here so the
   captured statistics stay reproducible. The random day-offset logic is
   unchanged. */

DATA ALAPANYAGOK (keep= ANYAG TERMEKCSOPORT UVEG_TIPUSA TIPUS KERET KILINCS ZAR ZSANER);
	
LENGTH ANYAG $10 TERMEKCSOPORT $15 UVEG_TIPUSA $25 TIPUS $35 KERET $6 KILINCS $6 ZAR $6 ZSANER $6;

do i=1 to 1000;

/*ANYAG*/
    RND=ranuni(1); 
    select;      
      when (RND LT 0.1)  ANYAG='Alu';
      when (RND LT 0.65) ANYAG='PVC';                                         
      otherwise		 ANYAG='Fa';
    end; 

 RND=ranuni(1); 
    select;     
      when (RND GT 0.50) TERMEKCSOPORT='Ablakok';
      when (RND GT 0.25) TERMEKCSOPORT='Bejárati ajtók';                                         
      otherwise		 TERMEKCSOPORT='Erkélyajtók';
    end;  

/*UVEG_TIPUSA*/ 
     RND=ranuni(1);
     select;  
     	when (RND GT 0.60)  UVEG_TIPUSA='Normál üveg';  
     	when (RND GT 0.50)  UVEG_TIPUSA='Kétrétegű üveg';                                               
     	when (RND GT 0.35)  UVEG_TIPUSA='Háromrétegű üveg';                                                
     	otherwise  UVEG_TIPUSA='Öntisztító üveg';
     end;

/*TIPUS*/
    RND=ranuni(1);
    select;  
        when (RND GT 0.80) TIPUS='Bukó-nyíló'; 
        when (RND GT 0.70) TIPUS='Bukó';
        when (RND GT 0.60) TIPUS='Nyíló';
        when (RND GT 0.40) TIPUS='Fix';
        when (RND GT 0.35) TIPUS='Toló';
        when (RND GT 0.20) TIPUS='Bejárati';
        when (RND GT 0.10) TIPUS='Toló-bukó';
        otherwise          TIPUS='Harmonika';
    end;

/*KERET*/
        RND=ranuni(1); 
    select;      
      when (RND GT 0.50)  KERET='Van';
      otherwise           KERET='Nincs'; 
    end;
 
/*KILINCS*/

    if TIPUS NE 'Fix' then do;
      RND=ranuni(1); 
      select;      
        when (RND GT 0.50)  KILINCS='Van';
        otherwise           KILINCS='Nincs'; 
      end;
    end;
    else do;
        KILINCS = 'Nincs';
    end;

/*ZAR*/
    if TERMEKCSOPORT='Ablakok' then do;
   	ZAR = 'Nincs';
    end;
    else do;
      RND=ranuni(1); 
      select;      
        when (RND GT 0.50)  ZAR='Van';
        otherwise           ZAR='Nincs'; 
      end;
    end;
/*ZSANER*/

    RND=ranuni(1); 
    select;      
      when (RND GT 0.50)  ZSANER='Van';
      otherwise           ZSANER='Nincs'; 
    end;
 
 output;
end;
run;

DATA BESZALLITO (keep= CEG CEG_ID ANYAG TERMEKCSOPORT UVEG_TIPUSA TIPUS KERET KILINCS ZAR ZSANER SZALL_DATUM 
	         index=(CEG_ID));

LENGTH CEG $20 CEG_ID $30 ANYAG $10 TERMEKCSOPORT $15 UVEG_TIPUSA $25 TIPUS $35 KERET $6 KILINCS $6 ZAR $6 ZSANER $6;
FORMAT SZALL_DATUM yymmdd10.;

do i=1 to 100;

SZALL_DATUM=.;

/*CEG*/
    RND=ranuni(1);
    select;
      when (RND LT 0.5)  CEG='ABLAK ZRT.';
      when (RND LT 0.75) CEG='Windows';                                         
      otherwise		 CEG='Üvegesék';
    end;

/*CEG_ID*/
    RND=int(ranuni(1)*1000);
    CEG_ID =substr(trim(left(100+RND)),2,2)||'-'||CEG;

/*ANYAG*/
    RND=ranuni(1);
    select;
      when (RND LT 0.1)  ANYAG='Alu';
      when (RND LT 0.65) ANYAG='PVC';                                         
      otherwise		 ANYAG='Fa';
    end; 

/*TERMEKCSOPORT*/
    RND=ranuni(1);
    select;  
      when (RND GT 0.50) TERMEKCSOPORT='Ablakok';
      when (RND GT 0.25) TERMEKCSOPORT='Bejárati ajtók';                                         
      otherwise		 TERMEKCSOPORT='Erkélyajtók';
    end;  

/*UVEG_TIPUSA*/ 
     RND=ranuni(1);
     select;  
     	when (RND GT 0.60)  UVEG_TIPUSA='Normál üveg';  
     	when (RND GT 0.50)  UVEG_TIPUSA='Kétrétegű üveg';                                               
     	when (RND GT 0.35)  UVEG_TIPUSA='Háromrétegű üveg';                                                
     	otherwise  UVEG_TIPUSA='Öntisztító üveg';
     end;

/*TIPUS*/
 select;  
      when (TERMEKCSOPORT='Ablakok') do;  
      	RND=ranuni(1);                
      	if      RND < 0.5  then TIPUS='Bukó-nyíló';
      	else if RND < 0.7  then TIPUS='Bukó';
        else if RND < 0.8  then TIPUS='Nyíló';
        else if RND < 0.85 then TIPUS='Fix';
        else                    TIPUS='Toló';  
      end;                           
      when (TERMEKCSOPORT='Erkélyajtók') do;  
        RND=ranuni(1);
        if      RND < 0.3 then TIPUS='Bejárati';
        else if RND < 0.6 then TIPUS='Toló';
        else if RND < 0.9 then TIPUS='Toló-bukó';
        else                   TIPUS='Harmonika';
      end;
      otherwise TIPUS='Bejárati';
    end;

/*KERET*/
        RND=ranuni(1); 
    select;      
      when (RND GT 0.50)  KERET='Van';
      otherwise           KERET='Nincs'; 
    end;
 
/*KILINCS*/

    if TIPUS NE 'Fix' then do;
      RND=ranuni(1); 
      select;      
        when (RND GT 0.50)  KILINCS='Van';
        otherwise           KILINCS='Nincs'; 
      end;
    end;
    else do;
        KILINCS = 'Nincs';
    end;

/*ZAR*/
    if TERMEKCSOPORT='Ablakok' then do;
   	ZAR = 'Nincs';
    end;
    else do;
      RND=ranuni(1); 
      select;      
        when (RND GT 0.50)  ZAR='Van';
        otherwise           ZAR='Nincs'; 
      end;
    end;
/*ZSANER*/

    RND=ranuni(1); 
    select;      
      when (RND GT 0.50)  ZSANER='Van';
      otherwise           ZSANER='Nincs'; 
    end;
 

/*SZALL_DATUM*/
 RND=ranuni(1)*100;
 SZALL_DATUM = '01JAN2026'd + RND;
 
 output;
end;
run;

/* feladat 6: data-generation quality check via elementary statistics */
proc means data=alapanyagok;
run;
proc freq data=alapanyagok;
tables anyag tipus termekcsoport;
run;
proc means data=beszallito;
run;
proc freq data=beszallito;
tables ceg anyag tipus;
run;
