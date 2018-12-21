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
    //MARK: Properties
    //Initialize empty Player array
    var players = [Player]()
    {
        didSet
        {
            players.sort(){ $0.fullName.lowercased() < $1.fullName.lowercased()}
            //reload the tableview data when players array is changed
            //tableView.reloadData()
        }
    }
    
    private let playerInitError = "Player failed to initialize!"
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        //reload tableView data when this view will appear.
        //this needs to happen here and not in DidSet of players, or swiping for delete doesn't work
        //probably a conflict with redrawing and realoading data
        tableView.reloadData()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadPlayers()
        
        //editButtonItem is an already-defined button that switches the table view's
        //editing on and off
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    /*
     initialize players
     */
    private func loadPlayers()
    {
        guard let player1 = Player(firstName: "Bert", lastName: "Vanrotsbakker", 15) else {
            os_log("player init failure on player1", log: OSLog.default, type: .debug)
            fatalError(playerInitError)
        }
        guard let player2 = Player(firstName: "Noatn", lastName: "Caring", 6) else {
            os_log("player init failure on player2", log: OSLog.default, type: .debug)
            fatalError(playerInitError)
        }
        guard let player3 = Player(firstName: "Ernie", lastName: "Sesam", 0) else {
            os_log("player init failure on player3", log: OSLog.default, type: .debug)
            fatalError(playerInitError)
        }
        guard let player4 = Player(firstName: "Ernie", lastName: "Sesam", 0) else {
            os_log("player init failure on player3", log: OSLog.default, type: .debug)
            fatalError(playerInitError)
        }
        guard let player5 = Player(firstName: "Ernie", lastName: "Sesam", 0) else {
            os_log("player init failure on player3", log: OSLog.default, type: .debug)
            fatalError(playerInitError)
        }
        guard let player6 = Player(firstName: "Ernie", lastName: "Sesam", 0) else {
            os_log("player init failure on player3", log: OSLog.default, type: .debug)
            fatalError(playerInitError)
        }
        guard let player7 = Player(firstName: "Ernie", lastName: "Sesam", 0) else {
            os_log("player init failure on player3", log: OSLog.default, type: .debug)
            fatalError(playerInitError)
        }
        guard let player8 = Player(firstName: "Ernie", lastName: "Sesam", 0) else {
            os_log("player init failure on player3", log: OSLog.default, type: .debug)
            fatalError(playerInitError)
        }
        guard let player9 = Player(firstName: "Ernie", lastName: "Sesam", 0) else {
            os_log("player init failure on player3", log: OSLog.default, type: .debug)
            fatalError(playerInitError)
        }
        guard let player10 = Player(firstName: "Ernie", lastName: "Sesam", 0) else {
            os_log("player init failure on player3", log: OSLog.default, type: .debug)
            fatalError(playerInitError)
        }
        guard let player11 = Player(firstName: "Ernie", lastName: "Sesam", 0) else {
            os_log("player init failure on player3", log: OSLog.default, type: .debug)
            fatalError(playerInitError)
        }
        guard let player12 = Player(firstName: "Ernie", lastName: "Sesam", 0) else {
            os_log("player init failure on player3", log: OSLog.default, type: .debug)
            fatalError(playerInitError)
        }
        guard let player13 = Player(firstName: "Ernie", lastName: "Sesam", 0) else {
            os_log("player init failure on player3", log: OSLog.default, type: .debug)
            fatalError(playerInitError)
        }
        guard let player14 = Player(firstName: "Ernie", lastName: "Sesam", 0) else {
            os_log("player init failure on player3", log: OSLog.default, type: .debug)
            fatalError(playerInitError)
        }
        guard let player15 = Player(firstName: "Ernie", lastName: "Sesam", 0) else {
            os_log("player init failure on player3", log: OSLog.default, type: .debug)
            fatalError(playerInitError)
        }
        
        
        players += [player1, player2, player3, player4, player5, player6, player7, player8,
        player9, player10, player11, player12, player13, player14, player15]
    }
    
    // MARK: - Table view data source
    //Tells the table how many sections to display
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    //Tells the table how many rows to display in a section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        let cellId = "PlayerTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PlayerTableViewCell else {
            fatalError()
        }
        
        //2. Fetch the model object to be displayed
        let row = indexPath.row
        let player = players[row]
        
        //3. Configure the cell's properties with the model object properties
        cell.update(with: player)
        
        
        //Enables reordering of cells
        //cell.showsReorderControl = true
        
        //4. Return fully configured cell
        return cell
    }
    
    //delegate method: called when user taps row
    //instead of using storyboard to create a segue,
    //you can use a programmed segue here to navigate
    /*override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let p = players[indexPath.row]
        print(p)
    }*/
    
    //Deleting a player
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if(editingStyle == .delete)
        {
            //tableView.beginUpdates()
            players.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            //tableView.endUpdates()
            
            /*
             tableView.reloadData() -> this does not update the view right away, only after Done is pressed
             */
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
            return .delete
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        
        //Activates when we click a cell in the playerslist
        if (segue.identifier == "EditPlayerSegue")
        {
            /**
             We need to first access the UINavigationController to get to the
             AddEditPlayerTableViewController. Apple course forgets to mention this,
             just like they forgot the headphone jack
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
                //the player is a new player
                else
                {
                    //let newIndexPath = IndexPath(row: players.count, section: 0)
                    players.append(player)
                    //tableView.insertRows(at: [newIndexPath], with: .automatic)
                }
            }
        }
        if segue.identifier == "deleteUnwind"
        {
            if let indexPath = tableView.indexPathForSelectedRow
            {
                players.remove(at: indexPath.row)
            }
        }
    }
    /*@IBAction func unwindToPlayerList(segue: UIStoryboardSegue)
    {
        if let source = segue.source as? PlayerFormViewController, let player = source.player
        {
            //add the player to the list
            players.append(player)
        }
        
        if let source = segue.source as? PlayerEditViewController, let player = source.player
        {
            if let indexPath = tableView.indexPathForSelectedRow
            {
                let index = indexPath.row
                
                //UpdateToPlayerListSegue
                if segue.identifier == "saveUnwind"
                {
                    players.remove(at: index)
                    players.insert(player, at: index)
                    tableView.deselectRow(at: indexPath, animated: true)
                }
                if(segue.identifier == "DeleteToPlayerListSegue")
                {
                    players.remove(at: index)
                }
            }
        }
    }*/
}
