//
//  GnomeCascadeView.swift
//  Brastlewark
//
//  Created by Arnaldo Gnesutta on 11/04/2018.
//  Copyright © 2018 Arnaldo Gnesutta. All rights reserved.
//

import UIKit

class GnomeCascadeView: UIView {
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 0
        let width = UIScreen.main.bounds.width
        layout.headerReferenceSize = CGSize(width: width, height: 50)
        let itemWidth = width/CGFloat(Constants.numberOfProfilesPerLine)
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    enum Constants {
        static let headerIdentifier = "GnomeCascadeHeader"
        static let numberOfProfilesPerLine = 2
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubviewsForAutolayout(collectionView)
        setupConstraints()
    }
    
    func setupConstraints() {
        let views = ["collectionView": collectionView]
        addConstraints(
            NSLayoutConstraint.constraints("H:|[collectionView]|", views: views),
            NSLayoutConstraint.constraints("V:|[collectionView]|", views: views))
    }
}
