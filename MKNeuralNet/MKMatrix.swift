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
        return array[row * self.columns + column - 1]
    }
    
    func elementOperation(operation: Double -> Double) -> Matrix {
        
        var returnArray = [Double]()
        
        for number in array {
            returnArray.append(operation(number))
        }
        
        return Matrix.init(array: returnArray, rows: self.rows, columns: self.columns)
    }
    
    func transpose() -> Matrix {
        
        let newRows = self.columns
        let newColumns = self.rows
        
        var result = [Double]()
        
        for column in 0...columns {
            for row in 0...rows {
                result.append(self[column, row])
            }
        }
        
        return Matrix.init(array: result, rows: newRows, columns: newColumns)
    }
}

prefix func - (matrix: Matrix) -> Matrix {
    return Matrix.init(array: matrix.array.map{ -$0 }, rows: matrix.rows, columns: matrix.rows)
}

//This function multiplies an M-by-P matrix A by a P-by-N matrix B and stores the results in an M-by-N matrix C.
infix operator • { associativity left precedence 120}
func • (lhs: Matrix, rhs: Matrix) -> Matrix {
    
    assert(lhs.columns == rhs.rows)
    
    let m = lhs.rows
    let n = rhs.columns
    let p = lhs.columns
    
    var product = [Double]()
    
    vDSP_mmulD(lhs.array, 1, rhs.array, 1, &product, 1, UInt(m), UInt(n), UInt(p))
    
    return Matrix.init(array: product, rows: m, columns: n)
}

//Elementwise multiplication
func * (lhs: Matrix, rhs: Matrix) -> Matrix {
    assert(lhs.rows == rhs.rows && lhs.columns == rhs.columns)
    return Matrix.init(array: Array(zip(lhs.array, rhs.array)).map { $0 * $1 }, rows: lhs.rows, columns: lhs.columns)
}

//This function adds two M-by-N matrices
func + (lhs: Matrix, rhs: Matrix) -> Matrix {
    assert(lhs.rows == rhs.rows && lhs.columns == rhs.columns)
    return Matrix.init(array: Array(zip(lhs.array, rhs.array)).map { $0 + $1 }, rows: lhs.rows, columns: lhs.columns)
}

func - (lhs: Matrix, rhs: Matrix) -> Matrix {
    return lhs + (-rhs)
}
