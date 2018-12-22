//
//  File.swift
//  Darts
//
//  Created by Yves on 11/11/2018.
//  Copyright © 2018 Yves. All rights reserved.
//

import UIKit
import Foundation
import os.log

//Protocols: interfaces in java
//CustomStringConvertible: toString in java
//Equatable: use to check if two instances are identical using == operator
//Comparable: use to sort on a property
//Codable: serialization and deserialization
class Player: ProtoPlayer, CustomStringConvertible, Comparable, Equatable, Codable
{
    //MARK: Properties
    var firstName: String
    var lastName: String
    var score: Int
    var notes: String?
    
    //MARK: Computed properties
    var fullName : String
    {
        return "\(firstName) \(lastName)"
    }
    
    //Required for CustomStringConvertible (toString in Java)
    var description: String
    {
        return "Player(firstName: \(firstName), lastName: \(lastName), score: \(score), fullName: \(fullName)"
    }
    
    //MARK: Initialization
    /// - parameter first: first name of the player
    /// - parameter last: last name of the player
    /// - parameter score: score of the player
    /// - parameter notes: notes for the player
    init?(firstName first: String, lastName last: String, _ score: Int, _ notes: String?)
    {
        //firstname and lastname must have values
        guard !first.isEmpty && !last.isEmpty else
        {
            os_log("Tried to initialize player with empty first or last name", log: OSLog.default, type: .error)
            return nil
        }
        //score can never be lower than 0
        guard score >= 0 else
        {
            os_log("Tried to initialize player with score less than 0", log: OSLog.default, type: .error)
            return nil
        }
        
        self.firstName = first
        self.lastName = last
        self.score = score
        self.notes = notes
        
        os_log("Player was initialized", log: OSLog.default, type: .debug)
    }
    
    //MARK: Equatable
    /**
     Checks if two players are the same
     */
    /// - parameter player1: player to equate
    /// - parameter player2: player to equate
    static func == (player1: Player, player2: Player) -> Bool
    {
        return player1.firstName == player2.firstName && player1.lastName == player2.lastName && player1.score == player2.score && player1.notes == player2.notes
    }
    
    //MARK: Comparable
    /**
     Used to sort players based on score
     */
    /// - parameter lhs: player to compare
    /// - parameter rhs: player to compare
    static func < (lhs: Player, rhs: Player) -> Bool
    {
        return lhs.score < rhs.score
    }
}
