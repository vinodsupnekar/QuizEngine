//
//  GameTests.swift
//  QuizEngineTests
//
//  Created by vinod supnekar on 12/03/21.
//

import Foundation
import XCTest
import QuizEngine

class GameTest: XCTestCase {
    
    func test_startGame_answerOneOutOfTwoCorrectly_scores1() {
        let router = RouterSpy()
        
        
        startGame(questions: ["Q1","Q2"],router: router,correctAnswers: ["Q1":"A1","Q2":"A2"])
        
        router.answerCallBack("A1")
        router.answerCallBack("wrong")
        
        XCTAssertEqual(router.routedResult!.score, 1)
    }
}
