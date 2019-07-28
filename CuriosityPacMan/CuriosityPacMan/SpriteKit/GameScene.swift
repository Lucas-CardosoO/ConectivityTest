//
//  GameScene.swift
//  CuriosityPacMan
//
//  Created by vinicius emanuel on 27/07/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private lazy var p1 = childNode(withName: "p1") as! SKSpriteNode
    
    private lazy var map: SKTileMapNode = childNode(withName: "TileMap") as! SKTileMapNode
    
    override func didMove(to view: SKView) {
        print("print")
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    fileprivate func tileCheck(_ nextTile: CGPoint) -> Bool {
        let column = map.tileColumnIndex(fromPosition: nextTile)
        let row = map.tileRowIndex(fromPosition: nextTile)
        
        let tile = map.tileDefinition(atColumn: column, row: row)
        
        return tile?.name != "wall"
    }
    
    func moveToNextTile(next: Direction){
        var movie = p1.position
        
        switch next {
        case .down:
            movie.y -= 64
        case .left:
            movie.x -= 64
        case .right:
            movie.x += 64
        case .up:
            movie.y += 64
        }
        
        if tileCheck(movie) {
            self.p1.run(SKAction.move(to: movie, duration: 0.3))
        }
    }
    
    
    
}

