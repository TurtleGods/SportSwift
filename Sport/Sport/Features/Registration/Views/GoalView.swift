import SwiftUI

struct GoalView: View {
    @ObservedObject var viewModel: RegistrationViewModel
    var onBack: () -> Void
    var onNext: () -> Void

    var body: some View {
        VStack(spacing: 28) {
            BackBar(title: "目標設定", onBack: onBack)

            Spacer()

            VStack(spacing: 16) {
                ForEach(viewModel.goals, id: \.self) { goal in
                    Button {
                        viewModel.selectedGoal = goal
                    } label: {
                        Text(goal)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(goal == viewModel.selectedGoal ? AppColors.primaryText : AppColors.mutedText)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(AppColors.line, lineWidth: 1)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(goal == viewModel.selectedGoal ? .white : AppColors.inputBackground)
                                    )
                            )
                    }
                    .padding(.horizontal, 24)
                }
            }

            Spacer()

            PrimaryButton(title: "下一步", action: onNext)
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
        }
    }
}
