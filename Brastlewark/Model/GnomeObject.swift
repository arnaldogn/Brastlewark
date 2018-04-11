////
////  GnomeObject.swift
////  Brastlewark
////
////  Created by Arnaldo Gnesutta on 10/04/2018.
////  Copyright © 2018 Arnaldo Gnesutta. All rights reserved.
////
//
//import Foundation
//import RealmSwift
//
////final public class CityForecastObject: Object {
////    @objc dynamic var id = 0
////    @objc dynamic var name = ""
////    @objc dynamic var date = Date()
////
////    override public static func primaryKey() -> String? {
////        return "id"
////    }
////}
//
////extension CityForecast: Persistable {
////    public init(managedObject: CityForecastObject) {
////        id = managedObject.id
////        name = managedObject.name
////        date = managedObject.date
////    }
////
////    public func managedObject() -> CityForecastObject {
////        let cityForecastObject = CityForecastObject()
////        cityForecastObject.id = id ?? 0
////        cityForecastObject.name = name ?? ""
////        cityForecastObject.date = date ?? Date()
////        return cityForecastObject
////    }
////}
//
//final public class GnomeObject: Object {
//    @objc dynamic var id = 0
//    @objc dynamic var name = ""
////    @objc dynamic var date = Date()
//
////    override public static func primaryKey() -> String? {
////        return "id"
////    }
//}
//
//extension Gnome: Persistable {
//    public init(managedObject: GnomeObject) {
//        id = managedObject.id
//        name = managedObject.name
//
//    }
//
//    public func managedObject() -> GnomeObject {
//        let gnomeObject = GnomeObject()
//        gnomeObject.id = id ?? 0
//        gnomeObject.name = name ?? ""
////        gnomeObject.date = Date()
//        return gnomeObject
//    }
//}
