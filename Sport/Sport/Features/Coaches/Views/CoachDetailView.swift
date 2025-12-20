import SwiftUI

struct CoachDetailView: View {
    @ObservedObject var viewModel: CoachesViewModel
    var onBack: () -> Void
    var onShowReviews: () -> Void
    var onSelectTab: (BottomTab) -> Void = { _ in }

    var body: some View {
        let coach = viewModel.currentCoach

        VStack(spacing: 4) {
            HStack {
                Button(action: onBack) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                }
                Spacer()
                Text("熱門教練推薦")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
                Spacer()
                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal, 12)
            .padding(.top, 6)
            .safeAreaPadding(.top)
            
            HStack(spacing: 12) {
                VStack(spacing: 6) {
                    Circle()
                        .strokeBorder(Color.white, lineWidth: 4)
                        .background(Circle().fill(coach.accent.opacity(0.8)))
                        .frame(width: 140, height: 140)
                        .overlay(
                            Image(systemName: "person.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.white)
                        )

                    HStack(spacing: 4) {
                        ForEach(0..<5) { idx in
                            Image(systemName: idx < coach.rating ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                        }
                    }
                }
            }
            .padding(.top, 8)

            CoachDetailInfo(coach: coach)
                .padding(.horizontal, 18)

            Spacer()

            HStack(spacing: 12) {
                Button(action: {}) {
                    Text("聊天")
                        .font(.system(size: 18, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .foregroundColor(AppColors.darkAccent)
                        .background(Color.white)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(AppColors.line, lineWidth: 1)
                        )
                }
                PrimaryButton(title: "立即選課", action: {})
                    .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 10)

            BottomBar(active: .home, onSelect: onSelectTab)
                .padding(.bottom, 4)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .highPriorityGesture(backSwipeGesture(onBack))
        .background(AppColors.sheetBackground.ignoresSafeArea())
    }
}

private struct CoachDetailInfo: View {
    var coach: Coach

    var body: some View {
        VStack(spacing: 12) {
            DetailRow(label: "姓名", value: coach.name)
            DetailRow(label: "生日", value: "1992.10.01")
            DetailRow(label: "體重", value: "52kg")
            DetailRow(label: "身高", value: "172cm")
            DetailRow(label: "工作經驗", value: "Scelerisque sit non ip")
            DetailRow(label: "地區", value: "台北市松山區、大安區、中山區")
            DetailRow(label: "證照", value: "facilisis quam hac")
            DetailRow(label: "收費標準", value: "900 hr/元")
        }
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(AppColors.line, lineWidth: 1)
                .fill(AppColors.inputBackground.opacity(0.3))
        )
    }
}

private struct DetailRow: View {
    var label: String
    var value: String

    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .medium))
                .frame(width: 70, alignment: .leading)
            Spacer()
            Text(value)
                .foregroundColor(.white)
                .font(.system(size: 14))
            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(AppColors.line),
            alignment: .bottom
        )
    }
}

private func backSwipeGesture(_ action: @escaping () -> Void) -> some Gesture {
    DragGesture(minimumDistance: 20, coordinateSpace: .local)
        .onEnded { value in
            if value.translation.width > 60 && abs(value.translation.height) < 40 {
                action()
            }
        }
}
