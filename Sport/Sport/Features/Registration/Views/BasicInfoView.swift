import SwiftUI

struct BasicInfoView: View {
    @ObservedObject var viewModel: RegistrationViewModel
    var onBack: () -> Void
    var onNext: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            BackBar(title: "我的基本資料", onBack: onBack)

            VStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(AppColors.line, lineWidth: 1)
                        .fill(AppColors.cardBackground)
                        .frame(width: 140, height: 140)

                    VStack(spacing: 10) {
                        Image(systemName: "photo.on.rectangle.angled")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48, height: 48)
                            .foregroundColor(AppColors.mutedText)
                        Text("上傳照片")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(AppColors.accent)
                            .cornerRadius(8)
                    }
                }
            }
            .padding(.top, 8)

            VStack(spacing: 14) {
                InfoField(title: "姓名", text: $viewModel.name)
                InfoField(title: "生日", text: $viewModel.birthday)
                InfoField(title: "性別", text: $viewModel.gender)
                InfoField(title: "身高", text: $viewModel.height)
                InfoField(title: "體重", text: $viewModel.weight)
                InfoField(title: "你的工作量", text: $viewModel.work)
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(AppColors.line, lineWidth: 1)
            )
            .padding(.horizontal, 20)

            VStack(spacing: 12) {
                Text("每日建議飲食熱量")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)

                HStack {
                    Text("1500")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppColors.inputBackground)
                        .cornerRadius(6)
                    Text("cal")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 64)
                        .padding(.vertical, 12)
                        .background(AppColors.inputBackground)
                        .cornerRadius(6)
                }
                .padding(.horizontal, 16)
            }
            .padding(.top, 12)

            Spacer()

            PrimaryButton(title: "開始設定目標 GO!", action: onNext)
                .padding(.horizontal, 20)
                .padding(.bottom, 28)
        }
    }
}
