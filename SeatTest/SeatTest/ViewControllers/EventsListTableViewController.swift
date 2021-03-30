//
//  EventsListTableViewController.swift
//  SeatTest
//
//  Created by Nilay Padsala on 3/29/21.
//

import UIKit

class EventsListTableViewController: UITableViewController {

    @IBOutlet weak var eventSearchBar: UISearchBar!
    
    var searchString = ""
    var page = 1
    var events: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = true
        self.tableView.register(EventCell.uiNib(), forCellReuseIdentifier: EventCell.identifier)

        self.eventSearchBar.delegate = self
        
        self.loadEvents()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadRows(at: self.tableView.indexPathsForVisibleRows ?? [], with: .automatic)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.events.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier, for: indexPath) as! EventCell

        cell.eventImageView.image = UIImage(named: "eventplaceholder")

        cell.configure(with: events[indexPath.row])
        
        if indexPath.row == events.count - 1 {
            page += 1
            self.loadEvents(for: self.searchString)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = self.events[indexPath.row]
        performSegue(withIdentifier: "showEventDetail", sender: event)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? EventDetailsViewController {
            vc.event = (sender as! Event)
        }
    }

}
