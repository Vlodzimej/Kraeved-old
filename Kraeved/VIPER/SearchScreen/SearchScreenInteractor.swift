import Foundation

//MARK: - SearchScreenInteractorProtocol
protocol SearchScreenInteractorProtocol: AnyObject {
    var businessObjects: [BusinessObject]? { get set }
    
    func search(metaType: MetaType, searchText: String)
}

//MARK: - SearchScreenInteractor
class SearchScreenInteractor: SearchScreenInteractorProtocol {

    var businessObjects: [BusinessObject]?
    //MARK: Properties
    weak var presenter: SearchScreenPresenterProtocol?

    //MARK: Init
    init() {}
    
    func search(metaType: MetaType, searchText: String) {
        var businessObjectsByMetaType: [BusinessObject]?
        switch metaType {
            case .historicalEvent:
            if let data = UserDefaults.standard.object(forKey: UserDefaultsKeys.historicalEvents.rawValue) as? Data {
                businessObjectsByMetaType = try? JSONDecoder().decode([BusinessObject].self, from: data)
            }
            case .picture:
                break
            case .annotation:
                break
        }
        
        if let businessObjectsByMetaType = businessObjectsByMetaType {
            let lowercasedText = searchText.lowercased()
            businessObjects = searchText.isEmpty ? businessObjectsByMetaType : businessObjectsByMetaType.filter({ $0.title?.lowercased().contains(lowercasedText) ?? false })
        }
    }
}
