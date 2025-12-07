import SwiftUI

struct CaloriesView: View {
    @ObservedObject var viewModel: RegistrationViewModel
    var onBack: () -> Void
    var showConfirmation: Bool = false
    var onSave: () -> Void

    var body: some View {
        VStack(spacing: 26) {
            BackBar(title: "設定每日飲食熱量攝取量", onBack: onBack)
                .padding(.bottom, 6)

            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .stroke(AppColors.line, lineWidth: 1)
                    .fill(AppColors.cardBackground)
                    .padding(.horizontal, 18)
                    .frame(height: 260)

                VStack(spacing: 18) {
                    CaloriesRow(label: "早餐", value: $viewModel.breakfast)
                    CaloriesRow(label: "午餐", value: $viewModel.lunch)
                    CaloriesRow(label: "晚餐", value: $viewModel.dinner)
                    CaloriesRow(label: "點心", value: $viewModel.snack)
                }
                .padding(.horizontal, 34)

                if showConfirmation {
                    Circle()
                        .fill(Color.white.opacity(0.85))
                        .frame(width: 96, height: 96)
                        .overlay(
                            Image(systemName: "checkmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 36, height: 36)
                                .foregroundColor(AppColors.darkAccent)
                        )
                }
            }

            Spacer()

            PrimaryButton(title: "儲存", action: onSave)
                .padding(.horizontal, 20)
                .padding(.bottom, 28)
        }
    }
}
