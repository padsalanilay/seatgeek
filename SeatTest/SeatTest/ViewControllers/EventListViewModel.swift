//
//  EventListViewModel.swift
//  SeatTest
//
//  Created by Nilay Padsala on 3/29/21.
//

import Foundation

extension EventsListTableViewController {
    func loadEvents(for searchString: String = "") {
        
        if !searchString.isEmpty {
            self.page = 1
            self.searchString = searchString
        }
        
        let urlStirngPrefix = "https://api.seatgeek.com/2/events?client_id=MjE2NDk5NzZ8MTYxNzAzOTcwNC4wMDIxODAz&page=\(self.page)"
        let urlString = urlStirngPrefix + (searchString.isEmpty ? "" : "&q=\(searchString)")
        let url = URL(string: urlString)!
        
        let networkManager = NetworkManger()
        networkManager.load(url: url) { [weak self] (data, error) in
            if let data = data, let newEvents = try? JSONDecoder().decode(DTEventsList.self, from: data) {
                let events = newEvents.events.map(Event.init)
                if self?.page == 1, let count = self?.events.count, count > 0 {
                    self?.events = []
                }
                self?.events += events
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
}
