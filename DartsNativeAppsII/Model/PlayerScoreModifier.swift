//
//  PlayerScoreModifier.swift
//  DartsNativeAppsII
//
//  Created by Yves on 12/12/2018.
//  Copyright © 2018 Yves. All rights reserved.
//

import Foundation
class PlayerScoreModifier
{
    let player: Player
    
    init?(for player: Player?)
    {
        guard let p = player else { return nil }
        self.player = p
    }
    
    func increaseScoreByOne()
    {
        player.score += 1
    }
    
    func decreaseScoreByOne() throws
    {
        if(player.score - 1 < 0)
        {
            throw ScoreModifierError.lessThanZero
        }
        else
        {
            player.score -= 1
        }
    }
    
    /*
     do {
     try instructies
     print("success")
     }
     catch ScoreModifierError.lessThanZero {
        doStuff
     }
     catch ...
 */
    
}
