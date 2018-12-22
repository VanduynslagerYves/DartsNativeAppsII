//
//  PlayerDatabase.swift
//  DartsNativeAppsII
//
//  Created by Yves on 22/12/2018.
//  Copyright © 2018 Yves. All rights reserved.
//

import Foundation

class PlayerArchive
{
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
 
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("players").appendingPathExtension("plist")
 
    /**
     Gets the playerlist from disk
     */
    static func loadPlayers() -> [Player]?
    {
        guard let savedPlayers = try? Data(contentsOf: ArchiveURL) else { return nil }
 
        let propertyListDecoder = PropertyListDecoder()
 
        return try? propertyListDecoder.decode(Array<Player>.self, from: savedPlayers)
    }
 
    /**
     Saves the playerlist to disk
     */
    /// - parameter players: the array of players that needs to be saved
    static func savePlayers(_ players: [Player])
    {
        let propertyListEncoder = PropertyListEncoder()
        let playersList = try? propertyListEncoder.encode(players)
        try? playersList?.write(to: ArchiveURL, options: .noFileProtection)
    }
}
