//
//  ImageViewController.swift
//  Pocket Library
//
//  Created by Kinan Alsheikh on 5/5/18.
//  Copyright © 2018 Kinan Alsheikh. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, PressedDelegate {

    var pic: UIImageView!
    var picture: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pic = UIImageView(image: picture)
        pic.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pic)
        setUpConstraints()
        // Do any additional setup after loading the view.
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            pic.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            pic.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            pic.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
            pic.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: 100)
            ])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableViewPressed(withImage image: UIImage){
        picture = image
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
