//
//  EventDetailsViewController.swift
//  SeatTest
//
//  Created by Nilay Padsala on 3/29/21.
//

import UIKit
import CoreData

class EventDetailsViewController: UIViewController {

    @IBOutlet weak var eventTitleLbl: UILabel!
    @IBOutlet weak var eventTimeLbl: UILabel!
    @IBOutlet weak var eventLocationLbl: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var isFavoriteBtn: UIBarButtonItem!
    var isFavorite: Bool = false
    var event: Event!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isFavorite = FavoriteEvents.isFavoriteEvent(id: self.event.id)
        self.configure(with: self.event)
        // Do any additional setup after loading the view.
    }
    
    func configure(with event: Event) {
        self.eventTitleLbl.text = event.title
        self.eventTimeLbl.text = event.time
        self.eventLocationLbl.text = event.address
        self.isFavoriteBtn.tintColor = self.isFavorite ? .systemPink : .systemGray
        self.loadEventImage(from: event.imageRefURL)
    }
    
    @IBAction func changeFavoriteStatus(_ sender: Any) {
        self.isFavorite.toggle()
        self.isFavoriteBtn.tintColor = self.isFavorite ? .systemPink : .systemGray
        FavoriteEvents.updateStatus(id: self.event.id, isFavorite: self.isFavorite)
    }
    
    private func loadEventImage(from urlString: String) {
        let networkManager = NetworkManger()
        networkManager.loadImage(from: urlString) { [weak self] (image) in
            DispatchQueue.main.async {
                self?.eventImageView.image = image
                self?.eventImageView.clipsToBounds = true
                self?.eventImageView.contentMode = .scaleAspectFit
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
