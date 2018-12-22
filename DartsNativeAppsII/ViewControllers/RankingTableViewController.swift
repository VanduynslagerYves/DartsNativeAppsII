//
//  PlayerTableViewController.swift
//  Darts
//
//  Created by Yves on 01/11/2018.
//  Copyright © 2018 Yves. All rights reserved.

import UIKit
import os.log

class RankingTableViewController: UITableViewController
{
    //MARK: - Properties
    //Initialize empty Player array
    var players = [Player]()
    {
        didSet
        { //when players array is changed: sort on name
            players = players.sorted(by: >)
            os_log("Players array updated", log: OSLog.default, type: .debug)
        }
    }
    
    //MARK: - Lifecycle functions
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        //check if there are saved players
        if let savedPlayers = PlayerArchive.loadPlayers()
        {
            players = savedPlayers
            /*if players.count == 0
            {
                loadSamplePlayers()
            }*/
        }
        
        tableView.reloadData()
        os_log("tableView data reloaded in viewWillAppear", log: OSLog.default, type: .debug)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    

    //MARK: - Table view & data source setup
    /**
     Tells the table how many sections to display
     */
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    /**
     Tells the table how many rows to display in a section
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0
        {
            return players.count
        }
        else
        {
            return 0
        }
    }

    /**
     Sets up one cell
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //1. Fetch correct cell type by dequeueing a cell
        let cellId = "RankingTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? RankingTableViewCell else
        {
            os_log("Failed to initialize cell", log: OSLog.default, type: .error)
            fatalError("Failed to initialize cell")
        }
        
        //2. Fetch the model object to be displayed
        let row = indexPath.row
        let player = players[row]
        
        //3. Configure the cell's properties with the model object properties
        cell.update(with: player, rank: row)

        os_log("Cell setup complete", log: OSLog.default, type: .debug)
        //4. Return fully configured cell
        return cell
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        os_log("Prepare for segue to EditPlayerScoreViewController", log: OSLog.default, type: .debug)
        
        //Activates when we click a cell in the ranking list
        if (segue.identifier == "EditScoreSegue")
        {
            /**
             We need to first access the UINavigationController to get to the
             AddEditPlayerTableViewController. Apple course forgets to mention this,
             just like they forgot the headphone jack
             */
            let navigation = segue.destination as! UINavigationController
            
            let indexPath = tableView.indexPathForSelectedRow!
            let player = players[indexPath.row]
            
            guard let editPlayerScoreViewController = navigation.topViewController as? EditPlayerScoreViewController else
            {
                os_log("Unknown controller", log: OSLog.default, type: .error)
                fatalError("Unknown controller: \(segue.destination)")
            }
            editPlayerScoreViewController.player = player
        }
    }
    
    @IBAction func unwindToRankList(segue: UIStoryboardSegue)
    {
        let source = segue.source as! EditPlayerScoreViewController
        
        if segue.identifier == "saveUnwind"
        {
            os_log("User saved player", log: OSLog.default, type: .debug)
            //Check if EditPlayerScoreController has a Player
            if let player = source.player
            {
                //the player was edited
                if let indexPath = tableView.indexPathForSelectedRow
                {
                    players[indexPath.row] = player
                }
            }
        }
        os_log("Unwinded from EditPlayerScoreViewController", log: OSLog.default, type: .debug)
        
        PlayerArchive.savePlayers(players)
    }
    
    //MARK: - Other
    /**
     Initialize sample player(s)
     */
    private func loadSamplePlayers()
    {
        guard let player1 = Player(firstName: "Bert", lastName: "Vanrotsbakker", 15, "a short description") else
        {
            os_log("Player initialization failure on player1", log: OSLog.default, type: .error)
            return
        }
        
        players += [player1]
    }
}
