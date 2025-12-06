import SwiftUI

struct GoalView: View {
    @State private var selected: String = "純記錄"
    var onBack: () -> Void
    var onNext: () -> Void

    private let goals = ["增肌減脂", "減重", "純記錄"]

    var body: some View {
        VStack(spacing: 28) {
            BackBar(title: "目標設定", onBack: onBack)

            Spacer()

            VStack(spacing: 16) {
                ForEach(goals, id: \.self) { goal in
                    Button {
                        selected = goal
                    } label: {
                        Text(goal)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(goal == selected ? AppColors.primaryText : AppColors.mutedText)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(AppColors.line, lineWidth: 1)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(goal == selected ? .white : AppColors.inputBackground)
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
