//
//  EmptyStateView.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 28.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import UIKit

final class EmptyStateView: UIView {
    
    private let stackView = UIStackView()
    private let inset: UIEdgeInsets
    private var callback: (() -> Void)?
    
    init(data: ErrorViewModel, inset: UIEdgeInsets) {
        self.inset = inset
        super.init(frame: .zero)
        makeStackView()
        build(with: data)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    private func build(with configuration: ErrorViewModel) {
        layoutStackView(with: configuration.description ?? "", title: configuration.title)
    }
    
    // MARK: - StackView
    
    private func makeStackView() {
        install(stackView)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 12
        
        NSLayoutConstraint.activate([stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     stackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -22),
                                     stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 30),
                                     stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -30),
                                     stackView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: inset.top),
                                     stackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: inset.bottom)])
    }
    
    private func layoutStackView(with message: String, title: String?) {
        let subviews: [UIView]
        
        switch (title) {
        case (.some(let title)):
            subviews = [makeTitleLabel(title),
                        makeMessageLabel(message)]
        default:
            subviews = [makeMessageLabel(message)]
        }
        stackView.addArrangedSubviews(subviews)
    }
    
    private func layoutStackView(width: CGFloat, message: String) {
        let label = makeMessageLabel(message)
        stackView.addArrangedSubviews([label])
        
    }
    
    // MARK: - Message Label
    private func makeMessageLabel(_ message: String) -> UILabel {
        let label = UILabel()
        label.text = message
        label.numberOfLines = 0
        label.textAlignment = .center
        label.isAccessibilityElement = true
        label.accessibilityIdentifier = "emptyStateView.text"
        label.accessibilityLabel = message
        return label
    }
    
    // MARK: - Title Label
    private func makeTitleLabel(_ title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.numberOfLines = 0
        label.textAlignment = .center
        label.isAccessibilityElement = true
        label.accessibilityIdentifier = "emptyStateView.title"
        return label
    }
    
    @objc private func performCallback() {
        callback?()
    }
    
}
