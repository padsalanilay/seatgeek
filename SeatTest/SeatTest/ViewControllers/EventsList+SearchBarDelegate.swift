//
//  EventsList+SearchBarDelegate.swift
//  SeatTest
//
//  Created by Nilay Padsala on 3/29/21.
//

import Foundation
import UIKit

extension EventsListTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.loadEvents(for: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.loadEvents(for: searchBar.text ?? "")
    }
}
