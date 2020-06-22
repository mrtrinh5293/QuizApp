//
//  QuizModel.swift
//  QuizApp
//
//  Created by Duc Dang on 6/16/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import Foundation

protocol QuizProtocol {
    
    func questionsRetrieved(_ questions:[Question])
}

class QuizModel {
    
    var delegate:QuizProtocol?
    
    func getQuestions() {
        
        // Fetch the questions
//        getLocalJsonFile()
        getRemoteJsonFile()
    }
    
    func getLocalJsonFile() {
        
        // Get bundle path to json file
        let path = Bundle.main.path(forResource: "QuestionData", ofType: "json")
        
        // Double check that the path isn't nil
        guard path != nil else {
            print("Couldn't find the json data file")
            return
        }
        
        // Create URL object from the path
        let url = URL(fileURLWithPath: path!)
        
        do {
            // Get the data from the url
            let data = try Data(contentsOf: url)
            
            // Try to decode the data into objects
            let decoder = JSONDecoder()
            let array = try decoder.decode([Question].self, from: data)
            
            // Notify the delegate of the parsed objects
            delegate?.questionsRetrieved(array)
        }
        catch {
            // Error: Couldn't download the data at that URL
        }
    }
    
    func getRemoteJsonFile() {
        // Get a URL object
        let urlString = "https://codewithchris.com/code/QuestionData.json"
        
        let url = URL(string: urlString)
        
        guard url != nil else {
            print("COulndt get the url object")
            return
        }
        // Get a URL Session object
        let session = URLSession.shared
        
        // Get data task object
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error == nil && data != nil {
                do {
                    
                    let decoder = JSONDecoder()
                    
                    let array =  try decoder.decode([Question].self, from: data!)
                    DispatchQueue.main.async {
                        self.delegate?.questionsRetrieved(array)
                    }
                } catch {
                    print("Could not parse JSON")
                }
            }
        }
        // Call resume on the data task
        dataTask.resume()
    }
}
