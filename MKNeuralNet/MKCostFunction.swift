//
//  MKCostFunction.swift
//  MKNeuralNet
//
//  Created by Morten Kals on 15/03/16.
//  Copyright © 2016 Morten Kals. All rights reserved.
//

import Foundation

struct CostFunction {
    
    func evaluate(network: Network, inputData: Matrix<Double>, targetData: Matrix<Double>) -> Matrix<Double> {
        let outputData = network.forwardPass(inputData)
        return (targetData - outputData).performElementOperation( { input in 0.5 * pow(input, 2) } )
    }
    
    func partialDerivatives(network: Network, inputData: Matrix<Double>, targetData: Matrix<Double>) -> [Matrix<Double>] {
        
        var activations = [Matrix<Double>]?()
        var activities = [Matrix<Double>]?()
        
        let outputData = network.forwardPass(inputData, activations: &activations, activities: &activities)
        let layerCount = network.hiddenLayerCount

        
        /* LOOPING IMPLIMENTATION */
        var differentiatedWeights = [Matrix<Double>]()
        
        var delta: Matrix = (outputData - targetData) * activations![layerCount].performElementOperation(ActivationFunction.Sigmoid.derivate)
        
        for layer in layerCount...0 {
            
            if layer != layerCount {
                delta = (delta * network[layer].transpose()) * activations![layer].performElementOperation(ActivationFunction.Sigmoid.derivate)
            }
            
            let derivative = layer != 0 ? activities![layer - 1].transpose() * delta : inputData.transpose() * delta
            
            differentiatedWeights.insert(derivative, atIndex: 0)
        }
        
        return differentiatedWeights
        
         /*
         //THEIR IMPLEMENTATION
         delta3 = np.multiply(-(y-self.yHat), self.sigmoidPrime(self.z3))
         dJdW2 = np.dot(self.a2.T, delta3)
         
         delta2 = np.dot(delta3, self.W2.T)*self.sigmoidPrime(self.z2)
         dJdW1 = np.dot(X.T, delta2)
         
         
         //MY TRANSLATION
         var layer = 3
         
         let delta3 = (outputData - targetData) * activities![layer]
         let djdw2 = activities![layer - 1].transpose() • delta3
         
         layer = 2
         
         let delta2 = (delta3 * network[layer].transpose()) * activities![layer]
         let djdw1 = inputData.transpose() • delta2
         */
    }
}