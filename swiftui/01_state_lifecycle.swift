import SwiftUI

final class CounterViewModel: ObservableObject {
    @Published var count = 0

    func increment() {
        count += 1
    }
}

struct ParentCounterView: View {
    @State private var localCount = 0
    @StateObject private var viewModel = CounterViewModel()

    var body: some View {
        VStack(spacing: 16) {
            Text("Local count: \(localCount)")
            Button("Increment Local") {
                localCount += 1
            }

            Divider()

            ChildCounterView(count: $localCount)
            ObservedCounterView(viewModel: viewModel)
        }
        .padding()
    }
}

struct ChildCounterView: View {
    @Binding var count: Int

    var body: some View {
        Button("Increment Binding") {
            count += 1
        }
    }
}

struct ObservedCounterView: View {
    @ObservedObject var viewModel: CounterViewModel

    var body: some View {
        VStack {
            Text("View model count: \(viewModel.count)")
            Button("Increment ViewModel") {
                viewModel.increment()
            }
        }
    }
}

#Preview {
    ParentCounterView()
}
