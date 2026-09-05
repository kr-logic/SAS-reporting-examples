/*
	1. feladat
Hány adatállomány keletkezett?

	Work könyvtárban 5 tábla jött létre:

	•	TERMEK (1000 rekorddal)
	•	VEVOK (1000 rekorddal)
	•	ALAPANYAGOK (1000 rekorddal)
	•	BESZALLITO (100 rekorddal)
	•	ures_adatallomany (Teljesen üres, 0 soros dataset)

Jellemezze néhány szóban az adatállományok és azok változóinak jellemzőit, adja meg a mutatókat és a nomenklatúrákat és a keletkezett rekordszámokat! 

	TERMEK (1000 rekord): A nyílászárók katalógusa.
	•	Kódváltozók: Termek_ID, Termékcsoport, Anyag, Profil, Típus, Nyitás iránya, Üveg típusa.
	•	Értékváltozók: Szélesség, Hosszúság, Darabszám.
	VEVOK (1000 rekord): A vásárlók és a szállítási adatok.
	•	Kódváltozók: User_ID, Termek_ID, Név, Város, Utca.
	•	Értékváltozók: Házszám, Távolság (km), Szállítási díj (Ft).
	ALAPANYAGOK (1000 rekord): A termékek felszereltsége 
	•	Kódváltozók: Anyag, Termékcsoport, Típus, Üveg típusa, egyéb összetevők (összesen 8 db kódváltozó)
	BESZALLITO (100 rekord): A partnerek és a szállítmányok.
	•	Kódváltozók: Ceg_ID, Cég neve, felszereltségi kategóriák (összesen 10 db).
	•	Dátum típusú változó: Szállítási dátum.
	ures_adatallomany (0 rekord): Egy teljesen üres tábla változók nélkül.

*/

/*
	2 feladat
A termék adatállományban képezze meg az egyes termékek területét és futtasson elemi statisztikákat!

 */
	data termek2;
	set termek;
	terul = szele*hossza;
	run;

	/*elemi statisztika*/
	title "Elemi statisztika";
	proc means data=termek2;
	run;

/* A nomenklatúrákra képezzen gyakoriságtáblákat! */
	/* gyakoriság tábla */
	title "Gyakoriság tábla";
	proc freq data=termek2;
	tables anyag tipus termekcsoport;
	run;

/* A mutatókra rajzoljon hisztogramokat is és véleményezze, hogy azok mennyire követik a normális eloszlást! */

	/* eloszlás */
	proc univariate data=termek2;
	histogram;
	run;
	
/* A generált termékek darabszáma, szélessége és hossza egyenletes eloszlású, míg a terület közel normális eloszlású. */

/*
	3. feladat
Készítsen statisztikai táblát!
Mutassa ki anyagonként és terméktípusonként a termékcsoportok számát és azok átlagos szélességét, hosszát, területét, illetve darabszámát!
Képezzen a kódadatok szerint összeseneket is.

*/
	/* tabulate: statisztikai tábla */
	proc tabulate data = termek2;
	class anyag tipus termekcsoport;
	var szele hossza terul darabszam;
	table (anyag all),
	(termekcsoport all)*(tipus all),
	N='Elemszám' (szele hossza terul darabszam)*mean;
	run;


/*
	4. feladat
Kapcsolja össze a Termék és a vevő állományokat a termékazonosítók szerint!

 */ 
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

/*
	5. feladat
Statisztikai táblázat készítésével mutassa be, hogy a különböző nevű emberek hány különböző típusú terméket vásároltak és mennyi azok átlaga?
 	
	*/
	proc tabulate data = kozos;
	class nev tipus;
	var szele hossza terul darabszam;
	table (nev all)*(tipus all),
	N='Vásárlások száma' (szele hossza terul darabszam)*mean='Átlag';
	run;

/*
	6. feladat
Ellenőrizze az adatgenerálás minőségét elemi statisztikákkal az Alapanyagok és a Beszállítók adatállományokban.  

	*/
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
	
	/*
	
	Az elemi statisztikák (gyakorisági táblák) alapján megállapítható, hogy az adatgenerálás minősége megfelelő, a kapott eloszlások követik a programkódban rögzített valószínűségi szabályokat:

	ALAPANYAGOK (N=1000): A termékcsoportok (Ablak: ~52%, Bejárati ajtó: ~22%, Erkélyajtó: ~26%) és az alapanyagok (PVC: ~56%, Fa: ~33%, Alu: ~11%) százalékos megoszlása szinte pontosan megegyezik a ranuni függvénynek megadott határértékekkel.

	BESZALLITO (N=100): A kisebb elemszám miatt itt nagyobb a szórás, de a trendek (pl. az Alu anyag alacsony, 6%-os részaránya vagy az ABLAK ZRT. dominanciája) továbbra is konzisztensek a kód logikájával.

	Következtetés: A generált adatok statisztikailag reprezentálják a modellben leírt üzleti logikát, nincsenek kiugró hibák vagy hiányzó kategóriák.
	
	*/

/*
	7. feladat
Kapcsolja össze (párosítsa) a két munkaállomány az anyagok szerint!	

	*/
	proc sort data=beszallito force;
	by anyag;
	run;
	proc sort data=alapanyagok force;
	by anyag;
	run;

	data kozos2;
	merge alapanyagok (in=t)
	beszallito (in=v);
	by anyag;
	if t=v;
	run;
	
/* Jellemezze az eredményül kapott adatállományt!

	Az összekapcsolás az ANYAG kulcsváltozó alapján történt. Mivel egy adott anyag (pl. Fa, PVC) mindkét eredeti táblában többször is szerepel, ez egy úgynevezett sok-a-sokhoz kapcsolat.
	A létrejött kozos2 adatállomány horizontálisan kibővült, azaz tartalmazza az ALAPANYAGOK tábla technikai paramétereit (Keret, Kilincs, Zár, Zsanér) és a BESZALLITO tábla adatait (Cégnév, Szállítási dátum) is egyetlen közös táblában.
	Az állomány azt mutatja meg, hogy a különböző anyagú és felszereltségű termékek (ablakok, ajtók) beszerzése melyik partnercéghez (pl. ABLAK ZRT., Windows) köthető.

*/
	
/* Készítsen statisztikai táblát a kapott adatállomány adataiból anyagtípusonként, a szállítók neve és a terméktípusok és a termékcsoportok szerint! -	Számítsa ki a kategóriánkénti összeseneket is. */

	title "Kimutatás cégenként, anyagonként és termékcsoportonként";
	proc tabulate data = kozos2;
	class anyag tipus termekcsoport ceg;
	table termekcsoport all = "Összesen",
	(anyag all="Összesen")*(tipus all="Összesen"),
	(ceg all = "Összesen");
	run;


