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
           
       override func viewDidLoad() {
           super.viewDidLoad()
           
           setupCollectionView()
           bindViewModel()
           viewModel.fetchTrendingGIFs()
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
               self?.collection.reloadData()
           }
           
           viewModel.onFetchFailed = { error in
               print("Failed to fetch data: \(error)")
           }
       }
       
       private func showDetailController() {
           let detailCoordinator = DetailCoordinator(navigationController: self.navigationController ?? UINavigationController())
           detailCoordinator.start()
       }
   }

   extension HomeController: UICollectionViewDataSource {
       func collectionView(_ collection: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return viewModel.currentItems.count
       }
       
       func collectionView(_ collection: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collection.dequeueReusableCell(withReuseIdentifier: "GifStickerCell", for: indexPath) as! GifStickerCell
           let item = viewModel.currentItems[indexPath.item]
           cell.configure(with: item)
           return cell
       }
       
       func collectionView(_ collection: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
           if kind == UICollectionView.elementKindSectionHeader {
               let header = collection.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(CategoriesHeaderView.self)", for: indexPath) as! CategoriesHeaderView
               header.didSelectCategory = { [weak self] index in
                   if index == 0 {
                       self?.viewModel.fetchTrendingGIFs()
                   } else {
                       self?.viewModel.fetchTrendingStickers()
                   }
               }
               return header
           }
           return UICollectionReusableView()
       }
   }

   extension HomeController: UICollectionViewDelegate {
       func collectionView(_ collection: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           showDetailController()
       }
   }

   extension HomeController: CHTCollectionViewDelegateWaterfallLayout {
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let width = (collectionView.bounds.width - 30) / 2
           let height = CGFloat(arc4random_uniform(100) + 100)
           return CGSize(width: width, height: height)
       }
   }
