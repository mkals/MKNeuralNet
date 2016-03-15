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
    private var weights = [Matrix]()
    private var activations = [Matrix]()
    
    let geometry: Geometry
    let hiddenLayerCount: Int
    let nodeCount: Int
    
    enum Geometry {
        case Rectangular
        case Rombus
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
            weights.append(Matrix.init(rows: (self.weights.last != nil ? self.weights.last!.columns : inputCount), columns: layerCount))
        }
    }
    
    func forwardPass(input: Matrix, var layer: Int = -1) -> Matrix {
        
        if layer == -1 {
            layer = self.weights.count - 1
        }
        
        let activation = layer == 0 ? input * weights[layer] : forwardPass(input, layer: layer - 1) * weights[layer]
        return activation.elementOperation(ActivationFunction.Sigmoid.evaluate)
    }
    
    func backPropogation(input: Int ) -> Matrix {
        
        return Matrix.init(rows: structure.last!, columns: 1)
    }
}



