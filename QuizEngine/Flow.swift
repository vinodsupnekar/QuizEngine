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
            router.routeTo(question: firstQuestion, answerCallBack: routeToNext(from: firstQuestion))
        } else {
            router.routeTo(result: result)
        }
    }
    
    private func routeToNext(from question: String) -> Router.AnswerCallBack {
        return { [weak self] answer in
            guard let strongSelf = self else {
                return
            }
            if let currentQuestionIndex = strongSelf.questions.firstIndex(of: question) {
                strongSelf.result[question] = answer
                if currentQuestionIndex + 1 < strongSelf.questions.count {
                    let nextQuestion = strongSelf.questions[currentQuestionIndex + 1]
                        strongSelf.router.routeTo(question: nextQuestion, answerCallBack: strongSelf.routeToNext(from: nextQuestion))
                } else {
                    strongSelf.router.routeTo(result: strongSelf.result)
                }
            }
        }
    }
    
}
