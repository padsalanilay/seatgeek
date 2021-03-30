//
//  EventCell.swift
//  SeatTest
//
//  Created by Nilay Padsala on 3/29/21.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var eventTitleLbl: UILabel!
    @IBOutlet weak var eventTimeLbl: UILabel!
    @IBOutlet weak var eventLocationLbl: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var isFavoriteBtn: UIButton!
    
    static var identifier = "eventcell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with event: Event) {
        self.eventTitleLbl.text = event.title
        self.eventTimeLbl.text = event.time
        self.eventLocationLbl.text = event.address
        self.isFavoriteBtn.isHidden = !FavoriteEvents.isFavoriteEvent(id: event.id)
        self.loadEventImage(from: event.imageRefURL)
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
    static func uiNib() -> UINib {
        return UINib(nibName: "EventCell", bundle: nil)
    }
}
