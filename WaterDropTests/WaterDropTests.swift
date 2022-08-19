//
//  WaterDropTests.swift
//  WaterDropTests
//
//  Created by Remigiusz Makuchowski on 18/08/2022.
//

import XCTest
@testable import WaterDrop

class WaterDropTests: XCTestCase {
    var sut: ViewController!

    override func setUpWithError() throws {
        sut = ViewController()
        sut.buildUI()
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    //MARK: - Label and counter tests
    func test_updateLabel() {
        sut.minutes = 4
        sut.seconds = 9
        sut.buildUI()
        sut.updateTimerLabel(sut.minutes, sut.seconds)
        XCTAssertEqual(sut.timerLabel.text!, "04:09")
    }
    
    func test_zeroZero() {
        sut.minutes = 0
        sut.seconds = 0
        let _ = sut.calcTime(&sut.minutes, &sut.seconds)
        XCTAssertEqual(sut.minutes, 0)
        XCTAssertEqual(sut.seconds, 0)
    }
    
    func test_secondDown() {
        sut.minutes = 4
        sut.seconds = 25
        let _ = sut.calcTime(&sut.minutes, &sut.seconds)
        XCTAssertEqual(sut.minutes, 4)
        XCTAssertEqual(sut.seconds, 24)
    }
    
    func test_minuteDown() {
        sut.minutes = 4
        sut.seconds = 0
        let _ = sut.calcTime(&sut.minutes, &sut.seconds)
        XCTAssertEqual(sut.minutes, 3)
        XCTAssertEqual(sut.seconds, 59)
    }
    
    //MARK: - Pickers tests
    func test_pickerReset() {
        sut.resetPickers()
        XCTAssertEqual(sut.toHour, 23)
        XCTAssertEqual(sut.fromHour, 0)
    }
    
    func test_pickerComparisionFromBiggerThanTo() {
        var isCalled = false
        sut.comparePickers(10, 0) {
            isCalled = true
        }
        XCTAssertTrue(isCalled)
    }
    
    func test_pickerComparisionFromSmallerThanTo() {
        sut.comparePickers(0, 10) {
            XCTFail("It shouldn't be called")
        }
    }
    
    func test_pickerComparisionBothEquals() {
        var isCalled = false
        sut.comparePickers(10, 0) {
            isCalled = true
        }
        XCTAssert(isCalled)
    }
}
