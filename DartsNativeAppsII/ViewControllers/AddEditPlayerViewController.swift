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
    @IBOutlet weak var txt_notes: UITextView!
    
    var player: Player?
    
    override func viewWillAppear(_ animated: Bool)
    {
        //if player has a value, display the player details
        if let player = player
        {
            txt_firstname.text = player.firstName
            txt_lastname.text = player.lastName
            txt_notes.text = player.notes
        }
        
        //Check if the Save button should be enabled on view load
        updateSaveButtonState()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60.0
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else
        {
            return
        }
        
        let firstName = txt_firstname.text ?? ""
        let lastName = txt_lastname.text ?? ""
        let notes = txt_notes.text ?? ""
        
        //player?.score ?? 0 -> use score if it has a value, otherwise use 0
        player = Player(firstName: firstName, lastName: lastName, (player?.score ?? 0), notes )
    }
    
    
    //MARK: - User interface setup
    
    //txt_firstname and txt_lastname are connected to this through Primary Action Triggered
    //when return is pressed in these fields the keyboard hides
    @IBAction func returnPressed(_ sender: UITextField) {
        txt_firstname.resignFirstResponder()
    }
    
    //change color of headers to black, this can't be done in Storyboard
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = .black
        }
    }
}
