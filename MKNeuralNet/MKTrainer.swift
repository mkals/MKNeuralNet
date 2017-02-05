//
//  MKTraining.swift
//  MKNeuralNet
//
//  Created by Marie Kals on 01.03.2016.
//  Copyright © 2016 no.kals.m. All rights reserved.
//

import Foundation

/**
 Trainer gets a copy of a network, input data, putput data and some specified training parameters and trains the network to the bests of its ability. -> Idea being several trainers may be launched cuncurrently with different training-parameters for the same network and the performance of them being compared through a parameter updated to indicate progress
 */

class Trainer {
    
    let network: Network
    let inputData: Matrix
    let targetData: Matrix
    
    init(network: Network, inputData: Matrix, targetData: Matrix) {
        self.network = network
        self.inputData = inputData
        self.targetData = targetData
        
    }
    
    func batchGradientDecent() -> Double {
        return 0.0
    }
    
    func backPropogation() -> Double {
        return 0.0
    }
}

/*

training:
 - gradient decent, AD back propopogation and adopting weights

*/