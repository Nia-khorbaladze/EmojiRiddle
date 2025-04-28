//
//  HomePageViewModel.swift
//  EmojiRiddle
//
//  Created by Nkhorbaladze on 27.12.24.
//

import Foundation
import CoreData

final class HomePageViewModel {
    
    private let coreDataManager: CoreDataManager
    private(set) var categories: [String] = []
    var didUpdateCategories: (() -> Void)?

    // MARK: - Initializer
    init(coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
    }

    // MARK: - Fetch Categories
    func fetchCategories() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Riddle")
        fetchRequest.propertiesToFetch = ["category"]
        fetchRequest.returnsDistinctResults = true
        fetchRequest.resultType = .dictionaryResultType

        do {
            if let results = try coreDataManager.context.fetch(fetchRequest) as? [[String: String]] {
                categories = results.compactMap { $0["category"] }
                didUpdateCategories?()
            }
        } catch {
            print("Error fetching categories: \(error)")
        }
    }
}
