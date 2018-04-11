//
//  CollectionViewHeader.swift
//  Brastlewark
//
//  Created by Arnaldo Gnesutta on 11/04/2018.
//  Copyright © 2018 Arnaldo Gnesutta. All rights reserved.
//

import UIKit

class CollectionViewHeader: UICollectionReusableView {
    var title: String? {
        didSet {
            label.text = title
        }
    }
    private lazy var label: UILabel = {
        let label = UILabel(frame: frame)
        label.textColor = .white
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setupViews()
    }
    private func setupViews() {
        frame = CGRect(x: 10, y: 0, width: bounds.width - 10, height: 50)
        addSubview(label)
    }
}
