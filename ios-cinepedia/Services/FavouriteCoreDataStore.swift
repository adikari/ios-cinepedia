//
//  FavouriteCoreDataStore.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 31/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation
import CoreData

class FavouriteCoreDataStore: FavouriteStoreProtocol {
    func fetchFavouriteMovies(completionHandler: @escaping ([FavouriteMovie], FavouriteStoreError?) -> Void) {
        let fetchRequest = NSFetchRequest<ManagedFavourite>(entityName: "ManagedFavourite")
        
        do {
            let managedFavourites = try AppDelegate.viewContext.fetch(fetchRequest)
            
            let movies = managedFavourites.map { managedFavourite in
                return FavouriteMovie(
                    id: Int(managedFavourite.movieId ?? "0") ?? 0,
                    title: managedFavourite.title ?? "",
                    description: managedFavourite.desc ?? "",
                    imageUrl: managedFavourite.imageUrl ?? ""
                )
            }
            
            completionHandler(movies, nil)
        } catch {
            completionHandler([], FavouriteStoreError.CannotFetch(error.localizedDescription))
        }
    }
    
    func isFavourite(movieId: Int, completionHandler: @escaping(Bool, FavouriteStoreError?) -> Void) {
        let fetchRequest = NSFetchRequest<ManagedFavourite>(entityName: "ManagedFavourite")
        fetchRequest.predicate = NSPredicate(format: "movieId == %@", movieId.description)
        
        do {
            let managedFavouriteMovies = try AppDelegate.viewContext.fetch(fetchRequest)
            
            if (managedFavouriteMovies.first != nil) {
                completionHandler(true, nil)
            } else {
                completionHandler(false, nil)
            }
            
        } catch {
            completionHandler(false, FavouriteStoreError.CannotFetch(error.localizedDescription))
        }
    }
    
    func setFavourite(movie: FavouriteMovie, completionHandler: @escaping (FavouriteStoreError?) -> Void) {
        let context = AppDelegate.viewContext
        let entryToCreate = ManagedFavourite(context: context)
        
        entryToCreate.movieId = movie.id.description
        entryToCreate.desc = movie.description
        entryToCreate.imageUrl = movie.imageUrl
        entryToCreate.title = movie.title
        
        do {
            try context.save()
            completionHandler(nil)
        } catch {
        completionHandler(FavouriteStoreError.CannotCreate(error.localizedDescription))
            
        }
    }
    
    func removeFavourite(movieId: Int, completionHandler: @escaping (FavouriteStoreError?) -> Void) {
        let fetchRequest = NSFetchRequest<ManagedFavourite>(entityName: "ManagedFavourite")
        fetchRequest.predicate = NSPredicate(format: "movieId == %@", movieId.description)
        
        do {
            let context = AppDelegate.viewContext
            
            if let managedFavourites = try? context.fetch(fetchRequest) {
                for object in managedFavourites {
                    context.delete(object)
                }
                
                try context.save()
            }
            
            completionHandler(nil)

        } catch {
            completionHandler(FavouriteStoreError.CannotUpdate(error.localizedDescription))
        }
    }
}
