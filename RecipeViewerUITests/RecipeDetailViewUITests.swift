//
//  Untitled.swift
//  RecipeViewer
//
//  Created by Waleed Jebrin on 05/02/2025.
//

import XCTest

final class RecipeDetailViewUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
        
        // Navigate to RecipeDetailView by tapping on the first recipe
        let firstRecipe = app.buttons["recipeRow"].firstMatch
        XCTAssertTrue(firstRecipe.waitForExistence(timeout: 10), "First recipe should exist")
        firstRecipe.tap()
    }

    // ✅ Test if the recipe image appears
    func testRecipeImageLoads() {
        let recipeImage = app.images.firstMatch
        XCTAssertTrue(recipeImage.waitForExistence(timeout: 10), "Recipe image should load")
    }

    // ✅ Test if the recipe name and tags appear
    func testRecipeNameAndTagsExist() {
        let recipeName = app.staticTexts.element(matching: .any, identifier: "recipeName")
        XCTAssertTrue(recipeName.waitForExistence(timeout: 10), "Recipe name should be visible")

        let recipeTags = app.staticTexts.element(matching: .any, identifier: "recipeTags")
        XCTAssertTrue(recipeTags.waitForExistence(timeout: 10), "Recipe tags should be visible")
    }

    // ✅ Test if rating, prep time, cook time, and difficulty exist
    func testRecipeInfoSectionExists() {
        let rating = app.staticTexts["Rating"]
        let prepTime = app.staticTexts["Prep"]
        let cookTime = app.staticTexts["Cook"]
        let difficulty = app.staticTexts["Difficulty"]

        XCTAssertTrue(rating.exists, "Rating info should be displayed")
        XCTAssertTrue(prepTime.exists, "Prep time should be displayed")
        XCTAssertTrue(cookTime.exists, "Cook time should be displayed")
        XCTAssertTrue(difficulty.exists, "Difficulty level should be displayed")
    }

    // ✅ Test if ingredients section is visible
    func testIngredientsSectionExists() {
        let ingredientsTitle = app.staticTexts["Ingredients:"]
        XCTAssertTrue(ingredientsTitle.waitForExistence(timeout: 10), "Ingredients section title should be visible")
        
        let ingredientsList = app.staticTexts.element(matching: .any, identifier: "recipeIngredients")
        XCTAssertTrue(ingredientsList.exists, "Ingredients list should be visible")
    }

    // ✅ Test if instructions section is visible
    func testInstructionsSectionExists() {
        let instructionsTitle = app.staticTexts["Instructions:"]
        XCTAssertTrue(instructionsTitle.waitForExistence(timeout: 10), "Instructions section title should be visible")

        let firstInstruction = app.staticTexts.element(matching: .any, identifier: "instruction_1")
        XCTAssertTrue(firstInstruction.exists, "First instruction should be visible")
    }
}
