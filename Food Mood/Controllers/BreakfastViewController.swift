//
//  Breakfast.swift
//  Food Mood
//
//  Created by Nikita Kuznetsov on 13.03.2023.
//

import UIKit
import Alamofire

class BreakfastViewController: UIViewController {
    
    
    var mealType = "breakfast"
    var resultRecipes = [Recipe?]()
    var query: String = ""
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var randomizeButton: UIButton!
    @IBOutlet weak var mealPreferences: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                mealPreferences.delegate = self
                mealPreferences.dataSource = self
        queryPicker()
    }
    
    
    @IBAction func randomizeButtonAction(_ sender: UIButton) {
        if resultRecipes.isEmpty {
            searchRecipes(query: query, mealType: mealType)
            
        } else {
            if let randomRecipe = resultRecipes.randomElement()??.label {
                let result: String = randomRecipe
                resultLabel.text = result
            }
        }
        

        func searchRecipes(query: String, mealType: String?) {
            if let mealType = mealType {
                let urlString = "https://api.edamam.com/search?q=\(query)&app_id=\(appId)&app_key=\(appKey)&mealType=\(mealType)"
                
                AF.request(urlString).responseDecodable(of: RecipeResponse.self) { (response) in
                    debugPrint(response)
                    
                    switch response.result {
                    case .success(let recipeResponse):
                        let recipes = Array(recipeResponse.hits.map { $0.recipe })
                        self.resultRecipes = recipes
                        if let randomRecipe = self.resultRecipes.randomElement()??.label {
                            let result: String = randomRecipe
                            self.resultLabel.text = result
                        }
                    case .failure(let error):
                        print("Error decoding recipes:", error)
                    }
                }
            }
        }

    }
}

extension BreakfastViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mealTypes.count
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let color = UIColor.white
        let attributes = [NSAttributedString.Key.foregroundColor: color]
        let attributedTitle = NSAttributedString(string: mealTypes[row], attributes: attributes)
        return attributedTitle
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        mealType = mealTypes[row]
        resultRecipes.removeAll()
    }
    
    func queryPicker(){
        let selectedRow = mealPreferences.selectedRow(inComponent: 0)
        let selectedValue = mealPreferences.delegate?.pickerView?(mealPreferences, titleForRow: selectedRow, forComponent: 0)
        
    }
    
}
