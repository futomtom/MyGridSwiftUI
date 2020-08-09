import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModal()
    var columns: [GridItem] =
        Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        NavigationView {
            ScrollView {
               LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.results) { item in
                        RowView(album: item)
                    }
                }.font(.largeTitle)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
