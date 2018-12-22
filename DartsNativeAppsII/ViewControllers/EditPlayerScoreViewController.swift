//
//  PlayersViewController.swift
//  DartsNativeAppsII
//
//  Created by Yves on 11/11/2018.
//  Copyright © 2018 Yves. All rights reserved.
//

import UIKit

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
            fatalError("Player not found")
        }
        
        //Set the labels with player properties
        lbl_fullname.text = selectedPlayer.fullName
        lbl_score.text = "\(selectedPlayer.score)"
        lbl_notes.text = selectedPlayer.notes
        
        playerScoreModifier = PlayerScoreModifier(for: player)
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
            lbl_score.text = "\(player!.score)"
        }
        catch ScoreModifierError.lessThanZero //User tried to adjust score to below 0
        {
            //TODO: show in view
            print("less than zero error")
        }
        catch {
            print("unknown error")
        }
    }
    
    /**
     Increase the score of the player with 1
     */
    @IBAction func increaseByOne(_ sender: UIButton)
    {
        playerScoreModifier?.increaseScoreByOne()
        lbl_score.text = "\(player!.score)"
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else
        {
            return
        }
    }
}
