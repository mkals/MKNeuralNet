//
//  AI ActivationFunctions.swift
//  MK Utility Framework
//
//  Created by Marie Kals on 01.03.2016.
//  Copyright © 2016 Morten Kals. All rights reserved.
//

import Foundation

protocol ActivationFunctionable {
    func evaluate(_ input: Double) -> Double
    func derivate(_ input: Double) -> Double
}

struct SigmoidActivationFunction : ActivationFunctionable {
    
    func evaluate(_ input: Double) -> Double {
        return 1/(1+exp(-input))
    }
    
    func derivate(_ input: Double) -> Double {
        return exp(-input)/pow(1+exp(-input), 2)
    }
}
