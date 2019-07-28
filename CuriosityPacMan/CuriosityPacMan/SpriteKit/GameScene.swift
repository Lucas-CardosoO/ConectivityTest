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
    private lazy var p2 = childNode(withName: "p2") as! SKSpriteNode
    
    private lazy var map: SKTileMapNode = childNode(withName: "TileMap") as! SKTileMapNode
    
    private var dirMoveP1: Direction
    private var dirMoveP2 = ""
    private var dirMoveBot = ""
    
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
    
    func moveToNextTileP1(next: Direction){
        var movePos = p1.position
        
        switch next {
        case .down:
            movePos.y -= 64
        case .left:
            movePos.x -= 64
        case .right:
            movePos.x += 64
        case .up:
            movePos.y += 64
        }
        
        if tileCheck(movePos) {
            self.p1.run(SKAction.move(to: movePos, duration: 0.3))
        }
    }
    
    
    func moveToNextTileP2(next: Direction){
        var movePos = p2.position
        
        switch next {
        case .down:
            movePos.y -= 64
        case .left:
            movePos.x -= 64
        case .right:
            movePos.x += 64
        case .up:
            movePos.y += 64
        }
        
        if tileCheck(movePos) {
            self.p2.run(SKAction.move(to: movePos, duration: 0.3))
        }
    }
    
    
}

