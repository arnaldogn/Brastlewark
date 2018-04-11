//
//  FetchGnomesServiceMock.swift
//  BrastlewarkTests
//
//  Created by Arnaldo Gnesutta on 11/04/2018.
//  Copyright © 2018 Arnaldo Gnesutta. All rights reserved.
//

import Foundation
@testable import Brastlewark

struct FetchGnomesServiceMock: FetchGnomesServiceProtocol {
    let fakeGnomesArray = [Gnome(id: 200000, name: "Arnaldo", thumbnail: nil, age: 34, weight: 70, height: 190, hairColor: "blue", professions: ["Systems Engineer"], friends: ["Sofi"])]
    
    func fetchGnomes(onCompletion: @escaping ([Gnome]?, Error?) -> Void) {
        return onCompletion(fakeGnomesArray, nil)
    }
}


