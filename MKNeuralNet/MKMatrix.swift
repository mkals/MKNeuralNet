//
//  MKMatrix.swift
//  MKNeuralNet
//
//  Created by Marie Kals on 03.03.2016.
//  Copyright © 2016 no.kals.m. All rights reserved.
//

import Foundation
import Accelerate

protocol Number: Equatable, Comparable {
    func +(lhs: Self, rhs: Self) -> Self
    func -(lhs: Self, rhs: Self) -> Self
    func *(lhs: Self, rhs: Self) -> Self
    func /(lhs: Self, rhs: Self) -> Self
    prefix func -(num: Self) -> Self
}

extension Int: Number {}
extension Double: Number {}

struct Matrix <T: Number> : Equatable {
    
    private var array: [T]
    
    let rows: Int
    let columns: Int

    
    init (array: [T], rows: Int, columns: Int) {
        
        assert(array.count == rows * columns)
        
        self.array = array
        
        self.rows = rows
        self.columns = columns
    }
 
    //init with random doubles between 0 and 1
    init (rows: Int, columns: Int, functionToGenerateNumbers: () -> T) {
        
        self.array = [T]()
        
        for _ in 1 ... rows * columns {
            self.array.append(functionToGenerateNumbers())
        }
        
        self.rows = rows
        self.columns = columns
    }
    
    subscript (row: Int, column: Int) -> T {
        return array[ (row - 1) * self.columns + (column - 1) ] //-2 as first index of matrix is 1,1 and first index of array is 0
    }
    
    func performElementOperation(operation: T -> T) -> Matrix {
        
        var returnArray = [T]()
        
        for number in array {
            returnArray.append(operation(number))
        }
        
        return Matrix.init(array: returnArray, rows: self.rows, columns: self.columns)
    }
    
    func transpose() -> Matrix {
        
        let newRows = self.columns
        let newColumns = self.rows
        
        var result = [T]()
        
        for column in 1...columns {
            for row in 1...rows {
                result.append(self[row, column])
            }
        }
        
        return Matrix.init(array: result, rows: newRows, columns: newColumns)
    }
}

//MARK: Function implementation

/**
 Equality comparison
 - Returns: weather matrices are equal (rows, columns and contained values are compared)
 */
func == <T:Number>(lhs: Matrix<T>, rhs: Matrix<T>) -> Bool {
    guard lhs.array == rhs.array else {return false}
    guard lhs.rows == rhs.rows else {return false}
    guard lhs.columns == rhs.rows else {return false}
    return true
}

/**
 Unary negative
 - Returns: matrix of same dimensionality but where every element has the opposite sign
 */
prefix func - <T:Number>(matrix: Matrix<T>) -> Matrix<T> {
    return Matrix.init(array: matrix.array.map{ -$0 }, rows: matrix.rows, columns: matrix.rows)
}


infix operator • { associativity left precedence 120}

/**
 Matrix multiplication A•B=C
 - Precondition: 
    - A must be of dimensionality M-by-P
    - B must be of dimensionality P-by-N
 - Returns: C, matrix of dimensionality M-by-N
 */
func • (lhs: Matrix<Double>, rhs: Matrix<Double>) -> Matrix<Double> {
    
    assert(lhs.columns == rhs.rows)
    
    let m = lhs.rows
    let n = rhs.columns
    let p = lhs.columns
    
    var product = [Double]()
    
    vDSP_mmulD(lhs.array, 1, rhs.array, 1, &product, 1, UInt(m), UInt(n), UInt(p))
    
    return Matrix.init(array: product, rows: m, columns: n)
}


/**
 Elementwise multiplication A*B=C
 - Precondition: A and B must have same number of rows and columns
 - Returns: C, matrix of dimensionality equal to that of A and B
 */
func * <T:Number>(lhs: Matrix<T>, rhs: Matrix<T>) -> Matrix<T> {
    assert(lhs.rows == rhs.rows && lhs.columns == rhs.columns)
    return Matrix.init(array: Array(zip(lhs.array, rhs.array)).map { $0 * $1 }, rows: lhs.rows, columns: lhs.columns)
}

/**
 Matrix addition A+B=C
 - Precondition: A and B must have same number of rows and columns
 - Returns: C, matrix of dimensionality equal to that of A and B
 */
func + <T:Number>(lhs: Matrix<T>, rhs: Matrix<T>) -> Matrix<T> {
    assert(lhs.rows == rhs.rows && lhs.columns == rhs.columns)
    return Matrix.init(array: Array(zip(lhs.array, rhs.array)).map { $0 + $1 }, rows: lhs.rows, columns: lhs.columns)
}

/**
 Matrix subtraction A-B=C
 - Precondition: A and B must have same number of rows and columns
 - Returns: C, matrix of dimensionality equal to that of A and B
 */
func - <T:Number>(lhs: Matrix<T>, rhs: Matrix<T>) -> Matrix<T> {
    assert(lhs.rows == rhs.rows && lhs.columns == rhs.columns)
    return lhs + (-rhs)
}
