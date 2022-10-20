//
//  testfileorder.swift
//  Merch Manager
//
//  Created by Gino Tateo on 8/11/22.
//

import SwiftUI
import CoreData
import Foundation




 public class Node<T>{
  // 2
     var value: T
     var next: Node<T>?
  weak var previous: Node<T>?

  // 3
  init(value: T) {
    self.value = value
  }
}


public class LinkedList: ObservableObject {
    
    fileprivate var head: Node<Any>?
    private var tail: Node<Any>?
    
    var objectToAddInDate = OrderModel()

  public var isEmpty: Bool {
    return head == nil
  }

    public var first: Node<Any>? {
    return head
  }

    public var last: Node<Any>? {
    return tail
  }
    
    public func append(value: Any) {
      // 1
      let newNode = Node(value: value)
      // 2
      if let tailNode = tail {
        tailNode.next = newNode
      }
      // 3
      else {
        head = newNode
      }
      // 4
      tail = newNode
    }
    
    public func removeAll() {
      head = nil
      tail = nil
    }
    
    public func nodeAt(index: Int) -> Node<Any>? {
      // 1
      if index >= 0 {
        var node = head
        var i = index
        // 2
        while node != nil {
          if i == 0 { return node }
          i -= 1
          node = node!.next
        }
      }
      // 3
      return nil
    }
    
    public func remove(node: Node<Any>) -> Any {
      let next = node.next
        let prev = node.next


      if let prev = next {
        prev.next = next // 1
      } else {
        head = next // 2
      }

      if next == nil {
        tail = prev // 4
      }

      // 5
      node.next = nil

      // 6
      return node.value
    }
    
}

extension LinkedList: CustomStringConvertible {
  // 2
  public var description: String {
    // 3
    var text = "["
    var node = head
    // 4
    while node != nil {
      text += "\(node!.value)"
      node = node!.next
      if node != nil { text += ", " }
    }
    // 5
    return text + "]"
  }
}




