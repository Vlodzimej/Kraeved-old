import UIKit

//MARK: - MainScreenViewProtocol
protocol MainScreenViewProtocol: AnyObject {
}

//MARK: - MainScreenViewController
class MainScreenViewController: BaseViewController, MainScreenViewProtocol {

    //MARK: Properties
    private let presenter: MainScreenPresenterProtocol
    
    //MARK: UIProperties
    
    //MARK: Init
    init(presenter: MainScreenPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("don't use storyboards!")
    }

    //MARK: VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

    private func initialize() {
    }

    //MARK: Private methods

    //MARK: Public methods

}

