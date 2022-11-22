import Foundation

protocol MainScreenRouterProtocol: BaseRouterProtocol {
    func openHistoricalEventDetail(id: UUID) 
}

class MainScreenRouter: BaseRouter<MainScreenViewController>, MainScreenRouterProtocol {
    func openHistoricalEventDetail(id: UUID) {
        let historicalEventVC = HistoricalEventModuleBuilder.build(id: id)
        guard let viewController = viewController else { return }
        viewController.navigationController?.pushViewController(historicalEventVC, animated: true)
    }
}
