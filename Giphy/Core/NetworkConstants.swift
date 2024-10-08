import Foundation
import Alamofire

enum BaseURL {
    case v1
    case v2
    
    var path: String {
        switch self {
        case .v1:
            return NetworkConstants.baseURL + "v1/"
        case .v2:
            return NetworkConstants.baseURL + "v2/"
        }
    }
}

enum Endpoint {
    case gifsTrending
    case stickersTrending
    case emoji
    case gifsSearch(query: String)
    case stickersSearch(query: String)

    var path: String {
        switch self {
        case .gifsTrending:
            return BaseURL.v1.path + "gifs/trending?api_key=\(NetworkConstants.apiKey)"
        case .stickersTrending:
            return BaseURL.v1.path + "stickers/trending?api_key=\(NetworkConstants.apiKey)"
        case .emoji:
            return BaseURL.v2.path + "emoji?api_key=\(NetworkConstants.apiKey)"
        case .gifsSearch(let query):
            return BaseURL.v1.path + "gifs/search?api_key=\(NetworkConstants.apiKey)&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query)"
        case .stickersSearch(let query):
            return BaseURL.v1.path + "stickers/search?api_key=\(NetworkConstants.apiKey)&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query)"
        }
    }
}

class NetworkConstants {
    static let baseURL = "https://api.giphy.com/"
    static let apiKey = "uZQeYKsD27WiYMFwwTbJGVsLsRu3YFzv"
}
