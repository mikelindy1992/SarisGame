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
    var shipId:Int = 0
    var shipType:Int = 0
    var shipLevel:Int = 0
    
    func GetShipId() -> Int
    {
        return shipId
    }
    
    func SetShipId(id: Int)
    {
        shipId = id
    }
    
    func GetShipType() -> Int
    {
        return shipType
    }
    
    func SetShipType(type: Int)
    {
        shipType = type
    }
    
    func GetShipLevel() -> Int
    {
        return shipLevel
    }
    
    func SetShipLevel(level: Int)
    {
        shipLevel = level
    }
    
    func CreateShip(id:Int, type:Int, level:Int)
    {
        shipId = id
        shipType = type
        shipLevel = level
    }
    
    func GetShipShipShield() -> Int
    {
        return GetBaseShieldForType(type: shipType) + (shipLevel * 10)
    }
    
    func GetBaseShieldForType(type: Int) -> Int
    {
        if(type == 1)
        {
            return 50;
        }
        
        return 1;
    }
}
