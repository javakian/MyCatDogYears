//
//  MainVC.swift
//  CatDogYears
//
//  Created by James Avakian on 8/15/15.
//  Copyright © 20156 Optical Automation, LLC. All rights reserved.
//

import UIKit
import AVFoundation

class MainVC: UIViewController, AVAudioPlayerDelegate {
    
    var audioPlayer = AVAudioPlayer()

    @IBOutlet weak var catAgeEntry: UITextField!
    @IBOutlet weak var catAgeResult: UILabel!
    @IBOutlet weak var dogAgeEntry: UITextField!
    @IBOutlet weak var dogAgeResult: UILabel!
    @IBOutlet weak var randomFactoidText: UILabel!
    
    var factoids = ["The average lifespan of an indoor cat is 13 - 17 years, while a feral outdoor cat only has a life expectancy of about six years.", "It is not uncommon for an indoor cat to live up to 18 - 20 years.", "For a long time it was though that cats and dogs both aged about 7 cat/dog years per one human year. We use a more accurate calculation in this app.", "The average lifespan of a mixed breed dog is approximately 12 - 14 years.", "Smaller dog breeds generally outlive their larger counterparts.", "Scientists think larger breeds age quicker because they have more growth hormones.", "A chihuahua can live up to 18 years of age.", "The life expectancy of cats and dogs vary slightly depending on the type of breed.", "The Newfoundland dog breed has a water resistant coat and webbed feet.", "Three dogs (from First Class cabins!) survived the sinking of the Titanic.", "It’s rumored that, at the end of the Beatles song, “A Day in the Life,” Paul McCartney recorded an ultrasonic whistle, audible only to dogs, just for his Shetland sheepdog.", "Puppies have 28 teeth and normal adult dogs have 42.", "Dogs chase their tails for a variety of reasons: curiosity, exercise, anxiety, predatory instinct or, they might have fleas!", "Dalmatian puppies are pure white when they are born and develop their spots as they grow older.", "Dogs and humans have the same type of slow wave sleep (SWS) and rapid eye movement (REM) and during this REM stage dogs can dream.", "Dogs’ eyes contain a special membrane, called the tapetum lucidum, which allows them to see in the dark.", "A dog’s normal temperature is between 101 and 102.5 degrees Fahrenheit.", "Unlike humans who sweat everywhere, dogs only sweat through the pads of their feet.", "62% of U.S. households own a pet, which equates to 72.9 million homes.", "45% of dogs sleep in their owner’s bed.", "Dogs’ noses secrete a thin layer of mucous that helps them absorb scent. They then lick their noses to sample the scent through their mouth.", "Dogs have about 1,700 taste buds. Humans have approximately 9,000 and cats have around 473.", "A Dog’s sense of smell is 10,000 – 100,000 times more acute as that of humans.", "Dogs hear best at 8,000 Hz, while humans hear best at around 2,000 Hz.", "Dogs’ ears are extremely expressive. It’s no wonder! There are more than a dozen separate muscles that control a dog’s ear movements.", "When dogs kick after going to the bathroom, they are using the scent glands on their paws to further mark their territory.", "In addition to sweating through their paw pads, dogs pant to cool themselves off. A panting dog can take 300-400 breaths (compared to his regular 30-40) with very little effort.", "Cats can drink sea water, cats have kidneys that can filter out salt and use the water content to hydrate their bodies.", "Scientists believe that a mutation in a key taste receptor has prevented cats from being able to taste sugar.", "The furry tufts inside cats' ears insulate the ear, and help filter out direct sounds and debris.", "The ridged pattern on cat’s nose is as unique as a human fingerprint.", "Nikola Tesla was inspired to investigate electricity after his cat, Macak, gave him a static shock.", "Kittens start to dream when they’re about a week old.", "Kittens sleep a lot because their bodies release a growth hormone only when they’re asleep.", "Cats sleep so much that, by the time a cat is 9 years old, it will only have been awake for three years of its life.", "By neutering a cat, you add about two to three years to its life."]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        getRandomFactoid(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CalculateCatYearsTapped(sender: AnyObject) {
        
        if catAgeEntry.text == "" {
            catAgeEntry.text = "1"
        }
        
        let age = Double(catAgeEntry.text!)!
        
        var result : Double = 0
        
        switch age {
        case 1:
            result = 15
            catAgeResult.text = String(result)
        case 2:
            result = 24
            catAgeResult.text = String(result)
        default:
            let interumResult = (age - 2) * 4
            result = interumResult + 24
            catAgeResult.text = String(result)
        }
        
        // play sound meow
        
        do {
            try playSound("meow", fileExtension: "wav")
        } catch {
            return
        }
        
        catAgeResult.hidden = false
        catAgeEntry.text = ""
        catAgeEntry.resignFirstResponder()
        getRandomFactoid(self)
        
    }
    
    @IBAction func calculateDogYearsTapped(sender: AnyObject) {
        
        if dogAgeEntry.text == "" {
            dogAgeEntry.text = "1"
        }
        
        let age = Double(dogAgeEntry.text!)!
        
        var result : Double = 0
        
        switch age {
        case 1, 2:
            result = age * 10.5
            dogAgeResult.text = String(result)
        default:
            let interumResult = (age - 2) * 4
            result = interumResult + 21
            dogAgeResult.text = String(result)
        }
        
        // play sound bark
        
        do {
            try playSound("bark", fileExtension: "m4a")
        } catch {
            return
        }
        
        dogAgeResult.hidden = false
        dogAgeEntry.text = ""
        dogAgeEntry.resignFirstResponder()
        getRandomFactoid(self)
        
    }
    
    @IBAction func getRandomFactoid(sender: AnyObject) {
        
        let randomNumber = Int(arc4random_uniform(UInt32(factoids.count)))
        randomFactoidText.text = factoids[randomNumber]
    }
    
    func playSound(fileName: String, fileExtension: String) throws {
        super.viewDidLoad()
        
        let dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_async(dispatchQueue, { let mainBundle = NSBundle.mainBundle()
            
            let filePath = mainBundle.pathForResource("\(fileName)", ofType:"\(fileExtension)")
            
            if let path = filePath {
                let fileData = NSData(contentsOfFile: path)
                
                do {
                    /* Start the audio player */
                    self.audioPlayer = try AVAudioPlayer(data: fileData!)
                    
                    guard let player : AVAudioPlayer? = self.audioPlayer else {
                        return
                    }
                    
                    /* Set the delegate and start playing */
                    player!.delegate = self
                    if player!.prepareToPlay() && player!.play() {
                        /* Successfully started playing */
                    } else {
                        /* Failed to play */
                    }
                    
                } catch {
                    //self.audioPlayer = nil
                    return
                }
                
            }
            
        })
        
    }

}
