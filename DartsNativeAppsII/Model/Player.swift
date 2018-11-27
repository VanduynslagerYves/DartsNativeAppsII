//
//  File.swift
//  Darts
//
//  Created by Yves on 11/11/2018.
//  Copyright © 2018 Yves. All rights reserved.
//

import UIKit
import Foundation

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
    //var photo: UIImage?
    var score: Int
    
    //MARK: Computed property
    var fullName : String {
        return "\(firstName) \(lastName)"
    }
    //required for CustomStringConvertible (toString in Java)
    var description: String {
        return "Player(firstName: \(firstName), lastName: \(lastName), score: \(score), fullName: \(fullName)"
    }
    
    //MARK: Initialization
    init?(firstName first: String, lastName last: String, /*_ photo: UIImage?, */_ score: Int)
    {
        guard !first.isEmpty && !last.isEmpty else { //firstname and lastname must have values
            return nil
        }
        
        guard score >= 0 else { //score can never be lower than 0
            return nil
        }
        
        self.firstName = first
        self.lastName = last
        //self.photo = photo
        self.score = score
        
        //print self: uses description
        print(self)
    }
    
    //MARK: Equatable
    static func == (player1: Player, player2: Player) -> Bool {
        return player1.firstName == player2.firstName && player1.lastName == player2.lastName && player1.score == player2.score
    }
    
    //MARK: Comparable
    //used to sort players on score
    static func < (lhs: Player, rhs: Player) -> Bool {
        return lhs.score < rhs.score
    }
}
