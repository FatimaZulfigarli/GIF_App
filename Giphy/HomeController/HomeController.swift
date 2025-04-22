//
//  SearchController.swift
//  Giphy
//
//  Created by Fatya on 24.07.24.
//

import UIKit
import CHTCollectionViewWaterfallLayout
import FirebaseAuth
class HomeController: UIViewController {
    var coordinator: HomeCoordinator? 
    
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
        observeAuthChanges()
        
    }
    
    private func observeAuthChanges() {
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            if let user = user {
                print("User is signed in: \(user.uid)")
                self?.viewModel.loadFavoritesFromFirebase {
                    print("Favorites loaded for user: \(user.uid)")
                    self?.collection.reloadData()
                }
            } else {
                print("No user is signed in")
            }
        }
    }
    
    
    
    
 
    
    @IBAction func searchAction(_ sender: UITextField) {
        guard let query = sender.text, !query.isEmpty else {
            return
        }
        
        showLoadingIndicator()
        switch viewModel.selectedCategory {
        case .gif:
            viewModel.searchGIFs(query: query)
        case .sticker:
            viewModel.searchStickers(query: query)
        case .emoji:
                let filteredEmojis = viewModel.emojis.filter { $0.title?.lowercased().contains(query.lowercased()) ?? false }
                viewModel.currentItems = filteredEmojis
                self.collection.reloadData()
                hideLoadingIndicator()
            }
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
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
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
    
    private func handleItemTap(id: String) {
        print("handleItemTap called with id: \(id)")
        if let selectedItem = viewModel.currentItems.first(where: { $0.id == id }) {
            print("Selected item found: \(selectedItem)")
            startDetailCoordinator(with: viewModel.currentItems, initialSelectedItem: selectedItem)
        } else {
            print("No item found with id: \(id)")
        }
    }
    
    private func startDetailCoordinator(with items: [GifStickerCellConfigurable], initialSelectedItem: GifStickerCellConfigurable) {
        print("startDetailCoordinator called")
        detailCoordinator = DetailCoordinator(navigationController: navigationController!, selectedItems: items, initialSelectedItem: initialSelectedItem)
        detailCoordinator?.start()
    }
    
    
    private func toggleFavoriteButton(for id: String) {
        if let index = viewModel.currentItems.firstIndex(where: { $0.id == id }),
           let cell = collection.cellForItem(at: IndexPath(item: index, section: 0)) as? GifStickerCell {
            let isFavorite = viewModel.isItemFavorite(id: id)
            cell.updateFavButton(isFavorite: isFavorite)
        }
    }
    
    private func toggleFavorite(for id: String) {
        let isFavorite = viewModel.isItemFavorite(id: id)
        
        if let index = viewModel.currentItems.firstIndex(where: { $0.id == id }),
           let cell = collection.cellForItem(at: IndexPath(item: index, section: 0)) as? GifStickerCell {
            cell.updateFavButton(isFavorite: !isFavorite)
        }
        
        if isFavorite {
            viewModel.removeFromFavorites(id: id)
        } else {
            viewModel.addToFavorites(id: id)
        }
        
        viewModel.saveFavoritesToFirebase()
    }
}

extension HomeController: UICollectionViewDataSource {
    func collectionView(_ collection: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.currentItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GifStickerCell", for: indexPath) as! GifStickerCell
        let item = viewModel.currentItems[indexPath.item]
        cell.configure(with: item, onTap: { [weak self] (id: String) in
            print("Cell onTap closure called with id: \(id)")
            self?.handleItemTap(id: id)
        }, onFavButtonTap: { [weak self] (id: String) in
            self?.toggleFavorite(for: id)
        })
        
        let isFavorite = viewModel.isItemFavorite(id: item.id)
        cell.updateFavButton(isFavorite: isFavorite)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CategoriesHeaderView", for: indexPath) as! CategoriesHeaderView
            headerView.didSelectCategory = { [weak self] type in
                self?.viewModel.selectedCategory = type
                self?.showLoadingIndicator()
                self?.viewModel.fetchContent(for: type)
            }
            return headerView
        }
        return UICollectionReusableView()
    }
}

extension HomeController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collectionView didSelectItemAt called with indexPath: \(indexPath)")
        let items = viewModel.currentItems
        startDetailCoordinator(with: items, initialSelectedItem: items[indexPath.item])
    }
}

extension HomeController: CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 30) / 2
        let height = CGFloat(arc4random_uniform(100) + 100)
        return CGSize(width: width, height: height)
    }
}

     
