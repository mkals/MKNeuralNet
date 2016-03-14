//
//  AI ActivationFunctions.swift
//  MK Utility Framework
//
//  Created by Marie Kals on 01.03.2016.
//  Copyright © 2016 Morten Kals. All rights reserved.
//

import Foundation

protocol Function {
    func evaluate(input: Double) -> Double
    func derivate(input: Double) -> Double
}

enum ActivationFunction {
    
    case Sigmoid
    
}

extension ActivationFunction: Function {
    
    func evaluate(input: Double) -> Double {
        switch self {
        case .Sigmoid:
            return 1/(1+exp(-input))
        }
    }
    
    func derivate(input: Double) -> Double {
        switch self {
        case .Sigmoid:
            return exp(-input)/pow(1+exp(-input), 2)
        }
    }
}