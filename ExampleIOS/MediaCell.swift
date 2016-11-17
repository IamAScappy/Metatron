//
//  MediaCell.swift
//  Metatron
//
//  Created by Almaz Ibragimov on 17.11.16.
//  Copyright © 2016 Almazrafi. All rights reserved.
//

import UIKit

class MediaCell: UITableViewCell {

    // MARK: Instance Properties
    
    @IBOutlet weak var coverArtView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var bitRateLabel: UILabel!
    @IBOutlet weak var sampleRateLabel: UILabel!
    
    // MARK: Instance Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
