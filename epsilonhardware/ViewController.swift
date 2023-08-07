//
//  ViewController.swift
//  epsilonhardware
//
//  Created by Hiren on 14/06/22.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var refController:UIRefreshControl = UIRefreshControl()
    
    var baseURL = "https://pythonprofiles.com/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.load(NSURLRequest(url: NSURL(string: baseURL)! as URL) as URLRequest)
        
        refController.bounds = CGRect(x: 0, y: 50, width: refController.bounds.size.width, height: refController.bounds.size.height)
        refController.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        refController.attributedTitle = NSAttributedString(string: "Pull to refresh")
        webView.scrollView.addSubview(refController)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !Reachability.isConnectedToNetwork(){
            let alert = UIAlertController(title: "Network Error", message: "No internet connection, Please check the network settings.", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            print("Internet Connection not Available!")
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            webView.load(NSURLRequest(url: NSURL(string: baseURL)! as URL) as URLRequest)
            refController.endRefreshing()
        } else {
            // create the alert
            let alert = UIAlertController(title: "Network Error", message: "No internet connection, Please check the network settings.", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { alert in
                self.refController.endRefreshing()
            }))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            print("Internet Connection not Available!")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func checkInternet(){
        
    }
}

