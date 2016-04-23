//
//  MKMain.swift
//  swix
//
//  Created by Marie Kals on 01.03.2016.
//  Copyright © 2016 com.scott. All rights reserved.
//

import Foundation
import Swift


/**
 Net configures automatically using inputData and target outputData and starts leaning proces.
 
 Displayed during learning process:
 - progress (performance of net at this momant relative to initial performance)
 - first time derivative of performance per itteration of algorythm (ei how much performace is imprving currently)
 
 certain state should at all times be possible to store, to be able to revert to this in case of overfitting or simular
 
 user should be able to do live learning through either helping learning along with commands such as (increase size of net) or (increase number of layers) etc. during learning.
 user should be able to stop learning process when satisfyed with performance
 
 result needs to be possible to output and print so as to pick a session up at a later stage and continue and so that a propperly learned largorithm may be store and used later
 
 learning should be possible to reingange at a later point.
 
 - parameters:
    - inputData set of data to
    - targetData

 */

class MKNeuralNet {
    
    //Local variables
    let network: Network
    
    
    /**
     - parameters:
        - inputData one row per data set (#datasets = #rows, #entries per data set = #columns). There shold be at least ... as many data sets as there is data.
        - targetData one row per data set (#datasets = #rows, #entries per data set = #columns)
     */
    init(inputData: Matrix<Double>, targetData: Matrix<Double>) {
        
        network = Network.init(withShape: Network.Geometry.Rectangular, hiddenLayerCount: inputData.size, inputCount: inputData.columns, outputCount: targetData.columns)
        
        
        
        
        
    }
    
    
    
}

/* 

- Launch net, decide siez from constants/dymanically from input data
- launch training
- store trained weights
- test performance on part of data not used for training

*/

