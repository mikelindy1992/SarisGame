//
//  ShipObject.swift
//  SarisGame
//
//  Created by Michael Lindenmayer on 2/1/17.
//  Copyright © 2017 Hadjilogics. All rights reserved.
//

import Foundation

class ShipObject
{
    var theShipId:Int = 0
    var theShipType:Int = 0
    var theShipLevel:Int = 0
    var theShipShield:Int = 0
    var theShipAtk:Int = 0
    var theShipAtkSpeed:Int = 0
    var theShipSpeed:Int = 0
    var theShipRange:Int = 0
    var theShipRespawn:Int = 0
    var theShipCategory:Int = 0
    var theShipName:String = ""
    
    func GetShipId() -> Int
    {
        return theShipId
    }
    
    func SetShipId(id: Int)
    {
        theShipId = id
    }
    
    func GetShipType() -> Int
    {
        return theShipType
    }
    
    func SetShipType(type: Int)
    {
        theShipType = type
    }
    
    func GetShipLevel() -> Int
    {
        return theShipLevel
    }
    
    func SetShipLevel(level: Int)
    {
        theShipLevel = level
    }
    
    func GetShipShield() -> Int
    {
        return theShipShield + theShipLevel * 10
    }
    
    func GetShipAtk() -> Int
    {
        return theShipAtk + theShipLevel * 5
    }
    
    func GetShipAtkSpeed() -> Int
    {
        return theShipAtkSpeed
    }
    
    func GetShipSpeed() -> Int
    {
        return theShipSpeed
    }
    
    func GetShipRange() -> Int
    {
        return theShipRange
    }
    
    func GetShipRespawn() -> Int
    {
        return theShipRange
    }
    
    func GetShipCategory() -> Int
    {
        return theShipCategory
    }
    
    func GetShipName() -> String
    {
        return theShipName
    }
    
    func CreateShip(id:Int, type:Int, level:Int)
    {
        theShipId = id
        theShipType = type
        theShipLevel = level
        
        // Setup the stats for the ship
        SetShipStats()
    }
    
    func GetShipIconForCategory(cat: Int) ->String
    {
        if(cat == 1)
        {
            return "AttackShipIcon.png"
        }
        else if(cat == 2)
        {
            return "TankShipIcon.png"
        }
        else if(cat == 3)
        {
            return "SupportShipIcon.png"
        }
        else if(cat == 4)
        {
            return "UtilityShipIcon.png"
        }
        
        return "AttackShipIcon.png"
    }
    
    func SetShipStats()
    {
        if(theShipType == 1)
        {
            // Alpha
            theShipCategory = 1
            theShipShield = 75
            theShipAtk = 50
            theShipAtkSpeed = 60
            theShipSpeed = 5
            theShipRange = 4
            theShipRespawn = 8
            theShipName = "Alpha"
        }
    }
}
