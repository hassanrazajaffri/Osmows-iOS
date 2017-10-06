//
//  NSFetchRequest+CWAdditions.h
//  CWCoreData
//  Created by Fredrik Olsson 
//
//  Copyright (c) 2011, Jayway AB All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of Jayway AB nor the names of its contributors may 
//       be used to endorse or promote products derived from this software 
//       without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL JAYWAY AB BE LIABLE FOR ANY DIRECT, INDIRECT, 
//  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT 
//  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
//  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
//  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE 
//  OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF 
//  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import <Foundation/Foundation.h>


/*!
 * @abstract Convinience category for working with NSFetchRequest on the current
 *           thread local NSManagedObjectContext.
 */
@interface NSFetchRequest (CWCoreData)

+(NSFetchRequest*)requestForEntityName:(NSString*)entityName withPredicate:(NSPredicate*)predicate sortDescriptors:(NSArray*)sortDescriptors;
+(NSFetchRequest*)requestForEntityName:(NSString*)entityName withPredicate:(NSPredicate*)predicate sortDescriptors:(NSArray*)sortDescriptors inContext:(NSManagedObjectContext*)context;

@end

/*!
 * @abstract Convinience category for working with NSFetchedResultsController on the current
 *           thread local NSManagedObjectContext.
 */
@interface NSFetchedResultsController (CWCoreData)

+(NSFetchedResultsController*)fetchedResultsControllerForEntityName:(NSString*)name sortDescriptors:(NSArray*)sortDescriptors sectionNameKeyPath:(NSString*)keyPath predicate:(NSPredicate*)predicate;
+(NSFetchedResultsController*)fetchedResultsControllerForEntityName:(NSString*)name sortDescriptors:(NSArray*)sortDescriptors sectionNameKeyPath:(NSString*)keyPath;
+(NSFetchedResultsController*)fetchedResultsControllerForEntityName:(NSString*)name sortDescriptors:(NSArray*)sortDescriptors;

@end
