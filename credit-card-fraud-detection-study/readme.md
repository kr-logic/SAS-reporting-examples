Magyar nyelvű leírás megtalálható lejjebb / Hungarian description can be found below

---

# Credit Card Fraud Detection Using a Statistical Model

[📄 **Click here to read the full study in PDF format!**](english/credit_card_fraud_detection.pdf)

**Research Objective**

The project documents the construction of a predictive classification model that filters out credit card fraud in real time. The damage resulting from global credit card fraud amounts to tens of billions of dollars annually, and traditional rule-based systems are easily bypassed by cybercriminals. Machine learning enables the proactive recognition of suspicious patterns, protecting the trust capital of financial institutions and minimizing accounting losses.

**Dataset and IT Solution**

* **Data Source:** Kaggle's open database containing 48 hours of transactions by European cardholders, comprising 284,807 records.
* **Technology:** SAS OnDemand for Academics, which, with its robust architecture, is capable of rapidly processing large, industry-standard datasets without local hardware requirements.
* **Challenge:** The extreme imbalance of the data, as the database contains only 492 (0.17%) actual frauds.
* **Data Cleaning:** Standardization of the `Amount` (transaction amount) variable so that the model does not assign unreasonably large weights to higher nominal values compared to the 28 encrypted numerical principal components (V1-V28).
* **Modeling:** To eliminate statistical noise and the accuracy paradox, an artificially balanced, 50-50 ratio working dataset of 984 rows was created using under-sampling for the stepwise training of the logistic regression model.

**Results and Business Evaluation**

The iterative evaluation of the predictive model was performed on the complete original dataset using a 50% intervention threshold.

| Statistical Metric | Result | Financial and Business Interpretation |
| :--- | :--- | :--- |
| **Successful Detection (Sensitivity)** | 91.1% (448 cases) | An excellent result based on industry standards, translating directly into saved capital and avoided compensation liabilities. |
| **False Negative (Slipped-through fraud)** | 44 cases | The number of sophisticated frauds that slipped through the net, representing the maximally tolerable risk loss for the bank. |
| **False Positive (False alarm)** | 8,267 cases | An acceptable additional administrative burden compared to the more than 280,000 normal transactions; a rationally manageable compromise via automated SMS or phone call. |

---

# Bankkártyás csalások detektálása statisztikai modellel

[📄 **A teljes tanulmány PDF formátumban ide kattintva olvasható!**](hungarian/bankkartyas_csalasok_detektalasa.pdf)

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
