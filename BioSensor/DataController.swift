//
//  DataController.swift
//  BioSensor
//
//  Created by Rivera Torres, Patria I. on 2/15/23.
//

import CoreData
import Foundation
import SwiftUI

class DataController: ObservableObject {
    @Environment(\.managedObjectContext) var moc
    
    let container = NSPersistentContainer(name: "BioSensor")

    init(){
        
        container.loadPersistentStores{(StoreDescription, error) in
            if let error = error{
                //fatalError("Loading of store failed \(error)")
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        
    }
    
    func createTilt(pitch: Double, dateTime: Date){
        let tilt = Tilt(context:moc)
        tilt.id = UUID()
        tilt.pitch = pitch
        tilt.dateTime = dateTime
        try?moc.save()
    }
    
    func fetchTilt() -> FetchedResults<Tilt>{
        @FetchRequest(sortDescriptors:[]) var tilt: FetchedResults<Tilt>
        try?moc.save()
        return tilt
    }
    
    func fetchTiltByDate(dateTime:Date)-> FetchedResults<Tilt>{
        @FetchRequest(
            sortDescriptors:[SortDescriptor(\.dateTime)],
            predicate:NSPredicate(format:"date == %@", dateTime as CVarArg)
        )var tilt: FetchedResults<Tilt>
        try?moc.save()
        return tilt
    }
    
    func fetchTiltByID(id:UUID)-> FetchedResults<Tilt>{
        @FetchRequest(
            sortDescriptors:[],
            predicate:NSPredicate(format:"id == %@", id as CVarArg)
        )var tilt: FetchedResults<Tilt>
        try?moc.save()
        return tilt
    }

    //Update Tilt data
    func deleteTilt(tilt:Tilt){
        container.viewContext.delete(tilt)
    }
    
    /*
    @discardableResult
    func createTilt(pitch:Double, dateTime:Date)->Tilt?{
        let context = container.viewContext
        
        let tilt = NSEntityDescription.insertNewObject(forEntityName:"Tilt", into:context) as! Tilt
        tilt.pitch = pitch
        tilt.dateTime = dateTime
        do{
            try context.save()
            return tilt
        } catch let createError{
            print("Failed to create: \(createError)")
        }
        return nil
    }
    
    //Fetch all Tilt data in the database
    func fetchTilt() -> [Tilt]?{
        let context = container.viewContext
        
        let fetchRequest = NSFetchRequest<Tilt>(entityName:"Tilt")
        
        do{
            let tilt = try context.fetch(fetchRequest)
            return tilt
        }catch let fetchError{
            print("Failed to fetch tilt data: \(fetchError)")
        }
        return nil
    }
    
    //Fetch Tilt data by Date
    func fetchTiltbyDate(date:Date) -> [Tilt]?{
        let context = container.viewContext
        
        let fetchRequest = NSFetchRequest<Tilt>(entityName:"Tilt")
        fetchRequest.predicate = NSPredicate(format:"date == %@", date as CVarArg)
        
        do{
            let tilt = try context.fetch(fetchRequest)
            return tilt
        }catch let fetchError{
            print("Failed to fetch tilt data: \(fetchError)")
        }
        return nil
    }
    
    //Fetch Tilt data by ID
    func fetchTiltByID(id:UUID)->Tilt?{
        let context = container.viewContext
        
        let fetchRequest = NSFetchRequest<Tilt>(entityName:"Tilt")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format:"id == %@", id as CVarArg)
        
        do{
            let tilt = try context.fetch(fetchRequest)
            return tilt.first
        } catch let fetchError{
            print("Failed to fetch: \(fetchError)")
        }
        return nil
    }
    
    
    //Update Tilt data
    func updateTilt(tilt:Tilt){
        let context = container.viewContext
        
        do{
            try context.save()
        }catch let createError{
            print("Failed to update: \(createError)")
        }
    }
    
    //Delete Tilt data
    func deleteTilt(tilt:Tilt){
        let context = container.viewContext
        context.delete(tilt)
        
        do{
            try context.save()
        }catch let createError{
            print("Failed to update: \(createError)")
        }
    }*/
}

