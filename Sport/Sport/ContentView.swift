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
    case coachList
    case coachDetail
    case coachReviews
    case writeReview
}

struct ContentView: View {
    @StateObject private var registrationViewModel = RegistrationViewModel()
    @StateObject private var homeViewModel = HomeViewModel()
    @StateObject private var coachesViewModel = CoachesViewModel()
    @State private var screen: AppScreen = .register

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            switch screen {
            case .register:
                RegisterView(viewModel: registrationViewModel) { screen = .basicInfo }
            case .basicInfo:
                BasicInfoView(
                    viewModel: registrationViewModel,
                    onBack: { screen = .register },
                    onNext: { screen = .goal }
                )
            case .goal:
                GoalView(
                    viewModel: registrationViewModel,
                    onBack: { screen = .basicInfo },
                    onNext: { screen = .calories }
                )
            case .calories:
                CaloriesView(
                    viewModel: registrationViewModel,
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
                    viewModel: registrationViewModel,
                    onBack: { screen = .goal },
                    showConfirmation: true,
                    onSave: {}
                )
            case .home:
                HomeView(
                    viewModel: homeViewModel,
                    onOpenCoaches: {
                    screen = .coachList
                })
            case .coachList:
                CoachListView(
                    viewModel: coachesViewModel,
                    onBack: { screen = .home },
                    onSelect: { _ in
                        screen = .coachDetail
                    }
                )
            case .coachDetail:
                CoachDetailView(
                    viewModel: coachesViewModel,
                    onBack: { screen = .coachList },
                    onShowReviews: { screen = .coachReviews }
                )
            case .coachReviews:
                CoachReviewsView(
                    viewModel: coachesViewModel,
                    onBack: { screen = .coachDetail },
                    onWriteReview: { screen = .writeReview }
                )
            case .writeReview:
                WriteReviewView(
                    viewModel: coachesViewModel,
                    onClose: { screen = .coachReviews }
                )
            }
        }
    }
}

#Preview {
    ContentView()
}
