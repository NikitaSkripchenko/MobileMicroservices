import SwiftUI
import SharedServices

struct ContentView: View {
    @ObservedObject var viewModel: MVVMViewModel
    @Environment(\.uiService) var uiService: UIService

    var body: some View {
        VStack {
            uiService.createButton(title: "Tap me") {
                viewModel.buttonTapped()
            }
            .padding()

            Text(viewModel.displayText)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: MVVMViewModel())
    }
}
