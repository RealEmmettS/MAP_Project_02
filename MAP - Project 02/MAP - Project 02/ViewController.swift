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
    @IBOutlet weak var time: UILabel!
    
    var screenSize = CGRect()
    var screenWidth = CGFloat()
    var screenHeight = CGFloat()
    
    var gameboardSize = CGRect()
    
    var score:Int = 0 {
        didSet{
            scoreText.text = "\(score)";
        }
    }
    
    
    //MARK:- Start of ViewDidLod
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
        time.text = "Time Left: 10"
        time.font = UIFont.systemFont(ofSize: (scoreFontSize-70), weight: UIFont.Weight(90))
        
        //MARK: Gameboard Setup
        gameboard.backgroundColor = UIColor.green
        gameboard.text = ""
        gameboardSize = gameboard.bounds
        gameboard.layer.masksToBounds = true
        gameboard.layer.cornerRadius = 30
        print("Gameboard Width: \(gameboardSize.width)\nGameboard Height: \(gameboardSize.height)")
        
        //MARK: Mole Setup
        let centerX = gameboard.center.x
        let centerY = gameboard.center.y
        mole.frame = CGRect(x: centerX, y: centerY, width: 50, height: 50)
        mole.setTitle("", for: .normal)
        //mole.backgroundColor = UIColor.brown
//        let moleImage = UIImage(named: "mole")
//        mole.setImage(moleImage!.withRenderingMode(.alwaysOriginal), for: .normal)
        setMoleMode(dead: false)
        //mole.center = gameboard.center
        
        
        
//        let label = UILabel()
//        label.frame = CGRect(x: view.center.x, y: view.center.y, width: 50, height: 50)
//        label.text = "test"
//        label.backgroundColor = .black
//        view.addSubview(label)
        
        
        
        
        var timeLeft = 10

        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            print("Timer fired!")
            timeLeft -= 1
            self.time.text = "Time Left: \(timeLeft)"

            if timeLeft == 0 {
                self.mole.isEnabled = false
                self.mole.isHidden = true
                self.scoreText.textColor = .red
                self.gameboard.backgroundColor = .darkGray
                timer.invalidate()
            }
        }

        
    }
    //MARK:- End of ViewDidLod
    

    
    
    
    
    
    //MARK: Mole Pressed
    @IBAction func molePressed(_ sender: Any) {
        
        mole.isSelected = false
        
        score += 1
        //setMoleMode(dead: true)
        mole.isEnabled = false
        //mole.isHidden = true
        
        // Find the button's width and height
        let moleWidth = mole.frame.width
        let moleHeight = mole.frame.height

        // Find the width and height of the enclosing view
        let boardWidth = gameboardSize.width
        let boardHeight = gameboardSize.height

        // Compute width and height of the area to contain the button's center
        let xwidth = boardWidth - moleWidth
        let yheight = boardHeight - moleHeight
        
        //print(boardWidth)
        //print(boardHeight)
        
        //Generate random x and y values
        let minX = 60
        let minY = 280
        let maxX = 320
        let maxY = 280
        let randomX = Int.random(in: minX..<Int(maxX))
        let randomY = Int.random(in: minY..<Int(boardHeight))
        
        print("Random X: \(randomX)")
        print("Random Y: \(randomY)")
        
        
        // Set the mole's X and Y to the random coordinates.
        self.mole.center.x = CGFloat(randomX)
        self.mole.center.y = CGFloat(randomY)
        
        //self.setMoleMode(dead: false)
        self.mole.isEnabled = true
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
//            // Set the mole's X and Y to the random coordinates.
//            self.mole.center.x = CGFloat(randomX)
//            self.mole.center.y = CGFloat(randomY)
//
//            self.setMoleMode(dead: false)
//            self.mole.isEnabled = true
//        }
        
        
        
    }
    
    
    //MARK:- End Mole Pressed
    
    
    
    func setMoleMode(dead: Bool){
        var moleImage:UIImage? {
            didSet{
                print("Mole image changed")
            }
        }
        
        if dead{
            moleImage = UIImage(named: "deadMole")
        }else{
            moleImage = UIImage(named: "mole")
        }
        
        mole.setImage(moleImage!.withRenderingMode(.alwaysOriginal), for: .normal)

    }
    


}//End of class

