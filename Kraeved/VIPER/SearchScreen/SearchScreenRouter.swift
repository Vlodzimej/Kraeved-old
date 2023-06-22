import Foundation

protocol SearchScreenRouterProtocol: BaseRouterProtocol {

}

final class SearchScreenRouter: BaseRouter<SearchScreenViewController>, SearchScreenRouterProtocol {
    override func dismiss() {
        viewController?.navigationController?.popViewController(animated: false)
    }
}
