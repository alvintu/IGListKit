//
//  FeedViewController.swift
//  Marslink
//
//  Created by Jo Tu on 1/18/17.
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//
import IGListKit
import UIKit

class FeedViewController: UIViewController, IGListUpdatingDelegate {
    
    lazy var adapter : IGListAdapter = {
        //workingRangeSize is the size of working range, whic hallows preparation of content for sections just outside the visible frame
        return IGListAdapter(updater:(), viewController: self, workingRangeSize: 0)
    }
    
    let collectionView: IGListCollectionView = {
        let view = IGListCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = UIColor.black
        return view
    }()
    
    //JourneyEntryLoader class loads hard-coded journal entries into an entries array
    let loader = JournalEntryLoader()
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
 
        view.addSubview(collectionView)

        // Do any additional setup after loading the view.
    //loadLatest method is a JournalEntryLoader method that loads lastest journal entries
        loader.loadLatest()
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FeedViewController: IGListAdapterDataSource {
    //1
    
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        return loader.entries
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController{
        return IGListSectionController()
    }
    
    
    
}
