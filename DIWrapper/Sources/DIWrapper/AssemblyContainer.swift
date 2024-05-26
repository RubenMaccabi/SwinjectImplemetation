//
//  File.swift
//
//
//  Created by Ruben  on 19/05/2024.
//

import Foundation
import Swinject

public class AssemblyContainer {
    
    let assembly: Assembly
    
    public init<Assembled>(
        scope: ObjectScope,
        name: String? = nil,
        type: Assembled.Type? = nil,
        buildAssembly: @escaping (
            any Resolver
        ) -> Assembled,
        circularDependency: ((any Resolver, Assembled) -> Void)? = nil
    ) {
        self.assembly = AssemblyContainer.Assembled(
            scope: scope,
            name: name,
            buildAssemble: buildAssembly,
            circularDependency: circularDependency
        )
    }
    
    struct Assembled<Assembled>: Assembly {
        
        private let scope: ObjectScope
        private let name: String?
        private let buildAssemble: (any Resolver) -> Assembled
        private var circularDependency: ((any Resolver, Assembled) -> Void)
        
        init(scope: ObjectScope,
             name: String? = nil,
             buildAssemble: @escaping (any Resolver) -> Assembled,
             circularDependency: ((any Resolver, Assembled) -> Void)?) {
            self.scope = scope
            self.name = name
            self.buildAssemble = buildAssemble
            self.circularDependency = circularDependency ?? {_, _ in }
        }
        
        func assemble(container: Container) {
            container
                .register(Assembled.self, name: name, factory: buildAssemble)
                .inObjectScope(scope)
                .initCompleted(circularDependency)
        }
    }
}
