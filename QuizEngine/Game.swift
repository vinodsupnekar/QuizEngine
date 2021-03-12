//
//  Game.swift
//  QuizEngine
//
//  Created by vinod supnekar on 12/03/21.
//

import Foundation

public func startGame<Question: Hashable, Answer, R: Router>(questions: [Question],router: R, correctAnswers : [Question: Answer]) where R.Question == Question, R.Answer == Answer {
    
}
