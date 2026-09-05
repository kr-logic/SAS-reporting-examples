/* Adatgeneráló fájl, készítette [Csicsman József](https://math.bme.hu/~csicsman/index.html) tanár úr. */

DATA TERMEK (keep= TERMEK_ID TERMEKCSOPORT ANYAG 
		   PROFIL TIPUS NYITAS_IRANYA 
		   UVEG_TIPUSA SZELE HOSSZA DARABSZAM
	     index=(TERMEK_ID));
	
LENGTH TERMEK_ID $20 TERMEKCSOPORT $25 ANYAG $10 PROFIL $30  TIPUS $30  NYITAS_IRANYA $15 UVEG_TIPUSA $20;
LENGTH DARABSZAM 8.;

LABEL TERMEK_ID     = 'Termék azonosítója'
      TERMEKCSOPORT = 'Termékcsoport'
      ANYAG         = 'Termék anyaga'
      PROFIL 	    = 'Profil'
      TIPUS 	    = 'Típus'
      NYITAS_IRANYA = 'Nyitás iránya'
      UVEG_TIPUSA   = 'Üveg típusa'
      SZELE			= 'Szélesség'
      HOSSZA		= 'Hosszúság'
      DARABSZAM     = 'Darabszám';
      

do i=1 to 1000;

/*TERMEK_ID*/
 TERMEK_ID = "002/"||substr(trim(left(100000+i)),2,5);

/*TERMEKCSOPORT*/

    RND=ranuni(1);
    select;
      when (RND GT 0.50) TERMEKCSOPORT='Ablakok';
      when (RND GT 0.25) TERMEKCSOPORT='Bejárati ajtók';                                         
      otherwise		 TERMEKCSOPORT='Erkélyajtók';
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
        if      RND < 0.2 then PROFIL='STAR exkluzív alumínium';
        else if RND < 0.6 then PROFIL='ULTRAGLIDE alumínium ';
        else if RND < 0.7 then PROFIL='PANORAMA alumínium'; 
        else                   PROFIL='SUPERIAL alumínium';
      end;   
      when (ANYAG='PVC') do;  
        RND=ranuni(1);    
        if      RND < 0.5 then PROFIL='M-9000 műanyag';  
        else                   PROFIL='M-OC műanyag';  
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


/*NYITAS_IRANYA*/ 
    select;  
      when (TIPUS='Bukó-nyíló') do;        
        RND=ranuni(1);                      
        if      RND < 0.5 then NYITAS_IRANYA='Jobbos'; 
        else                   NYITAS_IRANYA='Balos';  
      end;   
      when (TIPUS='Nyíló') do; 
        RND=ranuni(1);         
        if RND < 0.5 then NYITAS_IRANYA='Jobbos';
        else              NYITAS_IRANYA='Balos'; 
      end;
      when (TIPUS='Bejárati') do;  
        RND=ranuni(1);              
        if RND < 0.5 then NYITAS_IRANYA='Jobbos'; 
        else              NYITAS_IRANYA='Balos';  
        end;
      when (TIPUS='Toló') do;                    
        RND=ranuni(1);   
        if RND < 0.5 then NYITAS_IRANYA='Jobbos';  
        else              NYITAS_IRANYA='Balos'; 
      end;
      when (TIPUS='Harmonika') do;
        RND=ranuni(1);             
        if RND < 0.5 then NYITAS_IRANYA='Jobbos';  
        else              NYITAS_IRANYA='Balos';   
      end;
      
      when (TIPUS='Toló-bukó') do;    
        RND=ranuni(1);       
        if RND < 0.5 then NYITAS_IRANYA='Jobbos';
        else              NYITAS_IRANYA='Balos'; 
      end;
       when (TIPUS='Bukó') do;  
       NYITAS_IRANYA='Bukó';
      end;
      otherwise NYITAS_IRANYA='Fix';
    end;		      

/*UVEG_TIPUSA*/ 
     RND=ranuni(1);
     select;  
     	when (RND GT 0.60)  UVEG_TIPUSA='Normál üveg';  
     	when (RND GT 0.50)  UVEG_TIPUSA='Kétrétegű üveg';                                               
     	when (RND GT 0.35)  UVEG_TIPUSA='Háromrétegű üveg';                                                
     	otherwise  UVEG_TIPUSA='Öntisztító üveg';
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
 SZALL_DATUM = date() + RND;
 
 output;
end;
run;

data ures_adatallomany; 
run;
