import SwiftUI

public protocol UIService {
    func createButton(title: String, action: @escaping () -> Void) -> AnyView
}

public class UIServiceImpl: UIService {
    public init() {
        
    }
    public func createButton(title: String, action: @escaping () -> Void) -> AnyView {
        return AnyView(
            Button(action: action) {
                Text(title)
            }
        )
    }
}
