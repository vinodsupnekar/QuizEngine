//
//  Result.swift
//  QuizEngine
//
//  Created by vinod supnekar on 12/03/21.
//

import Foundation

public struct Result <Question: Hashable, Answer>{
    public let answers: [Question: Answer]
    public let score: Int
}

