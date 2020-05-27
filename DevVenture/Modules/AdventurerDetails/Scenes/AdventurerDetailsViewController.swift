//
//  AdventurerDetailsViewController.swift
//  DevVenture
//
//  Created by Amanda Coutrin on 24/05/20.
//  Copyright (c) 2020 Amanda. All rights reserved.
//

import UIKit

protocol AdventurerDetailsDisplayLogic: class {
    func displayAdventurer(viewModel: AdventurerDetails.Model.ViewModel)
}

class AdventurerDetailsViewController: UIViewController, AdventurerDetailsDisplayLogic {
    
    // MARK: Archtecture Objects
    
    var interactor: AdventurerDetailsBusinessLogic?
    var router: (NSObjectProtocol & AdventurerDetailsRoutingLogic & AdventurerDetailsDataPassing)?
    
    // MARK: - Views
    
    private lazy var safeArea: UILayoutGuide = {
        view.safeAreaLayoutGuide
    }()
    
    private lazy var infoDetailsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.layer.masksToBounds = false
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowOpacity = 0.9
        view.layer.shadowRadius = 5
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    
    private lazy var infoDetailsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: ViewController lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.566681338, green: 0.4721335827, blue: 0.824347648, alpha: 1)
        addComponents()
        addConstraints()
        interactor?.loadSocialNetworking()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = AdventurerDetailsInteractor()
        let presenter = AdventurerDetailsPresenter()
        let router = AdventurerDetailsRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - SubViews & Constraints
    
    private func addComponents() {
        view.addSubview(infoDetailsView)
        infoDetailsView.addSubview(nameLabel)
        infoDetailsView.addSubview(infoDetailsLabel)
    }
    
    private func addConstraints() {
        addInfoDetailsViewConstraints()
        addNameLabelConstraints()
        addInfoDetailsLabelConstraints()
    }
    
    private func addInfoDetailsViewConstraints() {
        let top = infoDetailsView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50)
        let leading = infoDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        let trailing = infoDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        let bottom = infoDetailsView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -50)
        NSLayoutConstraint.activate([top, leading, trailing, bottom])
    }
    
    private func addNameLabelConstraints() {
        let top = nameLabel.topAnchor.constraint(equalTo: infoDetailsView.topAnchor, constant: 10)
        let leading = nameLabel.leadingAnchor.constraint(equalTo: infoDetailsView.leadingAnchor, constant: 20)
        let trailing = nameLabel.trailingAnchor.constraint(equalTo: infoDetailsView.trailingAnchor, constant: -20)
        NSLayoutConstraint.activate([top, leading, trailing])
    }
    
    private func addInfoDetailsLabelConstraints() {
        let top = infoDetailsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20)
        let leading = infoDetailsLabel.leadingAnchor.constraint(equalTo: infoDetailsView.leadingAnchor, constant: 20)
        let trailing = infoDetailsLabel.trailingAnchor.constraint(equalTo: infoDetailsView.trailingAnchor, constant: -20)
        NSLayoutConstraint.activate([top, leading, trailing])
    }
    
    // MARK: DisplayLogic
    
    func displayAdventurer(viewModel: AdventurerDetails.Model.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.nameLabel.text = viewModel.name
            self?.infoDetailsLabel.text = viewModel.detailsText
        }
    }
}
