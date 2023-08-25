//
//  ListTableCell.swift
//  CardUI
//
//  Created by Vikram Kunwar on 24/08/23.
//

import UIKit

class ListTableCell: UITableViewCell {
    
    @IBOutlet weak var productImg: UIImageView!
    
    @IBOutlet weak var productTitle: UILabel!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var productPrice: UILabel!
        
    @IBOutlet weak var imageVi: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
