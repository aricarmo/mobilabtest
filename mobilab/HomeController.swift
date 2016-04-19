//
//  ViewController.swift
//  mobilab
//
//  Created by Arilson do Carmo on 4/14/16.
//  Copyright © 2016 Arilson do Carmo. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController {

    var pictureData: [PictureModel] = []
    let imageService = ImageService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImages(false)
        // Do any additional setup after loading the view, typically from a nib.
    }

    func loadImages(increment: Bool, connector: ApiConnection = ApiConnection()) {
        connector.getImagesByType(increment, type: "hot") { (result, error) in
            self.pictureData = result!
            self.collectionView?.reloadData()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pictureData.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! ImageCell
        cell.lblTitle.text = pictureData[indexPath.row].title
        cell.imgHero.image = nil
        if let url = self.pictureData[indexPath.row].link {
            if let img = imageService.getAvatarCache(url) {
                cell.imgHero.image = img
            } else {
                imageService.asyncLoadImageContent(url, completion: { (image) in
                    let ip = collectionView.indexPathForCell(cell)
                    if indexPath.isEqual(ip) {
                        cell.imgHero.image = image
                    }
                })
            }
        }
        return cell;
    }
}

