//
//  EventCell.swift
//  NBA
//
//  Created by Kalinin Andrey on 8/2/17.
//  Copyright © 2017 Kalinin Andrey. All rights reserved.
//

import UIKit
import SDWebImage

class EventCell: UITableViewCell {

    @IBOutlet fileprivate var timeLabel: UILabel?
    @IBOutlet fileprivate var descriptionLabel: UILabel?
    @IBOutlet fileprivate var scoreLabel: UILabel?
    @IBOutlet fileprivate var teamImage: UIImageView?
    
    var event: Event?
    {
        didSet {
            DispatchQueue.main.async {
                self.timeLabel?.text = self.event?.time
                self.descriptionLabel?.text = self.event?.eventDescription
                self.scoreLabel?.text = self.event?.score
                self.teamImage?.sd_setImage(with: URL(string: (self.event?.teamImage)!))
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
