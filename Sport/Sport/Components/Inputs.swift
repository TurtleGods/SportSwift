import SwiftUI

struct AppTextField: View {
    @Binding var text: String
    var placeholder: String

    var body: some View {
        TextField(placeholder, text: $text)
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
            .foregroundColor(.white)
            .background(AppColors.inputBackground)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(AppColors.line, lineWidth: 1)
            )
            .cornerRadius(10)
    }
}

struct PrimaryButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(AppColors.accent)
                .cornerRadius(8)
        }
    }
}

struct InfoField: View {
    var title: String
    @Binding var text: String

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.white)
                .frame(width: 90, alignment: .leading)
            TextField("", text: $text)
                .foregroundColor(.white)
                .overlay(Rectangle().frame(height: 1).foregroundColor(AppColors.line), alignment: .bottom)
        }
    }
}

struct CaloriesRow: View {
    var label: String
    @Binding var value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.white)
                .frame(width: 50, alignment: .leading)
            TextField("", text: $value)
                .keyboardType(.numberPad)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .overlay(Rectangle().frame(height: 1).foregroundColor(AppColors.line), alignment: .bottom)
                .frame(maxWidth: .infinity)
            Text("cal")
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(AppColors.mutedText)
        }
    }
}
