//
//  Errors.swift
//  MKNeuralNet
//
//  Created by Marie Kals on 03.03.2016.
//  Copyright © 2016 no.kals.m. All rights reserved.
//

import Foundation

enum Errors: ErrorType {
    
    case InvalidInitDimensions(arraySize: Int, rows: Int, columns: Int)
    case InvalidOperationDimensions(lhs: (rows: Int, columns: Int), rhs: (rows: Int, columns: Int))
    
}