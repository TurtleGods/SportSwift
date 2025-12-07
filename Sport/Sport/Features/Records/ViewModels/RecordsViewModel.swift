import Foundation
import Combine

final class RecordsViewModel: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()

    // Exercise
    @Published var exerciseDate: String = "2024年5月20日"
    @Published var exerciseDuration: String = "20 min"
    @Published var exerciseType: String = "跑步"
    @Published var exerciseCalories: String = "200"
    let exerciseTypes = ["跑步", "游泳", "重訓", "騎車"]

    // Food
    @Published var foodDate: String = "2024年5月20日"
    @Published var foodPeriod: String = "晚餐"
    @Published var foodItem: String = "燒鴨便當"
    @Published var foodCalories: String = "350"
    let foodPeriods = ["早餐", "午餐", "晚餐", "點心"]
    let foodItems = ["燒鴨便當", "雞胸沙拉", "牛肉麵", "水餃"]
}
