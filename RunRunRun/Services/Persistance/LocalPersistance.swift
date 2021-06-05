//
//  LocalPersistance.swift
//  RunRunRun
//
//  Created by Mohammed Ahmad on 7/1/20.
//  Copyright © 2020 Mohammed Ahmad. All rights reserved.
// 

import Foundation
import CoreData

public protocol LocalPersistence {
    // CRUD database operations
    func save(duration: Int, distance: Double, pace: Double, startDateTime: Date, locations: [Location])
    func readAll() -> [Run]?
    func delete(at indexPath: IndexPath)
}
