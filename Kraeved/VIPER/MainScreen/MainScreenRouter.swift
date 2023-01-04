import Foundation

protocol MainScreenRouterProtocol: BaseRouterProtocol {
    func showLogin()
}

class MainScreenRouter: BaseRouter<MainScreenViewController>, MainScreenRouterProtocol {
    func showLogin() {
        let startScreenViewController = StartScreenModuleBuilder.build()
        viewController?.navigationController?.present(startScreenViewController, animated: true)
    }
}
