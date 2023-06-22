import UIKit
import SnapKit

// MARK: - SearchScreenViewProtocol
protocol SearchScreenViewProtocol: AnyObject {
    var tableView: UITableView { get set }
}

private struct SearchTypes {
    let title: String
    let metaType: MetaType
}

// MARK: - SearchScreenViewController
final class SearchScreenViewController: BaseViewController, SearchScreenViewProtocol {

    // MARK: Properties
    private let presenter: SearchScreenPresenterProtocol

    private let searchTypes: [SearchTypes] = [
        SearchTypes(title: NSLocalizedString("searchItems.historicalEvents", comment: ""), metaType: .entity),
        SearchTypes(title: NSLocalizedString("searchItems.annotations", comment: ""), metaType: .entity)
    ]

    // MARK: UIProperties
    private lazy var searchBar = KraevedSearchBar()

    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .none
        return tableView
    }()

    // MARK: Init
    init(presenter: SearchScreenPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("don't use storyboards!")
    }

    // MARK: VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()

        presenter.viewDidLoad()
    }

    private func initialize() {
        navigationItem.titleView = searchBar
        navigationController?.navigationBar.topItem?.setHidesBackButton(true, animated: false)

        view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.top.bottom.equalTo(view.safeAreaLayoutGuide)
            maker.leading.trailing.equalToSuperview().inset(Constants.contentInset)
        }
        
        presenter.currentMetaType = searchTypes[0].metaType
        
        searchBar.showsCancelButton = true
        searchBar.becomeFirstResponder()
        searchBar.delegate = self
    }
}

extension SearchScreenViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.search(metaType: MetaType.entity, searchText: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if navigationController?.viewControllers.count == 1 {
            searchBar.resignFirstResponder()
            searchBar.showsCancelButton = false
        } else {
            presenter.dismiss()
        }
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
}
