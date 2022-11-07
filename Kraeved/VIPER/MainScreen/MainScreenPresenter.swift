import UIKit

//MARK: - MainScreenPresenterProtocol
protocol MainScreenPresenterProtocol: AnyObject {
}

//MARK: - MainScreenPresenter
class MainScreenPresenter: MainScreenPresenterProtocol {

    //MARK: Properties
    weak var view: MainScreenViewProtocol?
    private let interactor: MainScreenInteractorProtocol
    private let router: MainScreenRouterProtocol

    //MARK: Init
    init(interactor: MainScreenInteractorProtocol, router: MainScreenRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
}
