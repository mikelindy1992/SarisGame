//
//  ShipObject.swift
//  SarisGame
//
//  Created by Michael Lindenmayer on 2/1/17.
//  Copyright © 2017 Hadjilogics. All rights reserved.
//

import Foundation

class ItemObject
{
    var theItemId:Int = 0
    var theItemType:Int = 0
    var theItemStatBoost:Int = 0
    var theItemShipId:Int = 0
    var theItemAbility:Int = 0
    var theItemName:String = ""
    
    func GetItemId() -> Int
    {
        return theItemId
    }
    
    func SetItemId(id: Int)
    {
        theItemId = id
    }
    
    func GetItemType() -> Int
    {
        return theItemType
    }
    
    func SetItemType(type: Int)
    {
        theItemType = type
    }
    
    func GetItemStatBoost() -> Int
    {
        return theItemStatBoost
    }
    
    func SetItemStatBoost(boost: Int)
    {
        theItemStatBoost = boost
    }
    
    func GetItemShipId() -> Int
    {
        return theItemShipId
    }
    
    func SetItemShipId(id: Int)
    {
        theItemShipId = id
    }
    
    func GetItemAbility() -> Int
    {
        return theItemAbility
    }
    
    func SetItemAbility(ability: Int)
    {
        theItemAbility = ability
    }
    
    func GetItemName() -> String
    {
        if(theItemType == 1)
        {
            return "Shield"
        }
        if(theItemType == 2)
        {
            return "Attack"
        }
        if(theItemType == 3)
        {
            return "Attack Speed"
        }
        if(theItemType == 4)
        {
            return "Speed"
        }
        if(theItemType == 5)
        {
            return "Range"
        }
        if(theItemType == 6)
        {
            return "Respawn"
        }
        
        return "Shield"
    }
    
    func CreateItem(id:Int, type:Int, boost:Int, ability:Int, shipId:Int)
    {
        theItemId = id
        theItemType = type
        theItemStatBoost = boost
        theItemAbility = ability
        theItemShipId = shipId
    }
    
    func GetItemImageName() -> String
    {
        if(theItemType == 1)
        {
            return "ShieldItemIcon.png"
        }
        if(theItemType == 2)
        {
            return "AttackItemIcon.png"
        }
        if(theItemType == 3)
        {
            return "AttackSpeedItemIcon.png"
        }
        if(theItemType == 4)
        {
            return "SpeedItemIcon.png"
        }
        if(theItemType == 5)
        {
            return "RangeItemIcon.png"
        }
        if(theItemType == 6)
        {
            return "RespawnItemIcon.png"
        }
        
        return "ShieldItemIcon.png"
    }
}
