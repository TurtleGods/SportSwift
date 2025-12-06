import SwiftUI

struct Coach: Identifiable {
    let id = UUID()
    var name: String
    var experience: String
    var rating: Int
    var accent: Color

    static let sample = Coach(name: "王小名", experience: "abcabcabc", rating: 4, accent: .blue)
}
