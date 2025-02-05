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
    var mockService: RecipeServiceMock!

    override func setUp() {
        super.setUp()
        mockService = RecipeServiceMock()
        viewModel = RecipeViewModel(service: mockService)
    }

    override func tearDown() {
        mockService = nil
        viewModel = nil
        super.tearDown()
    }

    func testFetchRecipesSuccess() async {
        await viewModel.fetchRecipes()

        XCTAssertFalse(viewModel.recipes.isEmpty, "Recipes should be loaded")
        XCTAssertEqual(viewModel.recipes.count, 2, "Should load 2 mock recipes")
        XCTAssertNil(viewModel.errorMessage, "Error message should be nil")
    }

    func testFetchRecipesFailure() async {
        mockService.shouldReturnError = true

        await viewModel.fetchRecipes()

        XCTAssertTrue(viewModel.recipes.isEmpty, "Recipes should be empty on error")
        XCTAssertNotNil(viewModel.errorMessage, "Error message should be set")
    }
}
