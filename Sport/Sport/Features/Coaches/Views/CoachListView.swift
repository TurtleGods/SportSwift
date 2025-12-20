import SwiftUI

struct CoachListView: View {
    @ObservedObject var viewModel: CoachesViewModel
    var onBack: () -> Void
    var onSelect: (Coach) -> Void
    var onSelectTab: (BottomTab) -> Void = { _ in }

    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        VStack(spacing: 8) {
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

            CoachListFilters(
                selectedCity: $viewModel.selectedCity,
                cities: viewModel.cities,
                selectedArea: $viewModel.selectedArea,
                areas: viewModel.areas
            )
            .padding(.horizontal, 12)

            ScrollView {
                LazyVGrid(columns: columns, spacing: 18) {
                    ForEach(viewModel.coaches) { coach in
                        CoachCard(coach: coach)
                            .onTapGesture {
                                viewModel.selectCoach(coach)
                                onSelect(coach)
                            }
                    }
                }
                .padding(.horizontal, 12)
                .padding(.top, 8)
                .padding(.bottom, 12)
            }
            .background(AppColors.sheetBackground)

            Spacer(minLength: 0)

            BottomBar(active: .home, onSelect: onSelectTab)
                .padding(.bottom, 4)
        }
        .highPriorityGesture(backSwipeGesture(onBack))
        .background(AppColors.background.ignoresSafeArea())
    }
}

private struct CoachListFilters: View {
    @Binding var selectedCity: String
    var cities: [String]
    @Binding var selectedArea: String
    var areas: [String]

    var body: some View {
        HStack(spacing: 12) {
            FilterPicker(title: selectedCity, items: cities) { selectedCity = $0 }
            Divider()
                .frame(height: 24)
                .background(AppColors.line)
            FilterPicker(title: selectedArea, items: areas) { selectedArea = $0 }
            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(AppColors.line, lineWidth: 1)
                .fill(AppColors.inputBackground)
        )
    }
}

private struct FilterPicker: View {
    var title: String
    var items: [String]
    var onSelect: (String) -> Void

    var body: some View {
        Menu {
            ForEach(items, id: \.self) { item in
                Button(item) { onSelect(item) }
            }
        } label: {
            HStack(spacing: 6) {
                Text(title)
                    .foregroundColor(.white)
                Image(systemName: "chevron.down")
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(AppColors.inputBackground)
            .cornerRadius(8)
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
