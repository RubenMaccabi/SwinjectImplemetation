//
//  File.swift
//  
//
//  Created by Ruben  on 19/05/2024.
//

import Foundation
import Swinject
import UIKit
import SwiftUI


/// DiBuilder: protocol wrapping the graph builder functionnality
public protocol DiBuilder {
    var assembler: Assembler? { get }
    func makeAssembler(container: Container, startBy: @escaping (DI) -> UIViewController) -> DiBuilder
    func build()
    func resolve<T>(_ type: T.Type, name: String?) -> T
    func startUIKitApp() -> UIViewController?
}

extension DiBuilder {
    
    /// Creates a swift ui view
    /// - Returns: Return the root virew of swift ui app
    public func startSwiftUIApp() -> some View {
        AssembledViewRepresentable(parent: self)
    }
}

final public class DI: DiBuilder  {
    
    private var assemblies: [AssemblyContainer]
    public private (set) var assembler: Assembler?
    private var startApp: ((DI) -> UIViewController)?
    
    /// Object building the DI graph
    public init() {
        self.assemblies = []
    }
    
    @discardableResult
    /// Adds an object to the graph
    ///`
    ///let rootContainer = AssemblyContainer(scope: .container) { _ in
    ///  UINavigationController()
    ///}
    /// `
    /// - Parameter assembly: Instance holding an assembly object
    /// - Returns: DI
    public func add(_ assembly: AssemblyContainer) -> Self {
        self.assemblies.append(assembly)
        return self
    }
    
    @discardableResult
    /// Build the assembler to inject into the AssembledApp initializaer
    /// - Parameters:
    ///   - container: Swinject Container https://github.com/Swinject/Swinject
    ///   - startBy: Closure offering the possibility to create the Root of the app.
    /// - Returns: DiBuilder protocol to be injected in AssembledApp
    public func makeAssembler(container: Container = Container(), startBy: @escaping (DI) -> UIViewController) -> DiBuilder  {
        self.assembler = .init(container: container)
        self.startApp = startBy
        return self
    }
    
    public func build() {
        guard let assembler = assembler else {
            fatalError("makeAssembler(container:) has not been called !")
        }
        assembler.apply(assemblies: assemblies.map(\.assembly))
    }
    
    
    /// Helper method to fetch an Instance in graph according to its type of name. Make sure to add a name in the case you are using a protocol injection in order for the Graph to resolve the correct instance.
    /// - Parameters:
    ///   - type: The wanted type to be resolved from the graph
    ///   - name: Optionnal key value, recommended to key set when resolving an instance saved with protocol type.
    /// - Returns: The resolve type
    /// - Throws: Fatal error in case where the object has not been registered
    public func resolve<T>(_ type: T.Type, name: String? = nil) -> T {
        guard let resolved = assembler?.resolve(T.self, name: name) else {
            fatalError("\(T.self) has not beenRegistered")
        }
        return resolved
    }
    
    
    /// Returns the root view controller to be set in the window of the AppDelegate
    /// - Returns: root view controller of the app
    public func startUIKitApp() -> UIViewController? {
        guard let resolver = assembler?.resolver else {
            fatalError("makeAssembler() not called")
        }
        return startApp?(self)
    }
}

public extension Assembler {
    
    /// Helper method to fetch an Instance in graph according to its type of name. Make sure to add a name in the case you are using a protocol injection in order for the Graph to resolve the correct instance.
    /// - Parameters:
    ///   - type: The wanted type to be resolved from the graph
    ///   - name: Optionnal key value, recommended to key set when resolving an instance saved with protocol type.
    /// - Returns: The resolve type
    /// - Throws: Fatal error in case where the object has not been registered
     func resolve<T>(_ type: T.Type, name: String? = nil) -> T {
        guard let resolved = resolver.resolve(T.self, name: name) else {
            fatalError("\(T.self) has not beenRegistered")
        }
        return resolved
    }
}

public extension Resolver {

    
    /// Helper method to fetch an Instance in graph according to its type of name. Make sure to add a name in the case you are using a protocol injection in order for the Graph to resolve the correct instance.
    /// - Parameters:
    ///   - type: The wanted type to be resolved from the graph
    ///   - name: Optionnal key value, recommended to key set when resolving an instance saved with protocol type.
    /// - Returns: The resolve type
    /// - Throws: Fatal error in case where the object has not been registered
    func resolving<T>(_ type: T.Type, name: String? = nil) -> T {
        guard let resolved = resolve(T.self, name: name) else {
            fatalError("\(T.self) has not beenRegistered")
        }
        return resolved
    }
}
