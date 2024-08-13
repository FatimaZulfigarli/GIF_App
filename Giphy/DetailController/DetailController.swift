//
//  DetailController.swift
//  Giphy
//
//  Created by Fatya on 31.07.24.
//

import UIKit

class DetailController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedItem: GifStickerCellConfigurable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("DetailController viewDidLoad")
        
        // Register the header
        let nib = UINib(nibName: "SelectedItemHeader", bundle: nil)
        collectionView.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SelectedItemHeader")
        
        // Configure the view with the selected item
        configureView()
    }

    private func configureView() {
        // Set title or other UI elements based on selectedItem
        title = "Detail View"
        
        // Reload the collection view to ensure the header is displayed
        collectionView.reloadData()
    }
    }

extension DetailController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 // Just returning 1 for now to have something in the collection view
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BasicCell", for: indexPath)
        cell.backgroundColor = .blue // Set a background color so you can see the cell
        return cell
    }
}
extension DetailController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            print("Attempting to dequeue header...")
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SelectedItemHeader", for: indexPath) as! SelectedItemHeader
            print("Header dequeued successfully")
            return headerView
        }
        fatalError("Unexpected kind")
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50) 
        print("Reference size for header in section \(section): \(String(describing: size))")
// Ensure the size is non-zero
    }
}
