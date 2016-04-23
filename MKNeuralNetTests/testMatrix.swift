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
    
    //large matrices for performance testing on square matrices
    let squareOne = Matrix.init(rows: 500, columns: 500, functionToGenerateNumbers: drand48)
    let squareTwo = Matrix.init(rows: 500, columns: 500, functionToGenerateNumbers: drand48)
    
    func testRandomInit() {
        
        let one = Matrix.init(rows: 1, columns: 1, functionToGenerateNumbers: drand48)
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
        
        self.measureBlock { 
            self.squareOne.transpose()
        }
    }
    
    func testMultiplication() {
        
        //test one element
        let a = Matrix(rows: 1, columns: 1, array: [5.0])
        let b = Matrix(rows: 1, columns: 1, array: [2.0])
        let c = Matrix(rows: 1, columns: 1, array: [10.0])
        
        XCTAssertEqual(a • b, c)
        
        //test row/coumn vectors
        let d = Matrix(rows: 3, columns: 1, array: [1.0,2,3])
        let e = Matrix(rows: 1, columns: 3, array: [4.0,5,6])
        let f = Matrix(rows: 3, columns: 3, array: [4.0,5,6,8,10,12,12,15,18])
        let g = Matrix(rows: 1, columns: 1, array: [32.0])
        
        XCTAssertEqual(d • e, f)
        XCTAssertEqual(e • d, g)
        
        //test full matrix
        let h = Matrix(rows: 3, columns: 3, array: [1.0,2,3,4,5,6,7,8,9])
        let i = Matrix(rows: 3, columns: 3, array: [4.0,5,6,7,8,9,10,11,12])
        let j = Matrix(rows: 3, columns: 3, array: [48.0,54,60,111,126,141,174,198,222])
        
        XCTAssertEqual(h • i, j)
        
        self.measureBlock { 
            self.squareOne • self.squareTwo
        }
        
    }

    func testElementMultiplication() {
        // This is an example of a performance test case.
        
        //test one element
        let a = Matrix(rows: 1, columns: 1, array: [5.0])
        let b = Matrix(rows: 1, columns: 1, array: [2.0])
        let c = Matrix(rows: 1, columns: 1, array: [10.0])
        
        XCTAssertEqual(a * b, c)
        
        //test row/coumn vectors
        let d = Matrix(rows: 3, columns: 1, array: [1.0,2,3])
        let e = Matrix(rows: 3, columns: 1, array: [4.0,5,6])
        let f = Matrix(rows: 3, columns: 1, array: [4.0,10,18])
        
        XCTAssertEqual(d * e, f)
        
        //test full matrix
        let g = Matrix(rows: 3, columns: 3, array: [1.0,2,3,4,5,6,7,8,9])
        let h = Matrix(rows: 3, columns: 3, array: [4.0,5,6,7,8,9,10,11,12])
        let i = Matrix(rows: 3, columns: 3, array: [4.0,10,18,28,40,54,70,88,108])
        
        XCTAssertEqual(g * h, i)
        
        //test performance
        self.measureBlock {
            self.squareOne * self.squareTwo
        }
    }
    
    func testAddition() {
        //test one element
        let a = Matrix(rows: 1, columns: 1, array: [5.0])
        let b = Matrix(rows: 1, columns: 1, array: [2.0])
        let c = Matrix(rows: 1, columns: 1, array: [7.0])
        
        XCTAssertEqual(a + b, c)
        
        //test row/coumn vectors
        let d = Matrix(rows: 3, columns: 1, array: [1.0,2,3])
        let e = Matrix(rows: 3, columns: 1, array: [4.0,5,6])
        let f = Matrix(rows: 3, columns: 1, array: [5.0,7,9])
        
        XCTAssertEqual(d + e, f)
        
        //test full matrix
        let g = Matrix(rows: 3, columns: 3, array: [1.0,2,3,4,5,6,7,8,9])
        let h = Matrix(rows: 3, columns: 3, array: [4.0,5,6,7,8,9,10,11,12])
        let i = Matrix(rows: 3, columns: 3, array: [5.0,7,9,11,13,15,17,19,21])
        
        XCTAssertEqual(g + h, i)
    }
    
    func testSubstraciton() {
        //test one element
        let a = Matrix(rows: 1, columns: 1, array: [5.0])
        let b = Matrix(rows: 1, columns: 1, array: [2.0])
        let c = Matrix(rows: 1, columns: 1, array: [3.0])
        
        XCTAssertEqual(a - b, c)
        
        //test row/coumn vectors
        let d = Matrix(rows: 3, columns: 1, array: [1.0,2,3])
        let e = Matrix(rows: 3, columns: 1, array: [4.0,5,6])
        let f = Matrix(rows: 3, columns: 1, array: [3.0,3,3])
        
        XCTAssertEqual(d - e, f)
        
        //test full matrix
        let g = Matrix(rows: 3, columns: 3, array: [1.0,2,3,4,5,6,7,8,9])
        let h = Matrix(rows: 3, columns: 3, array: [4.0,5,6,7,8,9,9,9,9])
        let i = Matrix(rows: 3, columns: 3, array: [3.0,3,3,3,3,3,2,1,0])
        
        XCTAssertEqual(g - h, i)
    }
    
    func testUnarySubtraction() {
        
    }

}
