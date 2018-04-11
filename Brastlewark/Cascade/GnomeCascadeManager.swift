//
//  GnomeManager.swift
//  Brastlewark
//
//  Created by Arnaldo Gnesutta on 11/04/2018.
//  Copyright © 2018 Arnaldo Gnesutta. All rights reserved.
//

import UIKit
import MBProgressHUD
import EasyRealm
import RealmSwift

protocol GnomeCascadeDelegate: class {
    func didSelectProfile(_ gnome: Gnome)
}

protocol GnomeCascadeManagerProtocol {
    var view: GnomeCascadeView { get }
    func loadGnomes()
    func loadRecentGnomes()
    var delegate: GnomeCascadeDelegate? { get set }
}

class GnomeCascadeManager: NSObject, GnomeCascadeManagerProtocol {
    var fullList = [Gnome]()
    private var recentList = [Gnome]()
    private let fetchGnomesService: FetchGnomesServiceProtocol
    internal let view = GnomeCascadeView(frame: .zero)
    weak var delegate: GnomeCascadeDelegate?
    private let realm = try! Realm()
    
    init(fetchGnomesService: FetchGnomesServiceProtocol) {
        self.fetchGnomesService = fetchGnomesService
        super.init()
        view.collectionView.delegate = self
        view.collectionView.dataSource = self
        view.collectionView.register(GnomeCell.self, forCellWithReuseIdentifier: GnomeCell.defaultIdentifier)
        view.collectionView.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: GnomeCascadeView.Constants.headerIdentifier)
    }
    
    internal func loadGnomes() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        fetchGnomesService.fetchGnomes { (items, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            guard error == nil, let items = items else { return }
            self.fullList = items
            self.loadRecentGnomes()
        }
    }
    
    private func saveGnome(_ gnome: Gnome) {
        if recentList.count >= 4, let lastGnome = recentList.last, let id = lastGnome.id {
            deleteGnome(id)
        }
        try? gnome.managedObject().er.save(update: true)
    }
    
    private func deleteGnome(_ id: Int) {
        guard let gnomeToDelete = loadGnome(id) else { return }
        try? realm.write {
            try? GnomeObject.er.all().realm?.delete(gnomeToDelete)
        }
    }
    
    private func loadGnome(_ id: Int) -> GnomeObject? {
        return try? GnomeObject.er.fromRealm(with: id)
    }
    
    internal func loadRecentGnomes() {
        guard let recentList = try? GnomeObject.er.all().sorted(byKeyPath: "date", ascending: false) else { return }
        self.recentList.removeAll()
        self.recentList = recentList.compactMap { Gnome(managedObject: $0) }
        refreshCollectionView()
    }
    
    private func refreshCollectionView() {
        self.fullList = self.fullList.filter { !self.recentList.contains($0) }
        self.view.collectionView.reloadData()
    }
    
    private func isRecentProfileSection(_ section: Int) -> Bool {
        return section == 0
    }
}

extension GnomeCascadeManager: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isRecentProfileSection(section) ? recentList.count : fullList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GnomeCell.defaultIdentifier, for: indexPath) as? GnomeCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: GnomeDataModel(isRecentProfileSection(indexPath.section) ? recentList[indexPath.row] : fullList[indexPath.row]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gnome = isRecentProfileSection(indexPath.section) ? recentList[indexPath.row] : fullList[indexPath.row]
        delegate?.didSelectProfile(gnome)
        saveGnome(gnome)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader, let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: GnomeCascadeView.Constants.headerIdentifier, for: indexPath) as? CollectionViewHeader {
            headerView.title = isRecentProfileSection(indexPath.section) ? "Recently viewed" : "Other profiles"
            return headerView
        }
        return UICollectionReusableView()
    }
}
