//
//  MKDataScaling.swift
//  MKNeuralNet
//
//  Created by Marie Kals on 01.03.2016.
//  Copyright © 2016 no.kals.m. All rights reserved.
//

import Foundation

class Data {
    
    let normalizedTrainingInputData: [Double]
    let normalizedTrainingOutputData: [Double]
    
    private let outputFunction: (encode: (Double -> Double), decode: (Double -> Double))
    
    init(inputData: [Double], outputData: [Double]) {
        
        normalizedTrainingInputData = inputData.map(linearNormalization(inputData).encode)
        
        outputFunction = linearNormalization(outputData)
        normalizedTrainingOutputData = outputData.map(outputFunction.encode)
    }
    
    func decodingOutput(prediction: [Double]) -> [Double] {
        return prediction.map(outputFunction.decode)
    }
}

private func linearNormalization(data: [Double]) -> (encode: (Double -> Double), decode: (Double -> Double)) {
    
    let min = data.minElement()!
    let max = data.maxElement()!
    
    return (encode: { ($0 - min) / (max - min) }, decode: { $0 * (max - min) +  min } )
}

