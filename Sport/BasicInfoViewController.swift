//
//  BasicInfoViewController.swift
//  Sport
//
//  Created by 佳緯周 on 2025/12/5.
//

import UIKit

final class BasicInfoViewController: UIViewController {

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
        let photoCard = makePhotoCard()
        let infoCard = makeInfoCard()
        let calorieTitle = UILabel()
        calorieTitle.text = "每日建議飲食熱量"
        calorieTitle.textColor = .white
        calorieTitle.font = UIFont.boldSystemFont(ofSize: 18)

        let caloriePill = makeCaloriePill()
        let goalButton = makeGoalButton()

        let contentStack = UIStackView(arrangedSubviews: [topBar, photoCard, infoCard, calorieTitle, caloriePill, goalButton])
        contentStack.axis = .vertical
        contentStack.spacing = 20
        contentStack.alignment = .center

        view.addSubview(contentStack)
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        topBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            contentStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12)
        ])

        photoCard.translatesAutoresizingMaskIntoConstraints = false
        infoCard.translatesAutoresizingMaskIntoConstraints = false
        caloriePill.translatesAutoresizingMaskIntoConstraints = false
        goalButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topBar.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor),
            topBar.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor),
            photoCard.widthAnchor.constraint(equalToConstant: 150),
            photoCard.heightAnchor.constraint(equalToConstant: 170),
            infoCard.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor),
            infoCard.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor),
            caloriePill.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor),
            caloriePill.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor),
            goalButton.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor),
            goalButton.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor),
            goalButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }

    private func makeTopBar() -> UIView {
        let container = UIStackView()
        container.axis = .horizontal
        container.alignment = .center
        container.spacing = 12
        container.distribution = .fillProportionally
        container.translatesAutoresizingMaskIntoConstraints = false

        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)

        let titleLabel = UILabel()
        titleLabel.text = "我的基本資料"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)

        container.addArrangedSubview(backButton)
        container.addArrangedSubview(titleLabel)
        container.setContentHuggingPriority(.required, for: .horizontal)
        return container
    }

    private func makePhotoCard() -> UIView {
        let card = UIView()
        card.backgroundColor = UIColor(red: 39/255, green: 62/255, blue: 69/255, alpha: 1)
        card.layer.cornerRadius = 16
        card.layer.borderWidth = 1
        card.layer.borderColor = accentBlue.withAlphaComponent(0.6).cgColor

        let imageHolder = UIImageView(image: UIImage(systemName: "photo.on.rectangle"))
        imageHolder.tintColor = textLight
        imageHolder.contentMode = .scaleAspectFit

        let uploadButton = UIButton(type: .system)
        uploadButton.setTitle("上傳照片", for: .normal)
        uploadButton.setTitleColor(.black, for: .normal)
        uploadButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        uploadButton.backgroundColor = accentYellow
        uploadButton.layer.cornerRadius = 12
        uploadButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)

        let stack = UIStackView(arrangedSubviews: [imageHolder, uploadButton])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 12

        card.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        imageHolder.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: card.centerYAnchor),
            imageHolder.widthAnchor.constraint(equalToConstant: 48),
            imageHolder.heightAnchor.constraint(equalToConstant: 48)
        ])
        return card
    }

    private func makeInfoCard() -> UIView {
        let card = UIView()
        card.backgroundColor = UIColor(red: 39/255, green: 62/255, blue: 69/255, alpha: 1)
        card.layer.cornerRadius = 16
        card.layer.borderWidth = 1
        card.layer.borderColor = accentBlue.withAlphaComponent(0.6).cgColor
        card.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

        let rows: [(String, String)] = [
            ("姓名", "王曉明"),
            ("生日", "1990/02/01"),
            ("性別", "男"),
            ("身高", "180"),
            ("體重", "90"),
            ("你的工作量", "輕")
        ]

        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10

        for (index, item) in rows.enumerated() {
            let isLast = index == rows.count - 1
            stack.addArrangedSubview(makeInfoRow(title: item.0, value: item.1, showSeparator: !isLast))
        }

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

    private func makeInfoRow(title: String, value: String, showSeparator: Bool) -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 6

        let row = UIStackView()
        row.axis = .horizontal
        row.alignment = .center
        row.distribution = .fill
        row.spacing = 12

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = textLight
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.setContentHuggingPriority(.required, for: .horizontal)

        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.textColor = .white
        valueLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        valueLabel.textAlignment = .right

        row.addArrangedSubview(titleLabel)
        row.addArrangedSubview(valueLabel)
        container.addArrangedSubview(row)

        if showSeparator {
            let separator = UIView()
            separator.backgroundColor = accentBlue.withAlphaComponent(0.7)
            separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
            container.addArrangedSubview(separator)
        }

        return container
    }

    private func makeCaloriePill() -> UIView {
        let pill = UIView()
        pill.backgroundColor = accentBlue
        pill.layer.cornerRadius = 14

        let valueLabel = UILabel()
        valueLabel.text = "1500"
        valueLabel.textColor = .white
        valueLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        valueLabel.textAlignment = .center

        let unitLabel = UILabel()
        unitLabel.text = "cal"
        unitLabel.textColor = .white
        unitLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)

        let stack = UIStackView(arrangedSubviews: [valueLabel, unitLabel])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 12
        stack.distribution = .equalSpacing

        pill.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: pill.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: pill.trailingAnchor, constant: -20),
            stack.topAnchor.constraint(equalTo: pill.topAnchor, constant: 12),
            stack.bottomAnchor.constraint(equalTo: pill.bottomAnchor, constant: -12)
        ])

        return pill
    }

    private func makeGoalButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("開始設定目標 GO!", for: .normal)
        button.setTitleColor(UIColor(red: 54/255, green: 73/255, blue: 78/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = accentYellow
        button.layer.cornerRadius = 14
        button.addTarget(self, action: #selector(handleGoalSetup), for: .touchUpInside)
        return button
    }

    @objc private func handleBack() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func handleGoalSetup() {
        let controller = GoalSettingViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
