import Foundation
import SwiftUI
import Combine

final class HomeViewModel: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
    @Published var featuredCoaches: [Coach] = [
        Coach(name: "王小名", experience: "abcabcabc", rating: 4, accent: .blue),
        Coach(name: "王小名", experience: "abcabcabc", rating: 5, accent: .green),
        Coach(name: "王小名", experience: "abcabcabc", rating: 3, accent: .orange)
    ]
}
