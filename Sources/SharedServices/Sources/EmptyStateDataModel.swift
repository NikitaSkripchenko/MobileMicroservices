//
//  EmptyStateDataModel.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 28.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import UIKit

//public final class EmptyStateDataModel: NSObject {
//    public typealias Button = (title: String, action: () -> Void, type: ButtonType)
//
//    public static var empty = EmptyStateDataModel(message: "")
//
//    public enum ButtonType {
//        case red
//        case black
//    }
//
//    public enum LayoutStackViewOrder {
//        case buttonFirst
//        case messageFirst
//    }
//
//    public enum Configuration {
//        case text(message: String, title: String?, button: Button?)
//    }
//
//    public let configuration: Configuration
//    let layoutStackViewOrder: LayoutStackViewOrder
//
//    public init(configuration: Configuration,
//                layoutStackViewOrder: LayoutStackViewOrder = .buttonFirst) {
//        self.configuration = configuration
//        self.layoutStackViewOrder = layoutStackViewOrder
//    }
//
//    public convenience init(message: String, button: Button? = nil) {
//        self.init(configuration: .text(message: message, title: nil, button: button))
//    }
//
//}
//
//public enum EmptyStateViewType {
//    case loading
//    case empty
//    case error
//}
