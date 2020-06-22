//
//  Question.swift
//  QuizApp
//
//  Created by Duc Dang on 6/16/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import Foundation

struct Question: Codable {
    
    var question:String?
    var answers:[String]?
    var correctAnswerIndex:Int?
    var feedback:String?
    
}
