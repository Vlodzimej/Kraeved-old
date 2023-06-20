import UIKit

// MARK: - MainScreenViewProtocol
protocol MainScreenViewProtocol: AnyObject {

}

// MARK: - MainScreenViewController
final class MainScreenViewController: BaseViewController, MainScreenViewProtocol {
    
    // MARK: Properties
    private let presenter: MainScreenPresenterProtocol

    // MARK: UIProperties

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .clear
        return searchBar
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .none
        collectionView.bounces = false
        return collectionView
    }()

    // MARK: Init
    init(presenter: MainScreenPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("don't use storyboards!")
    }

    // MARK: VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
        initialize()
    }

    private func initialize() {
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor.MainScreen.searchBarTextField
            textfield.clipsToBounds = true
            textfield.layer.borderColor = UIColor.lightGray.cgColor
            textfield.layer.borderWidth = 1
            textfield.layer.cornerRadius = 12
        }
        
        view.backgroundColor = .HEX.hFAFAF4
        navigationItem.titleView = searchBar
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaLayoutGuide)
            maker.leading.trailing.bottom.equalToSuperview()
        }
        
        collectionView.register(StoryCollectionViewCell.self, forCellWithReuseIdentifier: "StoryCollectionViewCell")
        collectionView.register(HeaderSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderSupplementaryView")
        
        collectionView.collectionViewLayout = createLayout()
    
        setNeedsStatusBarAppearanceUpdate()
        setDelegates()
    }

    // MARK: Private methods
    private func setDelegates() {
        collectionView.delegate = presenter
        collectionView.dataSource = presenter
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self else { return nil }
            let section = self.presenter.sections[sectionIndex]
            switch section {
            case .stories(_):
                return self.createStorySection()
            }
        }
    }
    
    private func createLayoutSection(group: NSCollectionLayoutGroup, behaivor: UICollectionLayoutSectionOrthogonalScrollingBehavior, interGroupSpacing: CGFloat, supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem], contentInsets: Bool) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behaivor
        section.interGroupSpacing = interGroupSpacing
        section.boundarySupplementaryItems = supplementaryItems
        section.supplementariesFollowContentInsets = contentInsets
        return section
    }
    
    
    private func createStorySection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 0, leading: 4, bottom: 0, trailing: 4)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2)), subitems: [item])
        let section = createLayoutSection(group: group, behaivor: .continuous, interGroupSpacing: -38, supplementaryItems: [], contentInsets: true)
        section.contentInsets = .init(top: 0, leading: Constants.contentInset, bottom: 0, trailing: Constants.contentInset)
        return section
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }

    // MARK: Public methods

}

