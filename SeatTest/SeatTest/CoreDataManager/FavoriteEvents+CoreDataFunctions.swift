//
//  FavoriteEvents+CoreDataFunctions.swift
//  SeatTest
//
//  Created by Nilay Padsala on 3/29/21.
//

import Foundation
import CoreData

extension FavoriteEvents {
    private static func with(id: String) -> FavoriteEvents? {
        let context = PersistenceContainer.shared.context
        let request = fetchRequest(ID_PREDICATE(id))
        
        let favoriteEvent = try? context.fetch(request)
        
        return favoriteEvent?.first
    }
    
    /// Creates fetchrequest
    /// - Parameter predicate: NSPredicate for the fetch request
    /// - Returns: Fetch request with the given predicate
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<FavoriteEvents> {
        let request = NSFetchRequest<FavoriteEvents>(entityName: Self.entity().name!)
        request.predicate = predicate
        return request
    }
    
    static func updateStatus(id: String, isFavorite: Bool) {
        let context = PersistenceContainer.shared.context
        // check if the old event is there else create new
        let oldEvent = Self.with(id: id)
        let event = oldEvent ?? FavoriteEvents(context: context)
        
        // update data
        if oldEvent == nil {
            event.eventId = id
        }
        
        event.isFavorite = isFavorite
        
        try? context.save()
    }
    
    static func isFavoriteEvent(id: String) -> Bool {
        // if event is already in there and is favorite
        if let event = Self.with(id: id), event.isFavorite {
            return true
        }
        
        return false
    }
    
    static func ID_PREDICATE(_ id: String) -> NSPredicate { NSPredicate(format: "eventId == %@", id) }
}
