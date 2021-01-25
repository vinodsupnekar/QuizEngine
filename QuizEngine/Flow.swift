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
}

class Flow {
    private let router: Router
    private let questions: [String]
    
    init(questions:[String],router:Router) {
        self.router = router
        self.questions = questions
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallBack: routeToNext(from: firstQuestion))
        }
    }
    
    private func routeToNext(from question: String) -> Router.AnswerCallBack {
        return { [weak self] _ in
            guard let strongSelf = self else {
                return
            }
            if let currentQuestionIndex = strongSelf.questions.firstIndex(of: question) {
                if currentQuestionIndex + 1 < strongSelf.questions.count {
                    let nextQuestion = strongSelf.questions[currentQuestionIndex + 1]
                    strongSelf.router.routeTo(question: nextQuestion, answerCallBack: strongSelf.routeToNext(from: nextQuestion))
                }
            }
        }
    }
    
}
