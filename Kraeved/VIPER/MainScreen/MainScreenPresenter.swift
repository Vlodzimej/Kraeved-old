import UIKit

// MARK: - MainScreenPresenterProtocol
protocol MainScreenPresenterProtocol: AnyObject, UICollectionViewDelegate, UICollectionViewDataSource {
    var sections: [MainScreenSection] { get }
    
    func viewDidLoad()
}

// MARK: - MainScreenPresenter
final class MainScreenPresenter: NSObject, MainScreenPresenterProtocol {
    
    // MARK: Properties
    weak var view: MainScreenViewProtocol?
    private let interactor: MainScreenInteractorProtocol
    private let router: MainScreenRouterProtocol
    
    var sections: [MainScreenSection] = []
    
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
            var stories: [MainScreenSectionItem] = []
            var annotations: [MainScreenSectionItem] = []
            result.forEach { item in
                guard let data = item.data, let typeId = data.typeId?.uuidString else { return }
                switch typeId {
                case EntityType.story.rawValue:
                    stories.append(MainScreenSectionItem(title: item.title, image: item.image))
                case EntityType.annotation.rawValue:
                    annotations.append(MainScreenSectionItem(title: item.title, image: item.image))
                case EntityType.photo.rawValue:
                    break
                default:
                    break
                }
            }
            
            self.sections.append(.stories(stories))
            self.sections.append(.annotations(annotations))
            
            DispatchQueue.main.async {
                self.baseView?.isActivityIndicatorHidden = true
                self.view?.refresh()
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension MainScreenPresenter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - UICollectionViewDataSource
extension MainScreenPresenter: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = indexPath.row
        switch sections[indexPath.section] {
        case .stories(let stories):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCollectionViewCell", for: indexPath) as? StoryCollectionViewCell
            else { return UICollectionViewCell() }
            cell.configure(title: stories[row].title, image: stories[row].image)
            return cell
        case .annotations(let annotations):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnnotationCollectionViewCell", for: indexPath) as? AnnotationCollectionViewCell
            else { return UICollectionViewCell() }
            cell.configure(title: annotations[row].title, image: annotations[row].image)
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
