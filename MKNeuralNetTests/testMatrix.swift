//
//  testMatrix.swift
//  MKNeuralNet
//
//  Created by Morten Kals on 03/04/16.
//  Copyright © 2016 Morten Kals. All rights reserved.
//

import XCTest

protocol matrixTestSet {
    var a: Matrix {get}
    var b: Matrix {get}
    
    var mult: Matrix {get}
    var elMult: Matrix {get}
    var addi: Matrix {get}
    var subt: Matrix {get}
    
    var uNegA: Matrix {get}
    var tranA: Matrix {get}
    var tranB: Matrix {get}
}

class testMatrix: XCTestCase {
    
    struct oneElement: matrixTestSet {
        let a = Matrix.init(array: [5], rows: 1, columns: 1)
        let b = Matrix.init(array: [2], rows: 2, columns: 2)
        
        let mult = Matrix.init(array: [10], rows: 1, columns: 1)
        let elMult = Matrix.init(array: [10], rows: 1, columns: 1)
        let addi = Matrix.init(array: [7], rows: 1, columns: 1)
        let subt = Matrix.init(array: [3], rows: 1, columns: 1)
        
        let uNegA = Matrix.init(array: [-5], rows: 1, columns: 1)
        let tranA = Matrix.init(array: [5], rows: 1, columns: 1)
        let tranB = Matrix.init(array: [2], rows: 1, columns: 1)
    }
    
    struct oneRowOrColumn: matrixTestSet {
        let a = Matrix.init(array: [1,2,3], rows: 3, columns: 1)
        let b = Matrix.init(array: [4,5,6], rows: 1, columns: 3)
        
        let mult = Matrix.init(array: [10], rows: 1, columns: 1)
        let elMult = Matrix.init(array: [10], rows: 1, columns: 1)
        let addi = Matrix.init(array: [7], rows: 1, columns: 1)
        let subt = Matrix.init(array: [3], rows: 1, columns: 1)
        
        let uNegA = Matrix.init(array: [-5], rows: 1, columns: 1)
        let tranA = Matrix.init(array: [5], rows: 1, columns: 1)
        let tranB = Matrix.init(array: [2], rows: 1, columns: 1)
    }
    
    
    
    
    
    
    let matrix1 = Matrix.init(array: [5], rows: 1, columns: 1)
    let matrix2 = Matrix.init(array: [2], rows: 1, columns: 1)
    let matrix3 = Matrix.init(array: [3], rows: 1, columns: 1)
    
    let matrix4 = Matrix.init(array: [1,2,3], rows: 3, columns: 1)
    let matrix5 = Matrix.init(array: [1,2,3], rows: 1, columns: 3)
    let matrix6 = Matrix.init(array: [4,5,6], rows: 3, columns: 1)
    let matrix7 = Matrix.init(array: [4,5,6], rows: 1, columns: 3)
    let matrix8 = Matrix.init(array: [4,5,6,8,10,12,12,15,18], rows: 3, columns: 3)
    let matrix9 = Matrix.init(array: [32], rows: 1, columns: 1)
    
    let matrix10 = Matrix.init(array: [3,5,1,0,2,4,3,3,2,4,7,1], rows: 3, columns: 4)
    
    func matrixTestSetTesting(set: matrixTestSet) {
        
        XCTAssertEqual(set.mult, set.a * set.b)
        XCTAssertEqual(set.elMult, set.a • set.b)
        XCTAssertEqual(set.addi, set.a + set.b)
        XCTAssertEqual(set.subt, set.a - set.b)
        
        XCTAssertEqual(set.uNegA, -set.a)
        XCTAssertEqual(set.tranA, set.a.transpose())
        XCTAssertEqual(set.tranB, set.b.transpose())
    }
    
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
            let _ = Matrix.init(rows: 1000, columns: 1000) * Matrix.init(rows: 1000, columns: 1000)
        }
    }
    
    func testAddition() {
        
    }
    
    func testSubstraciton() {
        
    }
    
    func testUnarySubtraction() {
        
    }

}
