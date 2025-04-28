//
//  CoreDataManagerExtension.swift
//  EmojiRiddle
//
//  Created by Nkhorbaladze on 27.12.24.
//

import CoreData

extension CoreDataManager {
    func fetchRiddles() -> [Riddle] {
        let fetchRequest: NSFetchRequest<Riddle> = Riddle.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch riddles: \(error)")
            return []
        }
    }
}
