//
//  Created by Tom Baranes on 24/11/15.
//  Copyright © 2015 Tom Baranes. All rights reserved.
//

import XCTest
import SwiftyUtils

final class DictionaryExtensionTests: XCTestCase {

    private var firstdic = [String: Int]()
    private var secondDic = [String: Int]()
    private var thirdDic = [String: Int]()
    private var fourthDic = [String: Int]()

    override func setUp() {
        super.setUp()
        firstdic = ["one": 1, "two": 2, "three": 3]
        secondDic = ["four": 4, "five": 5]
        thirdDic = ["six": 6, "seven": 7]
        fourthDic = ["two": 2, "three": 3, "five": 5, "six": 6]
    }

    override func tearDown() {
        super.tearDown()
    }

}

// MARK: - Data

extension DictionaryExtensionTests {

    func testToData() {
        do {
            let dictionary = ["int": 1, "string": "string", "bool": true] as [String: Any]
            let data = try dictionary.toData()!

            let output = try data.toDictionary()!
            XCTAssertTrue(NSDictionary(dictionary: dictionary).isEqual(to: output))
        } catch {
            XCTFail("Should not failed creating the data")
        }
    }

}

// MARK: - Transform

extension DictionaryExtensionTests {

    func testUnion() {
        let union = firstdic.union(values: secondDic)
        XCTAssertEqual(firstdic.keys.count + secondDic.keys.count, union.keys.count)
        XCTAssertEqual(firstdic.values.count + secondDic.values.count, union.values.count)
    }

    func testMergeDictionaries() {
        var finalDic = [String: Int]()
        finalDic.merge(with: firstdic, secondDic)
        XCTAssertEqual(finalDic.count, firstdic.count + secondDic.count)
        for (key, _) in firstdic {
            XCTAssertEqual(finalDic[key], firstdic[key])
        }
        for (key, _) in secondDic {
            XCTAssertEqual(finalDic[key], secondDic[key])
        }
    }

}

// MARK: - Helpers

extension DictionaryExtensionTests {

    func testHas() {
        XCTAssertTrue(firstdic.has(key: "one"))
    }

    func testDifference() {
        let union = firstdic.union(values: secondDic)
        let difference = union.difference(with: fourthDic)

        XCTAssertTrue(difference.has(key: "one"))
        XCTAssertTrue(difference.has(key: "four"))
        XCTAssertEqual(difference.count, 2)
    }

}
