//
//  AddEditPlayerViewController.swift
//  DartsNativeAppsII
//
//  Created by Yves on 21/12/2018.
//  Copyright © 2018 Yves. All rights reserved.
//

import UIKit

class AddEditPlayerViewController: UITableViewController
{
    @IBOutlet weak var txt_firstname: UITextField!
    @IBOutlet weak var txt_lastname: UITextField!
    @IBOutlet weak var btn_add: UIBarButtonItem!
    @IBOutlet weak var btn_delete: UIBarButtonItem!
    
    var player: Player?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        //if player has a value, display the player details
        if let player = player {
            txt_firstname.text = player.firstName
            txt_lastname.text = player.lastName
        }
        
        //Check if the Save button should be enabled on view load
        updateSaveButtonState()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
    }
    
    //Checks if Save button should be enabled
    //Based on txt_firstname and txt_lastname empty values
    func updateSaveButtonState()
    {
        let firstname = txt_firstname.text ?? ""
        let lastname = txt_lastname.text ?? ""
        btn_add.isEnabled = !firstname.isEmpty && !lastname.isEmpty
    }
    
    //Connected to textfields "Editing Changed" event
    @IBAction func textEditingChanged(_ sender: UITextField)
    {
        updateSaveButtonState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else
        {
            return
        }
        
        let firstName = txt_firstname.text ?? ""
        let lastName = txt_lastname.text ?? ""
        
        //player?.score ?? 0 -> use score if it has a value, otherwise use 0
        player = Player(firstName: firstName, lastName: lastName, (player?.score ?? 0) )
    }
    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

}
