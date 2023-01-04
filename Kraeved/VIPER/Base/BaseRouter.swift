import UIKit

protocol BaseRouterProtocol {
    func openAnnotation(annotation: Annotation)
    func openEntityDetails(id: UUID)
    func showMessage(_ message: String)
}

class BaseRouter<T>: BaseRouterProtocol where T: UIViewController {
    var viewController: T?

    func openAnnotation(annotation: Annotation) {
        let annotationVC = AnnotationScreenModuleBuilder.build(annotation: annotation)
        guard let viewController = viewController else { return }
        viewController.navigationController?.present(annotationVC, animated: true)
    }

    func openEntityDetails(id: UUID) {
        let entityDetailsVC = EntityDetailsModuleBuilder.build(id: id)
        guard let viewController = viewController else { return }
        viewController.navigationController?.pushViewController(entityDetailsVC, animated: true)
    }
    
    func showMessage(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("common.close", comment: ""), style: .default))
        viewController?.present(alert, animated: true)
    }
}
