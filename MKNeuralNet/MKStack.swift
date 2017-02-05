//
//  MK Stack.swift
//  MK Utility Framework
//
//  Created by Morten Kals on 20.02.2016.
//  Copyright © 2016 Morten Kals. All rights reserved.
//

import Foundation

class Stack<Element> {
    var items = [Element]()
  
    func push(_ item: Element) {
        items.append(item)
    }
  
    func pop() -> Element {
        return items.removeLast()
    }
    
    func topItem() -> Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}
