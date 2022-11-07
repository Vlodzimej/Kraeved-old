import UIKit

//MARK: - SearchScreenPresenterProtocol
protocol SearchScreenPresenterProtocol: AnyObject {
}

//MARK: - SearchScreenPresenter
class SearchScreenPresenter: SearchScreenPresenterProtocol {

    //MARK: Properties
    weak var view: SearchScreenViewProtocol?
    private let interactor: SearchScreenInteractorProtocol
    private let router: SearchScreenRouterProtocol

    //MARK: Init
    init(interactor: SearchScreenInteractorProtocol, router: SearchScreenRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
}
