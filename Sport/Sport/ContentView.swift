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
    @State private var screen: AppScreen = .register
    @State private var selectedCoach: Coach? = nil

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
                HomeView(onOpenCoaches: {
                    screen = .coachList
                })
            case .coachList:
                CoachListView(
                    onBack: { screen = .home },
                    onSelect: { coach in
                        selectedCoach = coach
                        screen = .coachDetail
                    }
                )
            case .coachDetail:
                CoachDetailView(
                    coach: selectedCoach ?? Coach.sample,
                    onBack: { screen = .coachList },
                    onShowReviews: { screen = .coachReviews }
                )
            case .coachReviews:
                CoachReviewsView(
                    onBack: { screen = .coachDetail },
                    onWriteReview: { screen = .writeReview }
                )
            case .writeReview:
                WriteReviewView(onClose: { screen = .coachReviews })
            }
        }
    }
}

#Preview {
    ContentView()
}
