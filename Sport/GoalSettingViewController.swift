//
//  GoalSettingViewController.swift
//  Sport
//
//  Created by 佳緯周 on 2025/12/6.
//

import UIKit

final class GoalSettingViewController: UIViewController {

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
        let heading = UILabel()
        heading.text = "設定目標"
        heading.textColor = .white
        heading.font = UIFont.boldSystemFont(ofSize: 22)

        let description = UILabel()
        description.text = "設定你的目標，幫助我們建立更適合你的計畫。"
        description.textColor = textLight
        description.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        description.numberOfLines = 0

        let goalFields = makeGoalForm()
        let saveButton = makeSaveButton()

        let stack = UIStackView(arrangedSubviews: [topBar, heading, description, goalFields, saveButton])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 20

        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12)
        ])

        topBar.translatesAutoresizingMaskIntoConstraints = false
        goalFields.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }

    private func makeTopBar() -> UIView {
        let container = UIStackView()
        container.axis = .horizontal
        container.alignment = .center
        container.spacing = 12

        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)

        let titleLabel = UILabel()
        titleLabel.text = "我的基本資料"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)

        container.addArrangedSubview(backButton)
        container.addArrangedSubview(titleLabel)
        container.setContentHuggingPriority(.required, for: .horizontal)
        return container
    }

    private func makeGoalForm() -> UIView {
        let card = UIView()
        card.backgroundColor = UIColor(red: 39/255, green: 62/255, blue: 69/255, alpha: 1)
        card.layer.cornerRadius = 16
        card.layer.borderWidth = 1
        card.layer.borderColor = accentBlue.withAlphaComponent(0.6).cgColor
        card.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

        let weightRow = makeRow(title: "目標體重", placeholder: "75 kg")
        let weeklyRow = makeRow(title: "每週運動次數", placeholder: "3 次")
        let calorieRow = makeRow(title: "每日攝取熱量", placeholder: "1800 cal")
        let sleepRow = makeRow(title: "睡眠時數", placeholder: "7 小時")

        let stack = UIStackView(arrangedSubviews: [weightRow, weeklyRow, calorieRow, sleepRow])
        stack.axis = .vertical
        stack.spacing = 14

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

    private func makeRow(title: String, placeholder: String) -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 6

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = textLight
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)

        let field = UITextField()
        field.textColor = .white
        field.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        field.backgroundColor = UIColor(red: 46/255, green: 72/255, blue: 81/255, alpha: 1)
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = accentBlue.cgColor
        field.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: accentBlue]
        )
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 44))
        field.leftViewMode = .always
        field.heightAnchor.constraint(equalToConstant: 48).isActive = true

        container.addArrangedSubview(titleLabel)
        container.addArrangedSubview(field)
        return container
    }

    private func makeSaveButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("儲存", for: .normal)
        button.setTitleColor(backgroundColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = accentYellow
        button.layer.cornerRadius = 14
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return button
    }

    @objc private func handleBack() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func handleSave() {
        let controller = RegistrationCompleteViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
