//
//  main.swift
//  MKNeuralNet
//
//  Created by Morten Kals on 06/03/16.
//  Copyright © 2016 Morten Kals. All rights reserved.
//

import Foundation

let dataSet = Matrix.init(rows: 10, columns: 1, array: [1.0,2,3,4,5,6,7,8,9,10])
let result = Matrix.init(rows: 10, columns: 1, array: [1.0,4,6,8,10,12,14,16,18,20])


let _ = MKNeuralNet.init(inputData: dataSet, targetData: result)

