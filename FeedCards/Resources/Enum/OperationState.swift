//
//  OperationState.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 03/02/22.
//

import Foundation

public enum OperationState: String {
    case ready = "isReady"
    case executing = "isExecuting"
    case finished = "isFinished"
    case cancelled = "isCancelled"
}
