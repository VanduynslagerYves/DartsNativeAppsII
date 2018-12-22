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
    //MARK: Properties
    //Initialize empty Player array
    var players = [Player]() {
        didSet{
            players = players.sorted(by: >)
        }
    }
    
    internal let playerInitError = "Player failed to initialize!"
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        if let savedPlayers = PlayerArchive.loadPlayers()
        {
            players = savedPlayers
            /*if players.count == 0
            {
                loadSamplePlayers()
            }*/
        }
        
        tableView.reloadData()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //check if there are saved players
        
        
    }
    
    /*
     initialize players
     */
    private func loadSamplePlayers()
    {
        guard let player1 = Player(firstName: "Bert", lastName: "Vanrotsbakker", 15, "a short description") else {
            os_log("player init failure on player1", log: OSLog.default, type: .debug)
            fatalError(playerInitError)
        }
        
        players += [player1]
    }

    // MARK: - Table view data source
    //Tells the table how many sections to display
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //Tells the table how many rows to display in a section
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

    //Sets up one cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //1. Fetch correct cell type by dequeueing a cell
        let cellId = "RankingTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? RankingTableViewCell else {
            fatalError()
        }
        
        //2. Fetch the model object to be displayed
        let row = indexPath.row
        let player = players[row]
        
        //3. Configure the cell's properties with the model object properties
        cell.update(with: player, rank: row)

        //4. Return fully configured cell
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        
        //Activates when we click a cell in the playerslist
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
            //AddEditPlayerViewController has a Player
            if let player = source.player
            {
                //the player was edited
                if let indexPath = tableView.indexPathForSelectedRow
                {
                    players[indexPath.row] = player
                    //tableView.reloadRows(at: [indexPath], with: .none)
                }
            }
        }
        PlayerArchive.savePlayers(players)
    }
}
