//
//  ViewController.swift
//  ToastAndSnackBar
//
//  Created by alican on 1.12.2021.
//

import UIKit

class ViewController: UIViewController {

    var viewModel : SnackbarViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button1 = UIButton(frame: CGRect(x: 20, y: 130 + (CGFloat(0) * 55) + (CGFloat(0) * 10), width: view.frame.size.width-40, height: 55))
        button1.tag = 1
        button1.backgroundColor = .purple
        button1.setTitle("info Snackbar", for: .normal)
        button1.setTitleColor(.white, for: .normal)
        button1.addTarget(self, action: #selector(didTappedButton1), for: .touchUpInside)
        view.addSubview(button1)
        let button2 = UIButton(frame: CGRect(x: 20, y: 130 + (CGFloat(1) * 55) + (CGFloat(1) * 10), width: view.frame.size.width-40, height: 55))
        button2.tag = 2
        button2.backgroundColor = .purple
        button2.setTitle("action Snackbar", for: .normal)
        button2.setTitleColor(.white, for: .normal)
        button2.addTarget(self, action: #selector(didTappedButton2), for: .touchUpInside)
        view.addSubview(button2)
    }

    @objc private func didTappedButton1(){
        viewModel = SnackbarViewModel(type: .info, text: "Hello World", image: UIImage(systemName: "bell"))
        let frame = CGRect(x: 0, y: 0, width: view.frame.size.width/1.2, height: 60)
        let snackbar = SnackbarView(viewModel: viewModel , frame: frame)
        showSnackbar(snackBar: snackbar)
    }
    
    @objc private func didTappedButton2(){
        viewModel = SnackbarViewModel(type: .action(handler: {[weak self] in
            DispatchQueue.main.async {
                self?.showAlert()
            }
        }), text: "Hello World", image: UIImage(systemName: "bell"))
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.size.width/1.2, height: 60)
        let snackbar = SnackbarView(viewModel: viewModel , frame: frame)
        showSnackbar(snackBar: snackbar)
    }
    
    private func showAlert(){
        let alert = UIAlertController(title: "Opps", message: "This is a sample text.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert,animated: true)
    }
    
    public func showSnackbar(snackBar : SnackbarView){
        
        let width = view.frame.size.width/1.2
        snackBar.frame = CGRect(x: (view.frame.size.width-width)/2, y: view.frame.size.height - 110, width: width, height: 60)
        view.addSubview(snackBar)
        
        UIView.animate(withDuration: 0.5, animations: {
            snackBar.frame = CGRect(x: (self.view.frame.size.width-width)/2, y: self.view.frame.size.height - 110, width: width, height: 60)
        },completion: { done in
            if done{
                DispatchQueue.main.asyncAfter(deadline: .now()+4, execute: {
                    UIView.animate(withDuration: 0.5) {
                        snackBar.frame = CGRect(x: (self.view.frame.size.width-width)/2, y: self.view.frame.size.height, width: width, height: 60)
                    } completion: { finished in
                        if finished{
                            snackBar.removeFromSuperview()
                        }
                    }
                })
            }
        })
    }
}

