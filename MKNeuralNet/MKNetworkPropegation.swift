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
     - input: matrix of network inputs
     - layer: optional, last layer to be investigated. Default behaviour of going through all layers
     - Returns: matrix representing ybar (output layer activities)
     */
    
    private func forwardPass(input: Matrix, layer: Int) -> Matrix {
        
        let lastLayerActivity = layer == 0 ?
            input :
            forwardPass(input, layer: layer - 1)
        
        let activation =  lastLayerActivity * weights[layer]
        let activity = activation.performElementOperation(ActivationFunction.Sigmoid.evaluate)
        
        return activity
    }

    /**
     -returns: partial derivateive of output with respect to each weight matrix
     */
    func partials(inputData: Matrix, targetData: Matrix) -> [Matrix] {
        return partialsOfLayer(0, inputActivity: inputData, targetData: targetData).partials
    }
    
    
    private func partialsOfLayer(layer: Int, inputActivity lastLayerActivity: Matrix, targetData: Matrix) -> (partials: [Matrix], activity: Matrix, activation: Matrix, delta: Matrix) {
        
        //base caes
        if layer == self.hiddenLayerCount {
            
        }
        
        let activation =  lastLayerActivity * weights[layer]
        let activity = activation.performElementOperation(ActivationFunction.Sigmoid.evaluate)
        
        let result = partialsOfLayer(layer + 1, inputActivity: activity, targetData: targetData)
        
        
        //outputData is result of forward call
        
        //base case, TODO: is activity = output data for last layer?
        var delta: Matrix = (activity - targetData) • result.activation.performElementOperation(activationFunction.derivate)
        
        delta = (result.delta * self[layer].transpose()) • activation.performElementOperation(ActivationFunction.Sigmoid.derivate)
        
        
        //let partial = layer != 0 ? lastLayerActivity.transpose() * delta : inputData.transpose() * delta
        let partial = lastLayerActivity.transpose() * delta
        
        return (partials: [partial] + result.partials, activity: activity, activation: activation, delta: delta)
    }
        
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
    
    /*
    func evaluate(inputData: Matrix, targetData: Matrix) -> Matrix {
        let outputData = self.forwardPass(inputData)
        return (targetData - outputData).performElementOperation( { input in 0.5 * pow(input, 2) } )
    }*/
}