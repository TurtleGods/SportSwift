import SwiftUI

struct HappyCoinView: View {
    var onBack: () -> Void
    var onSelectTab: (BottomTab) -> Void = { _ in }

    private let historyItems: [HappyCoinHistoryItem] = [
        HappyCoinHistoryItem(title: "首次登入獎勵金", date: "2024/06/01 10:30", amount: "+100"),
        HappyCoinHistoryItem(title: "首次登入獎勵金", date: "2024/06/01 10:30", amount: "+100"),
        HappyCoinHistoryItem(title: "首次登入獎勵金", date: "2024/06/01 10:30", amount: "+100"),
        HappyCoinHistoryItem(title: "首次登入獎勵金", date: "2024/06/01 10:30", amount: "+100"),
        HappyCoinHistoryItem(title: "首次登入獎勵金", date: "2024/06/01 10:30", amount: "+100"),
        HappyCoinHistoryItem(title: "首次登入獎勵金", date: "2024/06/01 10:30", amount: "+100")
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                BackBar(title: "快樂幣", onBack: onBack)
                    .padding(.top, 4)

                VStack(alignment: .leading, spacing: 10) {
                    Text("快樂幣")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(AppColors.mutedText)

                    HStack {
                        Text("餘額")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .semibold))
                        Spacer()
                        Text("$200")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .bold))
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(AppColors.inputBackground)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(AppColors.line, lineWidth: 1)
                    )
                }
                .padding(.horizontal, 18)

                VStack(alignment: .leading, spacing: 10) {
                    Text("歷史紀錄")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(AppColors.mutedText)

                    historyList
                }
                .padding(.horizontal, 18)

                Spacer(minLength: 24)
            }
        }
        .background(AppColors.background.ignoresSafeArea())
        .safeAreaInset(edge: .bottom) {
            BottomBar(active: .home, onSelect: onSelectTab)
                .padding(.bottom, 4)
        }
    }

    private var historyList: some View {
        VStack(spacing: 0) {
            ForEach(historyItems.indices, id: \.self) { idx in
                HappyCoinHistoryRow(item: historyItems[idx], showsDivider: idx < historyItems.count - 1)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(AppColors.line, lineWidth: 1)
                .fill(AppColors.inputBackground)
        )
    }
}

private struct HappyCoinHistoryItem {
    let title: String
    let date: String
    let amount: String
}

private struct HappyCoinHistoryRow: View {
    let item: HappyCoinHistoryItem
    let showsDivider: Bool

    var body: some View {
        VStack(spacing: 6) {
            HStack {
                Text(item.title)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                Text(item.amount)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .semibold))
            }
            HStack {
                Text(item.date)
                    .foregroundColor(AppColors.mutedText)
                    .font(.system(size: 12, weight: .semibold))
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .overlay(
            Group {
                if showsDivider {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(AppColors.line)
                }
            },
            alignment: .bottom
        )
    }
}

#if DEBUG
#Preview("HappyCoin") {
    HappyCoinView(onBack: {})
        .preferredColorScheme(.dark)
}
#endif
