//
//  ContentView.swift
//  Sport
//
//  Created by 佳緯周 on 2025/12/6.
//

import SwiftUI

import SwiftUI

private enum AppScreen {
    case register
    case basicInfo
    case goal
    case calories
    case caloriesConfirm
    case home
}

struct ContentView: View {
    @State private var screen: AppScreen = .register

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            switch screen {
            case .register:
                RegisterView { screen = .basicInfo }
            case .basicInfo:
                BasicInfoView(
                    onBack: { screen = .register },
                    onNext: { screen = .goal }
                )
            case .goal:
                GoalView(
                    onBack: { screen = .basicInfo },
                    onNext: { screen = .calories }
                )
            case .calories:
                CaloriesView(
                    onBack: { screen = .goal },
                    onSave: {
                        screen = .caloriesConfirm
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            screen = .home
                        }
                    }
                )
            case .caloriesConfirm:
                CaloriesView(
                    onBack: { screen = .goal },
                    showConfirmation: true,
                    onSave: {}
                )
            case .home:
                HomeView()
            }
        }
    }
}

// MARK: - Screens

private struct RegisterView: View {
    @State private var phone: String = "091234567895"
    @State private var code: String = "1234"
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
                    AppTextField(text: $phone, placeholder: "091234567895")
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
                    AppTextField(text: $code, placeholder: "1234")
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

private struct BasicInfoView: View {
    @State private var name: String = "王曉明"
    @State private var birthday: String = "1990/02/01"
    @State private var gender: String = "男"
    @State private var height: String = "180"
    @State private var weight: String = "90"
    @State private var work: String = "輕"
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
                InfoField(title: "姓名", text: $name)
                InfoField(title: "生日", text: $birthday)
                InfoField(title: "性別", text: $gender)
                InfoField(title: "身高", text: $height)
                InfoField(title: "體重", text: $weight)
                InfoField(title: "你的工作量", text: $work)
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

private struct GoalView: View {
    @State private var selected: String = "純記錄"
    var onBack: () -> Void
    var onNext: () -> Void

    let goals = ["增肌減脂", "減重", "純記錄"]

    var body: some View {
        VStack(spacing: 28) {
            BackBar(title: "目標設定", onBack: onBack)

            Spacer()

            VStack(spacing: 16) {
                ForEach(goals, id: \.self) { goal in
                    Button {
                        selected = goal
                    } label: {
                        Text(goal)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(goal == selected ? AppColors.primaryText : AppColors.mutedText)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(AppColors.line, lineWidth: 1)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(goal == selected ? .white : AppColors.inputBackground)
                                    )
                            )
                    }
                    .padding(.horizontal, 24)
                }
            }

            Spacer()

            PrimaryButton(title: "下一步", action: onNext)
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
        }
    }
}

private struct CaloriesView: View {
    @State private var breakfast: String = "100"
    @State private var lunch: String = "600"
    @State private var dinner: String = "700"
    @State private var snack: String = "100"
    var onBack: () -> Void
    var showConfirmation: Bool = false
    var onSave: () -> Void

    var body: some View {
        VStack(spacing: 26) {
            BackBar(title: "設定每日飲食熱量攝取量", onBack: onBack)
                .padding(.bottom, 6)

            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .stroke(AppColors.line, lineWidth: 1)
                    .fill(AppColors.cardBackground)
                    .padding(.horizontal, 18)
                    .frame(height: 260)

                VStack(spacing: 18) {
                    CaloriesRow(label: "早餐", value: $breakfast)
                    CaloriesRow(label: "午餐", value: $lunch)
                    CaloriesRow(label: "晚餐", value: $dinner)
                    CaloriesRow(label: "點心", value: $snack)
                }
                .padding(.horizontal, 34)

                if showConfirmation {
                    Circle()
                        .fill(Color.white.opacity(0.85))
                        .frame(width: 96, height: 96)
                        .overlay(
                            Image(systemName: "checkmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 36, height: 36)
                                .foregroundColor(AppColors.darkAccent)
                        )
                }
            }

            Spacer()

            PrimaryButton(title: "儲存", action: onSave)
                .padding(.horizontal, 20)
                .padding(.bottom, 28)
        }
    }
}

