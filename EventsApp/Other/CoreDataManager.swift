//
//  CoreDataManger.swift
//  EventsApp
//
//  Created by icedoutxcv on 04/10/2020.
//

import Foundation
import CoreData
import UIKit

final class CoreDataManager {
    
    static let shared = CoreDataManager()
        
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "EventsApp")
        persistentContainer.loadPersistentStores {_, error in
            print(error?.localizedDescription ?? "")
        }
        return persistentContainer
    }()
    
    var moc: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func get<T: NSManagedObject>(_ id: NSManagedObjectID) -> T? {
        do {
            return try moc.existingObject(with: id) as? T
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func getAll<T: NSManagedObject>() -> [T] {
        do {
            let fetchRequest = NSFetchRequest<T>(entityName: "\(T.self)")
            return try moc.fetch(fetchRequest)
        } catch {
            print(error)
            return []
        }
    }
    
    func save() {
        do {
            try moc.save()
        } catch {
            print(error)
        }
    }
    
//
//    func saveEvent(name: String, date: Date, image: UIImage) {
//        let event = Event(context: moc)
//        event.setValue(name, forKey: "name")
//
//        let resizedImage = image.sameAspectRation(newHeight: 250)
//
//        let imageData = resizedImage.jpegData(compressionQuality: 0.5)
//        event.setValue(imageData, forKey: "image")
//        event.setValue(date, forKey: "date")
//
//        do {
//            try moc.save()
//        } catch {
//            print(error)
//        }
//    }
//
//    func updateEvent(event: Event, name: String, date: Date, image: UIImage) {
//        event.setValue(name, forKey: "name")
//
//        let resizedImage = image.sameAspectRation(newHeight: 250)
//
//        let imageData = resizedImage.jpegData(compressionQuality: 0.5)
//        event.setValue(imageData, forKey: "image")
//        event.setValue(date, forKey: "date")
//
//        do {
//            try moc.save()
//        } catch {
//            print(error)
//        }
//    }
//
    
}
