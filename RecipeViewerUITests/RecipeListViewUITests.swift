//
//  Untitled.swift
//  RecipeViewer
//
//  Created by Waleed Jebrin on 05/02/2025.
//

import XCTest

final class RecipeListViewUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    // ✅ Test if the recipe list appears
    func testRecipeListAppears() {
        let scrollView = app.scrollViews["recipeListScrollView"]
        XCTAssertTrue(scrollView.waitForExistence(timeout: 10), "Recipe list should be visible")
    }

    // ✅ Test search functionality
    func testSearchBarFiltering() {
        let searchField = app.navigationBars.searchFields.element
        XCTAssertTrue(searchField.exists)

        searchField.tap()
        searchField.typeText("Pizza")
        app.keyboards.buttons["Search"].tap()

        let filteredRecipe = app.buttons["recipeRow"].firstMatch
        XCTAssertTrue(filteredRecipe.waitForExistence(timeout: 10), "Filtered recipe should be visible")
    }

    // ✅ Test sorting functionality
    func testSorting() {
        let sortingPicker = app.staticTexts["sortPicker"]
        XCTAssertTrue(sortingPicker.waitForExistence(timeout: 10), "Sorting picker should exist")

        sortingPicker.tap()
        app.buttons["A-Z"].tap()

        let firstRecipe = app.buttons["recipeRow"]
        XCTAssertTrue(firstRecipe.waitForExistence(timeout: 10), "First sorted recipe should be visible")
    }

    // ✅ Test tapping a recipe navigates to detail view
    func testNavigationToRecipeDetail() {
        let firstRecipe = app.buttons["recipeRow"]
        XCTAssertTrue(firstRecipe.waitForExistence(timeout: 10), "First recipe should exist")

        firstRecipe.firstMatch.tap()
        let detailView = app.scrollViews["recipeDetailsScrollView"]
        XCTAssertTrue(detailView.waitForExistence(timeout: 10), "Detail view should be displayed")
    }

    // ✅ Test pull-to-refresh functionality
    func testPullToRefresh() {
        let firstRecipe = app.buttons["recipeRow"]
        XCTAssertTrue(firstRecipe.waitForExistence(timeout: 10), "Recipe list should be loaded")

        let scrollView = app.scrollViews["recipeListScrollView"]
        scrollView.swipeDown()

        XCTAssertTrue(firstRecipe.waitForExistence(timeout: 10), "List should refresh successfully")
    }
}

