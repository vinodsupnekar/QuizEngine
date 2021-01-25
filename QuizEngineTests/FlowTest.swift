//
//  FlowTest.swift
//  QuizEngineTests
//
//  Created by vinod supnekar on 21/01/21.
//

import Foundation
import XCTest
@testable import QuizEngine

class FlowTest: XCTestCase {
    let router = RouterSpy()

    func test_start_withNoQuestions_doesNotRouteToQuestion() {
        let sut = makeSUT(questions: [])
         
        sut.start()
        
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestions_routesToCorrectQuestion() {
        let sut = makeSUT(questions: ["Q1"])

        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    
    func test_start_withOneQuestions_routesToCorrectQuestion2() {
        let sut = makeSUT(questions: ["Q2"])

        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestions_routesToFirstQuestion() {
        let sut = makeSUT(questions: ["Q1","Q2"])

        sut.start()
 
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startTwice_withTwoQuestions_routesToFirstQuestionTwice() {
        let sut = makeSUT(questions: ["Q1","Q2"])

        sut.start()
        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q1","Q1"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withThreeQuestions_routesToSecondAndThirdQuestion() {
        let sut = makeSUT(questions: ["Q1","Q2","Q3"])
        sut.start()
        
        router.answerCallBack("A1")
        router.answerCallBack("A2")
        
        XCTAssertEqual(router.routedQuestions, ["Q1","Q2","Q3"])
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestions_doesNotRouteToAnotherQuestion() {
        let sut = makeSUT(questions: ["Q1"])

        sut.start()
         
        router.answerCallBack("A1")
    
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    //MARK: Helpers
    func makeSUT(questions: [String])-> Flow {
        return Flow(questions: questions, router: router)
    }
    
    class RouterSpy: Router {
        var routedQuestions:[String] = []
        var answerCallBack: Router.AnswerCallBack = { _ in }
        func routeTo(question: String, answerCallBack: @escaping Router.AnswerCallBack) {
            routedQuestions.append(question)
            self.answerCallBack = answerCallBack
        }

    }
}
