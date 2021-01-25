//
//  Flow.swift
//  QuizEngine
//
//  Created by vinod supnekar on 21/01/21.
//

import Foundation
protocol Router {
    typealias answerCallBack = (String) -> Void
    func routeTo(question:String, answerCallBack: @escaping answerCallBack)
}

class Flow {
    let router: Router
    let questions: [String]
    
    init(questions:[String],router:Router) {
        self.router = router
        self.questions = questions
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallBack: routeToNext(firstQuestion))
        }
    }
    
    func routeToNext(_ question: String) -> (String) -> Void {
        return { [weak self] _ in
            guard let strongSelf = self else {
                return
            }
            let currentQuestionIndex = strongSelf.questions.firstIndex(of: question)!
            let nextQuestion = strongSelf.questions[currentQuestionIndex + 1]
            strongSelf.router.routeTo(question: nextQuestion, answerCallBack: strongSelf.routeToNext(nextQuestion))
        }
    }
    
}
