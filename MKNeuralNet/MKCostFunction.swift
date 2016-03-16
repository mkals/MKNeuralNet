//
//  MKCostFunction.swift
//  MKNeuralNet
//
//  Created by Morten Kals on 15/03/16.
//  Copyright © 2016 Morten Kals. All rights reserved.
//

import Foundation

struct CostFunction {
    
    func evaluate(network: Network, inputData: Matrix, targetData: Matrix) -> Matrix {
        let outputData = network.forwardPass(inputData)
        return (targetData - outputData).elementOperation( { input in 0.5 * pow(input, 2) } )
    }
    
    func partialDerivatives(network: Network, inputData: Matrix, targetData: Matrix) -> Matrix {
        let outputData = network.forwardPass(inputData)
        
        return (outputData - targetData) //TODO: Implement properly
        
    }
}