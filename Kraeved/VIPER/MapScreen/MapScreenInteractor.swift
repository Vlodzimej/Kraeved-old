import Foundation

//MARK: - MapScreenInteractorProtocol
protocol MapScreenInteractorProtocol: AnyObject {
}

//MARK: - MapScreenInteractor
class MapScreenInteractor: MapScreenInteractorProtocol {

    //MARK: Properties
    weak var presenter: MapScreenPresenterProtocol?

    //MARK: Init
    init() {
    }
}
