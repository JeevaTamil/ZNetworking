//
//  File.swift
//  
//
//  Created by Azhagusundaram Tamil on 29/06/22.
//

import Foundation

extension APINetworkSession: NetworkSessionProtocol {

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask? {
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            completionHandler(data, response, error)
        }
        return dataTask
    }

    func downloadTask(request: URLRequest, progressHandler: ProgressHandler? = nil, completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask? {
        let downloadTask = session.downloadTask(with: request)
        // Set the associated progress and completion handlers for this task.
        set(handlers: (progressHandler, completionHandler), for: downloadTask)
        return downloadTask
    }

    func uploadTask(with request: URLRequest, from fileURL: URL, progressHandler: ProgressHandler? = nil, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask? {
        let uploadTask = session.uploadTask(with: request, fromFile: fileURL, completionHandler: { (data, urlResponse, error) in
            completion(data, urlResponse, error)
        })
        // Set the associated progress handler for this task.
        set(handlers: (progressHandler, nil), for: uploadTask)
        return uploadTask
    }
}
