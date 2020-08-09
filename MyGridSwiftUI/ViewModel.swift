import Foundation
import Combine
import SwiftUI

class ViewModal: ObservableObject {
    var cancelable: AnyCancellable?

    @Published var results: [AlbumResults] = []

    init() {
        handleTopAlbumsAPI()
    }

    func handleTopAlbumsAPI() {
        guard let url = URL(string: Constants.topAlbums) else { return }
        let urlSession = URLSession.shared
        cancelable = urlSession.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: TopAlbums.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (subscriber) in
            switch subscriber {
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            case .finished:
                break
            }
        }) {  topAlbums in
            self.results = topAlbums.feed.results
        }
    }
}

private extension ViewModal {
    enum Constants {
        static let topAlbums = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json"
    }
}

