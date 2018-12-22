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
    var score: Int
    var notes: String?
    
    //MARK: Computed property
    var fullName : String
    {
        return "\(firstName) \(lastName)"
    }
    //required for CustomStringConvertible (toString in Java)
    var description: String
    {
        return "Player(firstName: \(firstName), lastName: \(lastName), score: \(score), fullName: \(fullName)"
    }
    
    //MARK: Initialization
    init?(firstName first: String, lastName last: String, _ score: Int, _ notes: String?)
    {
        //firstname and lastname must have values
        guard !first.isEmpty && !last.isEmpty else { return nil }
        //score can never be lower than 0
        guard score >= 0 else { return nil }
        
        self.firstName = first
        self.lastName = last
        self.score = score
        self.notes = notes
    }
    
    //MARK: Equatable
    static func == (player1: Player, player2: Player) -> Bool
    {
        return player1.firstName == player2.firstName && player1.lastName == player2.lastName && player1.score == player2.score && player1.notes == player2.notes
    }
    
    //MARK: Comparable
    //used to sort players on score
    static func < (lhs: Player, rhs: Player) -> Bool
    {
        return lhs.score < rhs.score
    }
    
    //MARK: Persistence
    /*static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("players").appendingPathExtension("plist")
    
    //Gets the playerlist from disk
    static func loadPlayers() -> [Player]? {
        guard let savedPlayers = try? Data(contentsOf: ArchiveURL) else { return nil }
        
        let propertyListDecoder = PropertyListDecoder()
        
        return try? propertyListDecoder.decode(Array<Player>.self, from: savedPlayers)
    }
    
    //Saves the playerlist to disk
    static func savePlayers(_ players: [Player])
    {
        let propertyListEncoder = PropertyListEncoder()
        let playersList = try? propertyListEncoder.encode(players)
        try? playersList?.write(to: ArchiveURL, options: .noFileProtection)
    }*/
    //MARK: Codable
    //Code below is only needed if the model declares properties that do not
    //conform to the Codable protocol
    /*init(from: Decoder)
    {
        
    }
    func encode(to: Encoder)
    {
        
    }*/
}
