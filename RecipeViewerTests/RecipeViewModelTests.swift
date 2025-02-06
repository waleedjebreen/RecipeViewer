//
//  Untitled.swift
//  RecipeViewer
//
//  Created by Waleed Jebrin on 05/02/2025.
//

import XCTest
@testable import RecipeViewer

@MainActor
final class RecipeViewModelTests: XCTestCase {
    var viewModel: RecipeViewModel!
    var mockService: MockRecipeService!
    
    override func setUp() {
        super.setUp()
        mockService = MockRecipeService()
        
        viewModel = RecipeViewModel(service: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testInitialValues() {
        XCTAssertTrue(viewModel.recipes.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.searchText, "")
        XCTAssertEqual(viewModel.sortOption, .none)
        XCTAssertEqual(viewModel.totalRecipesCount, -1)
    }
    
    func testFetchRecipesSuccess() async {
        let response = mockService.generateMockResponse()
        mockService.mockResponse = response
        
        viewModel.fetch()
        try? await Task.sleep(nanoseconds: 200_000_000)
        XCTAssertEqual(viewModel.recipes, response?.recipes)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testFetchRecipesFailure() async {
        mockService.mockError = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Network error"])
        
        viewModel.fetch()
        try? await Task.sleep(nanoseconds: 200_000_000)
        
        XCTAssertTrue(viewModel.recipes.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.errorMessage, "Failed to fetch recipes Network error")
    }
    
    func testSearchRecipesSuccess() async {
        viewModel.searchText = "Test"
        let response = mockService.generateMockResponse()
        mockService.mockResponse = response
        
        viewModel.fetch()
        
        try? await Task.sleep(nanoseconds: 100_000_000)
        XCTAssertEqual(viewModel.recipes, response?.recipes)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testRefreshRecipes() async {
        viewModel.searchText = "Test"
        let response = mockService.generateMockResponse()
        mockService.mockResponse = response
        
        viewModel.fetch()
        try? await Task.sleep(nanoseconds: 100_000_000)
        XCTAssertEqual(viewModel.recipes, response?.recipes)
    }
}

