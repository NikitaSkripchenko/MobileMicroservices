import SwiftUI
import SharedServices

struct ContentView: View {
    @StateObject private var viewModel: ViewModel

    init(viewModel: ViewModel = ViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, SwiftUI!")
                    .padding()

                // Use shared service
                viewModel.button
            }
            .navigationTitle("MVC SwiftUI App")
        }
    }
}
