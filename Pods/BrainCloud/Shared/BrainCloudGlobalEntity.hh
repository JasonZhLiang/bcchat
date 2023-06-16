//
//  BrainCloudGlobalEntity.h
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-06.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#pragma once
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

#import "BrainCloudCompletionBlocks.hh"
#import <Foundation/Foundation.h>

@class BrainCloudClient;

@interface BrainCloudGlobalEntity : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
* Method creates a new entity on the server.
*
* Service Name - GlobalEntity
* Service Operation - Create
*
* @param entityType The entity type as defined by the user
* @param timeToLive Sets expiry time for entity in milliseconds if > 0
* @param jsonEntityAcl The entity's access control list as json. A null acl implies default
* @param jsonEntityData  The entity's data as a json string
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)createEntity:(NSString *)entityType
              timeToLive:(int64_t)timeToLive
           jsonEntityAcl:(NSString *)jsonEntityAcl
          jsonEntityData:(NSString *)jsonEntityData
         completionBlock:(BCCompletionBlock)completionBlock
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
* Method creates a new entity on the server with an indexed id.
*
* Service Name - GlobalEntity
* Service Operation - CreateWithIndexedId
*
* @param entityType The entity type as defined by the user
* @param indexedId A secondary ID that will be indexed
* @param timeToLive Sets expiry time for entity in milliseconds if > 0
* @param jsonEntityAcl The entity's access control list as json. A null acl implies default
* @param jsonEntityData  The entity's data as a json string
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)createEntityWithIndexedId:(NSString *)entityType
                        indexedId:(NSString *)indexedId
                       timeToLive:(int64_t)timeToLive
                    jsonEntityAcl:(NSString *)jsonEntityAcl
                   jsonEntityData:(NSString *)jsonEntityData
                  completionBlock:(BCCompletionBlock)completionBlock
             errorCompletionBlock:(BCErrorCompletionBlock)ecb
                         cbObject:(BCCallbackObject)cbObject;

