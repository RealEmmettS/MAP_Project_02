//
//  ViewController.swift
//  MAP - Project 02
//
//  Created by Emmett Shaughnessy on 8/19/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scoreText: UILabel!
    @IBOutlet weak var gameboard: UILabel!
    @IBOutlet weak var mole: UIButton!
    
    var screenSize = CGRect()
    var screenWidth = CGFloat()
    var screenHeight = CGFloat()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Screen Size
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        //MARK: Score Label Setup
        let scoreFontSize = screenHeight/10
        scoreText.text = "0"
        scoreText.font = UIFont.systemFont(ofSize: scoreFontSize, weight: UIFont.Weight(90))
        
        //MARK: Gameboard Setup
        gameboard.backgroundColor = UIColor.green
        gameboard.text = ""
        
        //MARK: Mole Setup
        let centerX = gameboard.center.x
        let centerY = gameboard.center.y
        mole.frame = CGRect(x: centerX, y: centerY, width: 50, height: 50)
        mole.setTitle("", for: .normal)
        mole.backgroundColor = UIColor.brown
        //mole.center = gameboard.center
        
    }
    

    @IBAction func molePressed(_ sender: Any) {
        
        // Find the button's width and height
        let moleWidth = mole.frame.width
        let moleHeight = mole.frame.height

        // Find the width and height of the enclosing view
        let gameboardSize = gameboard.bounds
        let viewWidth = gameboardSize.width-20
        let viewHeight = gameboardSize.height-20

        // Compute width and height of the area to contain the button's center
        let xwidth = viewWidth - moleWidth
        let yheight = viewHeight - moleHeight

        // Generate a random x and y offset
        let xoffset = CGFloat(arc4random_uniform(UInt32(xwidth)))
        let yoffset = CGFloat(arc4random_uniform(UInt32(yheight)))

        // Offset the button's center by the random offsets.
        mole.center.x = xoffset + moleWidth / 2
        mole.center.y = yoffset + moleHeight / 2
        
        
    }
    
    
    


}

