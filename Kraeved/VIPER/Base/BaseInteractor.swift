import Foundation

//MARK: - BaseInteractorProtocol
protocol BaseInteractorProtocol: AnyObject {
}

//MARK: - BaseInteractor
class BaseInteractor: BaseInteractorProtocol {

    //MARK: Properties
    weak var presenter: BasePresenterProtocol?

    //MARK: Init
    init() {
    }
}
