//
//  ViewController.swift
//  Sport
//
//  Created by 佳緯周 on 2025/12/5.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }

    private func configureLayout() {
        view.backgroundColor = UIColor(red: 33/255, green: 52/255, blue: 60/255, alpha: 1)

        let topBar = makeTopBar()
        view.addSubview(topBar)
        topBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            topBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            topBar.heightAnchor.constraint(equalToConstant: 44)
        ])

        let headingLabel = UILabel()
        headingLabel.text = "會員註冊"
        headingLabel.textColor = .white
        headingLabel.font = UIFont.boldSystemFont(ofSize: 20)
        headingLabel.textAlignment = .center

        let phoneField = makeTextField(placeholder: "091234567895")
        phoneField.keyboardType = .phonePad

        let sendButton = UIButton(type: .system)
        sendButton.setTitle("發送簡訊", for: .normal)
        sendButton.setTitleColor(UIColor(red: 106/255, green: 140/255, blue: 152/255, alpha: 1), for: .normal)
        sendButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        sendButton.layer.cornerRadius = 6
        sendButton.layer.borderWidth = 1
        sendButton.layer.borderColor = UIColor(red: 106/255, green: 140/255, blue: 152/255, alpha: 1).cgColor
        sendButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)

        let phoneRow = UIStackView(arrangedSubviews: [phoneField, sendButton])
        phoneRow.axis = .horizontal
        phoneRow.alignment = .fill
        phoneRow.spacing = 12
        sendButton.setContentHuggingPriority(.required, for: .horizontal)

        let codeLabel = UILabel()
        codeLabel.text = "驗證碼"
        codeLabel.textColor = UIColor(red: 170/255, green: 185/255, blue: 191/255, alpha: 1)
        codeLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)

        let codeField = makeTextField(placeholder: "1234")
        codeField.keyboardType = .numberPad

        let codeRow = UIStackView(arrangedSubviews: [codeLabel, codeField])
        codeRow.axis = .horizontal
        codeRow.alignment = .center
        codeRow.spacing = 12
        codeLabel.setContentHuggingPriority(.required, for: .horizontal)

        let registerButton = UIButton(type: .system)
        registerButton.setTitle("註冊", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        registerButton.backgroundColor = UIColor(red: 200/255, green: 160/255, blue: 57/255, alpha: 1)
        registerButton.layer.cornerRadius = 12
        registerButton.contentEdgeInsets = UIEdgeInsets(top: 14, left: 12, bottom: 14, right: 12)
        registerButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)

        let contentStack = UIStackView(arrangedSubviews: [headingLabel, phoneRow, codeRow, registerButton])
        contentStack.axis = .vertical
        contentStack.alignment = .fill
        contentStack.spacing = 16
        contentStack.setCustomSpacing(28, after: headingLabel)
        contentStack.setCustomSpacing(28, after: codeRow)

        view.addSubview(contentStack)
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            contentStack.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: 80)
        ])
    }

    @objc private func handleRegister() {
        let controller = BasicInfoViewController()
        navigationController?.pushViewController(controller, animated: true)
    }

    private func makeTextField(placeholder: String) -> UITextField {
        let field = UITextField()
        field.textColor = UIColor(red: 150/255, green: 182/255, blue: 192/255, alpha: 1)
        field.font = UIFont.boldSystemFont(ofSize: 16)
        field.backgroundColor = UIColor(red: 39/255, green: 62/255, blue: 69/255, alpha: 1)
        field.layer.cornerRadius = 10
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor(red: 98/255, green: 127/255, blue: 137/255, alpha: 1).cgColor
        field.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor(red: 106/255, green: 140/255, blue: 152/255, alpha: 1)]
        )

        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 44))
        field.leftView = padding
        field.leftViewMode = .always
        field.heightAnchor.constraint(equalToConstant: 44).isActive = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
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

        let icon = UIImageView(image: UIImage(systemName: "face.smiling"))
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
}
