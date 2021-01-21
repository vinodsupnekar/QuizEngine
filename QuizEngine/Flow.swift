//
//  Flow.swift
//  QuizEngine
//
//  Created by vinod supnekar on 21/01/21.
//

import Foundation
protocol Router {
    func routeTo(question:String, answerCallBack: @escaping (String) -> Void)
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
            router.routeTo(question: firstQuestion) { [weak self] _  in
               
                guard let strongSelf = self else { return}
                let firstQuestionIndex = strongSelf.questions.index(of: firstQuestion)!
                let nextQuestion = strongSelf.questions[firstQuestionIndex + 1]
                
                strongSelf.router.routeTo(question: nextQuestion){ _ in }
            }
        }
    }
}
