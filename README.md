# Parcel Tracker Lite

A small Flutter app for adding and tracking parcels via tracking number. This was made as a small showcase for a job interview

# How to run the project:
- `git clone https://github.com/Avalin/parcel_tracker_lite.git`
- `cd parcel_tracker_lite`
- `flutter pub get`
- `flutter run`

# Requirements:
Flutter (latest stable)

Android emulator or iOS simulator should work (I have only tested on Android)

# Architecture & Structure

I chose a feature-based structure (feature-first) with light layering:

```txt
lib/
  features/
    parcels/
      models/
      services/
      controllers/
      screens/
      widgets/
```

# Why this structure?
- Keeps everything related to a single feature in one place
- Makes the app easier to scale later on

I opted out of a classic layer-first structure because it quickly spreads related code across many folders (even though it still makes sense for a small MVP like this), and I avoided DDP (domain, data, presentation) because it becomes a bit too heavy for a small app.

Clear separation between:
- UI (`screens`, `widgets`)
- State / logic (`controllers`)
- Data / backend simulation (`services`)
- Data models (`models`)

# Functionality

- Add parcels using tracking number and postal code
- Display parcels in a list
- Simple status display (via enum)
- Basic loading and error state handling
- Simple detail page for each parcel

# Status handling

- Parcel status is modeled as an enum to ensure type safety.
- Mapping to presentation (label and color) is handled through extensions on the enum in order to:
  - keep logic close to the data
  - avoid duplication in the UI layer (for example if labels are shown in multiple places)

In a larger app, I would move UI-specific things (such as colors and labels) into a more dedicated presentation/localization layer.

# Model choices

I chose plain Dart models with immutable (`final`) fields instead of something like `freezed`, since the models in this assignment are small and simple, and I wanted to keep the solution lightweight and avoid unnecessary code generation.

If the models or state handling became more complex, `freezed` would be an obvious choice, especially because of `copyWith`, value equality, and reduced boilerplate.

# State management

I chose a simple `ChangeNotifier`-based controller for state management.

It provides a clear separation between UI and state without introducing unnecessary complexity relative to the scope of the assignment. For a larger app, I would use `Riverpod`, but for this task I felt that `ChangeNotifier` was an appropriate choice given the scope and timeframe.

# Persistence

I chose `shared_preferences` for local persistence because the amount of data in the assignment is small, and the solution is quick to implement.

If the amount of data grew significantly, or if the app needed more advanced queries and relationships, I would instead choose a database-based solution such as `Drift`.

# Data / fake backend

I introduced a simple `TrackingService` that simulates a backend lookup using a delayed `Future` and returns a parcel status.

This keeps the backend simulation separated from the controller and makes responsibilities clearer.

# Accessibility

I worked with basic accessibility by:

- Adding `Semantics` to list items and detail fields
- Choosing darker status colors for better contrast on light backgrounds

# If I had more time

If I had more time, I would among other things:
- Expand functionality so parcels can actually be removed/deleted and possibly edited
- Improve accessibility further, for example with more detailed labels/hints and systematic screen reader testing
- Simulate backend failures more explicitly in `TrackingService`
- Consider a more scalable state management setup for multiple features, such as `Riverpod`
- Improve date formatting and general UI polish
- Add pull-to-refresh
- Add tests! For example around `AddParcel`
- In the current solution, the dialog also closes when adding a parcel fails. A next step would be to only close the dialog on success and otherwise keep it open so the user does not lose their input
