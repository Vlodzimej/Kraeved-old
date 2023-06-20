import UIKit

// MARK: - MainScreenPresenterProtocol
protocol MainScreenPresenterProtocol: AnyObject, UICollectionViewDelegate, UICollectionViewDataSource {
    var sections: [ListSection] { get }
    
    func viewDidLoad()
}

// MARK: - MainScreenPresenter
final class MainScreenPresenter: NSObject, MainScreenPresenterProtocol {
    
    // MARK: Properties
    weak var view: MainScreenViewProtocol?
    private let interactor: MainScreenInteractorProtocol
    private let router: MainScreenRouterProtocol
    
    internal var sections: [ListSection] = MockData.shared.pageData
    
    var baseView: BaseViewProtocol? {
        view as? BaseViewProtocol
    }
    
    // MARK: Init
    init(interactor: MainScreenInteractorProtocol, router: MainScreenRouterProtocol) {
        self.router = router
        self.interactor = interactor
        super.init()
    }
    
    func viewDidLoad() {
        baseView?.isActivityIndicatorHidden = false
        interactor.fetchEntities { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.baseView?.isActivityIndicatorHidden = true
                //self.adapter.configurate(entities: result)
            }
        }
    }
}

extension MainScreenPresenter: UICollectionViewDelegate {
    
}

extension MainScreenPresenter: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .stories(let story):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCollectionViewCell", for: indexPath) as? StoryCollectionViewCell
            else { return UICollectionViewCell() }
            cell.configure(title: story[indexPath.row].title, image: story[indexPath.row].image)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderSupplementaryView", for: indexPath) as! HeaderSupplementaryView
            header.configureHeader(categoryName: sections[indexPath.section].title)
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    
}
