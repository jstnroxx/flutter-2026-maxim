# Campus events

A small Flutter app for browsing, registering for and organising events on a university campus:
hackathons, concerts, tournaments, career fairs and so on. All data lives in memory and is seeded with twelve events on every start.

## Screenshots

| Phone, light | Phone, dark | Tablet, grid |
| --- | --- | --- |
| ![Phone, light](phone_light.png) | ![Phone, dark](phone_dark.png) | ![Tablet, grid](tablet_grid.png) |

## What it does

- **Events tab:** search, category chips and a "Past" filter; a list on phones and a grid from 600 px wide; favourites; a badge when an event is full or has five or fewer places left.
- **Favourites tab:** the events you starred, with an empty state that leads back to the list.
- **Profile tab:** name, group (format `IT-2301`), a live "You are on N lists" line and a System / Light / Dark theme switch.
- **Event detail:** a countdown that updates every minute, About and Names tabs, Register and Unregister, and Edit and Delete in the menu.
- **Event form:** one screen for creating and editing, with validation, date and time pickers, and a guard against discarding unsaved changes.
- **Drawer:** About and Reset data.

## Run

```
flutter pub get
flutter run
```

The header image is `assets/header.png`, declared under `flutter: assets:` in `pubspec.yaml`.

## Structure

| File | Contents |
| --- | --- |
| `lib/models.dart` | `EventCategory`, the sealed `Countdown`, `CampusEvent`, `Profile`, list helpers and the seed data |
| `lib/utils/format.dart` | Date, time, duration and countdown formatting |
| `lib/widgets.dart` | `EventCard` and `EmptyState` |
| `lib/tabs.dart` | The Events, Favourites and Profile tabs |
| `lib/screens.dart` | The detail screen and the event form |
| `lib/routes.dart` | Route names, typed route arguments, route generation |
| `lib/main.dart` | `MyApp` (theme mode) and the `Shell` (tabs, drawer, state) |

## Decisions

The list of events and the profile live in the shell's
State, the lowest widget that all three tabs share, so the tabs receive them
as constructor parameters and report changes upward through callbacks. The detail screen
takes callbacks through typed route arguments because it is a separate route that cannot reach the
shell's State, and it keeps its own copy of the event so it can redraw at once after Register or Edit.
The form returns a value with `Navigator.pop` instead of writing into the list, which keeps it a plain
"edit this event" screen that works for new and existing events, while the caller decides what to do with
the result, or nothing when it returns null. The list uses a `LayoutBuilder` rather than a device check because 
the available width, not the kind of device, decides whether a grid fits, so a rotated phone or a split-screen
window gets the right layout without extra code. `PopScope` compares a snapshot of the form's current values
with the snapshot taken when the form opened, so retyping the original text does not count as a change, and Save
never asks because it pops directly. The theme mode sits in a `ValueNotifier` in `MyApp`'s State, because a route's
page is built once and cached, so a plain parameter passed to the shell would never refresh. 