private struct HomeView: View {
    private let coaches: [Coach] = [
        Coach(name: "王小名", experience: "abcabcabc", rating: 4, accent: .blue),
        Coach(name: "王小名", experience: "abcabcabc", rating: 5, accent: .green),
        Coach(name: "王小名", experience: "abcabcabc", rating: 3, accent: .orange)
    ]

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                HomeTopBar()

                CategoryBar()

                SearchBar()

                VStack(alignment: .leading, spacing: 14) {
                    Text("熱門教練推薦")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(coaches) { coach in
                                CoachCard(coach: coach)
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

// MARK: - Components

private struct TopBar: View {
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
            Image(systemName: "person.crop.circle")
                .foregroundColor(.white)
                .font(.system(size: 28))
        }
        .padding(.horizontal, 20)
        .padding(.top, 12)
    }
}

private struct BackBar: View {
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

private struct AppTextField: View {
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

private struct PrimaryButton: View {
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

private struct InfoField: View {
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

private struct CaloriesRow: View {
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

private struct HomeTopBar: View {
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
            Image(systemName: "person.crop.circle")
                .foregroundColor(.white)
                .font(.system(size: 26))
        }
        .padding(.horizontal, 16)
        .padding(.top, 12)
    }
}

private struct CategoryBar: View {
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

private struct SearchBar: View {
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

private struct CoachCard: View {
    var coach: Coach

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Rectangle()
                .fill(coach.accent.opacity(0.8))
                .frame(width: 150, height: 190)
                .overlay(
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                )
                .cornerRadius(8)

            HStack(spacing: 4) {
                Text("評價")
                    .foregroundColor(.white)
                    .font(.system(size: 12))
                ForEach(0..<5) { idx in
                    Image(systemName: idx < coach.rating ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                        .font(.system(size: 12))
                }
            }

            Text("姓名  \(coach.name)")
                .foregroundColor(.white)
                .font(.system(size: 13))
            Text("經歷  \(coach.experience)")
                .foregroundColor(.white)
                .font(.system(size: 13))
        }
        .frame(width: 150, alignment: .leading)
    }
}

private struct GroupClassCard: View {
    var index: Int

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Rectangle()
                .fill(Color.orange.opacity(0.8 - Double(index) * 0.1))
                .frame(width: 104, height: 106)
                .cornerRadius(10)
            Image(systemName: "heart")
                .foregroundColor(.white)
                .padding(8)
        }
    }
}

private struct BottomBar: View {
    var body: some View {
        HStack {
            BottomItem(title: "首頁", system: "house.fill", active: true)
            BottomItem(title: "我的最愛", system: "heart.fill")
            BottomItem(title: "我的課表", system: "calendar")
            BottomItem(title: "我的記錄", system: "list.bullet.rectangle")
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 10)
        .background(AppColors.cardBackground)
    }
}

private struct BottomItem: View {
    var title: String
    var system: String
    var active: Bool = false

    var body: some View {
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

// MARK: - Models & Colors

private struct Coach: Identifiable {
    let id = UUID()
    var name: String
    var experience: String
    var rating: Int
    var accent: Color
}

private enum AppColors {
    static let background = Color(red: 26/255, green: 46/255, blue: 58/255)
    static let inputBackground = Color(red: 38/255, green: 62/255, blue: 76/255)
    static let cardBackground = Color(red: 34/255, green: 51/255, blue: 61/255)
    static let accent = Color(red: 196/255, green: 153/255, blue: 55/255)
    static let darkAccent = Color(red: 55/255, green: 92/255, blue: 106/255)
    static let line = Color(red: 99/255, green: 131/255, blue: 144/255)
    static let mutedText = Color(red: 148/255, green: 170/255, blue: 179/255)
    static let primaryText = Color.black
}

#Preview {
    ContentView()
}
