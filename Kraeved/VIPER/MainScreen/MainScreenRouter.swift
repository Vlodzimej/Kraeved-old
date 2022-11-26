import Foundation

protocol MainScreenRouterProtocol: BaseRouterProtocol {
    func openHistoricalEventDetail(id: UUID)
}

class MainScreenRouter: BaseRouter<MainScreenViewController>, MainScreenRouterProtocol {

}
