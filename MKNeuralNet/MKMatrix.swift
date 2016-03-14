//
//  MKMatrix.swift
//  MKNeuralNet
//
//  Created by Marie Kals on 03.03.2016.
//  Copyright © 2016 no.kals.m. All rights reserved.
//

import Foundation
import Accelerate

struct Matrix {
    
    private var array: [Double]
    
    let rows: Int
    let columns: Int
    
    
    init (array: [Double], rows: Int, columns: Int) {
        
        assert(array.count == rows * columns)
        
        self.array = array
        
        self.rows = rows
        self.columns = columns
    }
 
    //init with random numbers between 0 and 1
    init (rows: Int, columns: Int) {
        
        self.array = [Double]()
        
        for _ in 0 ... rows * columns {
            self.array.append(drand48())
        }
        
        self.rows = rows
        self.columns = columns
    }
    
    subscript (row: Int, column: Int) -> Double {
        return array[row * self.columns + column]
    }
    
    func elementOperation(operation: Double -> Double) -> Matrix {
        
        var returnArray = [Double]()
        
        for number in array {
            returnArray.append(operation(number))
        }
        
        return Matrix.init(array: returnArray, rows: self.rows, columns: self.columns)
    }
}


//This function multiplies an M-by-P matrix A by a P-by-N matrix B and stores the results in an M-by-N matrix C.

func * (lhs: Matrix, rhs: Matrix) -> Matrix {
    
    assert(lhs.columns == rhs.rows)
    
    let m = lhs.rows
    let n = rhs.columns
    let p = lhs.columns
    
    var product = [Double]()
    
    vDSP_mmulD(lhs.array, 1, rhs.array, 1, &product, 1, UInt(m), UInt(n), UInt(p))
    
    return Matrix.init(array: product, rows: m, columns: n)
}

//This function adds two M-by-N matrices

func + (lhs: Matrix, rhs: Matrix) -> Matrix {
    
    assert(lhs.rows == rhs.rows && lhs.columns == rhs.columns)

    // FIXME:
    return lhs
}
