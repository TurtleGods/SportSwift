import SwiftUI

struct WalletView: View {
    var onBack: () -> Void
    var onSelectTab: (BottomTab) -> Void = { _ in }

    private let historyItems: [WalletHistoryItem] = [
        WalletHistoryItem(title: "購買課程", date: "2024/06/01 10:30", amount: "-$500"),
        WalletHistoryItem(title: "信用卡加值", date: "2024/06/01 10:30", amount: "+$2000"),
        WalletHistoryItem(title: "購買課程", date: "2024/06/01 10:30", amount: "-$500"),
        WalletHistoryItem(title: "購買課程", date: "2024/06/01 10:30", amount: "-$500"),
        WalletHistoryItem(title: "購買課程", date: "2024/06/01 10:30", amount: "-$500"),
        WalletHistoryItem(title: "購買課程", date: "2024/06/01 10:30", amount: "-$500")
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                BackBar(title: "我的錢包", onBack: onBack)
                    .padding(.top, 4)

                Button(action: {}) {
                    HStack {
                        Text("我要加值")
                            .font(.system(size: 16, weight: .bold))
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.system(size: 16, weight: .bold))
                    }
                    .foregroundColor(.white)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 18)
                    .background(AppColors.accent)
                    .cornerRadius(12)
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 18)

                VStack(alignment: .leading, spacing: 10) {
                    Text("我的錢包")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(AppColors.mutedText)

                    HStack {
                        Text("餘額")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .semibold))
                        Spacer()
                        Text("$2500")
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
                WalletHistoryRow(item: historyItems[idx], showsDivider: idx < historyItems.count - 1)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(AppColors.line, lineWidth: 1)
                .fill(AppColors.inputBackground)
        )
    }
}

private struct WalletHistoryItem {
    let title: String
    let date: String
    let amount: String
}

private struct WalletHistoryRow: View {
    let item: WalletHistoryItem
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
#Preview("Wallet") {
    WalletView(onBack: {})
        .preferredColorScheme(.dark)
}
#endif
