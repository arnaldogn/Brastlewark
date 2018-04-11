//
//  ItemViewModel.swift
//  Brastlewark
//
//  Created by Arnaldo Gnesutta on 10/04/2018.
//  Copyright © 2018 Arnaldo Gnesutta. All rights reserved.
//

import Foundation

class GnomeDataModel: NSObject {
    let gnome: Gnome

    init(_ gnome: Gnome) {
        self.gnome = gnome
    }
    var thumbnail: URL? {
        return gnome.thumbnail
    }
    var name: String {
        return gnome.name ?? ""
    }
    var age: String {
        guard let age = gnome.age else { return "" }
        return String(age)
    }
    var height: String {
        guard let height = gnome.height else { return "" }
        return String(format: "%.0f", height)
    }
    var weight: String {
        guard let weight = gnome.weight else { return "" }
        return String(format: "%.0f", weight)
    }
    var hairColor: String {
        guard let hairColor = gnome.hairColor else { return "" }
        return hairColor
    }
    var professions: String {
        guard let professions = gnome.professions else { return "" }
        return professions.joined(separator: ", ")
    }
    var friends: String {
        guard let friends = gnome.friends else { return "" }
        return friends.joined(separator: ", ")
    }
}
