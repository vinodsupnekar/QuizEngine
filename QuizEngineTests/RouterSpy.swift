//
//  RouterSpy.swift
//  QuizEngineTests
//
//  Created by vinod supnekar on 12/03/21.
//

import Foundation
import QuizEngine

class RouterSpy: Router {
    var routedQuestions:[String] = []
    var answerCallBack: (String) -> Void = { _ in }
    var routedResult: Result<String, String>? = nil
     
    func routeTo(question: String, answerCallBack: @escaping (String) -> Void) {
        routedQuestions.append(question)
        self.answerCallBack = answerCallBack
    }
    
    func routeTo(result: Result<String,String>) {
        routedResult = result
    }

}
