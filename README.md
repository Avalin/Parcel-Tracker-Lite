# Parcel Tracker Lite

En lille Flutter-app til at tilføje og tracke pakker via tracking-nummer.

# Sådan kører du projektet: 
- git clone https://github.com/Avalin/parcel_tracker_lite.git
- cd parcel_tracker_lite
- flutter pub get
- flutter run

# Kræver:
Flutter (latest stable)
Android emulator eller iOS simulator burde virke (Jeg har kun testet på Android)

# Arkitektur & struktur

Jeg har valgt en feature-baseret struktur (feature-first) med let lagdeling:

lib/
  features/
    parcels/
      models/
      services/
      controllers/
      screens/
      widgets/

# Hvorfor denne struktur?
- Samler alt relateret til én feature samme sted
- Gør det nemt at skalere appen senere

Jeg fravalgte en klassisk layer-first struktur, fordi den hurtigt spreder relateret kode ud i mange mapper (selvom det giver mening for en lille MVP som det her jo er), og DDP (domain, data, presentation) fordi det hurtigt bliver lidt for tungt i en lille app.

Tydelig adskillelse mellem:
* UI (screens, widgets)
* State / logik (controllers)
* Data / backend-simulering (services)
* Data-modeller (models)

# Funktionalitet

* Tilføjelse af pakker via trackingnummer og postnummer
* Visning af pakker i en liste
* Simpel statusvisning (via enum)
* Lidt loading- og fejl-state håndtering
* Simpel detaljeside for hver pakke

# Statushåndtering

- Parcel-status er modelleret som en enum for at sikre type safety.
- Mapping til visning (label og farve) håndteres via extension på enum’en, for at:
  * holde logik tæt på data
  * undgå duplikation i UI-laget (hvis vi viser labels flere steder fx)

I en større app ville jeg flytte UI-specifikke ting (fx farver og labels) til et mere dedikeret presentation-/localization-lag.

# Modelvalg

Jeg har valgt plain Dart-modeller med immutable felter (`final`) frem for fx `freezed`, da modellerne i denne opgave er små og enkle, og jeg gerne ville holde løsningen let og uden unødig code generation.

Hvis modellen eller state-håndteringen blev mere kompleks, ville `freezed` være et oplagt valg, især pga. `copyWith`, value equality og mindre boilerplate.

# State management

Jeg har valgt en simpel `ChangeNotifier`-baseret controller til state management.

Det giver en tydelig separation mellem UI og state uden at introducere unødig kompleksitet i forhold til opgavens scope. Til en større app ville jeg bruge `Riverpod`, men til denne opgave vurderede jeg, at `ChangeNotifier` var et passende valg i forhold til scope og tidsramme.

# Persistens

Jeg har valgt `shared_preferences` til lokal persistens, da datamængden i opgaven er lille, og løsningen er hurtig at implementere...
Hvis datamængden voksede markant, eller hvis appen fik behov for mere avancerede queries og relationer, ville jeg i stedet vælge en databasebaseret løsning som fx `Drift`.

# Data / fake backend

Jeg har introduceret en simpel `TrackingService`, som simulerer et backend-opslag via en `Future` med forsinkelse og returnerer en parcel-status.

Det holder backend-simulering adskilt fra controlleren og gør ansvarsfordelingen tydeligere.

# Accessibility

Jeg har arbejdet med basic accessibility ved at:

* Tilføje `Semantics` på listeelementer og detaljefelter
* Vælge mørkere statusfarver for bedre kontrast på lys baggrund

# Hvis jeg havde haft mere tid

Hvis jeg havde haft mere tid, ville jeg blandt andet:
* Udvide med at man faktisk kan fjerne/delete pakker igen, evt. redigere dem
* Udvide accessibility yderligere, fx med mere detaljerede labels/hints og systematisk test med skærmlæser
* Simulere backend-fejl mere eksplicit i `TrackingService`
* Overveje et mere skalerbart state management setup ved flere features, såsom Riverpod
* Forbedre datoformattering og generel UI-polish
* Tilføjet pull-to-refresh
* Tests! Fx. på AddParcel