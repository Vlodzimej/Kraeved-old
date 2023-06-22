import UIKit

// MARK: - MainScreenViewProtocol
protocol MainScreenViewProtocol: AnyObject {
    func refresh()
}

// MARK: - MainScreenViewController
final class MainScreenViewController: BaseViewController, MainScreenViewProtocol {
    
    // MARK: Properties
    private let presenter: MainScreenPresenterProtocol
    private let refreshControl = UIRefreshControl()
    
    // MARK: UIProperties

    let searchBar = KraevedSearchBar()
    
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
        collectionView.delegate = presenter
        collectionView.dataSource = presenter
        
        initialize()
        
        presenter.refresh(needToShowActivityIndicator: true) { [weak self] in
            self?.refresh()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchBar.resignFirstResponder()
    }

    private func initialize() {
        navigationItem.titleView = searchBar
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaLayoutGuide)
            maker.leading.trailing.bottom.equalToSuperview()
        }
        
        collectionView.register(StoryCollectionViewCell.self, forCellWithReuseIdentifier: "StoryCollectionViewCell")
        collectionView.register(AnnotationCollectionViewCell.self, forCellWithReuseIdentifier: "AnnotationCollectionViewCell")
        collectionView.register(HeaderSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderSupplementaryView")
        
        collectionView.collectionViewLayout = createLayout()
    
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        collectionView.bounces = true
        collectionView.alwaysBounceVertical = true
        collectionView.refreshControl = refreshControl
            
        setNeedsStatusBarAppearanceUpdate()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(searchBarTapped))
        tapGestureRecognizer.delegate = self
        searchBar.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func searchBarTapped() {
        searchBar.resignFirstResponder()
        presenter.openSearchScreen()
    }

    // MARK: Private methods
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self else { return nil }
            let section = self.presenter.sections[sectionIndex]
            switch section {
            case .stories(_):
                return self.createStorySection()
            case .annotations(_):
                return self.createAnnotationSection()
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
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(128), heightDimension: .absolute(128)))
        item.contentInsets = .init(top: 0, leading: 4, bottom: 0, trailing: 4)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(136)), subitems: [item])
        let section = createLayoutSection(group: group, behaivor: .continuous, interGroupSpacing: -6, supplementaryItems: [], contentInsets: true)
        section.contentInsets = .init(top: 0, leading: Constants.contentInset, bottom: 0, trailing: Constants.contentInset)
        return section
    }
    
    private func createAnnotationSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(104)))
        item.contentInsets = .init(top: 8, leading: 0, bottom: 8, trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [item])
        let section = createLayoutSection(group: group, behaivor: .none, interGroupSpacing: 0, supplementaryItems: [supplementaryHeaderItem()], contentInsets: true)
        section.contentInsets = .init(top: 0, leading: Constants.contentInset, bottom: 0, trailing: Constants.contentInset)
        return section
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
    
    @objc
    private func didPullToRefresh(_ sender: Any) {
        presenter.refresh(needToShowActivityIndicator: false) { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }

    // MARK: Public methods
    func refresh() {
        collectionView.reloadData()
    }

}

extension MainScreenViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith shouldRecognizeSimultaneouslyWithGestureRecognizer: UIGestureRecognizer) -> Bool {
      return true
    }
}
