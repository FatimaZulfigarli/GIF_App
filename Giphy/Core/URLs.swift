import UIKit
import SafariServices

enum URLType {
    case termsOfService
    case privacyTerms
    case googlePrivacyTerms
    case gifinitySupport
}

class URLs {
    func callURL(urlType: URLType, from viewController: UIViewController) {
        switch urlType {
        case .termsOfService:
            viewController.showSafariVC(url: "https://support.giphy.com/hc/en-us/articles/360020027752-GIPHY-User-Terms-of-Service#:~:text=Please%20do%20not%20publicly%20post,in%20connection%20with%20its%20Services.")
        case .privacyTerms:
            viewController.showSafariVC(url: "https://support.giphy.com/hc/en-us/articles/360032872931")
        case .googlePrivacyTerms:
            viewController.showSafariVC(url: "https://policies.google.com/privacy?hl=en-US")
        case .gifinitySupport:
            viewController.showSafariVC(url: "https://support.giphy.com/hc/en-us")
        }
    }
}

extension UIViewController {
    func showSafariVC(url: String) {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        let safariViewController = SFSafariViewController(url: url)
        // Present Safari view controller from the current view controller
        self.present(safariViewController, animated: true, completion: nil)
    }
}
