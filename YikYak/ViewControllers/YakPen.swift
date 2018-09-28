//
//  YakPen.swift
//  YikYak
//
//  Created by DevMountain on 9/27/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import UIKit

class YakPen: UIViewController {
    
    @IBOutlet weak var yakTextLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var upVoteButton: UIButton!
    @IBOutlet weak var downVoteButton: UIButton!
    
    var yak: Yak?{
        didSet{
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    func updateViews(){
        guard let yak = yak else {return}
        yakTextLabel.text = yak.text
        authorLabel.text = yak.author
        upVoteButton.setTitle("Up Votes: \(yak.upVotes)", for: .normal)
        downVoteButton.setTitle("Down Votes: \(yak.downVotes)", for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func upVoteButtonTapped(_ sender: Any) {
        guard let yak = yak else {return}
        
        yak.upVotes += 1
        updateViews()
    }
    
    @IBAction func downVoteButtonTapped(_ sender: Any) {
        guard let yak = yak else {return}
        
        yak.downVotes -= 1
        updateViews()
    }
}
