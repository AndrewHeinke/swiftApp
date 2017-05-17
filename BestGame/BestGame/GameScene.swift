//
//  GameScene.swift
//  BestGame
//
//  Created by Niraj Jayant on 5/14/17.
//  Copyright © 2017 nirajjayant. All rights reserved.
//

import SpriteKit
import GameplayKit
import FirebaseDatabase

class GameScene: SKScene {
   
   var myBarrier : SKSpriteNode?
   var firebaseRef : FIRDatabaseReference?
   
   override func didMove(to view: SKView) {
      myBarrier = self.childNode(withName: "barrier") as? SKSpriteNode
      
      // set-up the connection to the FireBase database
      firebaseRef = FIRDatabase.database().reference(withPath: "player-positions")
      firebaseRef?.child("player1")
   }
   
   
   func touchDown(atPoint pos : CGPoint) {
      updatePlayerAndServer(atPoint: pos)
   }
   
   func touchMoved(toPoint pos : CGPoint) {
      updatePlayerAndServer(atPoint: pos)
   }
   
   func touchUp(atPoint pos : CGPoint) {
      updatePlayerAndServer(atPoint: pos)
   }
   
   func updatePlayerAndServer(atPoint pos: CGPoint)
   {
      let dict : Dictionary<String, Any> = ["xPos" : pos.x, "yPos" : pos.y];
      firebaseRef?.child("player1").setValue(dict);
      
      let xPos = pos.x
      myBarrier?.position.x = xPos

   }
   
   
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      for t in touches { self.touchDown(atPoint: t.location(in: self)) }
   }
   
   override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
      for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
   }
   
   override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      for t in touches { self.touchUp(atPoint: t.location(in: self)) }
   }
   
   override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
      for t in touches { self.touchUp(atPoint: t.location(in: self)) }
   }
   
   
   override func update(_ currentTime: TimeInterval) {
      // Called before each frame is rendered
   }
}
