import UIKit

// MARK: - BaseViewProtocol
protocol BaseViewProtocol: AnyObject {
    var isActivityIndicatorHidden: Bool { get set }

    func showOnboarding()
}

// MARK: - BaseViewController
class BaseViewController: UIViewController, BaseViewProtocol {

    var isActivityIndicatorHidden: Bool = false {
        didSet {
            if isActivityIndicatorHidden {
                hideActivityIndicator()
            } else {
                showActivityIndicator()
            }
        }
    }

    // MARK: VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

    private func initialize() {}

    private func showActivityIndicator() {
        NotificationCenter.default.post(name: .changeActivityIndicatorVisibility, object: nil, userInfo: ["isVisible": true])
    }

    private func hideActivityIndicator() {
        NotificationCenter.default.post(name: .changeActivityIndicatorVisibility, object: nil, userInfo: ["isVisible": false])
    }

    func showOnboarding() {
        NotificationCenter.default.post(name: .showOnboarding, object: nil)
    }
}
