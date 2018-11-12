//
//  PlayersViewController.swift
//  DartsNativeAppsII
//
//  Created by Yves on 11/11/2018.
//  Copyright © 2018 Yves. All rights reserved.
//

import UIKit

class PlayerDetailViewController: UIViewController {
    
    var player: Player!
    @IBOutlet weak var lbl_fullname: UILabel!
    @IBOutlet weak var lbl_score: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl_fullname.text = player.fullName
        lbl_score.text = "\(player.score)"
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
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
