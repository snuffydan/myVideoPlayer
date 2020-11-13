//
//  CoreDataMethods.swift
//  MyVideoPlayer
//
//  Created by Danushika Priyadarshani on 11/13/20.
//

import UIKit
import CoreData

class CoreDataMethods {
    
    static var users: [NSManagedObject] = []
    
    static func saveUserData(username: String, password: String) -> Bool {
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        
        let user = NSManagedObject(entity: entity, insertInto: managedContext)
        user.setValue(username, forKeyPath: "username")
        user.setValue(password, forKeyPath: "password")
        
        do {
            try managedContext.save()
            users.append(user)
            return true
          } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return false
          }
    }
    
    static func getUserData() -> [(username: String, password: String)] {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        var usersDetails: [(String, String)] = []
        
        do {
            users = try managedContext.fetch(fetchRequest)
            for user in users {
                let username = user.value(forKey: "username") as! String
                let password = user.value(forKey: "password") as! String
                usersDetails.append((username, password))
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return usersDetails
    }

}
