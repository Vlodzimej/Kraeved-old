import UIKit

//MARK: - BasePresenterProtocol
protocol BasePresenterProtocol: AnyObject {
}

//MARK: - BaseOutput

//MARK: - BasePresenter
class BasePresenter: BasePresenterProtocol {

    //MARK: Properties
    weak var view: BaseViewProtocol?
    private let interactor: BaseInteractorProtocol
    private let router: BaseRouterProtocol

    //MARK: Init
    init(interactor: BaseInteractorProtocol, router: BaseRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
}
