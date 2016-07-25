//
//  AlbumCell.swift
//  Populate_UITableView_Using_JSON_Rest_API
//
//  Created by Toleen Jaradat on 7/25/16.
//  Copyright © 2016 Toleen Jaradat. All rights reserved.
//

import UIKit

class AlbumCell: UITableViewCell {

    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var postLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
