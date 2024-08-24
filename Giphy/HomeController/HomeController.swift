//
//  SearchController.swift
//  Giphy
//
//  Created by Fatya on 24.07.24.
//

import UIKit
import CHTCollectionViewWaterfallLayout
class HomeController: UIViewController {
    
    @IBOutlet weak var collection: UICollectionView!
    private let viewModel = HomeViewModel()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    private var detailCoordinator: DetailCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoadingIndicator()
        setupCollectionView()
        bindViewModel()
        viewModel.fetchContent(for: .gif) // Start with GIFs
    }
    
    @IBAction func searchAction(_ sender: UITextField) {
        guard let query = sender.text, !query.isEmpty else {
            return
        }

        let selectedCategory: ContentType = .gif

        showLoadingIndicator()
        viewModel.searchContent(for: selectedCategory, query: query)
    }


    private func setupLoadingIndicator() {
           loadingIndicator.center = view.center
           loadingIndicator.hidesWhenStopped = true
           view.addSubview(loadingIndicator)
       }
       
       private func setupCollectionView() {
           let layout = CHTCollectionViewWaterfallLayout()
           layout.columnCount = 2
           layout.minimumColumnSpacing = 10
           layout.minimumInteritemSpacing = 10
           layout.headerHeight = 44
           layout.footerHeight = 0
           layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
           layout.itemRenderDirection = .shortestFirst
           
           collection.collectionViewLayout = layout
           collection.dataSource = self
           collection.delegate = self
           collection.register(UINib(nibName: "GifStickerCell", bundle: nil), forCellWithReuseIdentifier: "GifStickerCell")
           collection.register(UINib(nibName: "\(CategoriesHeaderView.self)", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(CategoriesHeaderView.self)")
       }
       
       private func bindViewModel() {
           viewModel.onFetchCompleted = { [weak self] in
               DispatchQueue.main.async {
                   self?.collection.reloadData()
                   self?.hideLoadingIndicator()
               }
           }
           
           viewModel.onFetchFailed = { [weak self] error in
               DispatchQueue.main.async {
                   self?.hideLoadingIndicator()
                   self?.showAlert(message: "Failed to fetch data: \(error)")
               }
           }
       }
       
       private func showLoadingIndicator() {
           DispatchQueue.main.async {
               self.loadingIndicator.startAnimating()
               self.collection.isUserInteractionEnabled = false
           }
       }
       
       private func hideLoadingIndicator() {
           DispatchQueue.main.async {
               self.loadingIndicator.stopAnimating()
               self.collection.isUserInteractionEnabled = true
           }
       }
       
     
       private func presentEmojiVariationsPopover(_ variations: [EmojiDatum], from sourceView: UIView) {
           let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
           
           for variation in variations {
               let action = UIAlertAction(title: variation.title ?? "", style: .default) { [weak self] _ in
                   self?.selectEmojiVariation(variation)
               }
               alertController.addAction(action)
           }
           
           let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
           alertController.addAction(cancelAction)
           
           // For iPad support
           if let popoverController = alertController.popoverPresentationController {
               popoverController.sourceView = sourceView
               popoverController.sourceRect = sourceView.bounds
           }
           
           present(alertController, animated: true, completion: nil)
       }
       
       private func selectEmojiVariation(_ variation: EmojiDatum) {
           print("Selected variation: \(variation.title ?? "")")
           // You might want to update the collection view or perform other actions here
       }
       
       private func showAlert(message: String) {
           let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
       }
       
       // Add this method here
       private func handleItemTap(id: String) {
           print("handleItemTap called with id: \(id)")
           if let item = viewModel.currentItems.first(where: { $0.id == id }) {
               print("Item found, starting DetailCoordinator")
               startDetailCoordinator(with: viewModel.currentItems) // Pass all items to DetailCoordinator
           } else {
               print("No item found with id: \(id)")
           }
       }
       
       // Updated method to start DetailCoordinator with all selected items
       private func startDetailCoordinator(with items: [GifStickerCellConfigurable]) {
           print("startDetailCoordinator called")
           detailCoordinator = DetailCoordinator(navigationController: navigationController!, selectedItems: items)
           detailCoordinator?.start()
       }
   }

   extension HomeController: UICollectionViewDataSource {
       func collectionView(_ collection: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return viewModel.currentItems.count
       }
       
//       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GifStickerCell", for: indexPath) as! GifStickerCell
//           let item = viewModel.currentItems[indexPath.item]
//           cell.configure(with: item, onTap: { [weak self] id in
//               print("Cell onTap closure called with id: \(id)")
//               self?.handleItemTap(id: id)
//           }, onForceTouch: { [weak self] id in
//               self?.showEmojiVariations(for: id, from: cell)
//           })
//           return cell
//       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GifStickerCell", for: indexPath) as! GifStickerCell
           let item = viewModel.currentItems[indexPath.item]
           cell.configure(with: item, onTap: { [weak self] id in
               print("Cell onTap closure called with id: \(id)")
               self?.handleItemTap(id: id)
           })
           return cell
       }
       func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
           let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CategoriesHeaderView", for: indexPath) as! CategoriesHeaderView
           headerView.didSelectCategory = { [weak self] type in
               self?.showLoadingIndicator()
               self?.viewModel.currentItems.removeAll()
               self?.collection.reloadData()
               DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                   self?.viewModel.fetchContent(for: type)
               }
           }
           return headerView
       }
   }

   extension HomeController: UICollectionViewDelegate {
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           print("collectionView didSelectItemAt called with indexPath: \(indexPath)")
           let items = viewModel.currentItems // Get all items to pass to DetailCoordinator
           startDetailCoordinator(with: items)
       }
   }

   extension HomeController: CHTCollectionViewDelegateWaterfallLayout {
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let width = (collectionView.bounds.width - 30) / 2
           let height = CGFloat(arc4random_uniform(100) + 100)
           return CGSize(width: width, height: height)
       }
   }
