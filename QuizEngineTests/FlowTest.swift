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
    
    func test_start_withNoQuestions_doesNotRouteToQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: [], router: router)
         
        sut.start()
        
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestions_routesToCorrectQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1"], router: router)

        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    
    func test_start_withOneQuestions_routesToCorrectQuestion2() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q2"], router: router)

        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestions_routesToFirstQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1","Q2"], router: router)

        sut.start()
 
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startTwice_withTwoQuestions_routesToFirstQuestionTwice() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1","Q2"], router: router)

        sut.start()
        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q1","Q1"])
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestions_routesToSecondQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1","Q2"], router: router)

        sut.start()
         
        router.answerCallBack("A1")
    
        XCTAssertEqual(router.routedQuestions, ["Q1","Q2"])
    }
    
    class RouterSpy: Router {
        var routedQuestions:[String] = []
        var answerCallBack: ((String) -> Void) = { _ in }
        func routeTo(question: String, answerCallBack: @escaping (String) -> Void) {
            routedQuestions.append(question)
            self.answerCallBack = answerCallBack
        }

    }
}
