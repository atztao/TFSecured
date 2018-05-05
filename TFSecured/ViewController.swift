//
//  ViewController.swift
//  TFSecured
//
//  Created by user on 5/3/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit


private let INPUT_NODE_NAME     = "nn_input"
private let OUTPUT_NODE_NAME    = "nn_output"
private let IMAGE_SIDE_SIZE     = 28


class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        recognize(image: #imageLiteral(resourceName: "nine"))
    }
    
    
    private func recognize(image: UIImage) {
        DispatchQueue.global().async {
            
            let modelPath = Bundle.main.path(forResource: "saved_model", ofType: "pb")!
            let predictor = MNISTPredictor.initWith(modelPath,
                                                    inputNodeName: INPUT_NODE_NAME,
                                                    outputNodeName: OUTPUT_NODE_NAME)
            predictor.loadModel(nil)
            let inputImage =  image.resize(targetSize: CGSize(width: IMAGE_SIDE_SIZE,
                                                              height: IMAGE_SIDE_SIZE))
            predictor.predict(image: inputImage,
                              success: { digit in
                print("Recognized Digit: \(digit)")
            }, error: {
                print("Error")
            })
            
        }
    }
}

