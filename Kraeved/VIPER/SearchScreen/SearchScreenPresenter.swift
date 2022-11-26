import UIKit

//MARK: - SearchScreenPresenterProtocol
protocol SearchScreenPresenterProtocol: AnyObject {
    var currentMetaType: MetaType? { get set }
    
    func viewDidLoad()
    func search(metaType: MetaType, searchText: String)
}

//MARK: - SearchScreenPresenter
class SearchScreenPresenter: NSObject, SearchScreenPresenterProtocol {
    
    //MARK: Properties
    weak var view: SearchScreenViewProtocol?
    private let interactor: SearchScreenInteractorProtocol
    private let router: SearchScreenRouterProtocol
    
    private let adapter = SearchTableAdapter()
    
    var currentMetaType: MetaType?

    //MARK: Init
    init(interactor: SearchScreenInteractorProtocol, router: SearchScreenRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        guard let view = view else { return }
        adapter.delegate = self
        adapter.setup(for: view.tableView)
        if let currentMetaType = currentMetaType {
            search(metaType: currentMetaType, searchText: "")
        }
    }
    
    func search(metaType: MetaType, searchText: String) {
        interactor.search(metaType: metaType, searchText: searchText)
        guard let businessObjects = interactor.businessObjects else { return }
        adapter.configure(businessObjects: businessObjects)
    }
}

extension SearchScreenPresenter: SearchTableAdapterDelegate {
    func showHistoricalEventDetail(id: UUID) {
        router.openHistoricalEventDetail(id: id)
    }
}
