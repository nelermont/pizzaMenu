//
//  ContentCellTableViewCell.swift
//  UIcollectionViewTest
//
//  Created by Дмитрий Подольский on 05.03.2021.
//

import UIKit

class ContentCellTableViewCell: UITableViewCell {

    @IBOutlet weak var content: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var icon: UIImageView!
      
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  

}
