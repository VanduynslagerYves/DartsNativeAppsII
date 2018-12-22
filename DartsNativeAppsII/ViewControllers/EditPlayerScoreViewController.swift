//
//  PlayersViewController.swift
//  DartsNativeAppsII
//
//  Created by Yves on 11/11/2018.
//  Copyright © 2018 Yves. All rights reserved.
//

import UIKit
import os.log

class EditPlayerScoreViewController: UITableViewController
{
    //MARK: - Properties
    var player: Player?
    var playerScoreModifier: PlayerScoreModifier?
    
    //MARK: - Outlets
    @IBOutlet weak var lbl_fullname: UILabel!
    @IBOutlet weak var lbl_notes: UILabel!
    @IBOutlet weak var lbl_score: UILabel!
    
    //MARK: - Lifecycle functions
    override func viewWillAppear(_ animated: Bool)
    {
        //Check if player has a reference
        guard let selectedPlayer = player else
        {
            os_log("Player not found", log: OSLog.default, type: .error)
            fatalError("Player not found")
        }
        
        //Set the labels with player properties
        lbl_fullname.text = selectedPlayer.fullName
        lbl_score.text = "\(selectedPlayer.score)"
        lbl_notes.text = selectedPlayer.notes
        os_log("All labels updated in viewWillAppear", log: OSLog.default, type: .debug)
        
        playerScoreModifier = PlayerScoreModifier(for: player)
        os_log("ScoreModifier initialized", log: OSLog.default, type: .debug)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    //MARK: - Static table view setup
    /**
     Change the color of headers to black, this can't be done in Storyboard
     */
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        if let header = view as? UITableViewHeaderFooterView
        {
            header.textLabel?.textColor = .black
        }
    }
    
    //MARK: - Actions
    /**
     Decrease the score of the player with 1
     */
    @IBAction func decreaseByOne(_ sender: UIButton)
    {
        do
        {
            try playerScoreModifier?.decreaseScoreByOne()
        }
        catch ScoreModifierError.lessThanZero //User tried to adjust score to below 0
        {
            //TODO: show in view
            os_log("Less than zero exception", log: OSLog.default, type: .debug)
            print("Less than zero exception")
        }
        catch {
            print("Unknown error")
        }
        
        os_log("Score decreased with 1", log: OSLog.default, type: .debug)
        lbl_score.text = "\(player!.score)"
        os_log("Score label updated", log: OSLog.default, type: .debug)
    }
    
    /**
     Increase the score of the player with 1
     */
    @IBAction func increaseByOne(_ sender: UIButton)
    {
        playerScoreModifier?.increaseScoreByOne()
        os_log("Score increased with 1", log: OSLog.default, type: .debug)
        lbl_score.text = "\(player!.score)"
        os_log("Score label updated", log: OSLog.default, type: .debug)
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else
        {
            os_log("Unknown segue", log: OSLog.default, type: .error)
            return
        }
    }
}
