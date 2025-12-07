import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewModel: RegistrationViewModel
    var onRegister: () -> Void

    var body: some View {
        VStack(spacing: 32) {
            TopBar()

            Text("會員註冊")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
                .padding(.top, 32)

            VStack(spacing: 18) {
                HStack(spacing: 12) {
                    AppTextField(text: $viewModel.phone, placeholder: "091234567895")
                    Text("發送簡訊")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(AppColors.mutedText)
                        .frame(width: 72)
                }
                HStack(spacing: 12) {
                    Text("驗證碼")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(AppColors.mutedText)
                        .frame(width: 60, alignment: .leading)
                    AppTextField(text: $viewModel.code, placeholder: "1234")
                }
            }
            .padding(.horizontal, 24)

            Spacer()

            PrimaryButton(title: "註冊", action: onRegister)
                .padding(.horizontal, 20)
                .padding(.bottom, 32)
        }
    }
}
