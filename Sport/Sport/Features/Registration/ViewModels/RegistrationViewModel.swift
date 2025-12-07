import Foundation
import SwiftUI
import Combine

final class RegistrationViewModel: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
    // Registration step
    @Published var phone: String = "091234567895"
    @Published var code: String = "1234"

    // Basic info step
    @Published var name: String = "王曉明"
    @Published var birthday: String = "1990/02/01"
    @Published var gender: String = "男"
    @Published var height: String = "180"
    @Published var weight: String = "90"
    @Published var work: String = "輕"

    // Goal step
    let goals = ["增肌減脂", "減重", "純記錄"]
    @Published var selectedGoal: String = "純記錄"

    // Calories step
    @Published var breakfast: String = "100"
    @Published var lunch: String = "600"
    @Published var dinner: String = "700"
    @Published var snack: String = "100"
}
