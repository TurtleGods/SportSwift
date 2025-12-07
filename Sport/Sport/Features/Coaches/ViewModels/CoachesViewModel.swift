import Foundation
import SwiftUI
import Combine

struct CoachReview: Identifiable {
    let id = UUID()
    var authorInitial: String
    var authorName: String
    var timeAgo: String
    var rating: Int
    var comment: String
    var accent: Color
}

final class CoachesViewModel: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
    @Published var coaches: [Coach] = [
        Coach(name: "王小名", experience: "abcabcabc", rating: 4, accent: .blue),
        Coach(name: "王小名", experience: "abcabcabc", rating: 5, accent: .green),
        Coach(name: "王小名", experience: "abcabcabc", rating: 3, accent: .orange),
        Coach(name: "王小名", experience: "abcabcabc", rating: 4, accent: .purple)
    ]
    @Published var selectedCoach: Coach? = nil

    @Published var selectedCity: String = "台北"
    @Published var selectedArea: String = "大安區"
    let cities = ["台北", "新北", "桃園"]
    let areas = ["大安區", "信義區", "中山區"]

    @Published var averageRating: Int = 4
    @Published var reviews: [CoachReview] = [
        CoachReview(authorInitial: "T", authorName: "tsai pei-ru", timeAgo: "一週前", rating: 5, comment: "Lorem ipsum dolor sit amet consectetur. Scelerisque sit non magnis ipsum facilisis quam hac eleifend in. A nibh in semper.", accent: AppColors.accent),
        CoachReview(authorInitial: "A", authorName: "amy lin", timeAgo: "二週前", rating: 4, comment: "Scelerisque sit non magnis ipsum facilisis quam hac eleifend in. A nibh in semper.", accent: .blue),
        CoachReview(authorInitial: "M", authorName: "mike chen", timeAgo: "一個月前", rating: 4, comment: "Lorem ipsum dolor sit amet consectetur.", accent: .green)
    ]

    // Review form
    @Published var overallRating: Int = 4
    @Published var attitude1: Int = 0
    @Published var attitude2: Int = 0
    @Published var attitude3: Int = 0
    @Published var feedback: String = ""

    var currentCoach: Coach {
        selectedCoach ?? coaches.first ?? Coach.sample
    }

    func selectCoach(_ coach: Coach) {
        selectedCoach = coach
    }

    func resetReviewForm() {
        overallRating = 4
        attitude1 = 0
        attitude2 = 0
        attitude3 = 0
        feedback = ""
    }

    func submitReview() {
        let newReview = CoachReview(
            authorInitial: "Y",
            authorName: "You",
            timeAgo: "剛剛",
            rating: overallRating,
            comment: feedback.isEmpty ? "感謝您的回饋" : feedback,
            accent: .orange
        )
        reviews.insert(newReview, at: 0)
        resetReviewForm()
    }
}
