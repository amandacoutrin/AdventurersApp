//
//  AdventurerDetailsView.swift
//  DevVenture
//
//  Created by Amanda Coutrin on 25/05/20.
//  Copyright © 2020 Amanda. All rights reserved.
//

import Foundation
import UIKit

class AdventurerDetailsView: UIView {
    
    // MARK: - Views
    
    private lazy var detailsView: UIView = {
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
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14)
        label.text = "test"
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8893675086)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var adventurerDetailsButton: CustomButton = {
        let btn = CustomButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Details", for: .normal)
        //        btn.addTarget(self, action: #selector(didTapDetailsButton), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Cell LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addComponents()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: CGRect.zero)
    }
    
    // MARK: - Constraints
    
    private func addComponents() {
        addSubview(detailsView)
//        infoView.addSubview(nameLabel)
//        infoView.addSubview(adventurerDetailsButton)
    }
    
    private func addConstraints() {
        addDetailsViewConstraints()
//        addInfoLabelConstraints()
//        addbtnNextConstraint()
    }
    
    private func addDetailsViewConstraints() {
        let top = detailsView.topAnchor.constraint(equalTo: topAnchor)
        let xPosition = detailsView.centerXAnchor.constraint(equalTo: centerXAnchor)
        let width = detailsView.widthAnchor.constraint(equalToConstant: 150)
        let height = detailsView.heightAnchor.constraint(equalToConstant: 150)
        NSLayoutConstraint.activate([top, xPosition, width, height])
    }
    
    private func addInfoLabelConstraints() {
        let top = nameLabel.topAnchor.constraint(equalTo: detailsView.bottomAnchor, constant: 10)
        let leading = nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailing = nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        NSLayoutConstraint.activate([top, leading, trailing])
    }
    
    private func addbtnNextConstraint() {
        let top = adventurerDetailsButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 50)
        let width = adventurerDetailsButton.widthAnchor.constraint(equalToConstant: 200)
        let height = adventurerDetailsButton.heightAnchor.constraint(equalToConstant: 50)
        let xPosition = adventurerDetailsButton.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor, constant: 0)
        NSLayoutConstraint.activate([top, width, height, xPosition])
    }
    
    // MARK: - setup View
    
    func setup(model: Home.Model.Adventurer) {
        nameLabel.text = model.name
    }
}
