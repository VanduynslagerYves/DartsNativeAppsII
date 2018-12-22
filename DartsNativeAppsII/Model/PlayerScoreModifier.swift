//
//  PlayerScoreModifier.swift
//  DartsNativeAppsII
//
//  Created by Yves on 12/12/2018.
//  Copyright © 2018 Yves. All rights reserved.
//

import Foundation
import os.log

class PlayerScoreModifier
{
    //MARK: - Properties
    let player: Player
    
    //MARK: - Initialization
    /// - parameter player: the player which score to adjust
    init?(for player: Player?)
    {
        guard let p = player else
        {
            os_log("Player was not initialized", log: OSLog.default, type: .error)
            return nil
        }
        
        self.player = p
        os_log("Player is initialized", log: OSLog.default, type: .debug)
    }
    
    /**
     Increase the score of the player with one
     */
    func increaseScoreByOne()
    {
        player.score += 1
    }
    
    /**
     Decrease the score of the player with one
     */
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
}
