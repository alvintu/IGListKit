//
//  FeedViewController.swift
//  Marslink
//
//  Created by Jo Tu on 1/18/17.
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//
import IGListKit
import UIKit

class FeedViewController: UIViewController {
    
    let pathfinder = Pathfinder()
    
    lazy var adapter : IGListAdapter = {
        //workingRangeSize is the size of working range, whic hallows preparation of content for sections just outside the visible frame
        return IGListAdapter(updater:IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
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
    //1 - objects(for:) returns array of data objects that hsould show up in the collection view
    //loader.entries is provided as it contains journal entries
    
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        var items : [IGListDiffable] = pathfinder.messages
        items += loader.entries as [IGListDiffable]
        return items
    }
    
    //2- for each data object, listadapter(_:sectionControllerFor:) must return a new instance of section controller. for now, we are returning a plan IGListSectionController to appease the compiler
    // we will modify this to return a custom journal section controller
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController{
        if object is Message{
            return MessageSectionController()
        }
        else{
        return JournalSectionController()
    }
    }
    
    //3 - emptyView(for:) returns a view that should be displayed when the list is empty. 
    
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {return nil}
    
    
}
