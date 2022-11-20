//
//  Game.swift
//  Apple Pie
//
//  Created by Oleg Dorozhovets on 30/09/2022.
//

import Foundation

struct Game {
    var word                    : String
    var incorrectMoviesRemaining: Int
    var guessedLatters          : [Character]
    
    mutating func playerGuessed(letter: Character) {
        guessedLatters.append(letter)
        if !word.contains(letter) {
            incorrectMoviesRemaining -= 1
        }
    }
    
    var formatedWord: String {
        var guessedWord = ""
        for letter in word {
            if guessedLatters.contains(letter) {
                guessedWord += "\(letter.lowercased())"
            } else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
}
