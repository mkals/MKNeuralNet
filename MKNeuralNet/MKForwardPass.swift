//
//  MKForwardPass.swift
//  MKNeuralNet
//
//  Created by Morten Kals on 23/04/16.
//  Copyright © 2016 Morten Kals. All rights reserved.
//

import Foundation

extension Network {
    
    func forwardPass(input: Matrix<Double>) -> Matrix<Double> {
        var notOne: [Matrix<Double>]? = nil
        var notTwo: [Matrix<Double>]? = nil
        return forwardPass(input, activations: &notOne, activities: &notTwo)
    }
    
    func forwardPass(input: Matrix<Double>, inout activations: [Matrix<Double>]?, inout activities: [Matrix<Double>]?) -> Matrix<Double> {
        return forwardPass(input, activations: &activations, activities: &activities, layer: self.weights.endIndex)
    }
    
    /**
     Forward pass through network
     - Parameters:
     - input: matrix of network inputs
     - layer: optional, last layer to be investigated. Default behaviour of going through all layers
     - Returns: matrix representing ybar (output layer activities)
     */
    private func forwardPass(input: Matrix<Double>, inout activations: [Matrix<Double>]?, inout activities: [Matrix<Double>]?, layer: Int) -> Matrix<Double> {
        
        let lastLayerActivity = layer == 0 ?
            input :
            forwardPass(input, activations: &activations, activities: &activities, layer: layer - 1)
        
        let activation =  lastLayerActivity * weights[layer]
        let activity = activation.performElementOperation(ActivationFunction.Sigmoid.evaluate)
        
        activations?.append(activity)
        activities?.append(activation)
        
        return activity
    }
}

/*
 
 func backPropogation(input: Int ) -> Matrix {
 
 return Matrix.init(rows: structure.last!, columns: 1)
 }*/