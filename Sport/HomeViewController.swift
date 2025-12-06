//
//  HomeViewController.swift
//  Sport
//
//  Created by 佳緯周 on 2025/12/6.
//

import UIKit

final class HomeViewController: UIViewController {

    private let backgroundColor = UIColor(red: 33/255, green: 52/255, blue: 60/255, alpha: 1)
    private let accentBlue = UIColor(red: 96/255, green: 123/255, blue: 136/255, alpha: 1)
    private let accentYellow = UIColor(red: 200/255, green: 160/255, blue: 57/255, alpha: 1)
    private let textLight = UIColor(red: 170/255, green: 185/255, blue: 191/255, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }

    private func configureLayout() {
        view.backgroundColor = backgroundColor

        let topBar = makeTopBar()
        let welcome = UILabel()
        welcome.text = "嗨，歡迎回來！"
        welcome.textColor = .white
        welcome.font = UIFont.boldSystemFont(ofSize: 24)

        let summaryStack = UIStackView(arrangedSubviews: [makeStatCard(title: "今日消耗", value: "520 cal"), makeStatCard(title: "今日步數", value: "8,200")])
        summaryStack.axis = .horizontal
        summaryStack.alignment = .fill
        summaryStack.spacing = 12
        summaryStack.distribution = .fillEqually

        let progressCard = makeProgressCard()
        let scheduleCard = makeScheduleCard()

        let stack = UIStackView(arrangedSubviews: [topBar, welcome, summaryStack, progressCard, scheduleCard])
        stack.axis = .vertical
        stack.spacing = 18
        stack.alignment = .fill

        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12)
        ])
    }

    private func makeTopBar() -> UIView {
        let bar = UIStackView()
        bar.axis = .horizontal
        bar.alignment = .center
        bar.distribution = .equalSpacing

        let leftGroup = UIStackView()
        leftGroup.axis = .horizontal
        leftGroup.alignment = .center
        leftGroup.spacing = 8

        let icon = UIImageView(image: UIImage(systemName: "figure.strengthtraining.traditional"))
        icon.tintColor = .white
        icon.contentMode = .scaleAspectFit
        icon.widthAnchor.constraint(equalToConstant: 32).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 32).isActive = true

        let title = UILabel()
        title.text = "HappyGym"
        title.textColor = .white
        title.font = UIFont.boldSystemFont(ofSize: 22)

        let chevron = UIImageView(image: UIImage(systemName: "chevron.down"))
        chevron.tintColor = .white
        chevron.contentMode = .scaleAspectFit
        chevron.widthAnchor.constraint(equalToConstant: 16).isActive = true

        leftGroup.addArrangedSubview(icon)
        leftGroup.addArrangedSubview(title)
        leftGroup.addArrangedSubview(chevron)

        let profile = UIButton(type: .system)
        profile.setImage(UIImage(systemName: "person.circle"), for: .normal)
        profile.tintColor = .white
        profile.widthAnchor.constraint(equalToConstant: 32).isActive = true
        profile.heightAnchor.constraint(equalToConstant: 32).isActive = true

        bar.addArrangedSubview(leftGroup)
        bar.addArrangedSubview(profile)
        return bar
    }

    private func makeStatCard(title: String, value: String) -> UIView {
        let card = UIView()
        card.backgroundColor = UIColor(red: 39/255, green: 62/255, blue: 69/255, alpha: 1)
        card.layer.cornerRadius = 16
        card.layer.borderWidth = 1
        card.layer.borderColor = accentBlue.withAlphaComponent(0.6).cgColor
        card.layoutMargins = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = textLight
        titleLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)

        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.textColor = .white
        valueLabel.font = UIFont.boldSystemFont(ofSize: 18)

        let stack = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        stack.axis = .vertical
        stack.spacing = 8

        card.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: card.layoutMarginsGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: card.layoutMarginsGuide.trailingAnchor),
            stack.topAnchor.constraint(equalTo: card.layoutMarginsGuide.topAnchor),
            stack.bottomAnchor.constraint(equalTo: card.layoutMarginsGuide.bottomAnchor)
        ])

        return card
    }

    private func makeProgressCard() -> UIView {
        let card = UIView()
        card.backgroundColor = UIColor(red: 39/255, green: 62/255, blue: 69/255, alpha: 1)
        card.layer.cornerRadius = 16
        card.layer.borderWidth = 1
        card.layer.borderColor = accentBlue.withAlphaComponent(0.6).cgColor
        card.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

        let titleLabel = UILabel()
        titleLabel.text = "今日進度"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)

        let detailLabel = UILabel()
        detailLabel.text = "再走 1,800 步即可達成今日目標"
        detailLabel.textColor = textLight
        detailLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)

        let progress = UIProgressView(progressViewStyle: .bar)
        progress.tintColor = accentYellow
        progress.trackTintColor = accentBlue.withAlphaComponent(0.5)
        progress.progress = 0.7
        progress.layer.cornerRadius = 4
        progress.clipsToBounds = true
        progress.heightAnchor.constraint(equalToConstant: 8).isActive = true

        let stack = UIStackView(arrangedSubviews: [titleLabel, detailLabel, progress])
        stack.axis = .vertical
        stack.spacing = 12

        card.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: card.layoutMarginsGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: card.layoutMarginsGuide.trailingAnchor),
            stack.topAnchor.constraint(equalTo: card.layoutMarginsGuide.topAnchor),
            stack.bottomAnchor.constraint(equalTo: card.layoutMarginsGuide.bottomAnchor)
        ])

        return card
    }

    private func makeScheduleCard() -> UIView {
        let card = UIView()
        card.backgroundColor = UIColor(red: 39/255, green: 62/255, blue: 69/255, alpha: 1)
        card.layer.cornerRadius = 16
        card.layer.borderWidth = 1
        card.layer.borderColor = accentBlue.withAlphaComponent(0.6).cgColor
        card.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

        let titleLabel = UILabel()
        titleLabel.text = "行程提醒"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)

        let nextLabel = UILabel()
        nextLabel.text = "今晚 7:00 | 重訓 45 分鐘"
        nextLabel.textColor = textLight
        nextLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)

        let button = UIButton(type: .system)
        button.setTitle("查看詳情", for: .normal)
        button.setTitleColor(backgroundColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.backgroundColor = accentYellow
        button.layer.cornerRadius = 12
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)

        let stack = UIStackView(arrangedSubviews: [titleLabel, nextLabel, button])
        stack.axis = .vertical
        stack.spacing = 12

        card.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: card.layoutMarginsGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: card.layoutMarginsGuide.trailingAnchor),
            stack.topAnchor.constraint(equalTo: card.layoutMarginsGuide.topAnchor),
            stack.bottomAnchor.constraint(equalTo: card.layoutMarginsGuide.bottomAnchor)
        ])

        return card
    }
}
