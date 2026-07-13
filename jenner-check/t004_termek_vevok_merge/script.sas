/* Adapted from adatgeneralas.sas (TERMEK + VEVOK blocks) + feladat_megoldasok.sas
   (feladat 4-5). Generates the TERMEK product catalog and the VEVOK customer/
   delivery dataset, sorts and merges them by termek_id (feladat 4), then
   reproduces the student's PROC TABULATE breakdown of how many distinct
   product types each named customer bought and their average width/length/
   area/quantity (feladat 5). */

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

DATA VEVOK (keep= USER_ID NEV LAKHELY_V LAKHELY_U LAKHELY_HSZ 
KM KM_FT   TERMEK_ID index=(USER_ID));
	
LENGTH USER_ID $20 NEV $30 TERMEK_ID $20
LAKHELY_V $15 LAKHELY_U $20 LAKHELY_HSZ 6 ;

do i=1 to 1000;

/*USER_ID*/
USER_ID = "user/"||substr(trim(left(100000+i)),2,5);

/*NEV*/
    RND=ranuni(1);
    select;       
      when (RND GT 0.99) NEV= 'Mézga Aladár';
      when (RND GT 0.88) NEV= 'Dr. Bubó';
      when (RND GT 0.77) NEV= 'Jókai Mór';
      when (RND GT 0.66) NEV= 'Claude Achille Debussy';
      when (RND GT 0.55) NEV= 'Havasi Balázs';
      when (RND GT 0.44) NEV= 'Ernest Hemingway';
      when (RND GT 0.33) NEV= 'Vincent Willem van Gogh';
      when (RND GT 0.22) NEV= 'Harry James Potter';
      when (RND GT 0.11) NEV= 'Marie Curie';      
      otherwise          NEV= 'Sheldon Lee Cooper';
    end;  

/*LAKHELY_V*/ 
RND=ranuni(1);
    select;       
      when (RND GT 0.99) LAKHELY_V= 'Budapest';
      when (RND GT 0.88) LAKHELY_V= 'Szeged';
      when (RND GT 0.77) LAKHELY_V= 'Sopron';
      when (RND GT 0.66) LAKHELY_V= 'Győr';
      when (RND GT 0.55) LAKHELY_V= 'Debrecen';
      when (RND GT 0.44) LAKHELY_V= 'Pécs';
      when (RND GT 0.33) LAKHELY_V= 'Székesfehérvár';
      when (RND GT 0.22) LAKHELY_V= 'Veszprém';
      when (RND GT 0.11) LAKHELY_V= 'Eger';      
      otherwise          LAKHELY_V= 'Esztergom';
    end;
/*KM*/
  select;
   when (LAKHELY_V= 'Budapest') KM=0;  /*Budapesten belül ingyenes a szállítás*/
   when (LAKHELY_V= 'Szeged')   KM=174 ; 
   when (LAKHELY_V= 'Sopron')   KM=213; 
   when (LAKHELY_V= 'Győr')     KM=121; 
   when (LAKHELY_V= 'Debrecen') KM=230; 
   when (LAKHELY_V= 'Pécs')     KM=232; 
   when (LAKHELY_V= 'Székesfehérvár') KM=70; 
   when (LAKHELY_V= 'Veszprém') KM=115; 
   when (LAKHELY_V= 'Eger')     KM=138; 
   otherwise  KM=51; 		/*'Esztergom'*/
  end;

/*KM_FT*/
select;
 when (KM LT 50) do; KM_FT=0; end;
 when (KM LT 100) do; KM_FT=5000; end;
 when (KM LT 150) do; KM_FT=7500; end;
 when (KM LT 200) do; KM_FT=10000; end;
 otherwise KM_FT=15000;
end;

/*LAKHELY_U*/ 
RND=ranuni(1);
    select;       
      when (RND GT 0.99) LAKHELY_U= 'Tó u.';
      when (RND GT 0.88) LAKHELY_U= 'Fehér u.';
      when (RND GT 0.77) LAKHELY_U= 'Kukovecz Nana u.';
      when (RND GT 0.66) LAKHELY_U= 'Victor Hugo u.';
      when (RND GT 0.55) LAKHELY_U= 'Iker u.';
      when (RND GT 0.44) LAKHELY_U= 'Oskola u.';
      when (RND GT 0.33) LAKHELY_U= 'Oroszlán u.';
      when (RND GT 0.22) LAKHELY_U= 'Ősz u.';
      when (RND GT 0.11) LAKHELY_U= 'Tündér u.';      
      otherwise          LAKHELY_U= 'Tavasz u.';
    end;

/*LAKHELY_HSZ*/
 RND=int(ranuni(1)*1000);
 LAKHELY_HSZ = substr(trim(left(100+RND)),2,2);
/*TERMEK_ID*/
RND=int(ranuni(1)*1000);
 TERMEK_ID = "002/"||substr(trim(left(100000+RND)),2,5);

 output;
end;
run;

/* feladat 4: merge termek + vevok by termek_id */
proc sort data=termek2;
by termek_id;
run;
proc sort data=vevok force;
by termek_id;
run;
data kozos;
merge termek2 (in=t)
vevok (in=v);
by termek_id;
if t=v;
run;

/* feladat 5: purchases per customer name x product type, with averages */
proc tabulate data = kozos;
class nev tipus;
var szele hossza terul darabszam;
table (nev all)*(tipus all),
N='Vasarlasok szama' (szele hossza terul darabszam)*mean='Atlag';
run;
