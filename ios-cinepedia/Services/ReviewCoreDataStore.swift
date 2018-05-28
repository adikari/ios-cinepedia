//
//  ReviewCoreDataStore.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 27/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation
import CoreData

class ReviewCoreDataStore: ReviewStoreProtocol {

    func fetchReviews(movieId: Int, completionHandler: @escaping ([Review], ReviewStoreError?) -> Void) {
        let fetchRequest = NSFetchRequest<ManagedReview>(entityName: "ManagedReview")
        fetchRequest.predicate = NSPredicate(format: "movieId == %@", movieId.description)
        
        do {
            let managedReviews = try AppDelegate.viewContext.fetch(fetchRequest)

            let reviews = managedReviews.map { managedReview in
                return Review(
                    author: managedReview.author!,
                    content: managedReview.content!
                )
            }

            completionHandler(reviews, nil)
        } catch {
            completionHandler([], ReviewStoreError.CannotFetch(error.localizedDescription))
        }
        
    }
    
    func addReview(movieId: Int, review: Review, completionHandler: @escaping (Bool, ReviewStoreError?) -> Void) {
        let context = AppDelegate.viewContext
        let reviewToCreate = ManagedReview(context: context)
        
        reviewToCreate.id = UUID()
        reviewToCreate.author = review.author
        reviewToCreate.movieId = movieId.description
        reviewToCreate.content = review.content
        
        do {
            try context.save()
            completionHandler(true, nil)
        } catch {
            completionHandler(false, ReviewStoreError.CannotAdd(error.localizedDescription))
        }
    }
}
