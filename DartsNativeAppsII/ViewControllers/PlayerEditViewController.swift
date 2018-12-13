//
//  PlayerEditViewController.swift
//  DartsNativeAppsII
//
//  Created by Yves on 27/11/2018.
//  Copyright © 2018 Yves. All rights reserved.
//

import UIKit
import os.log

class PlayerEditViewController: UIViewController
{
    var player: Player?
    
    @IBOutlet weak var txt_firstName: UITextField!
    @IBOutlet weak var txt_lastName: UITextField!
    @IBOutlet weak var btn_save: UIBarButtonItem!
    @IBOutlet weak var btn_delete: UIBarButtonItem!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        guard let selectedPlayer = player else {
            fatalError("Player not found")
        }
        self.update(for: selectedPlayer)
        // Do any additional setup after loading the view.
    }
    
    private func update(for player: Player)
    {
        txt_firstName.text = player.firstName
        txt_lastName.text = player.lastName
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //Save button is set to unwind to PlayerList.
    //PlayerTable has access to this Player through sender.source
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        
        if let button = sender as? UIBarButtonItem, button === btn_save
        {
            guard let firstName = txt_firstName.text, let lastName = txt_lastName.text
                else { return }
            
            //performedAction = .update
            
            player?.firstName = firstName
            player?.lastName = lastName
        }
        /*
         
            os_log("Save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }*/
        
        /*if let button = sender as? UIBarButtonItem, button === btn_delete
        {
            //performedAction = .delete
        }*/
    }
}