/**
* Method updates an existing entity on the server.
*
* Service Name - GlobalEntity
* Service Operation - Update
*
* @param entityId The entity ID
* @param version The version of the entity to update
* @param jsonEntityData  The entity's data as a json string
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)updateEntity:(NSString *)entityId
                 version:(int64_t)version
          jsonEntityData:(NSString *)jsonEntityData
         completionBlock:(BCCompletionBlock)completionBlock
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
* Method updates an existing entity's Acl on the server.
*
* Service Name - GlobalEntity
* Service Operation - UpdateAcl
*
* @param entityId The entity ID
* @param version The version of the entity to update
* @param jsonEntityAcl The entity's access control list as json.
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)updateEntityAcl:(NSString *)entityId
                 version:(int64_t)version
           jsonEntityAcl:(NSString *)jsonEntityAcl
         completionBlock:(BCCompletionBlock)completionBlock
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
* Method updates an existing entity's time to live on the server.
*
* Service Name - GlobalEntity
* Service Operation - UpdateTimeToLive
*
* @param entityId The entity ID
* @param version The version of the entity to update
* @param timeToLive Sets expiry time for entity in milliseconds if > 0
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)updateEntityTimeToLive:(NSString *)entityId
                       version:(int64_t)version
                    timeToLive:(int64_t)timeToLive
               completionBlock:(BCCompletionBlock)completionBlock
          errorCompletionBlock:(BCErrorCompletionBlock)ecb
                      cbObject:(BCCallbackObject)cbObject;

/**
* Method deletes an existing entity on the server.
*
* Service Name - GlobalEntity
* Service Operation - Delete
*
* @param entityId The entity ID
* @param version The version of the entity to delete
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)deleteEntity:(NSString *)entityId
                 version:(int64_t)version
         completionBlock:(BCCompletionBlock)completionBlock
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
* Method reads an existing entity from the server.
*
* Service Name - GlobalEntity
* Service Operation - Read
*
* @param entityId The entity ID
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)readEntity:(NSString *)entityId
         completionBlock:(BCCompletionBlock)completionBlock
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
* Method gets list of entities from the server base on type and/or where clause
*
* Service Name - GlobalEntity
* Service Operation - GetList
*
* @param where Mongo style query string
* @param orderBy Sort order
* @param maxReturn The maximum number of entities to return
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)getList:(NSString *)where
                 orderBy:(NSString *)orderBy
               maxReturn:(int64_t)maxReturn
         completionBlock:(BCCompletionBlock)completionBlock
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
* Method gets list of entities from the server base on indexed id
*
* Service Name - GlobalEntity
* Service Operation - GetListByIndexedId
*
* @param entityIndexedId The entity indexed Id
* @param maxReturn The maximum number of entities to return
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)getListByIndexedId:(NSString *)entityIndexedId
                 maxReturn:(int64_t)maxReturn
           completionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject;

/**
* Method gets a count of entities based on the where clause
*
* Service Name - GlobalEntity
* Service Operation - GetListCount
*
* @param where Mongo style query string
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)getListCount:(NSString *)where
         completionBlock:(BCCompletionBlock)completionBlock
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
* Method uses a paging system to iterate through Global Entities
* After retrieving a page of Global Entities with this method,
* use GetPageOffset() to retrieve previous or next pages.
*
* Service Name - GlobalEntity
* Service Operation - GetPage
*
* @param context The json context for the page request.
*                   See the portal appendix documentation for format.
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)getPage:(NSString *)context
         completionBlock:(BCCompletionBlock)completionBlock
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
* Method to retrieve previous or next pages after having called the GetPage method.
*
* Service Name - GlobalEntity
* Service Operation - GetPageOffset
*
* @param context The context string returned from the server from a
*      previous call to GetPage or GetPageOffset
* @param pageOffset The positive or negative page offset to fetch. Uses the last page
*      retrieved using the context string to determine a starting point.
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)getPageOffset:(NSString *)context
              pageOffset:(int)pageOffset
         completionBlock:(BCCompletionBlock)completionBlock
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
 * Partial increment of entity data field items. Partial set of items incremented as specified.
 *
 * Service Name - globalEntity
 * Service Operation - INCREMENT_GLOBAL_ENTITY_DATA
 *
 * @param entityId The id of the entity to update
 * @param jsonData The entity's data object
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)incrementGlobalEntityData:(NSString *)entityId
                         jsonData:(NSString *)jsonData
                  completionBlock:(BCCompletionBlock)completionBlock
             errorCompletionBlock:(BCErrorCompletionBlock)ecb
                         cbObject:(BCCallbackObject)cbObject;

/**
 * Gets a list of up to randomCount randomly selected entities from the server
 *      based on the where condition and specified maximum return count. 
 * 
 * Service Name - globalEntity 
 * Service Operation - GET_RANDOM_ENTITIES_MATCHING
 *
 * @param where Mongo style query string
 * @param maxReturn The maximum number of entities to return
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getRandomEntitiesMatching:(NSString *)where
                        maxReturn:(int64_t)maxReturn
                  completionBlock:(BCCompletionBlock)completionBlock
             errorCompletionBlock:(BCErrorCompletionBlock)ecb
                         cbObject:(BCCallbackObject)cbObject;

/**
 * Method updates an existing entity's Owner and ACL on the server.
 *
 * Service Name - globalEntity
 * Service Operation - UPDATE_ENTITY_OWNER_AND_ACL
 *
 * @param entityId The entity ID
 * @param version The version of the entity to update
 * @param ownerId The owner ID
 * @param jsonEntityAcl The entity's access control list as JSON.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)updateEntityOwnerAndAcl:(NSString *)entityId
                        version:(int64_t)version
                        ownerId:(NSString *)ownerId
                  jsonEntityAcl:(NSString *)jsonEntityAcl
                completionBlock:(BCCompletionBlock)completionBlock
           errorCompletionBlock:(BCErrorCompletionBlock)ecb
                       cbObject:(BCCallbackObject)cbObject;

/**
 * Method clears the owner id of an existing entity and sets the ACL on the server.
 *
 * Service Name - globalEntity
 * Service Operation - MAKE_SYSTEM_ENTITY
 *
 * @param entityId The entity ID
 * @param version The version of the entity to update
 * @param jsonEntityAcl The entity's access control list as JSON.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)makeSystemEntity:(NSString *)entityId
                 version:(int64_t)version
           jsonEntityAcl:(NSString *)jsonEntityAcl
         completionBlock:(BCCompletionBlock)completionBlock
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

@end

#pragma clang diagnostic pop
