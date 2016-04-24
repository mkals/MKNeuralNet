//
//  MKMatrix.swift
//  MKNeuralNet
//
//  Created by Marie Kals on 03.03.2016.
//  Copyright © 2016 no.kals.m. All rights reserved.
//

import Foundation
import Accelerate

struct Matrix : Equatable {
    
    /**
     array to store matrix values: row one first, then row two etc.
     */
    private let array: [Double]
    
    let rows: Int
    let columns: Int
    
    var size: Int {
        get {
            return self.rows * self.columns
        }
    }
    
    /**
     Initializes new matrix with given number of rows and columns and containing provided values
     - Parameters:
        - rows: number of rows that the matrix is to have
        - columns: number of columns that the matrix is to have
        - array: array containing elements to be placed into array, starting with row one, then row two etc.
     - Precondition: rows * columns = array.count, rows and columns must exceed 0
     - Returns: matrix with privided size and values
     */
    init (rows: Int, columns: Int, array: [Double]) {
        
        assert(array.count == rows * columns)
        
        self.array = array
        
        self.rows = rows
        self.columns = columns
    }
 
    /**
     Initializes new matrix with given number of rows and columns and providing numbers generated by passed function
     - Parameters:
        - rows: number of rows that the matrix is to have
        - columns: number of columns that the matrix is to have
        - functionToGenerateNumbers: function that returns a number to be placed in the matrix, starting with row one, then row two etc.
     - Precondition: rows and columns must exceed 0
     - Returns: matrix with provided size and values
     */
    init (rows: Int, columns: Int, functionToGenerateNumbers: () -> Double) {
        
        var genArray = [Double]()
        
        for _ in 1 ... rows * columns {
            genArray.append(functionToGenerateNumbers())
        }
        
        self.array = genArray
        self.rows = rows
        self.columns = columns
    }
    
    /**
     Accesses elements of matrix
     - Parameters:
        - row: row index
        - column: column index
     - Precondition: row and column must exceed 0 and not be larger than total number of rows and columns respectivley
     - Returns: number stored at spesifyed location
     */
    subscript (row: Int, column: Int) -> Double {
        return array[ (row - 1) * self.columns + (column - 1) ] //-1 as first index of matrix is 1,1 and first index of array is 0
    }
    
    /**
     Elementwise operation on all numbers in matrix. Performs the function on all elements in the matrix and resturns .
     - Parameters:
        - operation: function to be performed on all elements of matrix
     - Returns: result as a new matrix
     */
    func performElementOperation(operation: Double -> Double) -> Matrix {
        
        var returnArray = [Double]()
        
        for number in array {
            returnArray.append(operation(number))
        }
        
        return Matrix.init(rows: self.rows, columns: self.columns, array: returnArray)
    }
    
    /**
     Matrix transpose
     - Returns: transpose of matrix
     */
    func transpose() -> Matrix {
        
        let newRows = self.columns
        let newColumns = self.rows
        
        var result = [Double]()
        
        for column in 1...columns {
            for row in 1...rows {
                result.append(self[row, column])
            }
        }
        
        return Matrix.init(rows: newRows, columns: newColumns, array: result)
    }
}


//MARK: Function implementation

/**
 Equality comparison
 - Returns: weather matrices are equal (rows, columns and contained values are compared)
 */
func == (lhs: Matrix, rhs: Matrix) -> Bool {
    guard lhs.array == rhs.array else {return false}
    guard lhs.rows == rhs.rows else {return false}
    guard lhs.columns == rhs.columns else {return false}
    return true
}

infix operator • { associativity left precedence 120}

/**
 Matrix multiplication A•B=C
 - Precondition: 
    - A must be of dimensionality M-by-P
    - B must be of dimensionality P-by-N
 - Returns: C, matrix of dimensionality M-by-N
 */
func • (lhs: Matrix, rhs: Matrix) -> Matrix {
    
    assert(lhs.columns == rhs.rows)
    
    let m = lhs.rows
    let n = rhs.columns
    let p = lhs.columns
    
    var product = [Double](count: m*n, repeatedValue: 0.0)
    
    vDSP_mmulD(lhs.array, 1, rhs.array, 1, &product, 1, UInt(m), UInt(n), UInt(p))
    
    return Matrix.init(rows: m, columns: n, array: product)
}


/**
 Elementwise multiplication A*B=C
 - Precondition: A and B must have same number of rows and columns
 - Returns: C, matrix of dimensionality equal to that of A and B
 */
func * (lhs: Matrix, rhs: Matrix) -> Matrix {
    
    assert(lhs.rows == rhs.rows && lhs.columns == rhs.columns)
    
    var result = [Double](count: lhs.size, repeatedValue: 0)
    vDSP_vmulD(lhs.array, 1, rhs.array, 1, &result, 1, UInt(lhs.size))
    return Matrix.init(rows: lhs.rows, columns: lhs.columns, array: result)
}

/**
 Matrix addition A+B=C
 - Precondition: A and B must have same number of rows and columns
 - Returns: C, matrix of dimensionality equal to that of A and B
 */
func +(lhs: Matrix, rhs: Matrix) -> Matrix {
    
    assert(lhs.rows == rhs.rows && lhs.columns == rhs.columns)

    var result = [Double](count: lhs.size, repeatedValue: 0)
    vDSP_vaddD(lhs.array, 1, rhs.array, 1, &result, 1, UInt(lhs.size))
    return Matrix.init(rows: lhs.rows, columns: lhs.columns, array: result)
}

/**
 Unary negative
 - Returns: matrix of same dimensionality but where every element has the opposite sign
 */
prefix func - (matrix: Matrix) -> Matrix {
    
    var result = [Double](count: matrix.size, repeatedValue: 0)
    var factor = -1.0
    
    vDSP_vsmulD(matrix.array, 1, &factor, &result, 1, UInt(matrix.size)) //TODO: SCALAR MAY NEED WORK
    
    return Matrix.init(rows: matrix.rows, columns: matrix.columns, array: result)
}

/**
 Matrix subtraction A-B=C
 - Precondition: A and B must have same number of rows and columns
 - Returns: C, matrix of dimensionality equal to that of A and B
 */
func - (lhs: Matrix, rhs: Matrix) -> Matrix {
    
    assert(lhs.rows == rhs.rows && lhs.columns == rhs.columns)
    
    var result = [Double](count: lhs.size, repeatedValue: 0)
    vDSP_vsubD(rhs.array, 1, lhs.array, 1, &result, 1, UInt(lhs.size))
    return Matrix.init(rows: lhs.rows, columns: lhs.columns, array: result)
}
