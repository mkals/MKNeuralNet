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
        
        let one = Matrix.init(rows: 1, columns: 1)
        let val = one[1,1]
        XCTAssert(one.rows == 1 && one.columns == 1 && val >= 0.0 && val <= 1.0)
        
    }


    //MARK: Testing matrix operations
    
    func testTranspose() {
        let a = Matrix(rows: 1, columns: 1, array: [5])
        let at = Matrix(rows: 1, columns: 1, array: [5])
        
        XCTAssertEqual(a.transpose(), at)
        
        let b = Matrix(rows: 3, columns: 2, array: [1,2,3,4,5,6])
        let bt = Matrix(rows: 2, columns: 3, array: [1,3,5,2,4,6])
        
        XCTAssertEqual(b.transpose(), bt)
    }
    
    func testMultiplication() {
        
        //test one element
        let a = Matrix(rows: 1, columns: 1, array: [5])
        let b = Matrix(rows: 1, columns: 1, array: [2])
        let c = Matrix(rows: 1, columns: 1, array: [10])
        
        XCTAssertEqual(a * b, c)
        
        //test row/coumn vectors
        let d = Matrix(rows: 3, columns: 1, array: [1,2,3])
        let e = Matrix(rows: 1, columns: 3, array: [4,5,6])
        let f = Matrix(rows: 3, columns: 3, array: [4,5,6,6,10,12,12,15,18])
        let g = Matrix(rows:1, columns: 1, array: [32])
        
        XCTAssertEqual(d * e, f)
        XCTAssertEqual(e * d, g)
        
        //test full matrix
        let h = Matrix(rows: 3, columns: 1, array: [1,2,3])
        let i = Matrix(rows: 1, columns: 3, array: [4,5,6])
        let j = Matrix(rows: 3, columns: 3, array: [4,5,6,6,10,12,12,15,18])
        
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
