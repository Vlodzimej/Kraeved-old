import Foundation

//MARK: - SearchScreenInteractorProtocol
protocol SearchScreenInteractorProtocol: AnyObject {
}

//MARK: - SearchScreenInteractor
class SearchScreenInteractor: SearchScreenInteractorProtocol {

    //MARK: Properties
    weak var presenter: SearchScreenPresenterProtocol?

    //MARK: Init
    init() {
    }
}
