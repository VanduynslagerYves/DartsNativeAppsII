//
//  ProtoPlayer.swift
//  DartsNativeAppsII
//
//  Created by Yves on 20/11/2018.
//  Copyright © 2018 Yves. All rights reserved.
//

import Foundation

//CustomStringConvertible: toString in java
//Equatable: use to check if two instances are identical using == operator
//Comparable: use to sort on a property
//Codable: serialization and deserialization
protocol ProtoPlayer{
    var firstName: String {get}
    var lastName: String {get}
    var score: Int {get}
}
