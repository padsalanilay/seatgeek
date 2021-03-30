//
//  DTEvent.swift
//  SeatTest
//
//  Created by Nilay Padsala on 3/29/21.
//

import Foundation

struct DTEventsList: Codable {
    var events: [DTEvent]
}

struct DTEvent: Codable {
    var id: Int
    var title: String
    fileprivate var datetime_local: String //2012-03-09T19:00:00
    fileprivate var venue: Venue
    fileprivate var performers: [Performer]
}

extension DTEvent {
    var address: String {
        "\(venue.city), \(venue.state)"
    }
    
    var eventTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let inputDate = dateFormatter.date(from: self.datetime_local)!
        dateFormatter.dateFormat = "EEEE, d MMM, yyyy, HH:mm a"
        
        return dateFormatter.string(from: inputDate)
    }
    
    var imageUrlString: String {
        for performer in performers {
            if let imageUrl = performer.image {
                return imageUrl
            }
        }
        
        return ""
    }
}

fileprivate struct Venue: Codable {
    var city: String
    var state: String
}

fileprivate struct Performer: Codable {
    var image: String?
}
