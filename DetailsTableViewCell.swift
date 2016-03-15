//
//  DetailsTableViewCell.swift
//  MapTestingNumber99
//
//  Created by Opeyemi Fasuyi on 15/03/2016.
//  Copyright © 2016 Opeyemi Fasuyi. All rights reserved.
//

import UIKit
import MapKit

class DetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var txtAddress: UITextView!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var txtWebsite: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
