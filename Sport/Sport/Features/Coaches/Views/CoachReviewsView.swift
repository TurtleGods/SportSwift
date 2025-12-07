import SwiftUI

struct CoachReviewsView: View {
    @ObservedObject var viewModel: CoachesViewModel
    var onBack: () -> Void
    var onWriteReview: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Button(action: onBack) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                }
                Spacer()
                Text("查看評價")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
                Spacer()
                Button(action: onWriteReview) {
                    Image(systemName: "pencil")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .semibold))
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 6)
            .safeAreaPadding(.top)

            ScrollView {
                VStack(spacing: 14) {
                    ReviewSummaryCard(rating: viewModel.averageRating)
                    ForEach(viewModel.reviews) { review in
                        ReviewCard(review: review)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 12)
            }
            .background(AppColors.sheetBackground)

            Spacer(minLength: 0)

            BottomBar()
                .padding(.bottom, 4)
        }
        .highPriorityGesture(backSwipeGesture(onBack))
        .background(AppColors.background.ignoresSafeArea())
    }
}

private struct ReviewSummaryCard: View {
    var rating: Int

    var body: some View {
        HStack {
            Circle()
                .fill(AppColors.mutedText.opacity(0.4))
                .frame(width: 52, height: 52)
            VStack(alignment: .leading, spacing: 4) {
                StarRow(filled: rating, size: 18)
                StarRow(filled: 0, size: 0) // spacer for alignment
            }
            Spacer()
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .background(AppColors.cardBackground)
        .cornerRadius(10)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(AppColors.line),
            alignment: .bottom
        )
    }
}

private struct ReviewCard: View {
    var review: CoachReview

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Circle()
                    .fill(review.accent.opacity(0.9))
                    .frame(width: 48, height: 48)
                    .overlay(
                        Text(review.authorInitial)
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                    )
                VStack(alignment: .leading, spacing: 2) {
                    Text(review.authorName)
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .semibold))
                    StarRow(filled: review.rating, size: 14)
                }
                Spacer()
                Text(review.timeAgo)
                    .foregroundColor(AppColors.mutedText)
                    .font(.system(size: 12))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
            }

            Text(review.comment)
                .foregroundColor(.white)
                .font(.system(size: 14))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(14)
        .background(AppColors.cardBackground)
        .cornerRadius(12)
    }
}

private struct StarRow: View {
    var filled: Int
    var size: CGFloat

    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<5) { idx in
                Image(systemName: idx < filled ? "star.fill" : "star")
                    .foregroundColor(.yellow)
                    .font(.system(size: size))
            }
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
