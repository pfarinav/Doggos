//
//  DoggosDTOTest.swift
//  DoggosTests
//
//  Created by Patricio Fariña on 04-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import XCTest
@testable import Doggos

class DoggosDTOTest: XCTestCase {
    var dto: DoggoDTO?
    override func setUp() {
        super.setUp()
        dto = DoggoDTO()
    }
    
    override func tearDown() {
        super.tearDown()
        dto = nil
    }
    
    func testGetDoggosWithValidDataShouldReturnArrayOfDoggos() {
        let data = dataFromJsonFile(fileName: "DogList")
        dto?.data = data
        let list = dto?.getDoggos()
        XCTAssertEqual(list!.count, 3)
        XCTAssertEqual(list![0].name, "cairn")
        XCTAssertEqual(list![1].name, "bullterrier")
        XCTAssertEqual(list![2].name, "bulldog")
    }
    
    func testGetDoggosWithInvalidDataShouldReturnNil() {
        let data = dataFromJsonFile(fileName: "DogListInvalid")
        dto?.data = data
        let list = dto?.getDoggos()
        XCTAssertNil(list)
    }
    
    func testGetPhotosWithValidDataShouldReturnArrayOfURL() {
        let data = dataFromJsonFile(fileName: "DogPhotos")
        dto?.data = data
        let list = dto?.getPhotos()
        XCTAssertEqual(list!.count, 2)
        XCTAssertEqual(list![0], URL(string: "https://dog.ceo/api/img/hound-Ibizan/n02091244_100.jpg")!)
        XCTAssertEqual(list![1], URL(string: "https://dog.ceo/api/img/hound-Ibizan/n02091244_1000.jpg")!)
    }
    
    func testGetPhotosWithInvalidDataShouldReturnEmptyArray() {
        let data = dataFromJsonFile(fileName: "DogPhotosInvalid")
        dto?.data = data
        let list = dto?.getPhotos()
        XCTAssertEqual(list!, [])
    }
    
    func testGetPhotosWithInvalidUrlShouldReturnArrayOfUrlIgnoringInvalidUrl() {
        let data = dataFromJsonFile(fileName: "DogPhotosInvalidURL")
        dto?.data = data
        let list = dto?.getPhotos()
        XCTAssertEqual(list!.count, 1)
        XCTAssertEqual(list![0], URL(string: "https://dog.ceo/api/img/hound-Ibizan/n02091244_100.jpg")!)
    }
    
    private func dataFromJsonFile(fileName: String) -> Any {
        let bundle = Bundle(for: DoggosDTOTest.self)
        let path = bundle.path(forResource: fileName, ofType: "json")
        let data = NSData(contentsOfFile: path!)! as Data
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        return json
    }
}
