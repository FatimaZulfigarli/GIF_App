//
//  GiphyCategoriesHeaderView.swift
//  Giphy
//
//  Created by Fatya on 24.07.24.
//

import UIKit

class CategoriesHeaderView: UICollectionReusableView {
    @IBOutlet weak var collection: UICollectionView!
    
    var didSelectCategory: ((ContentType) -> Void)?
    let categories: [ContentType] = [.gif, .sticker, .emoji]
    
    override func awakeFromNib() {
            super.awakeFromNib()
            
            // Print statement to debug if awakeFromNib is called
            print("CategoriesHeaderView awakeFromNib called")
            
            // Setting up data source and delegate for the collection view
            collection.dataSource = self
            collection.delegate = self
            
            // Register the cell with the collection view
            collection.register(UINib(nibName: "CategoriesCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCell")
        }
    }

    // MARK: - UICollectionViewDataSource
    extension CategoriesHeaderView: UICollectionViewDataSource {
        
        // Number of items in the collection view
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            print("Number of items in CategoriesHeaderView: \(categories.count)")
            return categories.count
        }
        
        // Setup the cell for each item in the collection view
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell
            let category = categories[indexPath.item]
            
            // Configure the cell
            cell.configure(with: category.rawValue) { [weak self] in
                print("Category \(category.rawValue) selected")
                self?.didSelectCategory?(category)
            }
            
            return cell
        }
    }

    // MARK: - UICollectionViewDelegate
    extension CategoriesHeaderView: UICollectionViewDelegate {
        
        // Action when a cell is selected
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print("Header cell selected: \(indexPath.item)")
            didSelectCategory?(categories[indexPath.item])
        }
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    extension CategoriesHeaderView: UICollectionViewDelegateFlowLayout {
        
        // Size for each item
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            // Divide the collection view's width by the number of categories to create equally sized cells
            let width = collectionView.frame.width / CGFloat(categories.count)
            let height = collectionView.frame.height
            return CGSize(width: width, height: height)
        }
    }
