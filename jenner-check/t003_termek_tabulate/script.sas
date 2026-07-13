/* Adapted from adatgeneralas.sas (TERMEK block) + feladat_megoldasok.sas (feladat 3).
   Generates the TERMEK dataset and computes product area (terul), then
   reproduces the student's PROC TABULATE step: a cross-tabulation of
   material x product group x type, with row/column counts and mean
   width/length/area/quantity, including ALL totals. */

DATA TERMEK (keep= TERMEK_ID TERMEKCSOPORT ANYAG
		   PROFIL TIPUS NYITAS_IRANYA
		   UVEG_TIPUSA SZELE HOSSZA DARABSZAM
	     index=(TERMEK_ID));

LENGTH TERMEK_ID $20 TERMEKCSOPORT $25 ANYAG $10 PROFIL $30  TIPUS $30  NYITAS_IRANYA $15 UVEG_TIPUSA $20;
LENGTH DARABSZAM 8.;

LABEL TERMEK_ID     = 'Termek azonositoja'
      TERMEKCSOPORT = 'Termekcsoport'
      ANYAG         = 'Termek anyaga'
      PROFIL 	    = 'Profil'
      TIPUS 	    = 'Tipus'
      NYITAS_IRANYA = 'Nyitas iranya'
      UVEG_TIPUSA   = 'Uveg tipusa'
      SZELE			= 'Szelesseg'
      HOSSZA		= 'Hosszusag'
      DARABSZAM     = 'Darabszam';


do i=1 to 100;

/*TERMEK_ID*/
 TERMEK_ID = "002/"||substr(trim(left(100000+i)),2,5);

/*TERMEKCSOPORT*/

    RND=ranuni(1);
    select;
      when (RND GT 0.50) TERMEKCSOPORT='Ablakok';
      when (RND GT 0.25) TERMEKCSOPORT='Bejarati ajtok';
      otherwise		 TERMEKCSOPORT='Erkelyajtok';
    end;

/*ANYAG*/
 RND=ranuni(1);
     select;
      when (RND LT 0.1)  ANYAG='Alu';
      when (RND LT 0.65) ANYAG='PVC';
      otherwise		 ANYAG='Fa';
    end;

/*PROFIL*/
    select;
      when (ANYAG='Alu') do;
        RND=ranuni(1);
        if      RND < 0.2 then PROFIL='STAR exkluziv alumínium';
        else if RND < 0.6 then PROFIL='ULTRAGLIDE alumínium ';
        else if RND < 0.7 then PROFIL='PANORAMA alumínium';
        else                   PROFIL='SUPERIAL alumínium';
      end;
      when (ANYAG='PVC') do;
        RND=ranuni(1);
        if      RND < 0.5 then PROFIL='M-9000 muanyag';
        else                   PROFIL='M-OC muanyag';
      end;
      when (ANYAG='Fa') do;
        RND=ranuni(1);
        if      RND < 0.3 then PROFIL='Sydney';
        else if RND < 0.6 then PROFIL='Venezia';
        else                   PROFIL='Alaska';
      end;
    end;


/*TIPUS*/
    select;
      when (TERMEKCSOPORT='Ablakok') do;
      RND=ranuni(1);
        if      RND < 0.5  then TIPUS='Buko-nyilo';
        else if RND < 0.7  then TIPUS='Buko';
        else if RND < 0.8  then TIPUS='Nyilo';
        else if RND < 0.85 then TIPUS='Fix';
        else                    TIPUS='Tolo';
      end;
      when (TERMEKCSOPORT='Erkelyajtok') do;
        RND=ranuni(1);
        if      RND < 0.3 then TIPUS='Bejarati';
        else if RND < 0.6 then TIPUS='Tolo';
        else if RND < 0.9 then TIPUS='Tolo-buko';
        else                   TIPUS='Harmonika';
      end;
      otherwise TIPUS='Bejarati';
    end;


/*NYITAS_IRANYA*/
    select;
      when (TIPUS='Buko-nyilo') do;
        RND=ranuni(1);
        if      RND < 0.5 then NYITAS_IRANYA='Jobbos';
        else                   NYITAS_IRANYA='Balos';
      end;
      when (TIPUS='Nyilo') do;
        RND=ranuni(1);
        if RND < 0.5 then NYITAS_IRANYA='Jobbos';
        else              NYITAS_IRANYA='Balos';
      end;
      when (TIPUS='Bejarati') do;
        RND=ranuni(1);
        if RND < 0.5 then NYITAS_IRANYA='Jobbos';
        else              NYITAS_IRANYA='Balos';
        end;
      when (TIPUS='Tolo') do;
        RND=ranuni(1);
        if RND < 0.5 then NYITAS_IRANYA='Jobbos';
        else              NYITAS_IRANYA='Balos';
      end;
      when (TIPUS='Harmonika') do;
        RND=ranuni(1);
        if RND < 0.5 then NYITAS_IRANYA='Jobbos';
        else              NYITAS_IRANYA='Balos';
      end;

      when (TIPUS='Tolo-buko') do;
        RND=ranuni(1);
        if RND < 0.5 then NYITAS_IRANYA='Jobbos';
        else              NYITAS_IRANYA='Balos';
      end;
       when (TIPUS='Buko') do;
       NYITAS_IRANYA='Buko';
      end;
      otherwise NYITAS_IRANYA='Fix';
    end;

/*UVEG_TIPUSA*/
     RND=ranuni(1);
     select;
     	when (RND GT 0.60)  UVEG_TIPUSA='Normal uveg';
     	when (RND GT 0.50)  UVEG_TIPUSA='Ketretegu uveg';
     	when (RND GT 0.35)  UVEG_TIPUSA='Haromretegu uveg';
     	otherwise  UVEG_TIPUSA='Ontisztito uveg';
     end;

 /*MERET*/
 RND=int(ranuni(1)*100);
 SZELE =100+rnd ;
 RNDM=int(ranuni(1)*100);
 HOSSZA= 100+RNDM ;


/*DARABSZAM*/

 RND=int(ranuni(1)*100) ;
 DARABSZAM = RND;

 output;
end;
run;

/* feladat 2: product area + elementary statistics + frequency tables */
data termek2;
set termek;
terul = szele*hossza;
run;

/* tabulate: statisztikai tabla */
proc tabulate data = termek2;
class anyag tipus termekcsoport;
var szele hossza terul darabszam;
table (anyag all),
(termekcsoport all)*(tipus all),
N='Elemszam' (szele hossza terul darabszam)*mean;
run;
