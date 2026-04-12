# Parcel Tracker Lite

En lille Flutter-app til at tilføje og tracke pakker via tracking-nummer.

# Sådan kører du projektet: 
git clone <repo-url>
cd test_repository
flutter pub get
flutter run

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

Jeg fravalgte en klassisk layer-first struktur, fordi den hurtigt spreder relateret kode ud i mange mapper, og DDP (domain, data, presentation) fordi det hurtigt bliver lidt for tungt i en lille app.

Tydelig adskillelse mellem:
* UI (screens, widgets)
* State / logik (controllers)
* Data / backend-simulering (services)
* Data-modeller (models)