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
    case records
    case account
}

struct ContentView: View {
    @StateObject private var registrationViewModel = RegistrationViewModel()
    @StateObject private var homeViewModel = HomeViewModel()
    @StateObject private var coachesViewModel = CoachesViewModel()
    @StateObject private var recordsViewModel = RecordsViewModel()
    @State private var screen: AppScreen = .register

    private func handleTab(_ tab: BottomTab) {
        switch tab {
        case .home, .favorites, .schedule:
            screen = .home
        case .records:
            screen = .records
        }
    }

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
                    },
                    onProfile: { screen = .account },
                    onSelectTab: handleTab
                )
            case .coachList:
                CoachListView(
                    viewModel: coachesViewModel,
                    onBack: { screen = .home },
                    onSelect: { _ in
                        screen = .coachDetail
                    },
                    onSelectTab: handleTab
                )
            case .coachDetail:
                CoachDetailView(
                    viewModel: coachesViewModel,
                    onBack: { screen = .coachList },
                    onShowReviews: { screen = .coachReviews },
                    onSelectTab: handleTab
                )
            case .coachReviews:
                CoachReviewsView(
                    viewModel: coachesViewModel,
                    onBack: { screen = .coachDetail },
                    onWriteReview: { screen = .writeReview },
                    onSelectTab: handleTab
                )
            case .writeReview:
                WriteReviewView(
                    viewModel: coachesViewModel,
                    onClose: { screen = .coachReviews },
                    onSelectTab: handleTab
                )
            case .records:
                RecordsView(
                    viewModel: recordsViewModel,
                    onBack: { screen = .home },
                    onSelectTab: handleTab
                )
            case .account:
                AccountView(
                    onBack: { screen = .home },
                    onBasicInfo: { screen = .basicInfo }
                )
            }
        }
    }
}

#Preview {
    ContentView()
}
