//
//  AsyncOperation.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 09/12/21.
//

import Foundation

open class AsyncOperation: Operation {
    
    // MARK: - Properties
    
    private(set) var state: OperationState = .ready {
        willSet {
            willChangeValue(forKey: state.rawValue)
            willChangeValue(forKey: newValue.rawValue)
        }
        didSet {
            didChangeValue(forKey: state.rawValue)
            didChangeValue(forKey: oldValue.rawValue)
        }
    }
    
    override public var isReady: Bool {
        if state == .ready {
            return super.isReady
        }
        
        return state == .ready
    }
    
    override public var isExecuting: Bool {
        if state == .executing {
            return super.isExecuting
        }
        
        return state == .executing
    }
    
    override public var isFinished: Bool {
        if state == .finished {
            return super.isFinished
        }
        
        return state == .finished
    }
    
    override public var isCancelled: Bool {
        if state == .cancelled {
            return super.isCancelled
        }
        
        return state == .cancelled
    }
    
    override public var isAsynchronous: Bool {
        return true
    }
    
    // MARK: - Functions
    
    override open func main() {
        state = isCancelled
        ? .finished
        : .executing
    }
    
    public final func finish() {
        state = .finished
    }
}
