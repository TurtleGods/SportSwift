# Sport (SwiftUI)

## Overview
- iOS SwiftUI app that follows MVVM-by-feature: Registration, Home, Coaches, Records, Account.
- `ContentView` coordinates navigation and holds shared view models; shared UI in `Sport/Components`, theme in `Sport/Theme`, models in `Sport/Models`.
- Flows are aligned with provided design mockups under `Flow/`.

## Project Structure
- `Sport/SportApp.swift` – entry point.
- `Sport/ContentView.swift` – navigation state and screen composition.
- Features
  - `Sport/Features/Registration/{Views,ViewModels}` – registration, basic info, goals, calories.
  - `Sport/Features/Home/{Views,ViewModels}` – home feed and coach entrypoints.
  - `Sport/Features/Coaches/{Views,ViewModels}` – coach list/detail/reviews/write review.
  - `Sport/Features/Records/{Views,ViewModels}` – exercise/food record forms with swipe/tap paging.
  - `Sport/Features/Account/Views/AccountView.swift` – account hub opened from the profile icon.
- Shared UI
  - `Sport/Components` – bars, inputs, cards, bottom navigation.
  - `Sport/Theme` – colors and styling tokens.
  - `Sport/Models` – data models (e.g., `Coach`).
- Assets: `Sport/Assets.xcassets`.
- Designs: `Flow/*.png`.

## Running & Building
```sh
cd Sport
DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer xcodebuild -scheme Sport -destination 'generic/platform=iOS' build
```
Open `Sport.xcodeproj` in Xcode 15+ to run on simulator/device.

## Navigation Notes
- Bottom bar uses `BottomTab`; callbacks are passed from `ContentView`.
- Profile icon (`person.crop.circle`) opens the account screen.
- Records view supports swipe or dot tap to switch exercise/food pages.
- Registration flow auto-advances to Home after calories confirmation.

## Testing & TODOs
- No automated tests yet. Add SwiftUI snapshot/unit tests per feature if needed.
- Replace placeholder data in coaches/account with real sources or networking.
