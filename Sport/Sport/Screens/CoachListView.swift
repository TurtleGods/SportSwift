import SwiftUI

struct CoachListView: View {
    private let coaches: [Coach] = [
        Coach(name: "王小名", experience: "abcabcabc", rating: 4, accent: .blue),
        Coach(name: "王小名", experience: "abcabcabc", rating: 5, accent: .green),
        Coach(name: "王小名", experience: "abcabcabc", rating: 3, accent: .orange),
        Coach(name: "王小名", experience: "abcabcabc", rating: 4, accent: .purple)
    ]
    var onBack: () -> Void
    var onSelect: (Coach) -> Void
    @State private var selectedCity: String = "台北"
    @State private var selectedArea: String = "大安區"

    private let cities = ["台北", "新北", "桃園"]
    private let areas = ["大安區", "信義區", "中山區"]
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
            .padding(.horizontal, 16)
            .padding(.top, 6)

            CoachListFilters(
                selectedCity: $selectedCity,
                cities: cities,
                selectedArea: $selectedArea,
                areas: areas
            )
            .padding(.horizontal, 12)

            ScrollView {
                LazyVGrid(columns: columns, spacing: 18) {
                    ForEach(coaches) { coach in
                        CoachCard(coach: coach)
                            .onTapGesture { onSelect(coach) }
                    }
                }
                .padding(.horizontal, 12)
                .padding(.top, 8)
                .padding(.bottom, 12)
            }
            .background(AppColors.sheetBackground)

            Spacer(minLength: 0)

            BottomBar()
                .padding(.bottom, 4)
        }
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
