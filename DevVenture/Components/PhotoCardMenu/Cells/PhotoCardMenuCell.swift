//
//  PhotoCardMenuCell.swift
//  DevVenture
//
//  Created by Amanda Coutrin on 24/05/20.
//  Copyright © 2020 Amanda. All rights reserved.
//

import Foundation
import UIKit

class PhotoCardMenuCell: UICollectionViewCell {
    static let identifier = String(describing: PhotoCardMenuCell.self)
    
    // MARK: - Views
    
    private lazy var photo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "developerAvatar")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = kImageSize/2
        imageView.layer.borderColor = .none
        imageView.backgroundColor = .white
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Layout Constants
    
    let kImageSize: CGFloat = 150
    
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
        addSubview(photo)
        addSubview(nameLabel)
    }
    
    private func addConstraints() {
        addPhotoConstraints()
        addNameLabelConstraints()
    }
    
    private func addPhotoConstraints() {
        let top = photo.topAnchor.constraint(equalTo: topAnchor)
        let xPosition = photo.centerXAnchor.constraint(equalTo: centerXAnchor)
        let width = photo.widthAnchor.constraint(equalToConstant: kImageSize)
        let height = photo.heightAnchor.constraint(equalToConstant: kImageSize)
        NSLayoutConstraint.activate([top, xPosition, width, height])
    }
    
    private func addNameLabelConstraints() {
        let top = nameLabel.topAnchor.constraint(equalTo: photo.bottomAnchor)
        let leading = nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailing = nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        let bottom = nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([top, leading, trailing, bottom])
    }
    
    // MARK: - setup cell
    
    func setup(model: PhotoCardMenuModel.Button) {
        nameLabel.text = model.name
        let image = UIImage(named: model.photoName ?? "") ?? UIImage(named: "developerAvatar")
        photo.image = image
    }
}
