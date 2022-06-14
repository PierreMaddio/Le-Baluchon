//
//  Le_BaluchonTests.swift
//  Le BaluchonTests
//
//  Created by Pierre on 08/06/2022.
//

import XCTest
@testable import Le_Baluchon

class Le_BaluchonTests: XCTestCase {
    
    let maxDouble: Double = 134232332332
    let minDouble: Double = -134232332332

    func testKelvinToCelciusForMaxKelvion() throws {
        let vc = WeatherViewController()

        let result = vc.kelvinsToCelsius(temperature: maxDouble)
        XCTAssertEqual(result, "-273.15")
    }
    
    func testKelvinToCelciusForZeroKelvin() throws {
        let vc = WeatherViewController()
        let result = vc.kelvinsToCelsius(temperature: 0 )
        XCTAssertEqual(result, "-273.15")
    }
    
    func testKelvinToCelciusForMinKelvin() throws {
        let vc = WeatherViewController()
        let result = vc.kelvinsToCelsius(temperature: minDouble )
        XCTAssertEqual(result, "-263.15")
    }

}
