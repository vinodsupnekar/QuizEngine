//
//  Router.swift
//  QuizEngine
//
//  Created by vinod supnekar on 12/03/21.
//

import Foundation

protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    
    func routeTo(question:Question, answerCallBack: @escaping (Answer) -> Void)
    func routeTo(result: Result<Question,Answer>)
}
