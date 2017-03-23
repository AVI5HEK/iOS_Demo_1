//
//  User.swift
//  Avishek
//
//  Created by framgia on 10/20/16.
//  Copyright © 2016 framgia. All rights reserved.
//

import Foundation

class User/*: NSObject, NSCoding*/ {
    var username: String = ""
    var password: String = ""
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("user")
    
    // MARK: - UserDefaults
    
    static let userDefaults = UserDefaults.standard
    
    // MARK: Types
    
    struct PropertyKey {
        static let usernameKey = "username"
        static let passwordKey = "password"
    }
    
    // MARK: Initialization
    
    init?(username: String, password: String) {
        self.username = username
        self.password = password
        
//        super.init()
        
        // Initialization should fail if there is no name or if the rating is negative.
        if username.isEmpty || password.isEmpty {
            return nil
        }
    }
    
    // MARK: NSCoding
//
//    public func encode(with aCoder: NSCoder) {
//        aCoder.encode(username, forKey: PropertyKey.usernameKey)
//        aCoder.encode(password, forKey: PropertyKey.passwordKey)
//    }
//    
//    required convenience init?(coder aDecoder: NSCoder) {
//        let username = aDecoder.decodeObject(forKey: PropertyKey.usernameKey) as! String
//        let password = aDecoder.decodeObject(forKey: PropertyKey.passwordKey) as! String
//        
//        // Must call designated initializer.
//        self.init(username: username, password: password)
//    }
    
    // MARK: NSCoding
    
    static func saveUser(user: User) {
//        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(user, toFile: User.ArchiveURL.path)
//        if !isSuccessfulSave {
//            print("Failed to save user credentials...")
//        }
        userDefaults.set(user.username, forKey: PropertyKey.usernameKey)
        userDefaults.set(user.password, forKey: PropertyKey.passwordKey)
    }
    
    static func loadUser() -> User? {
//        return NSKeyedUnarchiver.unarchiveObject(withFile: User.ArchiveURL.path) as? User
        var user = User(username: "", password: "")
        if userDefaults.string(forKey: PropertyKey.usernameKey) != nil {
            user = User(username: userDefaults.string(forKey: PropertyKey.usernameKey)!, password: userDefaults.string(forKey: PropertyKey.passwordKey)!)
        }
        return user
    }
}
