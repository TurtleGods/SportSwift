//
//  RegistrationCompleteViewController.swift
//  Sport
//
//  Created by 佳緯周 on 2025/12/6.
//

import UIKit

final class RegistrationCompleteViewController: UIViewController {

    private let backgroundColor = UIColor(red: 33/255, green: 52/255, blue: 60/255, alpha: 1)
    private let accentBlue = UIColor(red: 96/255, green: 123/255, blue: 136/255, alpha: 1)
    private let accentYellow = UIColor(red: 200/255, green: 160/255, blue: 57/255, alpha: 1)
    private let textLight = UIColor(red: 170/255, green: 185/255, blue: 191/255, alpha: 1)

    private let iconBackground = UIView()
    private let iconImageView = UIImageView()
    private var isIconHighlighted = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }

    private func configureLayout() {
        view.backgroundColor = backgroundColor

        let topBar = makeTopBar()

        let card = UIView()
        card.backgroundColor = UIColor(red: 39/255, green: 62/255, blue: 69/255, alpha: 1)
        card.layer.cornerRadius = 16
        card.layer.borderWidth = 1
        card.layer.borderColor = accentBlue.withAlphaComponent(0.6).cgColor
        card.layoutMargins = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)

        iconBackground.backgroundColor = accentBlue.withAlphaComponent(0.4)
        iconBackground.layer.cornerRadius = 38
        iconBackground.translatesAutoresizingMaskIntoConstraints = false

        iconImageView.image = UIImage(systemName: "seal")
        iconImageView.tintColor = .white
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.isUserInteractionEnabled = true
        iconImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleIconColor)))

        let statusLabel = UILabel()
        statusLabel.text = "完成註冊"
        statusLabel.textColor = .white
        statusLabel.font = UIFont.boldSystemFont(ofSize: 20)

        let detailLabel = UILabel()
        detailLabel.text = "資料已儲存，點擊徽章切換圖示顏色。"
        detailLabel.textColor = textLight
        detailLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        detailLabel.numberOfLines = 0
        detailLabel.textAlignment = .center

        let cardStack = UIStackView(arrangedSubviews: [iconBackground, statusLabel, detailLabel])
        cardStack.axis = .vertical
        cardStack.alignment = .center
        cardStack.spacing = 16

        card.addSubview(cardStack)
        cardStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardStack.leadingAnchor.constraint(equalTo: card.layoutMarginsGuide.leadingAnchor),
            cardStack.trailingAnchor.constraint(equalTo: card.layoutMarginsGuide.trailingAnchor),
            cardStack.topAnchor.constraint(equalTo: card.layoutMarginsGuide.topAnchor),
            cardStack.bottomAnchor.constraint(equalTo: card.layoutMarginsGuide.bottomAnchor),
            iconBackground.widthAnchor.constraint(equalToConstant: 76),
            iconBackground.heightAnchor.constraint(equalToConstant: 76)
        ])

        iconBackground.addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: iconBackground.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconBackground.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 36),
            iconImageView.heightAnchor.constraint(equalToConstant: 36)
        ])

        let continueButton = UIButton(type: .system)
        continueButton.setTitle("前往首頁", for: .normal)
        continueButton.setTitleColor(backgroundColor, for: .normal)
        continueButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        continueButton.backgroundColor = accentYellow
        continueButton.layer.cornerRadius = 14
        continueButton.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
        continueButton.heightAnchor.constraint(equalToConstant: 52).isActive = true

        let stack = UIStackView(arrangedSubviews: [topBar, card, continueButton])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 24

        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        card.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            card.heightAnchor.constraint(greaterThanOrEqualToConstant: 200)
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
        titleLabel.text = "確認資料"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)

        container.addArrangedSubview(backButton)
        container.addArrangedSubview(titleLabel)
        container.setContentHuggingPriority(.required, for: .horizontal)
        return container
    }

    @objc private func handleBack() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func toggleIconColor() {
        isIconHighlighted.toggle()
        let targetColor = isIconHighlighted ? accentYellow : .white
        UIView.animate(withDuration: 0.2) {
            self.iconImageView.tintColor = targetColor
            self.iconBackground.backgroundColor = self.isIconHighlighted ? self.accentYellow.withAlphaComponent(0.25) : self.accentBlue.withAlphaComponent(0.4)
        }
    }

    @objc private func handleContinue() {
        let controller = HomeViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
