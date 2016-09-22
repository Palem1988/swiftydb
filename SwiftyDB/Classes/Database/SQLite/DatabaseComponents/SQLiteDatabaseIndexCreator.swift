//
//  SQLiteDatabaseIndexCreator.swift
//  SwiftyDB
//
//  Created by Øyvind Grimnes on 24/08/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import TinySQLite

class SQLiteDatabaseIndexer: DatabaseIndexerType {
    
    let databaseQueue: DatabaseQueue
    let queryFactory: SQLiteQueryFactory
    
    init(databaseQueue: DatabaseQueue, queryFactory: SQLiteQueryFactory) {
        self.databaseQueue = databaseQueue
        self.queryFactory = queryFactory
    }
    
    func create(index: _IndexType) throws {
        try deleteIndicesForType(index.type)
        
        for index in index.indices {
            let query = queryFactory.createIndexQueryFor(index)

            try databaseQueue.database { database in
                try database.prepare(query.query)
                    .executeUpdate()
                    .finalize()
            }
        }
    }
    
    private func deleteIndicesForType(type: Storable.Type) throws {
        let indexNames = try indexNamesForType(type)
        
        let query = "DROP INDEX ?"
        
        try databaseQueue.database { database in
            
            let statement = try database.prepare(query)
            
            for indexName in indexNames {
                try statement.executeUpdate([indexName])
            }
            
            try statement.finalize()
        }
    }
    
    private func indexNamesForType(type: Storable.Type) throws -> [String] {
        let query = "SELECT name FROM sqlite_master WHERE type == 'index' AND tbl_name == ?"
        
        var indexNames: [String] = []
        
        try databaseQueue.database { database in
            let statement = try database.prepare(query)

            indexNames = try statement.execute([String(type)]).map { $0.stringForColumn(0)! }
            
            try statement.finalize()
        }
        
        return indexNames
    }
}