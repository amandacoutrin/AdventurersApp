//
//  PhotoCardMenu.swift
//  DevVenture
//
//  Created by Amanda Coutrin on 24/05/20.
//  Copyright © 2020 Amanda. All rights reserved.
//

import Foundation
import UIKit

protocol PhotoCardMenuDelegate: class {
    func didTapButtonWith(_ id: Int)
}

class PhotoCardMenu: UIView {
    
    // MARK: - Delegate
    
    weak var delegate: PhotoCardMenuDelegate?
    
    // MARK: - Model
    
    var cardButtons: [PhotoCardMenuModel.Button]? {
        didSet { collectionView.reloadData() }
    }
    
    // MARK: - Views
    
    internal lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0,
                                           left: 30,
                                           bottom: 0,
                                           right: 30)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 170)
        return layout
    }()
    
    internal lazy var collectionView: UICollectionView = {
        let collView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collView.translatesAutoresizingMaskIntoConstraints = false
        collView.backgroundColor = .clear
        collView.showsVerticalScrollIndicator = false
        collView.showsHorizontalScrollIndicator = false
        collView.delegate = self
        collView.dataSource = self
        collView.register(PhotoCardMenuCell.self, forCellWithReuseIdentifier: PhotoCardMenuCell.identifier)
        return collView
    }()
    
    // MARK: - View Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        addComponents()
        addCollectionViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Subviews & Constraints
    
    private func addComponents() {
        addSubview(collectionView)
    }
    
    private func addCollectionViewConstraints() {
        let top = collectionView.topAnchor.constraint(equalTo: topAnchor)
        let leading = collectionView.leadingAnchor.constraint(equalTo: leadingAnchor)
        let width = collectionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        let height = collectionView.heightAnchor.constraint(equalToConstant: 170)
        NSLayoutConstraint.activate([top, leading, width, height])
    }
    
    // MARK: - Functions
    
    func setup(cardButtons: [PhotoCardMenuModel.Button]) {
        self.cardButtons = cardButtons
    }
    
}

extension PhotoCardMenu: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardButtons?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCardMenuCell.identifier, for: indexPath) as? PhotoCardMenuCell,
            let buttons = cardButtons,
            buttons.indices.contains(indexPath.row)
            else { return UICollectionViewCell() }
        let model = buttons[indexPath.row]
        cell.setup(model: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let  buttons = cardButtons,
            buttons.indices.contains(indexPath.row) else { return }
        let id = buttons[indexPath.row].id
        delegate?.didTapButtonWith(id)
    }
}
