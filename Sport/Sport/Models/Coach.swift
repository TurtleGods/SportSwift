import SwiftUI

struct Coach: Identifiable {
    let id = UUID()
    var name: String
    var experience: String
    var rating: Int
    var accent: Color
}
