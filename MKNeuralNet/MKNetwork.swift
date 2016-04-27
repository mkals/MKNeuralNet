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
    
    let activationFunction = ActivationFunction.Sigmoid
    
    private var structure = [Int]()
    var weights = [Matrix]()
    
    let geometry: Geometry
    let layerCount: Int
    let nodeCount: Int
    
    enum Geometry {
        case Rectangular
        case Rombus
    }
    
    subscript(index: Int) -> Matrix {
        return weights[index] //REP EXPOSURE if matrix is changed to class
    }
    
    init (withShape geometry: Geometry, layerCount: Int, inputCount: Int, outputCount: Int) {
        
        //Init nodal structure
        for i in 0 ... layerCount {
            
            switch geometry {
            case .Rectangular:
                structure.append(inputCount + 1)
                
            case .Rombus:
                let extraWidth = layerCount/2 - abs(layerCount/2 - i)
                structure.append(inputCount + extraWidth)
            }
        }
        
        self.structure.append(outputCount)
        
        
        //Set constant properties
        self.geometry = geometry
        self.layerCount = layerCount
        self.nodeCount = structure.reduce(0, combine: + )
        
        
        //Build collection of weight matrices
        for layerCount in structure {
            weights.append(Matrix.init(rows: (self.weights.last != nil ? self.weights.last!.columns : inputCount), columns: layerCount, functionToGenerateNumbers: drand48))
        }
    }
}



