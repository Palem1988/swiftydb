//
//  QueryType.swift
//  SwiftyDB
//
//  Created by Øyvind Grimnes on 10/09/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

/** Contains all valid filter methods */
public protocol QueryType {
    func filter(filter: FilterStatement) -> Self
    func max(max: Int) -> Self
    func start(start: Int) -> Self
    func sortBy(property: String, ascending: Bool) -> Self
}

/** A query representation used internally */
protocol _QueryType {
    var type: Storable.Type {get}
    var filter: FilterStatement? { get }
    var max: Int? {get}
    var start: Int? {get}
    var sorting: Sorting {get}
}