[📄 **Olvasd el a teljes tanulmányt PDF formátumban ide kattintva!**](bankkartyas_csalasok_detektalasa.pdf)

**A Kutatás Célja**
A projekt egy prediktív osztályozó modell felépítését dokumentálja, amely a bankkártyás csalásokat (fraud) valós időben szűri ki. A globális bankkártyás csalásokból eredő kár évente több tízmilliárd dollárra tehető, a hagyományos szabályalapú (rule-based) rendszereket pedig a kiberbűnözők könnyedén kijátsszák. A gépi tanulás lehetővé teszi a gyanús mintázatok proaktív felismerését, megvédve a pénzintézetek bizalmi tőkéjét és minimalizálva a számviteli veszteséget.

**Adathalmaz és Informatikai Megoldás**
* **Adatforrás:** A Kaggle európai kártyabirtokosok 48 órás tranzakcióit tartalmazó nyílt adatbázisa, amely 284 807 rekordot foglal magába.
* **Technológia:** SAS OnDemand for Academics, amely robusztus architektúrájával helyi hardverigény nélkül képes a nagyméretű, iparági standardoknak megfelelő állományok gyors feldolgozására.
* **Kihívás:** Az adatok szélsőséges kiegyensúlyozatlansága, mivel az adatbázisban mindössze 492 (0,17%) tényleges csalás szerepel.
* **Adattisztítás:** Az `Amount` (tranzakciós összeg) változó standardizálása, hogy a modell ne rendeljen indokolatlanul nagy súlyt a magasabb nominális értékekhez a 28 darab titkosított numerikus főkomponenshez (V1-V28) képest.
* **Modellezés:** A statisztikai zaj és a pontossági paradoxon kiküszöbölése érdekében alul-mintavételezéssel (under-sampling) egy 50-50 százalékos arányú, mesterségesen kiegyensúlyozott, 984 soros munkaállomány jött létre a logisztikus regressziós modell lépésenkénti (stepwise) betanításához.

**Eredmények és Üzleti Értékelés**
A prediktív modell iteratív kiértékelése a teljes eredeti adathalmazon, egy 50%-os beavatkozási küszöbérték alkalmazásával történt.

| Statisztikai Mutató | Eredmény | Pénzügyi és Üzleti Interpretáció |
| :--- | :--- | :--- |
| **Sikeres Detektálás (Szenzitivitás)** | 91,1% (448 eset) | Iparági sztenderdek alapján kiváló eredmény, amely közvetlenül lefordítható megmentett tőkére és elkerült kártérítési kötelezettségekre. |
| **Fals Negatív (Átcsúszott csalás)** | 44 eset | A hálón átcsúszott kifinomult csalások száma, amely a bank számára már maximálisan tolerálható kockázati veszteséget jelent. |
| **Fals Pozitív (Téves riasztás)** | 8 267 eset | Elfogadható adminisztratív többletterhelés a több mint 280 000 normál tranzakcióhoz viszonyítva; automata SMS-sel vagy hívással racionálisan kezelhető kompromisszum. |
