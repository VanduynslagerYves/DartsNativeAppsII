//
//  PlayerTableViewCell.swift
//  Darts
//
//  Created by Yves on 01/11/2018.
//  Copyright © 2018 Yves. All rights reserved.
//

import UIKit

class RankingTableViewCell: UITableViewCell
{
    //MARK: - Outlets
    @IBOutlet weak var lbl_rank: UILabel!
    @IBOutlet weak var lbl_score: UILabel!
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
    func update(with player: Player, rank row: Int)
    {
        lbl_rank.text = "\(row + 1)"
        lbl_name.text = player.fullName
        lbl_score.text = "\(player.score)"
    }
}
