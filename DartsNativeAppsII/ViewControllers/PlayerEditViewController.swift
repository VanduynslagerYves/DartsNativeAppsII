//
//  PlayerEditViewController.swift
//  DartsNativeAppsII
//
//  Created by Yves on 27/11/2018.
//  Copyright © 2018 Yves. All rights reserved.
//

import UIKit

class PlayerEditViewController: UIViewController {

    var player: Player?
    @IBOutlet weak var txt_firstName: UITextField!
    @IBOutlet weak var txt_lastName: UITextField!
    
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
    @IBAction func save(_ sender: UIBarButtonItem)
    {
        //when save button is tapped
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
