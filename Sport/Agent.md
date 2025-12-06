### Apple App Application
Use apple swiftUI to build iOS app application
### Registration
- Build the registration flow to match the screens in `Flow/1-0-1.png`, `Flow/1-0-2.png`, `Flow/1-0-3.png`, and `Flow/1-0-4.png`.
- On the screen that matches `Flow/1-0-4.png`, when the user taps Save, show the confirmation view in `Flow/1-0-5.png`; After a while delay, go to Home page.

### Home
- After registration completes, navigate to the home screen shown in `Flow/1-1-1-home.png`.

### 熱門教練推薦
- From `Screens/HomeView.swift`, tapping 「熱門教練推薦」 (header or card) navigates forward (no sheets) through the following flow:
1. `Flow/1-2-1.png` coach list. Selecting a coach pushes to…
2. `Flow/1-2-2.png` coach detail. Tapping the top-right 「查看評價」 pushes to…
3. `Flow/1-2-3.png` reviews list. Tapping to rate/comment pushes to…
4. `Flow/1-2-4.png` write review screen.
