//
//  ViewController.swift
//  Brastlewark
//
//  Created by Arnaldo Gnesutta on 10/04/2018.
//  Copyright © 2018 Arnaldo Gnesutta. All rights reserved.
//

import UIKit
import MBProgressHUD

class MainViewController: UIViewController {
    
    let gnomesCascadeManager: GnomeCascadeManagerProtocol?

    init(fetchService: FetchGnomesServiceProtocol) {
        gnomesCascadeManager = GnomeCascadeManager(fetchGnomesService: fetchService)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Brastlewark"
        setupViews()
        gnomesCascadeManager?.loadGnomes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gnomesCascadeManager?.loadRecentGnomes()
    }
    
    private func setupViews() {
        edgesForExtendedLayout = []
        guard var gnomeCascadeManager = gnomesCascadeManager else { return }
        gnomeCascadeManager.delegate = self
        view.addSubviewsForAutolayout(gnomeCascadeManager.view)
        setupConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupConstraints() {
        guard let gnomeCascade = gnomesCascadeManager?.view else { return }
        let views = ["gnomeCascade": gnomeCascade]
        view.addConstraints(
            NSLayoutConstraint.constraints("H:|[gnomeCascade]|", views: views),
            NSLayoutConstraint.constraints("V:|[gnomeCascade]|", views: views))
    }
}

extension MainViewController: GnomeCascadeDelegate {
    func didSelectProfile(_ gnome: Gnome) {
        let itemDetailsVC = GnomeDetailsViewController(GnomeDataModel(gnome))
        navigationController?.pushViewController(itemDetailsVC, animated: true)
    }
}
