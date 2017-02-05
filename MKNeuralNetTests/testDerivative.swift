//
//  MKNeuralNetTests.swift
//  MKNeuralNetTests
//
//  Created by Morten Kals on 03/04/16.
//  Copyright © 2016 Morten Kals. All rights reserved.
//

import XCTest

class MKNeuralNetTests: XCTestCase {
    
    let testInputData = Matrix.init(rows: 3, columns: 3)
    let testTargetData = Matrix.init(rows: 3, columns: 1)
    
    let test = MKNeuralNet.init(inputData: , targetData: <#T##Matrix#>)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    /*
 
def computeNumericalGradient(N, X, y): paramsInitial = N.getParams()
     numgrad = np.zeros(paramsInitial.shape)
     perturb = np.zeros(paramsInitial.shape)
     e = 1e-4
     for p in range(len(paramsInitial)):
     #Set perturbation vector
     perturb[p] = e N.setParams(paramsInitial + perturb) loss2 = N.costFunction(X, y)
     N.setParams(paramsInitial - perturb)
     loss1 = N.costFunction(X, y)
     #Compute Numerical Gradient
     numgrad[p] = (loss2 - loss1) / (2*e)
     #Return the value we changed to zero:
     perturb[p] = 0
     #Return Params to original value:
     N.setParams(paramsInitial) return numgrad
 */
    
}
