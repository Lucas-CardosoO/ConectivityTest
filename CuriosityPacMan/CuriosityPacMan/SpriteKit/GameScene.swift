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
    private lazy var bot = childNode(withName: "bot") as! SKSpriteNode
    private lazy var cat = childNode(withName: "cat") as! SKSpriteNode
    
    private lazy var map: SKTileMapNode = childNode(withName: "TileMap") as! SKTileMapNode
    
    var endGameFunction: ((String)->(Void))!
    
    private var dirMoveP1: Direction = .none
    private var currDirP1: Direction = .none
    private var dirMoveP2: Direction = .none
    private var currDirP2: Direction = .none
    private var dirMoveBot: Direction = .none
    
    override func didMove(to view: SKView) {
        print("print")
        self.moveToNextTileP1()
        self.moveToNextTileP2()
        self.moveBot()
    }
    
    override func update(_ currentTime: TimeInterval) {
        if (checkCollision(cat.position, bot.position)) {
            cat.removeFromParent()
            self.endGameFunction("a Inquisição Espanhola")
        }
        
        if (checkCollision(p1.position, bot.position)) {
            bot.removeFromParent()
            self.endGameFunction("Player 1")
        }
        
        if (checkCollision(p2.position, bot.position)) {
            bot.removeFromParent()
            self.endGameFunction("Player 2")
        }
    }
    
    func checkCollision(_ a: CGPoint, _ b: CGPoint) -> Bool {
        let columnA = map.tileColumnIndex(fromPosition: a)
        let rowA = map.tileRowIndex(fromPosition: a)
        
        let columnB = map.tileColumnIndex(fromPosition: b)
        let rowB = map.tileRowIndex(fromPosition: b)
        
        return (columnA == columnB) && (rowA == rowB)
    }
    
    fileprivate func tileCheck(_ nextTile: CGPoint) -> Bool {
        let column = map.tileColumnIndex(fromPosition: nextTile)
        let row = map.tileRowIndex(fromPosition: nextTile)
        
        let tile = map.tileDefinition(atColumn: column, row: row)
        
        return tile?.name != "wall"
    }
    
    fileprivate func getNextPos(_ next: Direction, _ movePos: CGPoint) -> CGPoint{
        var moveTo = movePos
        
        switch next {
        case .down:
            moveTo.y -= 64
        case .left:
            moveTo.x -= 64
        case .right:
            moveTo.x += 64
        case .up:
            moveTo.y += 64
        case .none:
            break
        }
        
        return moveTo
    }
    
    func moveToNextTileP1(){
        let nextChangeDir = self.getNextPos(self.dirMoveP1, self.p1.position)
        let nextCurrDir = self.getNextPos(self.currDirP1, self.p1.position)
        
        if self.tileCheck(nextChangeDir) {
            self.currDirP1 = self.dirMoveP1
            self.p1.run(SKAction.move(to: nextChangeDir, duration: playerMovementTime)) {
                self.moveToNextTileP1()
            }
        } else if self.tileCheck(nextCurrDir){
            self.p1.run(SKAction.move(to: nextCurrDir, duration: playerMovementTime)){
                self.moveToNextTileP1()
            }
        } else {
            self.p1.run(SKAction.wait(forDuration: playerMovementTime)) {
                self.moveToNextTileP1()
            }
        }
    }
    
    
    func moveToNextTileP2(){
        let nextChangeDir = self.getNextPos(self.dirMoveP2, self.p2.position)
        let nextCurrDir = self.getNextPos(self.currDirP2, self.p2.position)
        
        if self.tileCheck(nextChangeDir) {
            self.currDirP2 = self.dirMoveP2
            self.p2.run(SKAction.move(to: nextChangeDir, duration: playerMovementTime)) {
                self.moveToNextTileP2()
            }
        } else if self.tileCheck(nextCurrDir){
            self.p2.run(SKAction.move(to: nextCurrDir, duration: playerMovementTime)){
                self.moveToNextTileP2()
            }
        } else {
            self.p2.run(SKAction.wait(forDuration: playerMovementTime)) {
                self.moveToNextTileP2()
            }
        }
    }
    
    func moveBot() {
        let nextMove = self.randomMoveBot()
        
        let nextChangeDir = self.getNextPos(nextMove, self.bot.position)
        let nextCurrDir = self.getNextPos(self.dirMoveBot, self.bot.position)
        
        if self.tileCheck(nextChangeDir) {
            self.dirMoveBot = nextMove
            self.bot.run(SKAction.move(to: nextChangeDir, duration: botMovementTime)) {
                self.moveBot()
            }
        } else if self.tileCheck(nextCurrDir){
            self.bot.run(SKAction.move(to: nextCurrDir, duration: botMovementTime)){
                self.moveBot()
            }
        } else {
            self.bot.run(SKAction.wait(forDuration: botMovementTime)) {
                self.moveBot()
            }
        }
    }
    
    func randomMoveBot() -> Direction {
        let randomNum = Int.random(in: 1...4)
        
        return Direction(rawValue: randomNum) ?? .none
    }
    
    func setP1Direction(direction: Direction) {
        self.dirMoveP1 = direction
    }
    
    func setP2Direction(direction: Direction) {
        self.dirMoveP2 = direction
    }
}

