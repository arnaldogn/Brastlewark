//
//  ItemCell.swift
//  Brastlewark
//
//  Created by Arnaldo Gnesutta on 10/04/2018.
//  Copyright © 2018 Arnaldo Gnesutta. All rights reserved.
//

import UIKit
import SDWebImage

class GnomeCell: UICollectionViewCell {
    private let thumbnail: UIImageView = {
        let thumbnail = UIImageView()
        thumbnail.clipsToBounds = true
        thumbnail.contentMode = .scaleAspectFill
        thumbnail.layer.cornerRadius = 10
        return thumbnail
    }()
    private let name: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    private let age: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    private let nameBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        return view
    }()
    static let defaultIdentifier = "GnomeCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubviewsForAutolayout(thumbnail,nameBackground, name, age)
        setupConstraints()
    }

    private func setupConstraints() {
        let views: [String: Any] = ["thumbnail": thumbnail,
                                    "name": name,
                                    "age": age,
                                    "nameBackground": nameBackground]
                                    
        contentView.addConstraints(
            NSLayoutConstraint.constraints("H:|-0.5-[thumbnail]-0.5-|", views: views),
            NSLayoutConstraint.constraints("H:|-5-[name]-5-|", views: views),
            NSLayoutConstraint.constraints("H:|[nameBackground]|", views: views),
            NSLayoutConstraint.constraints("H:|-5-[age]-5-|", views: views),
            NSLayoutConstraint.constraints("V:|-0.5-[thumbnail]-0.5-|", views: views),
            NSLayoutConstraint.constraints("V:[nameBackground]|", views: views),
            NSLayoutConstraint.constraints("V:[name]-5-[age]-5-|", views: views))
        
        nameBackground.topAnchor.constraint(equalTo: name.topAnchor, constant: -5).isActive = true
    }
    func configure(with item: GnomeDataModel) {
        name.text = item.name
        age.text = item.age
        thumbnail.sd_addActivityIndicator()
        thumbnail.sd_setImage(with: item.thumbnail, placeholderImage: UIImage(named: "UserPlaceholder"), completed: nil)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnail.image = nil
    }
}

