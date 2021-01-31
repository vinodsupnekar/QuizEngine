//
//  Flow.swift
//  QuizEngine
//
//  Created by vinod supnekar on 21/01/21.
//

import Foundation
protocol Router {
    typealias AnswerCallBack = (String) -> Void
    func routeTo(question:String, answerCallBack: @escaping AnswerCallBack)
    func routeTo(result:[String:String])
}

class Flow {
    private let router: Router
    private let questions: [String]
    private var result : [String:String] = [:]
    
    init(questions:[String],router:Router) {
        self.router = router
        self.questions = questions
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallBack: nextCallBack(from: firstQuestion))
        } else {
            router.routeTo(result: result)
        }
    }
    
    private func nextCallBack(from question: String) -> Router.AnswerCallBack {
        return { [weak self] answer in
            self?.routeNext(question, answer)
        }
    }
    
    private func routeNext(_ question: String,_ answer:String) {
        if let currentQuestionIndex = questions.firstIndex(of: question) {
            result[question] = answer
            let nextQuestionIndex = currentQuestionIndex + 1
            if nextQuestionIndex < questions.count {
                let nextQuestion = questions[nextQuestionIndex]
                    router.routeTo(question: nextQuestion, answerCallBack: nextCallBack(from: nextQuestion))
            } else {
                router.routeTo(result: result)
            }

        }
    }
    
}
