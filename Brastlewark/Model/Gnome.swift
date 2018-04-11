//
//  Item.swift
//  Brastlewark
//
//  Created by Arnaldo Gnesutta on 10/04/2018.
//  Copyright © 2018 Arnaldo Gnesutta. All rights reserved.
//

import ObjectMapper
import RealmSwift

struct Gnome {
    var id: Int?
    var name: String?
    var thumbnail: URL?
    var age: Int?
    var weight: Double?
    var height: Double?
    var hairColor: String?
    var professions: [String]?
    var friends: [String]?
}

extension Gnome: Equatable {
    static func == (lhs: Gnome, rhs: Gnome) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Gnome: Mappable {
    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        thumbnail <- (map["thumbnail"], URLTransform())
        age <- map["age"]
        weight <- map["weight"]
        height <- map["height"]
        hairColor <- map["hair_color"]
        professions <- map["professions"]
        friends <- map["friends"]
    }
}

final class RealmString: Object {
    @objc dynamic var value = ""
}

final public class GnomeObject: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var thumbnail = ""
    @objc dynamic var age = 0
    @objc dynamic var weight: Double = 0
    @objc dynamic var height: Double = 0
    @objc dynamic var hairColor = ""
    var professions = List<RealmString>()
    var friends = List<RealmString>()
    @objc dynamic var date = Date()
    
    override public static func primaryKey() -> String? {
        return "id"
    }
}

extension Gnome: Persistable {
    public init(managedObject: GnomeObject) {
        id = managedObject.id
        name = managedObject.name
        thumbnail = URL(string: managedObject.thumbnail)
        age = managedObject.age
        weight = managedObject.weight
        height = managedObject.height
        hairColor = managedObject.hairColor
        professions = managedObject.professions.compactMap { $0.value }
        friends = managedObject.friends.compactMap { $0.value }
    }
    
    public func managedObject() -> GnomeObject {
        let gnomeObject = GnomeObject()
        gnomeObject.id = id ?? 0
        gnomeObject.name = name ?? ""
        gnomeObject.thumbnail = thumbnail?.absoluteString ?? ""
        gnomeObject.age = age ?? 0
        gnomeObject.height = height ?? 0
        gnomeObject.weight = weight ?? 0
        gnomeObject.hairColor = hairColor ?? ""
        friends?.forEach { gnomeObject.friends.append(RealmString(value: [$0]))}
        professions?.forEach { gnomeObject.professions.append(RealmString(value: [$0]))}
        gnomeObject.date = Date()
        return gnomeObject
    }
}

