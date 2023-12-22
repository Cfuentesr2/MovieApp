//
//  ProgressView.swift
//  MovieApp
//
//  Created by Carlos Enrrique Fuentes Rojas on 20/12/23.
//

import UIKit

public class ProgressView {
    
    // MARK: - Properties
    
    public static let shared = ProgressView()
    
    public var containerSize: CGFloat = 80
    public var indicatorSize: CGFloat = 40
    public var containerColor = UIColor(hex: "#FFFFFF")
    public var backgroundColor = UIColor(hex: "#000000", alpha: 0.25)
    public var indicatorColor = UIColor.gray
    
    private lazy var containerView = UIView()
    private lazy var containerIndicator = UIView()
    private lazy var activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Lifecycle
    
    private init() {}
    
    public func showProgressView(in parentView: UIView) {
        // Container
        containerView.frame = parentView.bounds
        containerView.backgroundColor = backgroundColor
        containerView.addSubview(containerIndicator)
        // Container indicator
        containerIndicator.frame = CGRect(x: 0, y: 0, width: containerSize, height: containerSize)
        containerIndicator.center = containerView.center
        containerIndicator.backgroundColor = containerColor
        containerIndicator.clipsToBounds = true
        containerIndicator.layer.cornerRadius = 10
        containerIndicator.addSubview(activityIndicator)
        // Indicator
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.frame = CGRect(x: 0, y: 0, width: indicatorSize, height: indicatorSize)
        activityIndicator.color = indicatorColor
        activityIndicator.centerXAnchor.constraint(equalTo: containerIndicator.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: containerIndicator.centerYAnchor).isActive = true
        parentView.addSubview(containerView)
        activityIndicator.startAnimating()
    }
    
    public func hideProgressView() {
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
    
}
