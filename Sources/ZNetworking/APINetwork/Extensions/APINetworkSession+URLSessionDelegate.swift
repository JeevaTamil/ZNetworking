//
//  File.swift
//  
//
//  Created by Azhagusundaram Tamil on 29/06/22.
//

import Foundation

extension APINetworkSession: URLSessionDelegate {

    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        guard let handlers = getHandlers(for: task) else {
            return
        }

        let progress = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
        DispatchQueue.main.async {
            handlers.progress?(progress)
        }
        //  Remove the associated handlers.
        set(handlers: nil, for: task)
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let downloadTask = task as? URLSessionDownloadTask,
            let handlers = getHandlers(for: downloadTask) else {
            return
        }

        DispatchQueue.main.async {
            handlers.completion?(nil, downloadTask.response, downloadTask.error)
        }

        //  Remove the associated handlers.
        set(handlers: nil, for: task)
    }
}
