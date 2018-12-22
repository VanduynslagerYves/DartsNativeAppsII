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
    var player: Player?
    var playerScoreModifier: PlayerScoreModifier?
    
    @IBOutlet weak var lbl_fullname: UILabel!
    @IBOutlet weak var lbl_notes: UILabel!
    @IBOutlet weak var lbl_score: UILabel!
    
    //Update the content of views
    override func viewWillAppear(_ animated: Bool)
    {
        guard let selectedPlayer = player else {
            fatalError("Player not found")
        }
        
        lbl_fullname.text = selectedPlayer.fullName
        lbl_score.text = "\(selectedPlayer.score)"
        lbl_notes.text = selectedPlayer.notes
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        playerScoreModifier = PlayerScoreModifier(for: player)
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Static table view properties setup
    //change color of headers to black, this can't be done in Storyboard
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = .black
        }
    }
    
    //MARK: - Actions
    @IBAction func decreaseByOne(_ sender: UIButton)
    {
        do
        {
            try playerScoreModifier?.decreaseScoreByOne()
            lbl_score.text = "\(player!.score)"
        }
        catch ScoreModifierError.lessThanZero
        {
            //show in ui
            print("less than zero error")
        }
        catch {
            print("unknown error")
        }
        
    }
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
