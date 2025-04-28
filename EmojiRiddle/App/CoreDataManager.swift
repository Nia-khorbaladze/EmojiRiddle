//
//  CoreDataManager.swift
//  EmojiRiddle
//
//  Created by Nkhorbaladze on 27.12.24.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let context: NSManagedObjectContext

    private init() {
        let persistentContainer = NSPersistentContainer(name: "EmojiRiddle")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        self.context = persistentContainer.viewContext
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Failed to save context: \(error)")
            }
        }
    }

    func preloadRiddles() {
        guard isDatabaseEmpty() else { return }

        let riddles = [
            // MARK: - Movies
            ["emoji": "🎩🪄🧙‍♂️", "options": ["Fantastic Beasts", "Harry Potter", "Lord of the Rings", "The Hobbit"], "correctAnswer": "Harry Potter", "hint": "A boy wizard with a scar.", "category": "Movies"],
            ["emoji": "🚢❄️💔", "options": ["Frozen", "Waterworld", "Titanic", "The Icebreaker"], "correctAnswer": "Titanic", "hint": "A tragic love story on a sinking ship.", "category": "Movies"],
            ["emoji": "🦖🌴⚡", "options": ["Jurassic Park", "The Land Before Time", "King Kong", "Godzilla"], "correctAnswer": "Jurassic Park", "hint": "Dinosaurs brought back to life on an island.", "category": "Movies"],
            ["emoji": "🛡️⚔️👑", "options": ["Game of Thrones", "Braveheart", "Lord of the Rings", "The Hobbit"], "correctAnswer": "Lord of the Rings", "hint": "A ring that rules them all.", "category": "Movies"],
            ["emoji": "🤖🌌🚀", "options": ["Interstellar", "Star Wars", "Blade Runner", "The Terminator"], "correctAnswer": "Star Wars", "hint": "An epic battle between the light and dark side.", "category": "Movies"],
            ["emoji": "🦇🌃🃏", "options": ["Joker", "Batman Begins", "Suicide Squad", "The Dark Knight"], "correctAnswer": "The Dark Knight", "hint": "A masked vigilante fights crime in Gotham.", "category": "Movies"],
            ["emoji": "🏠🎈🌄", "options": ["Finding Nemo", "Up", "Toy Story", "Coco"], "correctAnswer": "Up", "hint": "A flying house with balloons.", "category": "Movies"],
            ["emoji": "👸❄️⛄", "options": ["Frozen", "Moana", "The Little Mermaid", "Tangled"], "correctAnswer": "Frozen", "hint": "An ice queen with magical powers.", "category": "Movies"],
            ["emoji": "🦸‍♂️🕷️🏙️", "options": ["Superman", "Iron Man", "The Avengers", "Spider-Man"], "correctAnswer": "Spider-Man", "hint": "A superhero bitten by a radioactive spider.", "category": "Movies"],
            ["emoji": "👽📞🌌", "options": ["E.T.", "Arrival", "Independence Day", "Contact"], "correctAnswer": "E.T.", "hint": "An alien trying to phone home.", "category": "Movies"],
            
            // MARK: - Anime
            ["emoji": "🍙👊🔥", "options": ["Attack on Titan", "Dragon Ball Z", "One Piece", "Naruto"], "correctAnswer": "Dragon Ball Z", "hint": "A warrior searching for magical spheres.", "category": "Anime"],
            ["emoji": "🎩🍎📖", "options": ["One Piece", "Attack on Titan", "Death Note", "Bleach"], "correctAnswer": "Death Note", "hint": "A book that decides fate.", "category": "Anime"],
            ["emoji": "⛩️👹⚔️", "options": ["Demon Slayer", "Naruto", "Bleach", "Yu Yu Hakusho"], "correctAnswer": "Demon Slayer", "hint": "Fighting demons with a sword.", "category": "Anime"],
            ["emoji": "👒🏴‍☠️🌊", "options": ["One Piece", "Hunter x Hunter", "Black Lagoon", "Naruto"], "correctAnswer": "One Piece", "hint": "Pirates searching for the ultimate treasure.", "category": "Anime"],
            ["emoji": "🛡️⚔️🕊️", "options": ["Attack on Titan", "Claymore", "Fullmetal Alchemist", "Berserk"], "correctAnswer": "Attack on Titan", "hint": "Humans fight giants to survive.", "category": "Anime"],
            ["emoji": "🤖🚀🌌", "options": ["Neon Genesis Evangelion", "Space Dandy", "Cowboy Bebop", "Gundam"], "correctAnswer": "Neon Genesis Evangelion", "hint": "Pilots control giant mechs to save humanity.", "category": "Anime"],
            ["emoji": "🍵🎎👊", "options": ["Bleach", "Hunter x Hunter", "Naruto", "Jujutsu Kaisen"], "correctAnswer": "Naruto", "hint": "A ninja's journey to become Hokage.", "category": "Anime"],
            ["emoji": "⚙️🤖🔧", "options": ["Black Clover", "Steins;Gate", "Fullmetal Alchemist", "Soul Eater"], "correctAnswer": "Fullmetal Alchemist", "hint": "Alchemy and automail play key roles.", "category": "Anime"],
            ["emoji": "🌌🎸🚬", "options": ["Cowboy Bebop", "Outlaw Star", "Space Dandy", "Trigun"], "correctAnswer": "Cowboy Bebop", "hint": "A space bounty hunter and his jazz.", "category": "Anime"],
            ["emoji": "🐰🔫🎩", "options": ["Overlord", "Re:Zero", "Beastars", "Black Lagoon"], "correctAnswer": "Black Lagoon", "hint": "Mercenaries in a criminal underworld.", "category": "Anime"],
            
            // MARK: - Books
            ["emoji": "🌊🏞️🧘‍♂️", "options": ["Siddhartha", "The Old Man and the Sea", "The Alchemist", "Walden"], "correctAnswer": "Siddhartha", "hint": "A spiritual journey along the river.", "category": "Books"],
            ["emoji": "😞📖🙅‍♂️", "options": ["No Longer Human", "The Stranger", "Notes from Underground", "Crime and Punishment"], "correctAnswer": "No Longer Human", "hint": "A tale of alienation and despair.", "category": "Books"],
            ["emoji": "⏳💀✉️", "options": ["Death with Interruptions", "One Hundred Years of Solitude", "The Book Thief", "Blindness"], "correctAnswer": "Death with Interruptions", "hint": "What if people stopped dying?", "category": "Books"],
            ["emoji": "👁️🎥📜", "options": ["Animal Farm", "Fahrenheit 451", "Brave New World", "1984"], "correctAnswer": "1984", "hint": "A dystopia ruled by Big Brother.", "category": "Books"],
            ["emoji": "✈️🛠️🤔", "options": ["Zen and the Art of Motorcycle Maintenance", "Steppenwolf", "Homo Faber", "The Catcher in the Rye"], "correctAnswer": "Homo Faber", "hint": "A rational man confronts his fate.", "category": "Books"],
            ["emoji": "🧠💥🥊", "options": ["Trainspotting", "Fight Club", "The Road", "American Psycho"], "correctAnswer": "Fight Club", "hint": "The first rule is not to talk about it.", "category": "Books"],
            ["emoji": "🌸🛏️🌀", "options": ["The Bell Jar", "The Awakening", "The Yellow Wallpaper", "The Hours"], "correctAnswer": "The Bell Jar", "hint": "A young woman's descent into depression.", "category": "Books"],
            ["emoji": "🌟👑✈️", "options": ["The Little Prince", "Peter Pan", "The Alchemist", "Alice in Wonderland"], "correctAnswer": "The Little Prince", "hint": "A small boy travels the universe.", "category": "Books"],
            ["emoji": "💸🛒📊", "options": ["Capital", "Moneyball", "99 Francs", "The Great Gatsby"], "correctAnswer": "99 Francs", "hint": "A satirical critique of consumerism.", "category": "Books"],
            ["emoji": "🐑🔪🧠", "options": ["American Psycho", "The Silence of the Lambs", "Hannibal", "Gone Girl"], "correctAnswer": "The Silence of the Lambs", "hint": "A clever killer and a cannibalistic helper.", "category": "Books"]
        ]


        for riddleData in riddles {
            let riddle = Riddle(context: context)
            riddle.emoji = riddleData["emoji"] as? String
            riddle.answerOptions = riddleData["options"] as? [String] as NSObject?
            riddle.correctAnswer = riddleData["correctAnswer"] as? String
            riddle.hint = riddleData["hint"] as? String
            riddle.category = riddleData["category"] as? String
        }

        saveContext()
    }

    private func isDatabaseEmpty() -> Bool {
        let fetchRequest = NSFetchRequest<Riddle>(entityName: "Riddle")
        do {
            let count = try context.count(for: fetchRequest)
            return count == 0
        } catch {
            print("Error checking database: \(error)")
            return true
        }
    }
}

