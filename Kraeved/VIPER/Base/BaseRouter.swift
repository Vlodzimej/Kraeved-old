import UIKit

protocol BaseRouterProtocol {
    func openAnnotation(annotation: Annotation)
    func openHistoricalEventDetail(id: UUID)
}

class BaseRouter<T>: BaseRouterProtocol where T: UIViewController {
    var viewController: T?
    
    func openAnnotation(annotation: Annotation) {
        let vc = AnnotationScreenModuleBuilder.build(annotation: annotation)
        guard let viewController = viewController else { return }
        viewController.navigationController?.present(vc, animated: true)
        //viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openHistoricalEventDetail(id: UUID) {
        let historicalEventVC = HistoricalEventModuleBuilder.build(id: id)
        guard let viewController = viewController else { return }
        viewController.navigationController?.pushViewController(historicalEventVC, animated: true)
    }
}
