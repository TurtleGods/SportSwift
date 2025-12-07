import SwiftUI

enum BottomTab {
    case home
    case favorites
    case schedule
    case records
}

struct TopBar: View {
    var onProfile: () -> Void = {}

    var body: some View {
        HStack {
            Image(systemName: "smiley.fill")
                .foregroundColor(.white)
                .font(.system(size: 32))
            Text("HappyGym")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
            Image(systemName: "chevron.down")
                .foregroundColor(.white)
                .padding(.leading, 4)
            Spacer()
            Button(action: onProfile) {
                Image(systemName: "person.crop.circle")
                    .foregroundColor(.white)
                    .font(.system(size: 28))
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 12)
    }
}

struct BackBar: View {
    var title: String
    var onBack: () -> Void

    var body: some View {
        HStack {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
                    .font(.system(size: 22, weight: .bold))
            }
            Spacer()
        }
        .overlay(
            Text(title)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
        )
        .padding(.horizontal, 20)
        .padding(.top, 12)
    }
}

struct HomeTopBar: View {
    var onProfile: () -> Void = {}

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "smiley.fill")
                .foregroundColor(.white)
                .font(.system(size: 32))
            Text("HappyGym")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
            Image(systemName: "chevron.down")
                .foregroundColor(.white)
            Spacer()
            Image(systemName: "bell")
                .foregroundColor(.white)
                .font(.system(size: 22))
            Button(action: onProfile) {
                Image(systemName: "person.crop.circle")
                    .foregroundColor(.white)
                    .font(.system(size: 26))
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 12)
    }
}

struct CategoryBar: View {
    let categories = ["全部", "教練", "飲食", "課程", "場地", "團課", "熱鬧"]
    @State private var selected: String = "全部"

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(categories, id: \.self) { category in
                    Button {
                        selected = category
                    } label: {
                        Text(category)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(category == selected ? AppColors.primaryText : AppColors.mutedText)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(category == selected ? Color.yellow.opacity(0.9) : AppColors.inputBackground)
                            .cornerRadius(6)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

struct SearchBar: View {
    @State private var query: String = ""

    var body: some View {
        HStack {
            TextField("輸入關鍵字", text: $query)
                .foregroundColor(.white)
            Image(systemName: "magnifyingglass")
                .foregroundColor(AppColors.mutedText)
        }
        .padding()
        .background(AppColors.inputBackground)
        .cornerRadius(8)
        .padding(.horizontal, 16)
    }
}

struct BottomBar: View {
    var active: BottomTab = .home
    var onSelect: (BottomTab) -> Void = { _ in }

    var body: some View {
        HStack {
            BottomItem(title: "首頁", system: "house.fill", active: active == .home) { onSelect(.home) }
            BottomItem(title: "我的最愛", system: "heart.fill", active: active == .favorites) { onSelect(.favorites) }
            BottomItem(title: "我的課表", system: "calendar", active: active == .schedule) { onSelect(.schedule) }
            BottomItem(title: "我的記錄", system: "list.bullet.rectangle", active: active == .records) { onSelect(.records) }
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 10)
        .background(AppColors.cardBackground)
    }
}

struct BottomItem: View {
    var title: String
    var system: String
    var active: Bool = false
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 4) {
                Image(systemName: system)
                    .foregroundColor(active ? Color.yellow : .white)
                Text(title)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(active ? Color.yellow : .white)
            }
            .frame(maxWidth: .infinity)
        }
    }
}
