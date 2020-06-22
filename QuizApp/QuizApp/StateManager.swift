//
//  StateManager.swift
//  QuizApp
//
//  Created by Duc Dang on 6/19/20.
//  Copyright © 2020 Christopher Ching. All rights reserved.
//

import Foundation

class StateManager {
    
    static var numCorrectKey = "NumberCorrectkey"
    static var questionIndexKey = "questionIndexKey"
    // passing data that you want to save
    static func saveState(numCorrect:Int, questionIndex:Int) {
        
        let defaults = UserDefaults.standard
        
        // store interger in to user default - Save the state data
        defaults.set(numCorrect, forKey: numCorrectKey)
        defaults.set(questionIndex, forKey: questionIndexKey)
    }
    
    // retrieve value one at a time
    static func retrieveValue(key: String) -> Any? {
        // Get a reference to user defaults
        let defaults = UserDefaults.standard
        
        return defaults.value(forKey: key)
    }
    
    static func clearState() {
        let defaults = UserDefaults.standard
        
        defaults.removeObject(forKey: numCorrectKey)
        defaults.removeObject(forKey: questionIndexKey)
    }
    
}
