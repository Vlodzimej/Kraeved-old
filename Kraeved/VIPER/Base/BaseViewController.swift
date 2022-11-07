import UIKit

//MARK: - BaseViewProtocol
protocol BaseViewProtocol: AnyObject {
}

//MARK: - BaseViewController
class BaseViewController: UIViewController, BaseViewProtocol {

    //MARK: VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

    private func initialize() {
    }
}

