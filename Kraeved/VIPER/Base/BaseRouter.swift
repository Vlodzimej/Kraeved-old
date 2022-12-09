import UIKit

protocol BaseRouterProtocol {
    func openAnnotation(annotation: Annotation)
    func openEntityDetails(id: UUID)
}

class BaseRouter<T>: BaseRouterProtocol where T: UIViewController {
    var viewController: T?
    
    func openAnnotation(annotation: Annotation) {
        let vc = AnnotationScreenModuleBuilder.build(annotation: annotation)
        guard let viewController = viewController else { return }
        viewController.navigationController?.present(vc, animated: true)
        //viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openEntityDetails(id: UUID) {
        let entityDetailsVC = EntityDetailsModuleBuilder.build(id: id)
        guard let viewController = viewController else { return }
        viewController.navigationController?.pushViewController(entityDetailsVC, animated: true)
    }
}
