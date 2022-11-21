import UIKit

protocol BaseRouterProtocol {
    func openAnnotation(annotation: Annotation)
}

class BaseRouter<T>: BaseRouterProtocol where T: UIViewController {
    var viewController: T?
    
    func openAnnotation(annotation: Annotation) {
        let vc = AnnotationScreenModuleBuilder.build(annotation: annotation)
        guard let viewController else { return }
        viewController.navigationController?.present(vc, animated: true)
        //viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
