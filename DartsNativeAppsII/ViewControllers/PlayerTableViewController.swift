//
//  PlayerTableViewController.swift
//  Darts
//
//  Created by Yves on 01/11/2018.
//  Copyright © 2018 Yves. All rights reserved.

import UIKit
import os.log

class PlayerTableViewController: UITableViewController
{
    //MARK: - Properties
    /** Initialize empty Player array */
    var players = [Player]()
    {
        didSet
        {
            players.sort(){ $0.fullName.lowercased() < $1.fullName.lowercased()}
        }
    }
    
    private let playerInitError = "Player failed to initialize!"
    
    //MARK: - Lifecycle functions
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        //Check if there are saved players
        if let savedPlayers = PlayerArchive.loadPlayers()
        {
            players = savedPlayers
            /*if players.count == 0
            {
                loadSamplePlayers()
            }*/
        }
        
        /**
         Reload tableView data when this view will appear.
         This needs to happen here and not in didSet of players, or swiping for delete doesn't work.
         Probably a conflict with redrawing the view and reloading the data
         */
        tableView.reloadData()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        /* editButtonItem is an already-defined button that switches the table view's
        editing on and off */
        navigationItem.leftBarButtonItem = editButtonItem
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
        let cellId = "PlayerTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PlayerTableViewCell else
        {
            fatalError()
        }
        
        //2. Fetch the model object to be displayed
        let row = indexPath.row
        let player = players[row]
        
        //3. Configure the cell's properties with the model object properties
        cell.update(with: player)
        
        //4. Return fully configured cell
        return cell
    }
    
    /**
     Executes when the user swipes an item in the list.
     Swiping deletes a player from the list
     */
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if(editingStyle == .delete)
        {
            //Remove the player
            players.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            //Save the players to disk
            PlayerArchive.savePlayers(players)
        }
    }
    
    /**
     Tells the tableView that we can edit a row, here we return true for all rows.
     Needed for deleting a player with a swiping action
     */
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    /**
     Sets the editingStyle for the tableView.
     Needed for deleting a player with a swiping action.
     */
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle
    {
            return .delete
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        
        //Activates when we click a cell in the playerslist
        if (segue.identifier == "EditPlayerSegue")
        {
            /*
             We need to first access the UINavigationController to get to the
             AddEditPlayerTableViewController. Apple course forgets to mention this,
             just like they forgot the headphone jack.
             */
            let navigation = segue.destination as! UINavigationController
            
            let indexPath = tableView.indexPathForSelectedRow!
            let player = players[indexPath.row]
            guard let addEditPlayerTableViewController = navigation.topViewController as? AddEditPlayerViewController else
            {
                fatalError("Unknown controller: \(segue.destination)")
            }
            addEditPlayerTableViewController.player = player
            addEditPlayerTableViewController.title = "Edit \(player.firstName)"
            addEditPlayerTableViewController.btn_delete.isEnabled = true
        }
    }
    
    @IBAction func unwindToPlayerList(segue: UIStoryboardSegue)
    {
        let source = segue.source as! AddEditPlayerViewController
        
        //Unwind is caused by tapping the save button
        if segue.identifier == "saveUnwind"
        {
            //AddEditPlayerViewController has a Player
            if let player = source.player
            {
                //the player was edited
                if let indexPath = tableView.indexPathForSelectedRow
                {
                    //update the player in the player array
                    players[indexPath.row] = player
                }
                //the player is a new player
                else
                {
                    /*
                     insert the new player in the player array
                     indexPath is not needed, as we sort the array before displaying it in the tableView
                     and reload the array into the tableView
                     */
                    players.append(player)
                }
            }
        }
        //Unwind is caused by tapping the delete button
        if segue.identifier == "deleteUnwind"
        {
            if let indexPath = tableView.indexPathForSelectedRow
            {
                players.remove(at: indexPath.row)
            }
        }
        //Save the players to disk
        PlayerArchive.savePlayers(players)
    }
    
    //MARK: - Other
    
    /*
     Initialize players
     */
    private func loadSamplePlayers()
    {
        guard let player1 = Player(firstName: "Bert", lastName: "Vanrotsbakker", 15, "a short description") else {
            os_log("player init failure on player1", log: OSLog.default, type: .debug)
            fatalError(playerInitError)
        }
        players += [player1]
    }
}
