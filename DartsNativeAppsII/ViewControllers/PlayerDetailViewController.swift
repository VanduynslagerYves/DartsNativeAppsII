//
//  PlayersViewController.swift
//  DartsNativeAppsII
//
//  Created by Yves on 11/11/2018.
//  Copyright © 2018 Yves. All rights reserved.
//

import UIKit

class PlayerDetailViewController: UIViewController
{
    
    var player: Player?
    
    @IBOutlet weak var lbl_fullname: UILabel!
    @IBOutlet weak var lbl_score: UILabel!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        guard let selectedPlayer = player else {
            fatalError("Player not found")
        }
        self.update(for: selectedPlayer)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func update(for player: Player)
    {
        lbl_fullname.text = player.fullName
        lbl_score.text = "Score: \(player.score)"
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        
        if(segue.identifier == "EditPlayerSegue")
        {
            guard let addEditPlayerViewController = segue.destination as? AddEditPlayerViewController else
            {
                fatalError("Unknown controller: \(segue.destination)")
            }
            
            addEditPlayerViewController.player = self.player
            
            if let selectedPlayer = player {
                addEditPlayerViewController.title = "Edit \(selectedPlayer.firstName)"
                
                //Set back button to "player's details text" Instead of "Players"
                let backItem = UIBarButtonItem()
                backItem.title = self.title
                navigationBar.backBarButtonItem = backItem
            }
        }
        else
        {
            fatalError("Unexpected segue identifier: \(String(describing: segue.identifier))")
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
