//
//  HomeViewController.swift
//  DevVenture
//
//  Created by Amanda Coutrin on 23/05/20.
//  Copyright (c) 2020 Amanda. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic: class {
    func displayPhotoCard(viewModel: Home.Model.PhotoCardViewModel)
    func displayDetails(viewModel: Home.Model.DetailsViewModel)
}

class HomeViewController: UIViewController, HomeDisplayLogic {
    
    // MARK: - Archtecture Objects
    
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    // MARK: - Views
    
    private lazy var safeArea: UILayoutGuide = {
        view.safeAreaLayoutGuide
    }()
    
    internal lazy var photoCardMenu: PhotoCardMenu = {
        let photos = PhotoCardMenu()
        photos.delegate = self
        return photos
    }()
    
    private lazy var adventurerDetailsView: UIView = {
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
        label.font = .systemFont(ofSize: 14)
        label.text = ""
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8893675086)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14)
        label.text = ""
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8893675086)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var adventurerDetailsButton: CustomButton = {
        let btn = CustomButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Details", for: .normal)
        btn.addTarget(self, action: #selector(didTapDetailsButton), for: .touchUpInside)
        return btn
    }()
    
    // MARK - Variables
    var scrollViewWidth: CGFloat {
        CGFloat()
    }
    
    // MARK: - ViewController lifecycle
    
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
        interactor?.loadScreenValues()
        addComponents()
        addConstraints()
    }
    
    // MARK: Setup
        
    private func setup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: - SubViews & Constraints
    
    private func addComponents() {
        view.addSubview(photoCardMenu)
        view.addSubview(adventurerDetailsView)
        adventurerDetailsView.addSubview(nameLabel)
        adventurerDetailsView.addSubview(descriptionLabel)
        adventurerDetailsView.addSubview(adventurerDetailsButton)
    }
    
    private func addConstraints() {
        addPhotoCardMenuConstraints()
        addDetailsViewConstraints()
        addNameLabelConstraints()
        addDescriptionLabelConstraints()
        addbtnNextConstraint()
    }
    
    private func addPhotoCardMenuConstraints() {
        let top = photoCardMenu.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50)
        let leading = photoCardMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailing = photoCardMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let height = photoCardMenu.heightAnchor.constraint(equalToConstant: 170)
        NSLayoutConstraint.activate([top, leading, trailing, height])
    }
    
    private func addDetailsViewConstraints() {
        let top = adventurerDetailsView.topAnchor.constraint(equalTo: photoCardMenu.bottomAnchor, constant: 50)
        let leading = adventurerDetailsView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20)
        let trailing = adventurerDetailsView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20)
        let bottom = adventurerDetailsView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -50)
        NSLayoutConstraint.activate([top, leading, trailing, bottom])
    }
    
    private func addNameLabelConstraints() {
        let top = nameLabel.topAnchor.constraint(equalTo: adventurerDetailsView.topAnchor, constant: 10)
        let leading = nameLabel.leadingAnchor.constraint(equalTo: adventurerDetailsView.leadingAnchor, constant: 20)
        let trailing = nameLabel.trailingAnchor.constraint(equalTo: adventurerDetailsView.trailingAnchor, constant: -20)
        NSLayoutConstraint.activate([top, leading, trailing])
    }
    
    private func addDescriptionLabelConstraints() {
        let top = descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20)
        let leading = descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
        let trailing = descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
        NSLayoutConstraint.activate([top, leading, trailing])
    }
    
    private func addbtnNextConstraint() {
        let top = adventurerDetailsButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 50)
        let width = adventurerDetailsButton.widthAnchor.constraint(equalToConstant: 200)
        let height = adventurerDetailsButton.heightAnchor.constraint(equalToConstant: 50)
        let xPosition = adventurerDetailsButton.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor, constant: 0)
        NSLayoutConstraint.activate([top, width, height, xPosition])
    }
    
    // MARK: - HomeDisplayLogic
    
    func displayPhotoCard(viewModel: Home.Model.PhotoCardViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.photoCardMenu.setup(cardButtons: viewModel.photoCardMenus)
        }
    }
    
    func displayDetails(viewModel: Home.Model.DetailsViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.nameLabel.text = viewModel.name
            self?.descriptionLabel.text = viewModel.description
        }
    }
    
    // MARK: - Button Actions
    
    @objc func didTapDetailsButton(_ sender: UIButton) {
        goToAdventurerDetails()
    }
    
    // MARK: - Routing
    
    private func goToAdventurerDetails() {
        router?.routeToAdventurerDetails()
    }
    
}

extension HomeViewController: PhotoCardMenuDelegate {
    func didTapButtonWith(_ id: Int) {
        interactor?.selectAdventurer(id: id)
    }
}
