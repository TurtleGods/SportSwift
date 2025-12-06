//
//  ContentView.swift
//  Sport
//
//  Created by 佳緯周 on 2025/12/6.
//

import SwiftUI

private enum AppScreen {
    case register
    case basicInfo
    case goal
    case calories
    case caloriesConfirm
    case home
}

struct ContentView: View {
    @State private var screen: AppScreen = .register

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            switch screen {
            case .register:
                RegisterView { screen = .basicInfo }
            case .basicInfo:
                BasicInfoView(
                    onBack: { screen = .register },
                    onNext: { screen = .goal }
                )
            case .goal:
                GoalView(
                    onBack: { screen = .basicInfo },
                    onNext: { screen = .calories }
                )
            case .calories:
                CaloriesView(
                    onBack: { screen = .goal },
                    onSave: {
                        screen = .caloriesConfirm
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            screen = .home
                        }
                    }
                )
            case .caloriesConfirm:
                CaloriesView(
                    onBack: { screen = .goal },
                    showConfirmation: true,
                    onSave: {}
                )
            case .home:
                HomeView()
            }
        }
    }
}

#Preview {
    ContentView()
}
