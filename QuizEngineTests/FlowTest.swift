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
    
    func test_start_withNoQuestions_routesToResult() {
        makeSUT(questions: []).start()
                 
        XCTAssertEqual(router.routedResult?.answers,[:])
    }
    
    func test_start_AnswerFirstQuestions_withOneQuestion_routesToResult() {
        let sut = makeSUT(questions: [])

        sut.start()
        router.answerCallBack("Q1")
        
        XCTAssertEqual(router.routedResult?.answers,[:])
    }
    
    func test_start_AnswerFirstQuestions_doesNotRouteToResult() {
        makeSUT(questions: ["Q1"]).start()
        
        XCTAssertNil(router.routedResult)
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestions_routesToResult() {
        let sut = makeSUT(questions: ["Q1"])

        sut.start()
         
        router.answerCallBack("A1")
    
        XCTAssertEqual(router.routedResult?.answers, ["Q1": "A1"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_routesToResult() {
        let sut = makeSUT(questions: ["Q1","Q2"])

        sut.start()
         
        router.answerCallBack("A1")
        XCTAssertNil(router.routedResult)
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_doesNotRouteToResult() {
        let sut = makeSUT(questions: ["Q1","Q2"])

        sut.start()
         
        router.answerCallBack("A1")
        router.answerCallBack("A2")

        XCTAssertEqual(router.routedResult?.answers, ["Q1": "A1","Q2":"A2"])
    }

    
    //MARK: Helpers
    func makeSUT(questions: [String])-> Flow<String,String, RouterSpy> {
        return Flow(questions: questions, router: router)
    }
    
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
}
