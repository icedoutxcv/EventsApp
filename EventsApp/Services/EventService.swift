//
//  EventService.swift
//  EventsApp
//
//  Created by icedoutxcv on 13/10/2020.
//

import UIKit
import CoreData

protocol EventServiceProtocol {
    func perform(_ action: EventService.EventAction, data: EventService.EventInputData)
    func getEvent(_ id: NSManagedObjectID) -> Event?
    func getEvent() -> [Event]
}

final class EventService: EventServiceProtocol {
    private let coreDataManager: CoreDataManager
    
    struct EventInputData {
        let name: String
        let date: Date
        let image: UIImage
    }
    enum EventAction {
        case add
        case update(Event)
    }
    
    init(coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
    }
    
    func perform(_ action: EventAction, data: EventInputData) {
        var event: Event
        switch action {
        case .add:
            event = Event(context: coreDataManager.moc)
        case .update(let eventToUpdate):
            event = eventToUpdate
        }
        
        event.setValue(data.name, forKey: "name")
        let resizedImage = data.image.sameAspectRation(newHeight: 250)
        let imageData = resizedImage.jpegData(compressionQuality: 0.5)
        event.setValue(imageData, forKey: "image")
        event.setValue(data.date, forKey: "date")
        
        coreDataManager.save()
    }
    
    func getEvent(_ id: NSManagedObjectID) -> Event? {
        return coreDataManager.get(id)
    }
    
    func getEvent() -> [Event] {
        return coreDataManager.getAll()
    }
    
}
