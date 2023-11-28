//
//  ViewModel.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 28.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import UIKit

public enum ErrorViewStatus {
    case visible(text: String)
    case hidden
}


public protocol ErrorViewPresentable: AnyObject {
    func setErrorViewStatus(_ status: ErrorViewStatus)
}

extension ErrorViewPresentable where Self: UIViewController {

    public func setErrorViewStatus(_ status: ErrorViewStatus) {
        defaultErrorViewStatus(status, animated: true, view: nil)
    }

    public func defaultErrorViewStatus(_ status: ErrorViewStatus, animated: Bool, view: UIView?, yAxisOffset: CGFloat = 0) {
        if !isViewLoaded {
            return
        }
        let v = view ?? self.view!

        switch status {
        case .hidden:
            ErrorView.hide(for: v, animated: animated)
        case .visible(let text):
            ErrorView.show(in: v, text: text, animated: animated, yAxisOffset: yAxisOffset)
        }
    }

}

private final class ErrorView: UIView {
    class func show(in view: UIView, text: String, animated: Bool, yAxisOffset: CGFloat) {

        let errorView = ErrorView(frame: view.bounds)
        let label = UILabel()

        errorView.install(label)
        errorView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.text = text
        label.textAlignment = .center
        label.numberOfLines = 0

        let constraints: [NSLayoutConstraint] = [
            label.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.75),
            label.heightAnchor.constraint(greaterThanOrEqualToConstant: 58),
            label.centerXAnchor.constraint(equalTo: errorView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: errorView.centerYAnchor, constant: yAxisOffset)
        ]

        if animated {
            UIView.animate(withDuration: CATransaction.animationDuration(), animations: {
                view.addSubview(errorView)
                NSLayoutConstraint.activate(constraints)
            })
        } else {
            view.addSubview(errorView)
            NSLayoutConstraint.activate(constraints)
        }
    }

    class func hide(for view: UIView, animated: Bool) {
        let subviewsEnum = view.subviews.reversed()
        for subview in subviewsEnum {
            if subview.isKind(of: ErrorView.self) {
                subview.removeFromSuperview()
            }
        }
    }
}
