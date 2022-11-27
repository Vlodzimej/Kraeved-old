import UIKit

//MARK: - SearchScreenViewProtocol
protocol SearchScreenViewProtocol: AnyObject {
    var tableView: UITableView { get set }
}

fileprivate struct SearchTypes {
    let title: String
    let metaType: MetaType
}

//MARK: - SearchScreenViewController
class SearchScreenViewController: BaseViewController, SearchScreenViewProtocol {

    //MARK: UIConstants
    struct UIConstants {
        static let segmentedControlHeight: CGFloat = 32
    }
    
    //MARK: Properties
    private let presenter: SearchScreenPresenterProtocol
    
    private let searchTypes: [SearchTypes] = [
        SearchTypes(title: NSLocalizedString("searchItems.historicalEvents", comment: ""), metaType: .historicalEvent),
        SearchTypes(title: NSLocalizedString("searchItems.annotations", comment: ""), metaType: .annotation),
    ]
    
    //MARK: UIProperties
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: searchTypes.map { $0.title })
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        segmentedControl.tintColor = .white
        return segmentedControl
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        return tableView
    }()
    
    //MARK: Init
    init(presenter: SearchScreenPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("don't use storyboards!")
    }

    //MARK: VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        presenter.currentMetaType = searchTypes[0].metaType
        presenter.viewDidLoad()
        
    }

    private func initialize() {
        view.backgroundColor = .white
        navigationItem.titleView = searchBar

        view.addSubview(segmentedControl)

        segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.contentInset).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.contentInset).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: UIConstants.segmentedControlHeight).isActive = true
        
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: Constants.contentInset).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.contentInset).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.contentInset).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    //MARK: Private methods

    //MARK: Public methods
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        
    }
}

extension SearchScreenViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let metaType = searchTypes[segmentedControl.selectedSegmentIndex].metaType
        presenter.search(metaType: metaType, searchText: searchText)
    }
}
