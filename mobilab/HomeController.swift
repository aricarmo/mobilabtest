//
//  ViewController.swift
//  mobilab
//
//  Created by Arilson do Carmo on 4/14/16.
//  Copyright © 2016 Arilson do Carmo. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController {

    var pictureData: [PictureModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImages(false)
        // Do any additional setup after loading the view, typically from a nib.
    }

    func loadImages(increment: Bool, connector: ApiConnection = ApiConnection()) {
        connector.getImagesByType(increment, type: "hot") { (result, error) in
            print(result)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! ImageCell
        return cell;
    }
}

