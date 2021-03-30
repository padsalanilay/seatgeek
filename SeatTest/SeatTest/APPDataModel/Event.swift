//
//  Event.swift
//  SeatTest
//
//  Created by Nilay Padsala on 3/29/21.
//

import Foundation

struct Event {
    var id: String
    var imageRefURL: String
    var address: String
    var time: String
    var title: String
    
    init(dtEvent: DTEvent) {
        self.id = String(dtEvent.id)
        self.imageRefURL = dtEvent.imageUrlString
        self.title = dtEvent.title
        self.time = dtEvent.eventTime
        self.address = dtEvent.address
    }
}
