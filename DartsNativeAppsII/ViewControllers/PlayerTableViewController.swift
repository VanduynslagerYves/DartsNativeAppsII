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
        didSet{
            //players = players.sorted(by:{ $0.firstName > $1.lastName})
            players.sort() { $0.fullName < $1.fullName}
        }
    }
    
    private let playerInitError = "Player failed to initialize!"
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //reload tableView data when this view will appear.
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
    
    
    //MARK: Actions
    @IBAction func unwindToPlayerList(sender: UIStoryboardSegue)
    {
        if let source = sender.source as? PlayerFormViewController, let player = source.player
        {
            //index for the new row to be added
            //let index = IndexPath(row: players.count, section: 0)
            //add the player to the list
            players.append(player)
            //add a new row
            //tableView.insertRows(at: [index], with: .automatic)
        }
        
        if let source = sender.source as? PlayerEditViewController, let player = source.player
        {
                if let indexPath = tableView.indexPathForSelectedRow
                {
                    let index = indexPath.row
                
                    if(source.performedAction == .update)
                    {
                        players.remove(at: index)
                        //tableView.deleteRows(at: [indexPath], with: .automatic)
                
                        players.insert(player, at: index)
                        //tableView.insertRows(at: [indexPath], with: .automatic)
                
                        tableView.deselectRow(at: indexPath, animated: true)
                    }
                    if(source.performedAction == .delete)
                    {
                        players.remove(at: index)
                        //tableView.deleteRows(at: [indexPath], with: .automatic)
                    }
                }
        }
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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let p = players[indexPath.row]
        print(p)
    }
    
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
        
        if (segue.identifier == "EditSegue")
        {
            guard let playerEditViewController = segue.destination as? PlayerEditViewController else
            {
                fatalError("Unknown controller: \(segue.destination)")
            }
            
            guard let selectedPlayerCell = sender as? PlayerTableViewCell else
            {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedPlayerCell) else
            {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedPlayer = players[indexPath.row]
            playerEditViewController.player = selectedPlayer
            
            playerEditViewController.title = "Edit \(selectedPlayer.firstName)"
        }
    }
}
