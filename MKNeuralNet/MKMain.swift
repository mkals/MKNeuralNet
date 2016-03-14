//
//  MKMain.swift
//  swix
//
//  Created by Marie Kals on 01.03.2016.
//  Copyright © 2016 com.scott. All rights reserved.
//

import Foundation
import Swift

class Main {
    
    //Parameters:
    let shape = Network.Geometry.Rectangular
    let hiddenLayerCount = 1
    let inputCount = 2
    let outputCount = 1
    
    let dataSets = 3
    
    
    //Local variables
    let network: Network
    
    init() {
        
        network = Network.init(withShape: Network.Geometry.Rectangular, hiddenLayerCount: hiddenLayerCount, inputCount: inputCount, outputCount: outputCount)

    }
}


/* 

- Launch net, decide siez from constants/dymanically from input data
- launch training
- store trained weights
- test performance on part of data not used for training

*/

