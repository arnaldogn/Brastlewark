//
//  FetchItemsService.swift
//  Brastlewark
//
//  Created by Arnaldo Gnesutta on 10/04/2018.
//  Copyright © 2018 Arnaldo Gnesutta. All rights reserved.
//

import AlamofireObjectMapper
import Alamofire

protocol FetchGnomesServiceProtocol {
    func fetchGnomes(onCompletion: @escaping ([Gnome]?, Error?) -> Void)
}

struct FetchGnomesService: FetchGnomesServiceProtocol {

    func fetchGnomes(onCompletion: @escaping ([Gnome]?, Error?) -> Void) {
        Alamofire.request(GnomeAPI.baseURL).responseArray(keyPath: GnomeAPI.listKeyPath) { (response: DataResponse<[Gnome]>) in
            guard let itemList = response.result.value else { return onCompletion(nil, response.error) }
            return onCompletion(itemList, nil)
            
        }
    }
}
