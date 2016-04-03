//
//  testMatrix.swift
//  MKNeuralNet
//
//  Created by Morten Kals on 03/04/16.
//  Copyright © 2016 Morten Kals. All rights reserved.
//

import XCTest

class testMatrix: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
    //MARK: Test initializations
    
    func testRandomInit() {
        
        let empty = Matrix.init(rows: 0, columns: 0)
        XCTAssert(empty.rows == 0 && empty.columns == 0)
        
        let one = Matrix.init(rows: 1, columns: 1)
        let val = one[1,1]
        XCTAssert(one.rows == 1 && one.columns == 1 && val >= 0.0 && val <= 1.0)
        
    }
    
    func testInitFromArray() {
        
    }
    
    //MARK: Testing matrix operations
    
    func testMultiplication() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testElementMultiplication() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testAddition() {
        
    }
    
    func testSubstraciton() {
        
    }
    
    func testUnarySubtraction() {
        
    }

}
