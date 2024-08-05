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

       override func viewDidLoad() {
           super.viewDidLoad()
           setupLoadingIndicator()

           setupCollectionView()
           bindViewModel()
           viewModel.fetchContent(for: 0) // Start with GIFs
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
               print("Fetch completed, reloading collection view")
               DispatchQueue.main.async {
                   self?.collection.reloadData()
                   self?.hideLoadingIndicator()
               }
           }
           
           viewModel.onFetchFailed = { [weak self] error in
               print("Failed to fetch data: \(error)")
               DispatchQueue.main.async {
                   self?.hideLoadingIndicator()
                   // Optionally show an error message to the user
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
       
       private func showDetailController() {
           let detailCoordinator = DetailCoordinator(navigationController: self.navigationController ?? UINavigationController())
           detailCoordinator.start()
       }
   }

   extension HomeController: UICollectionViewDataSource {
       func collectionView(_ collection: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return viewModel.currentItems.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GifStickerCell", for: indexPath) as! GifStickerCell
              let item = viewModel.currentItems[indexPath.item]
              cell.configure(with: item)
              return cell
          }
       
//       func collectionView(_ collection: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//           if kind == UICollectionView.elementKindSectionHeader {
//               let header = collection.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(CategoriesHeaderView.self)", for: indexPath) as! CategoriesHeaderView
//               header.didSelectCategory = { [weak self] index in
//                   if index == 0 {
//                       self?.viewModel.fetchTrendingGIFs()
//                   } else {
//                       self?.viewModel.fetchTrendingStickers()
//                   }
//               }
//               return header
//           }
//           return UICollectionReusableView()
//       }
//   }
       
       func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
               if kind == UICollectionView.elementKindSectionHeader {
                   let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CategoriesHeaderView", for: indexPath) as! CategoriesHeaderView
                   headerView.didSelectCategory = { [weak self] index in
                       self?.showLoadingIndicator()
                       self?.viewModel.fetchContent(for: index)
                   }
                   return headerView
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
