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

struct QuizModel {
    
    var delegate:QuizProtocol?
    
    func getQuestions() {
        
        // Fetch the questions
//        getLocalJsonFile()
        getRemoteJsonFile()
    }
    
    private func getRemoteJsonFile() {
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
