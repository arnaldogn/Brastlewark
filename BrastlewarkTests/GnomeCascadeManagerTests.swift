//
//  BrastlewarkTests.swift
//  BrastlewarkTests
//
//  Created by Arnaldo Gnesutta on 10/04/2018.
//  Copyright © 2018 Arnaldo Gnesutta. All rights reserved.
//

import XCTest
@testable import Brastlewark

class GnomeCascadeManagerTests: XCTestCase {
    
    var gnomeCascadeManager: GnomeCascadeManager!
    var fetchGnomesService =  FetchGnomesServiceMock()
    
    override func setUp() {
        super.setUp()
        gnomeCascadeManager = GnomeCascadeManager(fetchGnomesService: fetchGnomesService)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoadingGnomes() {
        gnomeCascadeManager.loadGnomes()
        XCTAssertEqual(gnomeCascadeManager.view.collectionView.numberOfItems(inSection: 1),1)
    }
}
