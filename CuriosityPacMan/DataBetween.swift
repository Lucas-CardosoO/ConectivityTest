//
//  DataBetween.swift
//  CuriosityPacMan
//
//  Created by vinicius emanuel on 27/07/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import Foundation

let serviceType = "hws-kb"


enum Direction{
    case left
    case right
    case up
    case down
    
    static func fromString(side: String) -> Direction?{
        switch side {
        case "←":
            return Direction.left
        case "→":
            return Direction.right
        case "↑":
            return Direction.up
        case "↓":
            return Direction.down
        default:
            return nil
        }
        
        return nil
    }
}
