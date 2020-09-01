//
//  ViewModelTests.swift
//  ChallengeTests
//
//  Created by Estelle Paus on 9/1/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import XCTest
@testable import Challenge

class ViewModelTests: XCTestCase {
    var viewModel: ViewModel!
    
    override func setUpWithError() throws {
        viewModel = ViewModel()
       
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_getNumberModels_convertsDTOsToNumberModels() throws {
        let name1 = "name1"
        let imageUrl1 = "imageUrl1"
        let dtoModel1 = DTOModel.init(name: name1, imageUrl: imageUrl1)
       
        let dtoArray = [dtoModel1]
        let numberModels = viewModel.testGetNumberModels(dtos: dtoArray)
        XCTAssertNotNil(numberModels)
        
        let newNumberModel = NumberModel(name:name1, imageUrl:imageUrl1)
        XCTAssertEqual(numberModels[0].name,newNumberModel.name)
        XCTAssertEqual(numberModels[0].imageUrl, newNumberModel.imageUrl)
    }
    
    func test_listCount_returnsNumberOfElementsInList() {
        let name1 = "name1"
        let imageUrl1 = "imageUrl1"
        let dtoModel1 = DTOModel.init(name: name1, imageUrl: imageUrl1)
        
        let name2 = "name2"
        let imageUrl2 = "imageUrl2"
        let dtoModel2 = DTOModel.init(name: name2, imageUrl: imageUrl2)
        
        let dtoArray = [dtoModel1, dtoModel2]
        let dtoArrayCount = dtoArray.count
        
        viewModel.list = viewModel.testGetNumberModels(dtos: dtoArray)
        XCTAssertEqual(viewModel.listCount(), dtoArrayCount)
    }

}
extension ViewModel {
    func testGetNumberModels(dtos:[DTOModel]) -> [NumberModel] {
        return self.getNumberModels(dtos: dtos)
    }
}

