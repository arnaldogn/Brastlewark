//
//  ItemDetailViewController.swift
//  Brastlewark
//
//  Created by Arnaldo Gnesutta on 10/04/2018.
//  Copyright © 2018 Arnaldo Gnesutta. All rights reserved.
//

import UIKit

class GnomeDetailsViewController: UIViewController {
    private var gnome: GnomeDataModel
    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let name: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    private let age: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    private let aboutMeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "About me"
        label.textAlignment = .left
        return label
    }()
    private let weight: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    private let height: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    private let hairColor: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    private let professionsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Professions"
        label.textAlignment = .left
        return label
    }()
    private let professions: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    private let friendsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Friends"
        label.textAlignment = .left
        return label
    }()
    private let friends: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    private let detailsBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        return view
    }()
    
    init(_ item: GnomeDataModel) {
        self.gnome = item
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.addSubviewsForAutolayout(image,detailsBackground, name, age,aboutMeLabel, weight, height, hairColor, professionsLabel, professions, friendsLabel, friends)
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        edgesForExtendedLayout = []
        view.backgroundColor = .black
        
        name.text = gnome.name
        age.text = gnome.age
        height.text = "Height: \(gnome.height) ft"
        weight.text = "Weight: \(gnome.weight) lbs"
        hairColor.text = "Hair Color: \(gnome.hairColor)"
        professions.text = gnome.professions
        friends.text = gnome.friends
        image.sd_addActivityIndicator()
        image.sd_setImage(with: gnome.thumbnail, placeholderImage: UIImage(named: "UserPlaceholder"), completed: nil)
    }

    private func setupConstraints() {
        let views: [String : Any] = ["image": image,
                                     "detailsBackground": detailsBackground,
                                     "name": name,
                                     "age": age,
                                     "aboutMeLabel": aboutMeLabel,
                                     "height": height,
                                     "weight": weight,
                                     "hairColor": hairColor,
                                     "professionsLabel": professionsLabel,
                                     "professions": professions,
                                     "friendsLabel": friendsLabel,
                                     "friends": friends]
        
        view.addConstraints(NSLayoutConstraint.constraints("H:|[image]|", views: views),
                            NSLayoutConstraint.constraints("H:|[detailsBackground]|", views: views),
                            NSLayoutConstraint.constraints("H:|-30-[name]-30-|", views: views),
                            NSLayoutConstraint.constraints("H:|-30-[age]-30-|", views: views),
                            NSLayoutConstraint.constraints("H:|-15-[aboutMeLabel]-30-|", views: views),
                            NSLayoutConstraint.constraints("H:|-30-[height]-30-|", views: views),
                            NSLayoutConstraint.constraints("H:|-30-[weight]-30-|", views: views),
                            NSLayoutConstraint.constraints("H:|-30-[hairColor]-30-|", views: views),
                            NSLayoutConstraint.constraints("H:|-15-[professionsLabel]-30-|", views: views),
                            NSLayoutConstraint.constraints("H:|-30-[professions]-30-|", views: views),
                            NSLayoutConstraint.constraints("H:|-15-[friendsLabel]-30-|", views: views),
                            NSLayoutConstraint.constraints("H:|-30-[friends]-30-|", views: views),
                            NSLayoutConstraint.constraints("V:|[image][detailsBackground]", views: views),
                            NSLayoutConstraint.constraints( "V:|[image]-20-[name]-5-[age]-50-[aboutMeLabel]-5-[height][weight][hairColor]-30-[professionsLabel]-5-[professions]-30-[friendsLabel]-5-[friends]", views: views))
        image.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/5).isActive = true
        detailsBackground.bottomAnchor.constraint(equalTo: age.bottomAnchor, constant: 20).isActive = true
    }
}
