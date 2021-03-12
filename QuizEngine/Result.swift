//
//  Result.swift
//  QuizEngine
//
//  Created by vinod supnekar on 12/03/21.
//

import Foundation

struct Result <Question: Hashable, Answer>{
    let answers: [Question: Answer]
    let score: Int
}

