import UIKit

//MARK: - MainScreenPresenterProtocol
protocol MainScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
}

//MARK: - MainScreenPresenter
class MainScreenPresenter: MainScreenPresenterProtocol {

    private let adapter = MainTableAdapter()
    
    //MARK: Properties
    weak var view: MainScreenViewProtocol?
    private let interactor: MainScreenInteractorProtocol
    private let router: MainScreenRouterProtocol

    //MARK: Init
    init(interactor: MainScreenInteractorProtocol, router: MainScreenRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        guard let view = view else { return }
        adapter.setup(for: view.tableView)
        interactor.getHistoricalEvents { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.adapter.configure(historicalEvents: result)
            }
        }
    }
}
