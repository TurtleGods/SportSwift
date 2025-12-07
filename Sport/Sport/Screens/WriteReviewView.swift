import SwiftUI

struct WriteReviewView: View {
    var onClose: () -> Void
    @State private var overall: Int = 4
    @State private var attitude1: Int = 0
    @State private var attitude2: Int = 0
    @State private var attitude3: Int = 0
    @State private var feedback: String = ""

    var body: some View {
        VStack(spacing: 18) {
            HStack {
                Button(action: onClose) {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
            .safeAreaPadding(.top)

            HStack(spacing: 12) {
                Circle()
                    .fill(AppColors.mutedText.opacity(0.5))
                    .frame(width: 64, height: 64)
                    .overlay(
                        Text("T")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(.white)
                    )
                StarInput(selected: $overall, size: 22)
                Spacer()
            }
            .padding(.horizontal, 16)

            VStack(alignment: .leading, spacing: 12) {
                RatingRow(title: "態度", selection: $attitude1)
                RatingRow(title: "態度", selection: $attitude2)
                RatingRow(title: "態度", selection: $attitude3)
            }
            .padding(.horizontal, 16)

            TextEditor(text: $feedback)
                .frame(height: 180)
                .padding(8)
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(AppColors.line, lineWidth: 1)
                )
                .padding(.horizontal, 16)

            PrimaryButton(title: "發布") {
                onClose()
            }
            .padding(.horizontal, 16)

            Spacer()

            BottomBar()
                .padding(.bottom, 4)
        }
        .highPriorityGesture(backSwipeGesture(onClose))
        .background(AppColors.sheetBackground.ignoresSafeArea())
    }
}

private struct RatingRow: View {
    var title: String
    @Binding var selection: Int

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .medium))
                .frame(width: 60, alignment: .leading)
            StarInput(selected: $selection, size: 18)
            Spacer()
        }
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

private struct StarInput: View {
    @Binding var selected: Int
    var size: CGFloat

    var body: some View {
        HStack(spacing: 6) {
            ForEach(1...5, id: \.self) { idx in
                Image(systemName: idx <= selected ? "star.fill" : "star")
                    .foregroundColor(.yellow)
                    .font(.system(size: size))
                    .onTapGesture { selected = idx }
            }
        }
    }
}
