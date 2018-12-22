//
//  PlayerTableViewCell.swift
//  Darts
//
//  Created by Yves on 01/11/2018.
//  Copyright © 2018 Yves. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell
{
    //MARK: - Outlets
    @IBOutlet weak var lbl_name: UILabel!
    
    //MARK: - Cell setup
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //MARK: - Other
    func update(with player: Player)
    {
        lbl_name.text = player.fullName
    }
}
