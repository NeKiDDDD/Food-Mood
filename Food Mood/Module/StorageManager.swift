//
//  FoodStructs.swift
//  Food Mood
//
//  Created by Nikita Kuznetsov on 07.04.2023.
//
import RealmSwift

class StorageManager {
    static let shared = StorageManager()
    
    private init() {}
    
    func save(recipes: Recipe) {
        let realm = try! Realm()
        write(realm) {
            realm.add(recipes)
        }
    }
    
    private func write(_ realm: Realm, _ completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch let error {
            print(error)
        }
    }
}
