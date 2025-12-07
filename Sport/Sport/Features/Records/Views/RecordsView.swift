import SwiftUI

private enum RecordsPage {
    case exercise
    case food
}

struct RecordsView: View {
    @ObservedObject var viewModel: RecordsViewModel
    var onBack: () -> Void
    var onSelectTab: (BottomTab) -> Void = { _ in }

    @State private var page: RecordsPage = .exercise

    var body: some View {
        VStack(spacing: 18) {
            header

            Spacer(minLength: 0)

            VStack(alignment: .leading, spacing: 14) {
                Text(page == .exercise ? "請輸入運動資訊" : "請輸入飲食資訊")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)

                infoCard
            }
            .padding(.horizontal, 18)

            VStack(alignment: .leading, spacing: 12) {
                Text(page == .exercise ? "計算消耗熱量" : "計算飲食熱量")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)

                HStack {
                    TextField("", text: caloriesBinding)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(AppColors.inputBackground)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                    Text("cal")
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(AppColors.inputBackground)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal, 18)

            PrimaryButton(title: "加入資訊") { }
                .padding(.horizontal, 18)
                .padding(.top, 6)

            pageControl

            Spacer(minLength: 16)
        }
        .background(AppColors.background.ignoresSafeArea())
        .safeAreaInset(edge: .bottom) {
            BottomBar(active: .records, onSelect: onSelectTab)
                .padding(.bottom, 4)
        }
        .highPriorityGesture(
            DragGesture(minimumDistance: 20)
                .onEnded { value in
                    if value.translation.width < -40 {
                        withAnimation { page = .food }
                    } else if value.translation.width > 40 {
                        withAnimation { page = .exercise }
                    }
                }
        )
    }

    private var header: some View {
        HStack {
            Text("我的紀錄")
                .foregroundColor(.white)
                .font(.system(size: 22, weight: .bold))
                .padding(.leading, 8)
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 6)
        .safeAreaPadding(.top)
    }

    private var infoCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            recordField(title: "日期") {
                RecordInput(text: dateBinding)
            }
            if page == .exercise {
                recordField(title: "運動時間") {
                    RecordInput(text: $viewModel.exerciseDuration)
                }
                recordField(title: "運動項目") {
                    RecordPicker(selection: $viewModel.exerciseType, items: viewModel.exerciseTypes)
                }
            } else {
                recordField(title: "飲食時段") {
                    RecordPicker(selection: $viewModel.foodPeriod, items: viewModel.foodPeriods)
                }
                recordField(title: "飲食項目") {
                    RecordPicker(selection: $viewModel.foodItem, items: viewModel.foodItems)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 18)
        .background(AppColors.inputBackground)
        .cornerRadius(14)
    }

    private var pageControl: some View {
        HStack(spacing: 8) {
            Circle()
                .fill(page == .exercise ? AppColors.accent : Color.white.opacity(0.5))
                .frame(width: 8, height: 8)
                .onTapGesture { withAnimation { page = .exercise } }
            Circle()
                .fill(page == .food ? AppColors.accent : Color.white.opacity(0.5))
                .frame(width: 8, height: 8)
                .onTapGesture { withAnimation { page = .food } }
        }
        .padding(.top, 6)
    }

    private func recordField<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .semibold))
                .frame(width: 70, alignment: .leading)
            content()
            Spacer()
        }
    }

    private var dateBinding: Binding<String> {
        switch page {
        case .exercise:
            return $viewModel.exerciseDate
        case .food:
            return $viewModel.foodDate
        }
    }

    private var caloriesBinding: Binding<String> {
        switch page {
        case .exercise:
            return $viewModel.exerciseCalories
        case .food:
            return $viewModel.foodCalories
        }
    }
}

private struct RecordInput: View {
    @Binding var text: String

    var body: some View {
        TextField("", text: $text)
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(Color.white.opacity(0.15))
            .cornerRadius(8)
            .foregroundColor(.white)
    }
}

private struct RecordPicker: View {
    @Binding var selection: String
    var items: [String]

    var body: some View {
        Menu {
            ForEach(items, id: \.self) { item in
                Button(item) { selection = item }
            }
        } label: {
            HStack {
                Text(selection)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(Color.white.opacity(0.15))
            .cornerRadius(8)
        }
    }
}
