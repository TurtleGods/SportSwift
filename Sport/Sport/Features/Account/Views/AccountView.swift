import SwiftUI

struct AccountView: View {
    var onBack: () -> Void

    private let analysisItems = ["運動記錄分析", "飲食記錄分析", "綜合分析"]
    private let generalItems = ["申請成為教練", "上課打卡記錄", "帳號", "帳號"]
    private let otherItems = ["隱私權政策", "服務條款"]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            BackBar(title: "我的帳戶", onBack: onBack)
                .padding(.top, 4)

            accountHeader
                .padding(.horizontal, 16)

            walletCard
                .padding(.horizontal, 16)

            section(title: "紀錄分析", items: analysisItems)
                .padding(.horizontal, 16)

            section(title: "一般", items: generalItems)
                .padding(.horizontal, 16)

            section(title: "其他", items: otherItems)
                .padding(.horizontal, 16)

            Spacer()
        }
        .background(AppColors.background.ignoresSafeArea())
    }

    private var accountHeader: some View {
        Button(action: {}) {
            HStack(spacing: 12) {
                Circle()
                    .fill(Color.gray.opacity(0.4))
                    .frame(width: 48, height: 48)
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundColor(.white)
                    )
                VStack(alignment: .leading, spacing: 4) {
                    Text("我的基本資料")
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold))
                    Text("王曉明")
                        .foregroundColor(.white)
                        .font(.system(size: 12))
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.white)
            }
            .padding()
            .background(AppColors.cardBackground)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(AppColors.line, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }

    private var walletCard: some View {
        HStack {
            VStack(spacing: 4) {
                Text("我的錢包")
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .semibold))
                Text("$2500")
                    .foregroundColor(.yellow)
                    .font(.system(size: 18, weight: .bold))
            }
            .frame(maxWidth: .infinity)
            Rectangle()
                .fill(AppColors.line)
                .frame(width: 1, height: 48)
            VStack(spacing: 4) {
                Text("快樂幣")
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .semibold))
                Text("200")
                    .foregroundColor(.yellow)
                    .font(.system(size: 18, weight: .bold))
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 14)
        .background(AppColors.cardBackground)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(AppColors.line, lineWidth: 1)
        )
    }

    private func section(title: String, items: [String]) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .bold))
            VStack(spacing: 0) {
                ForEach(items.indices, id: \.self) { idx in
                    HStack {
                        Image(systemName: "plus.circle")
                            .foregroundColor(.white)
                        Text(items[idx])
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .semibold))
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 12)
                    .background(AppColors.cardBackground)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(AppColors.line),
                        alignment: .bottom
                    )
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(AppColors.line, lineWidth: 1)
                    .fill(AppColors.cardBackground)
            )
        }
    }
}
