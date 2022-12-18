import UIKit
import MapKit

// MARK: - MapScreenViewProtocol
protocol MapScreenViewProtocol: AnyObject {
    var mapView: MKMapView { get set }

    func showLocationDetails(entity: MetaObject<Entity>)
}

// MARK: - MapScreenViewController
final class MapScreenViewController: BaseViewController, MapScreenViewProtocol {
    private struct UIConstants {
        static let addButtonSize: CGFloat = 64
        static let addButtonInset: CGFloat = 32
        static let locationMarkSize: CGFloat = 16
    }

    // MARK: Properties
    private let presenter: MapScreenPresenterProtocol

    private var isBottomPanelHidden = true
    private var bottomPanelAnchor: NSLayoutConstraint?

    // MARK: UIProperties
    var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()

    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = UIConstants.addButtonSize / 2
        button.setImage(UIImage.Common.plus, for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    private let bottomPanelView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.layer.borderColor = UIColor.MapScreen.bottomPanelBorder.cgColor
        view.layer.borderWidth = 1
        return view
    }()

    private let locationMarkView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()

    private let annotationView = MapScreenAnnotationView()

    // MARK: Init
    init(presenter: MapScreenPresenterProtocol) {
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
        mapView.delegate = presenter
    }

    private func initialize() {
        view.addSubview(mapView)
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        view.addSubview(bottomPanelView)
        bottomPanelView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomPanelView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomPanelAnchor = bottomPanelView.heightAnchor.constraint(equalToConstant: 0)
        bottomPanelAnchor?.isActive = true
        bottomPanelView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        view.addSubview(addButton)
        addButton.bottomAnchor.constraint(equalTo: bottomPanelView.topAnchor, constant: -UIConstants.addButtonInset).isActive = true
        addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.addButtonInset).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: UIConstants.addButtonSize).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: UIConstants.addButtonSize).isActive = true

        bottomPanelView.addSubview(annotationView)
        annotationView.topAnchor.constraint(equalTo: bottomPanelView.topAnchor).isActive = true
        annotationView.trailingAnchor.constraint(equalTo: bottomPanelView.trailingAnchor).isActive = true
        annotationView.leadingAnchor.constraint(equalTo: bottomPanelView.leadingAnchor).isActive = true
        annotationView.bottomAnchor.constraint(equalTo: bottomPanelView.bottomAnchor).isActive = true
    }

    @IBAction func addButtonTapped(_ sender: UIButton) {
        toggleBottomPanel()

    }

    private func toggleBottomPanel() {
        if isBottomPanelHidden {
            showBottomPanel()
        } else {
            hideBottomPanel()
        }
    }

    private func showBottomPanel() {
        addButton.setImage(UIImage.Common.xmark, for: .normal)
        addButton.backgroundColor = UIColor.MapScreen.closeButton
        bottomPanelAnchor?.constant = view.bounds.height / 3
        isBottomPanelHidden = false
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let self = self else { return }
            self.view.layoutSubviews()
        }
    }

    private func hideBottomPanel() {
        addButton.setImage(UIImage.Common.plus, for: .normal)
        addButton.backgroundColor = .systemBlue
        bottomPanelAnchor?.constant = 0
        isBottomPanelHidden = true
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let self = self else { return }
            self.view.layoutSubviews()
        }
    }

    func showLocationDetails(entity: MetaObject<Entity>) {
        showBottomPanel()
        annotationView.configurate(entity: entity)
    }

}
