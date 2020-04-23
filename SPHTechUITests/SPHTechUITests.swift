//
//  SPHTechUITests.swift
//  SPHTechUITests
//
//  Created by La Hy Tai on 4/23/20.
//

import XCTest
import SBTUITestTunnelClient
@testable import SPHTech

class SPHTechUITests: XCTestCase {
    
    override func setUp() {
        continueAfterFailure = false
        app.launchTunnel()
        if(app.buttons["OK"].exists){
            app.buttons["OK"].tap()
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testReloadButtonExists(){
        XCTAssertTrue(app.buttons["Reload"].exists)
    }
    
    func testDisplayCorrect(){
        let match = SBTRequestMatch(url: "https://data.gov.sg/api/action/datastore_search", query: ["&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"])
        app.stubRequests(matching: match, response: SBTStubResponse(response: """
                            {  "success":true,
                               "result":{
                                  "records":[{
                                     "volume_of_mobile_data":"10.1",
                                     "quarter":"2004-Q3",
                                     "_id":1
                                  },
                                  {
                                     "volume_of_mobile_data":"20.1234567",
                                     "quarter":"2005-Q4",
                                     "_id":2
                                  }],
                                  "total":2 }}
                        """))
        XCUIApplication().buttons["Reload"].tap()
        
        expectation(for: NSPredicate(format: "count > 0"), evaluatedWith: app.tables.cells, handler: nil)
        waitForExpectations(timeout: 4.0, handler: nil)
        XCTAssertTrue(app.staticTexts["2004"].exists)
        XCTAssertTrue(app.staticTexts["2005"].exists)
        XCTAssertTrue(app.staticTexts["10.100000"].exists)
        XCTAssertTrue(app.staticTexts["20.123457"].exists)
        XCTAssertEqual(app.tables.cells.count, 2)
    }
    
    func testReloadError(){
        let match = SBTRequestMatch(url: "https://data.gov.sg/api/action/datastore_search", query: ["&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"])
        app.stubRequests(matching: match, response: SBTStubResponse(response: ""))
        XCUIApplication().buttons["Reload"].tap()
        let errorAlert = self.app.staticTexts["Error"]
        XCTAssertTrue(errorAlert.exists)
    }
    
    func testLoadData_EmptyData(){
        let match = SBTRequestMatch(url: "https://data.gov.sg/api/action/datastore_search", query: ["&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"])
        app.stubRequests(matching: match, response: SBTStubResponse(response: """
                {
                   "help":"https://data.gov.sg/api/3/action/help_show?name=datastore_search",
                   "success":true,
                   "result":{
                      "resource_id":"a807b7ab-6cad-4aa6-87d0-e283a7353a0f",
                      "fields":[],
                      "records":[],
                      "_links":{},
                      "limit":5,
                      "total":59
                   }
                }
            """))
        XCUIApplication().buttons["Reload"].tap()
        
        let cellCount = app.tables.firstMatch.cells.count
        XCTAssertTrue(cellCount == 0)
    }
    
    func testLoadData_dataIncrease(){
        let match = SBTRequestMatch(url: "https://data.gov.sg/api/action/datastore_search", query: ["&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"])
        app.stubRequests(matching: match, response: SBTStubResponse(response: """
                        {  "success":true,
                           "result":{
                              "records":[{
                                 "volume_of_mobile_data":"0.000384",
                                 "quarter":"2004-Q3",
                                 "_id":1
                              },
                              {
                                 "volume_of_mobile_data":"0.000543",
                                 "quarter":"2004-Q4",
                                 "_id":2
                              }],
                              "total":4 }}
                    """))
        XCUIApplication().buttons["Reload"].tap()
        
        let cells = app.tables.firstMatch.cells
        XCTAssertEqual(cells.count, 1)
        XCTAssertFalse(cells.firstMatch.isSelected)
    }
    
    func testClickable_dataDecrease(){
        let match = SBTRequestMatch(url: "https://data.gov.sg/api/action/datastore_search", query: ["&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"])
        app.stubRequests(matching: match, response: SBTStubResponse(response: """
                {  "success":true,
                   "result":{
                      "records":[{
                         "volume_of_mobile_data":"0.2",
                         "quarter":"2004-Q3",
                         "_id":1
                      },
                      {
                         "volume_of_mobile_data":"0.1",
                         "quarter":"2004-Q4",
                         "_id":2
                      },
                      {
                         "volume_of_mobile_data":"0.00062",
                         "quarter":"2005-Q1",
                         "_id":3
                      },
                      {
                         "volume_of_mobile_data":"0.000634",
                         "quarter":"2005-Q2",
                         "_id":4
                      }],
                      "total":4 }}
            """))
        XCUIApplication().buttons["Reload"].tap()
        
        let cells = app.tables.firstMatch.cells
        XCTAssertEqual(cells.count, 2)
        let firstCell = cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.buttons.firstMatch.label == "checkmark")
        XCTAssertTrue(firstCell.isSelected)
    }
    
    func testClickable_dataDecrease_dereaseQuarter(){
        let match = SBTRequestMatch(url: "https://data.gov.sg/api/action/datastore_search", query: ["&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"])
        app.stubRequests(matching: match, response: SBTStubResponse(response: """
                {  "success":true,
                   "result":{
                      "records":[{
                         "volume_of_mobile_data":"0.4",
                         "quarter":"2004-Q4",
                         "_id":1
                      },
                      {
                         "volume_of_mobile_data":"1.0",
                         "quarter":"2004-Q3",
                         "_id":2
                      }],
                        "total":4 }}
            """))
        XCUIApplication().buttons["Reload"].tap()
        
        let cells = app.tables.firstMatch.cells
        XCTAssertEqual(cells.count, 1)
        let firstCell = cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.buttons.firstMatch.label == "checkmark")
        XCTAssertTrue(firstCell.isSelected)
    }
}
