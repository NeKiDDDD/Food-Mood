//
//  SearchViewController.swift
//  Food Mood
//
//  Created by Nikita Kuznetsov on 10.04.2023.
//

import UIKit
import Alamofire
import RealmSwift

class SearchViewController: UIViewController {
    
    let cellID = "recipeCell"
    var endpoint: String = ""
    var resultRecipes = [Recipe]()
//    @IBOutlet weak var imageBackgroundView: UIImageView!
    
    @IBOutlet weak var recipeSearchBar: UISearchBar!
    @IBOutlet weak var resultSearchCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableInit()
        resultSearchCollectionView.backgroundColor = .clear
        view.backgroundColor = .white
        
    }
    
    private func tableInit(){
        resultSearchCollectionView.dataSource = self
        resultSearchCollectionView.delegate = self
        resultSearchCollectionView.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
    }
}



extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(resultRecipes.count)
        return resultRecipes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = resultSearchCollectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! recipeCell
        let recipe = resultRecipes[indexPath.row]
        cell.recipeName.text = recipe.label
        
        if let imageUrl = URL(string: recipe.image) {
            AF.download(imageUrl).responseData { response in
                if let data = response.value, let image = UIImage(data: data) {
                    cell.recipeImage.image = image
                }
            }
        }
        
        cell.isUserInteractionEnabled = true
        return cell
    }


    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let detailVC = storyboard.instantiateViewController(identifier: "DetailRecipeViewController") as! DetailRecipeViewController
                let selectedRecipe = resultRecipes[indexPath.row]
                detailVC.recipe = selectedRecipe
                navigationController?.pushViewController(detailVC, animated: true)
                print("Selected row at index: \(indexPath.row)")
    }
    
    func searchRecipes(query: String) {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api.edamam.com/search?q=\(encodedQuery)&app_id=\(appId)&app_key=\(appKey)"
        
        AF.request(urlString).responseDecodable(of: RecipeResponse.self) { (response) in
            debugPrint(response)
            
            switch response.result {
            case .success(let recipeResponse):
                let recipes = recipeResponse.hits.compactMap { $0.recipe }
                self.resultRecipes = recipes.map { $0 }
                DispatchQueue.main.async {
                    self.resultSearchCollectionView.reloadData()
                }
                print(self.resultRecipes.count)
            case .failure(let error):
                print("Error decoding recipes:", error)
            }
        }
    }

    }

    

extension SearchViewController: UISearchBarDelegate {
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        self.recipeSearchBar.endEditing(true)
//    } 
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text {
            searchRecipes(query: query)
            searchBar.resignFirstResponder()
        }
    }

}
