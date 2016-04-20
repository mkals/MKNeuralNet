//
//  MKNetworkGeometry.swift
//  MKNeuralNet
//
//  Created by Marie Kals on 01.03.2016.
//  Copyright © 2016 no.kals.m. All rights reserved.
//

import Foundation
import Accelerate

struct Network {
    
    private var structure = [Int]()
    private var weights = [Matrix<Double>]()
    
    let geometry: Geometry
    let hiddenLayerCount: Int
    let nodeCount: Int
    
    enum Geometry {
        case Rectangular
        case Rombus
    }
    
    subscript(index: Int) -> Matrix<Double> {
        return weights[index] //REP EXPOSURE if matrix is changed to class
    }
    
    init (withShape geometry: Geometry, hiddenLayerCount: Int, inputCount: Int, outputCount: Int) {
        
        //Init nodal structure
        for i in 0 ... hiddenLayerCount {
            
            switch geometry {
            case .Rectangular:
                structure.append(inputCount + 1)
                
            case .Rombus:
                let extraWidth = hiddenLayerCount/2 - abs(hiddenLayerCount/2 - i)
                structure.append(inputCount + extraWidth)
            }
        }
        
        self.structure.append(outputCount)
        
        
        //Set constant properties
        self.geometry = geometry
        self.hiddenLayerCount = hiddenLayerCount
        self.nodeCount = structure.reduce(0, combine: + )
        
        
        //Build collection of weight matrices
        for layerCount in structure {
            weights.append(Matrix.init(rows: (self.weights.last != nil ? self.weights.last!.columns : inputCount), columns: layerCount, functionToGenerateNumbers: drand48))
        }
    }
    
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
    
    /*
    
    func backPropogation(input: Int ) -> Matrix {
        
        return Matrix.init(rows: structure.last!, columns: 1)
    }*/
}



