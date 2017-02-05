//
//  Errors.swift
//  MKNeuralNet
//
//  Created by Marie Kals on 03.03.2016.
//  Copyright © 2016 no.kals.m. All rights reserved.
//

import Foundation

enum Errors: Error {
    
    case invalidInitDimensions(arraySize: Int, rows: Int, columns: Int)
    case invalidOperationDimensions(lhs: (rows: Int, columns: Int), rhs: (rows: Int, columns: Int))
    
}
