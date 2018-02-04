//
//  ImageDownloader.swift
//  Doggos
//
//  Created by Patricio Fariña on 03-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import Foundation
protocol ImageDownloaderDelegate: class {
    func didGetData(data: Data, atIndex index: Int)
    func errorOnDowload(error: String)
}
protocol ImageDownloaderProtocol: class {
    var delegate: ImageDownloaderDelegate? {get set}
    var isRunning: Bool {get set}
    func addUrl(url: URL, atIndex index: Int)
    func start()
    func stop()
}
class ImageDownloader: ImageDownloaderProtocol {
    private var urls: [URL]
    weak var delegate: ImageDownloaderDelegate?
    var isRunning: Bool = false
    private let operationQueue = OperationQueue()
    init() {
        self.urls = []
    }
    func addUrl(url: URL, atIndex index: Int) {
        urls.insert(url, at: index)
        let operation = BlockOperation()
        operation.addExecutionBlock { [weak self] in
            guard let welf = self, !operation.isCancelled else {
                return
            }
            
            welf.getImageData(forUrlAtIndex: index)
        }
        operationQueue.addOperation(operation)
    }
    func start() {
        operationQueue.isSuspended = false
        isRunning = true
    }
    func stop() {
        operationQueue.isSuspended = true
        operationQueue.cancelAllOperations()
        isRunning = false
    }
    
    private func getImageData(forUrlAtIndex index: Int) {
        let url = urls[index]
        let request = URLRequest(url: url)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { [weak self] _data, _response, _error -> Void in
            guard let welf = self else {
                return
            }
            guard _error == nil else {
                DispatchQueue.main.async {
                    welf.delegate?.errorOnDowload(error: _error!.localizedDescription)
                }
                return
            }
            guard let data = _data else {
                DispatchQueue.main.async {
                    welf.delegate?.errorOnDowload(error: "Could not read data")
                }
                return
            }
            DispatchQueue.main.async {
                welf.delegate?.didGetData(data: data, atIndex: index)
            }
        }
        task.resume()
    }
}
