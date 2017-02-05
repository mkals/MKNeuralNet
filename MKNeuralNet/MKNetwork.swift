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
    
    let activationFunction : ActivationFunctionable = SigmoidActivationFunction()
    
    private var structure = [Int]()
    var weights = [Matrix]()
    
    let geometry: Geometry
    let layerCount: Int
    let nodeCount: Int
    
    enum Geometry {
        case rectangular
        case rombus
    }
    
    subscript(index: Int) -> Matrix {
        get {
            return weights[index]
        }
        set {
            assert(weights[index].rows == newValue.rows && weights[index].columns == newValue.columns)
            weights[index] = newValue
        }
    }
    
    init (withShape geometry: Geometry, layerCount: Int, inputCount: Int, outputCount: Int) {
        
        //Init nodal structure
        for i in 0 ... layerCount {
            
            switch geometry {
            case .rectangular:
                structure.append(inputCount + 1)
                
            case .rombus:
                let extraWidth = layerCount/2 - abs(layerCount/2 - i)
                structure.append(inputCount + extraWidth)
            }
        }
        
        self.structure.append(outputCount)
        
        
        //Set constant properties
        self.geometry = geometry
        self.layerCount = layerCount
        self.nodeCount = structure.reduce(0, + )
        
        
        //Build collection of weight matrices
        for layerCount in structure {
            weights.append(Matrix.init(rows: (self.weights.last != nil ? self.weights.last!.columns : inputCount), columns: layerCount, functionToGenerateNumbers: drand48))
        }
    }
}



