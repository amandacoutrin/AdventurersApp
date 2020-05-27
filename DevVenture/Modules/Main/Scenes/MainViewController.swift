//
//  MainViewController.swift
//  DevVenture
//
//  Created by Amanda Coutrin on 23/05/20.
//  Copyright (c) 2020 Amanda. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: Archtecture Objects
    
    var router: (NSObjectProtocol & MainViewRoutingLogic)?
    
    
    // MARK: - Views
    
    private lazy var safeArea: UILayoutGuide = {
        return view.layoutMarginsGuide
    }()
    
    private lazy var backagroudImage: UIImageView = {
        let imageName = "background.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var launchScreenImage: UIImageView = {
        let imageName = "devVenture.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - View Constants
    
    // XPosition
    let kXPosition: CGFloat = 0
    let kYPosition: CGFloat = 0
    
    
    // MARK: ViewController lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let router = MainViewRouter()
        
        viewController.router = router
        router.viewController = viewController
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UIView.animate(withDuration: 2.0, animations: {
            self.launchScreenImage.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }, completion: { _ in
            UIView.animate(withDuration: 2.0, animations: {
                self.launchScreenImage.alpha = 0.1
            }, completion: { [weak self] _ in
                self?.goToHome()
            })
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Private Functions
    
    private func setupView() {
        addComponentsInView()
        addComponentsConstraint()
    }
    private func addComponentsInView() {
        view.addSubview(backagroudImage)
        view.addSubview(launchScreenImage)
    }
    
    private func addComponentsConstraint() {
        addBackgroundImageConstraint()
        addLaunchScreenImageConstraint()
    }
    
    private func addBackgroundImageConstraint() {
        let top = backagroudImage.topAnchor.constraint(equalTo: backagroudImage.superview!.topAnchor)
        let leading = backagroudImage.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor)
        let trailing = backagroudImage.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        let bottom = backagroudImage.bottomAnchor.constraint(equalTo: backagroudImage.superview!.bottomAnchor)
        NSLayoutConstraint.activate([top, leading, trailing, bottom])
        
    }
    
    private func addLaunchScreenImageConstraint() {
        let xPosition = launchScreenImage.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: kXPosition)
        let yPosition = launchScreenImage.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor, constant: kYPosition)
        let height = launchScreenImage.heightAnchor.constraint(equalToConstant: 128)
        let width = launchScreenImage.widthAnchor.constraint(equalToConstant: 180)
        NSLayoutConstraint.activate([xPosition, yPosition, height, width])
    }
    
    // MARK: Routing
    
    private func goToHome() {
        router?.routeToHome()
    }
    
}
