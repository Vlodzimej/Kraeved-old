import Foundation

//MARK: - MainScreenInteractorProtocol
protocol MainScreenInteractorProtocol: AnyObject {
}

//MARK: - MainScreenInteractor
class MainScreenInteractor: MainScreenInteractorProtocol {

    //MARK: Properties
    weak var presenter: MainScreenPresenterProtocol?

    //MARK: Init
    init() {
    }
}
