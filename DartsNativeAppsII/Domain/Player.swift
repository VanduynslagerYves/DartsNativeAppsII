//
//  File.swift
//  Darts
//
//  Created by Yves on 11/11/2018.
//  Copyright © 2018 Yves. All rights reserved.
//

import UIKit
import Foundation

class Player
{
    //MARK: Properties
    var firstName: String
    var lastName: String
    var photo: UIImage?
    var score: Int
    
    //Computed property
    var fullName : String {
        return "\(firstName) \(lastName)"
    }
    
    //MARK: Initialization
    init?(firstName first: String, lastName last: String, _ photo: UIImage?, _ score: Int)
    {
        guard !first.isEmpty && !last.isEmpty else { //firstname and lastname must have values
            return nil
        }
        
        guard score >= 0 else { //score can never be lower than 0
            return nil
        }
        
        self.firstName = first
        self.lastName = last
        self.photo = photo
        self.score = score
    }
}
