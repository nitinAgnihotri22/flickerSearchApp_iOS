//
//  ViewController.swift
//  FlickerSearchApp
//
//  Created by Nitin Agnihotri on 2/12/20.
//  Copyright © 2020 Nitin Mac. All rights reserved.
//

import UIKit
import Lightbox

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextfield: UITextField!
    private var searchBarController: UISearchController!
    private var numberOfColumns: CGFloat = FlickrConstants.defaultColumnCount
    private var viewModel = FlickrViewModel()
    private var isFirstTimeActive = true
    private var spaceMargin: CGFloat = 41.0
    private let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureUI()
        viewModelClosures()
        addRightBarBtn()
        addRefreshController()
    }
    
    func addRightBarBtn() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"menu"), style: .plain, target: self, action: #selector(optionPicker))
    }
    
    @objc
    func optionPicker() {
        AlertController.actionSheet(title: "Change Layout", message: "Choose no of columns you want to set.", sourceView: self.view, buttons: ["2","3","4","Cancel"]) { (alert, selectedIndex) in
            switch selectedIndex {
            case 0:
                self.numberOfColumns = 2.0
                break
            case 1:
                self.numberOfColumns = 3.0
                break
            case 2:
                self.numberOfColumns = 4.0
                break
            default:
                self.numberOfColumns += 0
            }
            self.spaceMargin = (self.numberOfColumns*10)+11.0
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isFirstTimeActive {
            isFirstTimeActive = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, text.count > 1 else {
            textField.resignFirstResponder()
            return true
        }
        viewModel.search(text: text) {
            self.collectionView.reloadData()
            print("search completed.")
        }
        
        textField.resignFirstResponder()
        return true
    }
}

//MARK:- Clousers
extension ViewController {
    
    fileprivate func viewModelClosures() {
        viewModel.showAlert = { [weak self] (message) in
            self?.searchBarController.isActive = false
            AlertController.alert(message:message)
        }
        
        viewModel.dataUpdated = { [weak self] in
            print("data source updated")
            self?.collectionView.reloadData()
        }
    }
    
    private func loadNextPage() {
        viewModel.fetchNextPage {
            print("next page fetched")
        }
    }
}

extension ViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    private func createSearchBar() {
        searchBarController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchBarController
        searchBarController.delegate = self
        searchBarController.searchBar.delegate = self
        searchBarController.dimsBackgroundDuringPresentation = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text, text.count > 1 else {
            return
        }
        
        collectionView.reloadData()
        
        viewModel.search(text: text) {
            print("search completed.")
        }
        
        searchBarController.searchBar.resignFirstResponder()
    }
    
}

//MARK:- Configure UI
extension ViewController {
    
    fileprivate func configureUI() {
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(nib: ImageCollectionViewCell.nibName)
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.nibName, for: indexPath) as! ImageCollectionViewCell
        cell.imageView.image = nil
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ImageCollectionViewCell else {
            return
        }
        
        let model = viewModel.photoArray[indexPath.row]
        cell.model = ImageModel.init(withPhotos: model)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = viewModel.photoArray[indexPath.row]
        presentLightBox(imgUrl: model.imageURL)
    }
}
//MARK:- UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width-self.spaceMargin)/numberOfColumns, height: (collectionView.bounds.width-self.spaceMargin)/numberOfColumns)
    }
}

extension ViewController {
    
    func addRefreshController() {
        let refreshControl = UIRefreshControl()
        refreshControl.triggerVerticalOffset = 70.0
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.bottomRefreshControl = refreshControl
    }
    
    @objc
    func refresh() {
        loadNextPage()
        collectionView.bottomRefreshControl?.endRefreshing()
    }
}

extension ViewController: LightboxControllerPageDelegate {
    
    func lightboxController(_ controller: LightboxController, didMoveToPage page: Int) {
        print(page)
    }
}

extension ViewController: LightboxControllerDismissalDelegate {
    
    func lightboxControllerWillDismiss(_ controller: LightboxController) {
        // ...
    }
    
    private func presentLightBox(imgUrl:String) {
        let images = [
            LightboxImage(imageURL: URL(string: imgUrl)!)]
        print("model.imageURL: ",imgUrl)
        
        // Create an instance of LightboxController.
        let controller = LightboxController(images: images)
        
        // Set delegates.
        controller.pageDelegate = self
        controller.dismissalDelegate = self
        
        // Use dynamic background.
        controller.dynamicBackground = true
        controller.modalPresentationStyle = .fullScreen
        // Present your controller.
        present(controller, animated: true, completion: nil)
    }
}
