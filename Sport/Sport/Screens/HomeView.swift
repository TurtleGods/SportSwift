import SwiftUI

struct HomeView: View {
    private let coaches: [Coach] = [
        Coach(name: "王小名", experience: "abcabcabc", rating: 4, accent: .blue),
        Coach(name: "王小名", experience: "abcabcabc", rating: 5, accent: .green),
        Coach(name: "王小名", experience: "abcabcabc", rating: 3, accent: .orange)
    ]
    var onOpenCoaches: () -> Void

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                HomeTopBar()

                CategoryBar()

                SearchBar()

                VStack(alignment: .leading, spacing: 14) {
                    HStack {
                        Text("熱門教練推薦")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .bold))
                    }
                    .padding(.horizontal, 16)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        onOpenCoaches()
                    }

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(coaches) { coach in
                                Button {
                                    onOpenCoaches()
                                } label: {
                                    CoachCard(coach: coach)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("團體課程推薦")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)

                    HStack(spacing: 14) {
                        ForEach(0..<3) { idx in
                            GroupClassCard(index: idx)
                        }
                    }
                    .padding(.horizontal, 16)
                }

                Spacer(minLength: 30)
            }
        }
        .background(AppColors.background)
        .safeAreaInset(edge: .bottom) {
            BottomBar()
                .padding(.bottom, 4)
                .background(AppColors.background)
        }
    }
}
