//
//  MKBackPropegation.swift
//  MKNeuralNet
//
//  Created by Morten Kals on 23/04/16.
//  Copyright © 2016 Morten Kals. All rights reserved.
//

import Foundation

extension Network {
        
    /**
     Forward pass through network
     - Parameters:
        - inputData: matrix of network inputs
     - Returns: matrix representing ybar (output layer activities)
     */
    func forwardPass(_ inputData: Matrix) -> Matrix {
        
        func forwardPassThoughLayer(_ layer: Int, lastLayerActivity: Matrix) -> Matrix {
            
            let activation =  lastLayerActivity * weights[layer]
            let activity = activation.performElementOperation(activationFunction.evaluate)
            
            return layer == layerCount ?
                activity :
                forwardPassThoughLayer(layer + 1, lastLayerActivity: activity)
        }
        
        return forwardPassThoughLayer(0, lastLayerActivity: inputData)
    }
    
    func costFunction(_ network: Network, inputData: Matrix, targetData: Matrix) -> Matrix {
        let outputData = network.forwardPass(inputData)
        return (targetData - outputData).performElementOperation( { input in 0.5 * pow(input, 2) } )
    }
    
    /**
     Back-propogation thorugh network to calculate partial first order derivatives of cost function with respect to weight matrices
     - Parameters: 
        - inputData: matrix of network inputs
        - targetData: matrix of target outputs
     - Returns: partial derivateive of output with respect to each weight matrix
     */
    func costFunctionPrime(_ inputData: Matrix, targetData: Matrix) -> [Matrix] {
        
        func partialsThroughLayer(_ layer: Int, lastLayerActivity: Matrix, targetData: Matrix) -> (partials: [Matrix], deltaTerm: Matrix) {
            
            //forward propegation
            let activation =  lastLayerActivity * weights[layer]
            let activity = activation.performElementOperation(activationFunction.evaluate)
            
            //edge case: layer = layerCount
            let nextLayer: (partials: [Matrix], deltaTerm: Matrix) = ( layer == layerCount ?
                ([Matrix](), activity - targetData) :
                partialsThroughLayer(layer + 1, lastLayerActivity: activity, targetData: targetData)
            )
            
            //backwards propogation
            let delta = nextLayer.deltaTerm * activation.performElementOperation(activationFunction.derivate)
            let partial = lastLayerActivity.transpose() * delta
            
            return (partials: [partial] + nextLayer.partials, deltaTerm: delta * self[layer].transpose())
        }
        
        return partialsThroughLayer(0, lastLayerActivity: inputData, targetData: targetData).partials
    }
}
