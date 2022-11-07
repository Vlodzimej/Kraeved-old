import UIKit

//MARK: - SearchScreenViewProtocol
protocol SearchScreenViewProtocol: AnyObject {
}

//MARK: - SearchScreenViewController
class SearchScreenViewController: BaseViewController, SearchScreenViewProtocol {

    //MARK: Properties
    private let presenter: SearchScreenPresenterProtocol
    
    //MARK: UIProperties
    
    //MARK: Init
    init(presenter: SearchScreenPresenterProtocol) {
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

