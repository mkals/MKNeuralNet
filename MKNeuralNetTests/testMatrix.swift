//
//  testMatrix.swift
//  MKNeuralNet
//
//  Created by Morten Kals on 03/04/16.
//  Copyright © 2016 Morten Kals. All rights reserved.
//

import XCTest

    //MARK: Test initializations

class testMatrix: XCTestCase {
    
    func testRandomInit() {
        
        let empty = Matrix.init(rows: 0, columns: 0, )
        XCTAssert(empty.rows == 0 && empty.columns == 0)
        
        let one = Matrix.init(rows: 1, columns: 1)
        let val = one[1,1]
        XCTAssert(one.rows == 1 && one.columns == 1 && val >= 0.0 && val <= 1.0)
        
    }


    //MARK: Testing matrix operations
    
    func testTranspose() {
        let a = Matrix(array: [5], rows: 1, columns: 1)
        let at = Matrix(array: [5], rows: 1, columns: 1)
        
        XCTAssertEqual(a.transpose(), at)
        
        let b = Matrix(array: [1,2,3,4,5,6], rows: 3, columns: 2)
        let bt = Matrix(array: [1,3,5,2,4,6], rows: 2, columns: 3)
        
        XCTAssertEqual(b.transpose(), bt)
    }
    
    func testMultiplication() {
        
        //test one element
        let a = Matrix(array: [5], rows: 1, columns: 1)
        let b = Matrix(array: [2], rows: 1, columns: 1)
        let c = Matrix(array: [10], rows: 1, columns: 1)
        
        XCTAssertEqual(a * b, c)
        
        //test row/coumn vectors
        let d = Matrix(array: [1,2,3], rows: 3, columns: 1)
        let e = Matrix(array: [4,5,6], rows: 1, columns: 3)
        let f = Matrix(array: [4,5,6,6,10,12,12,15,18], rows: 3, columns: 3)
        let g = Matrix(array: [32], rows:1, columns: 1)
        
        XCTAssertEqual(d * e, f)
        XCTAssertEqual(e * d, g)
        
        //test full matrix
        
        //test row/coumn vectors
        let h = Matrix(array: [1,2,3], rows: 3, columns: 1)
        let i = Matrix(array: [4,5,6], rows: 1, columns: 3)
        let j = Matrix(array: [4,5,6,6,10,12,12,15,18], rows: 3, columns: 3)
        
        XCTAssertEqual(h * i, j)
        
        
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
