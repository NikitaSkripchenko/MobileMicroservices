//
//  EmptyStateController.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 28.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import UIKit

public class EmptyStateController: NSObject {

    public var data: ErrorViewModel {
        didSet {
            let wasShowing = overlay?.superview != nil
            hideOverlay()
            overlay = nil
            if wasShowing {
                showOverlay()
            }
        }
    }
    public weak var parentView: UIView?
    var overlay: EmptyStateView?

    public var customInset: UIEdgeInsets?
    public var customOrigin: CGPoint? {
        didSet {
            self.overlay?.frame.origin = customOrigin ?? defaultOrigin
        }
    }

    private var defaultInset: UIEdgeInsets {
        let parentInset = (parentView as? UIScrollView)?.contentInset ?? .zero
        return UIEdgeInsets(top: -parentInset.top / 2, left: 0, bottom: 0, right: 0)
    }

    private var defaultOrigin: CGPoint  = .zero

    public func showOverlay(_ backgroundColor: UIColor = .clear, isUserInteractionEnabled: Bool = true) {
        guard let parentView = parentView else {
            return
        }
        if self.overlay?.superview != nil {
            hideOverlay()
        }
        let overlay = EmptyStateView(data: data, inset: customInset ?? defaultInset)
        overlay.backgroundColor = backgroundColor
        overlay.frame = CGRect(origin: customOrigin ?? defaultOrigin, size: parentView.bounds.size)
        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlay.isUserInteractionEnabled = isUserInteractionEnabled

        if self.overlay?.superview != nil {
            return
        }
        parentView.addSubview(overlay)
        self.overlay = overlay
    }

    public func hideOverlay() {
        self.overlay?.removeFromSuperview()
    }

    public init(data: ErrorViewModel) {
        self.data = data
        super.init()
    }
    
    public init(data: ErrorViewModel, on view: UIView) {
        self.data = data
        parentView = view
        super.init()
    }

    deinit {
        hideOverlay()
    }

    public func setData(data: ErrorViewModel) {
        self.data = data
    }

    public func setBackgroundColor(_ color: UIColor) {
        self.overlay?.backgroundColor = color
    }

    public func setIsUserInteractionEnabled(_ isEnabled: Bool) {
        self.overlay?.isUserInteractionEnabled = isEnabled
    }
}

public class EmptyStateControllerImageRetriever: NSObject {
    public class func magnifier() -> UIImage {
        let bundle = Bundle(for: EmptyStateControllerImageRetriever.self)
        return UIImage(named: "EmptyState/magnifier", in: bundle, compatibleWith: nil)!.withRenderingMode(.alwaysTemplate)
    }
}
