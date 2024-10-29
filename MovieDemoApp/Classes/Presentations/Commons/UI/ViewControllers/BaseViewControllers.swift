//
//  BaseViewControllers.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/27/24.
//

import Foundation
import UIKit
import RxSwift

/// Abstract Base ViewController
class BaseViewController<T: AnyObject>: UIViewController, ViewModelBindableType {
    
    var isKeyboardObserverEnabled: Bool = true
    private var keyboardListeners: [NSObjectProtocol] = []
    
    var bottomLayoutAnchor: NSLayoutConstraint?
    
    var viewModel: T?
    
    let disposeBag = DisposeBag()
    
    deinit {
        viewModel = nil
        removeKeyboardEventListeners()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUILayouts()
    }

    // MARK: - Binding
    open func bindViewModel() {
        fatalError("Please override this method")
    }
    
    // MARK: - Setup
    open func setupUILayouts() {
        fatalError("Please override this method")
    }
    
    open func configCloseButtonIfNeeded() {
        let close = UIBarButtonItem(barButtonSystemItem: .close,
                                    target: self, action: #selector(closeButtonTapped(_:)))
        // close.tintColor = .primaryFillColor
        self.navigationItem.leftBarButtonItem = close
    }
    
    @objc open func closeButtonTapped(_ button: UIBarButtonItem) {
        print("Handle this close button")
    }
    
    open func presentAlertFor(error msg: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in completion() }))
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
            alert.dismiss(animated: true)
        }))
        present(alert, animated: true)
    }
    // MARK: - Keyboard Observation
    
    /// Subscribe to Keyboard Events likes Keyboard will show, will hide, and keyboard frame will change
    func listenToKeyboardEvents() {
        guard keyboardListeners.isEmpty else {
            return
        }

        isKeyboardObserverEnabled = true
        let willShow = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification,
                                               object: nil, queue: .main) {[weak self] notification in
            self?.didKeyboardNotificationEventFire(notification)
        }
        let willChange = NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillChangeFrameNotification,
            object: nil,
            queue: .main
        ) {[weak self] notification in
            self?.didKeyboardNotificationEventFire(notification)
        }
        
        let willHide = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                               object: nil, queue: .main) {[weak self] notification in
            self?.didKeyboardNotificationEventFire(notification)
        }
        keyboardListeners = [willShow, willHide, willChange]
    }
    
    /// Unsubscribe keyboards listeners
    func removeKeyboardEventListeners() {
        guard keyboardListeners.isEmpty == false else {
            return
        }
        for listener in keyboardListeners {
            NotificationCenter.default.removeObserver(listener)
        }
        keyboardListeners.removeAll()
    }
    
    private func didKeyboardNotificationEventFire(_ notification: Notification) {
        // if keyboard observer enabled otherwise do nothing
        guard isKeyboardObserverEnabled else {
            return
        }
        
        // get necessary information
        let userInfo = notification.userInfo
        let name = notification.name
        
        // Get the animation curve constant and the duration for your animation.
        guard let animationCurve = userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
              let animationDuration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
              let keyboardEndFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        // Convert the animation curve constant to animation options.
        let animationOptions = UIView.AnimationOptions(rawValue: animationCurve << 16)
        
        var keyboardEvent = KeyboardEvent(keyboardHeight: keyboardEndFrame.height,
                                          animationDuration: animationDuration,
                                          animationOptions: animationOptions)
        
        switch name {
        case UIResponder.keyboardWillShowNotification:
            keyboardEvent.type = .willShow
        case UIResponder.keyboardWillHideNotification:
            keyboardEvent.type = .willHide
        case UIResponder.keyboardWillChangeFrameNotification:
            keyboardEvent.type = .willChange
        default:
            return
        }
        
        keyboardEventReceived(event: keyboardEvent)
    }
    
    open func keyboardEventReceived(event: KeyboardEvent) {
        
        // 1. animation for bottom layout
        let distance = event.type == .willHide ? 0 : event.keyboardHeight
        var bottom: CGFloat = 0
        // calculate the bottom height
        let safeBottom = self.view.safeAreaInsets.bottom
        bottom = distance >= safeBottom ? distance - safeBottom : safeBottom
            
        UIView.animate(withDuration: event.animationDuration, delay: .zero,
                       options: event.animationOptions) { [unowned self] in
            bottomLayoutAnchor?.constant = bottom
            view.layoutIfNeeded()
        } completion: { _ in
            
        }
        // 2. override
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BaseViewController {
    
    struct KeyboardEvent {
       
        enum EventType: Int {
            case willShow
            case willHide
            case willChange
        }
        
        var type: EventType
        var keyboardHeight: CGFloat
        var animationDuration: TimeInterval
        var animationOptions: UIView.AnimationOptions
        
        fileprivate init(type: EventType = .willShow,
                         keyboardHeight: CGFloat = .zero,
                         animationDuration: TimeInterval = .zero,
                         animationOptions: UIView.AnimationOptions = []) {
            self.type = type
            self.keyboardHeight = keyboardHeight
            self.animationDuration = animationDuration
            self.animationOptions = animationOptions
        }
        
    }
    
}
