//
//  UserInfo.swift
//  SarisGame
//
//  Created by Michael Lindenmayer on 2/1/17.
//  Copyright © 2017 Hadjilogics. All rights reserved.
//

import Foundation

class UserInfo
{
    var userId:Int = 0
    var theCrystalCount:Int = 0
    var theTokenCount:Int = 0
    var theShipPartCount:Int = 0
    var theItemPartCount:Int = 0
    var theShipObjects:Array<ShipObject> = []
    
    func BuildObjectFromJSON(jsonString: String) -> Bool
    {
        // Serialize the json object into a class
        var isValidJson = 0
        do
        {
            let data = jsonString.data(using: .ascii)
            let json = try JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments) as! Dictionary<String, AnyObject>
            if(json.index(forKey: "user_id") != nil)
            {
                userId = json["user_id"] as! Int
                isValidJson += 1
            }
            if(json.index(forKey: "crystals") != nil)
            {
                theCrystalCount = json["crystals"] as! Int
                isValidJson += 1
            }
            if(json.index(forKey: "tokens") != nil)
            {
                theTokenCount = json["tokens"] as! Int
                isValidJson += 1
            }
            if(json.index(forKey: "ship_parts") != nil)
            {
                theShipPartCount = json["ship_parts"] as! Int
                isValidJson += 1
            }
            if(json.index(forKey: "item_parts") != nil)
            {
                theItemPartCount = json["item_parts"] as! Int
                isValidJson += 1
            }
            if(json.index(forKey: "ships") != nil)
            {
                let shipArray = json["ships"] as! Array<Dictionary<String, AnyObject>>
                isValidJson += 1
                
                for ship in shipArray
                {
                    var isValid = 0
                    var ship_id = 0
                    var ship_type = 0
                    var ship_level = 0
                    if(ship.index(forKey: "ship_id") != nil)
                    {
                        ship_id = ship["ship_id"] as! Int
                        isValid += 1
                    }
                    if(ship.index(forKey: "ship_type") != nil)
                    {
                        ship_type = ship["ship_type"] as! Int
                        isValid += 1
                    }
                    if(ship.index(forKey: "ship_level") != nil)
                    {
                        ship_level = ship["ship_level"] as! Int
                        isValid += 1
                    }
                    if(isValid == 3)
                    {
                        let shipItem = ShipObject()
                        shipItem.CreateShip(id: ship_id, type: ship_type, level: ship_level)
                        theShipObjects.append(shipItem);
                    }
                    else
                    {
                        isValidJson -= 1
                        break
                    }
                }
            }
            
            
        }
        catch
        {
            print(error)
        }
        
        // Check if the JSON was valid!
        if(isValidJson != 6)
        {
            return false
        }
        
        return true
    }
    
    func GetCrystalCount() -> Int
    {
        return theCrystalCount
    }
    
    func GetTokenCount() -> Int
    {
        return theTokenCount
    }
    
    func GetShipPartCount() -> Int
    {
        return theShipPartCount
    }
    
    func GetItemPartCount() -> Int
    {
        return theItemPartCount
    }
    
    func GetShips() -> Array<ShipObject>
    {
        return theShipObjects
    }
}
