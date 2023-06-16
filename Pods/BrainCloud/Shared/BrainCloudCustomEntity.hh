//
//  BrainCloudEntity.h
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

@interface BrainCloudCustomEntity : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
 * Method creates a new entity on the server.
 *
 * @param entityType The entity type as defined by the user
 * @param dataJson The entity's data as a json String
 * @param acl The entity's access control list as json. A null acl implies
 *            default permissions which make the entity readable/writeable
 *            by only the player.
 * @param timeToLive
 * @param isOwned
 * @param callback Callback.
 */
- (void)createEntity:(NSString *)entityType
            dataJson:(NSString *)dataJson
                 acl:(NSString *)acl
          timeToLive:(long)timeToLive
             isOwned:(bool)isOwned
     completionBlock:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject;

/**
 * Deletes the specified custom entity on the server, enforcing ownership/ACL permissions.
 *
 * @param entityType The entity type as defined by the user
 * @param entityId
 * @param version
 * @param callback Callback.
 */
- (void)deleteEntity:(NSString *)entityType
            entityId:(NSString *)entityId
      jsonEntityData:(NSString *)jsonEntityData
             version:(int)version
     completionBlock:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject;

/**
 * Deletes Entities based on the criteria passed in
 *
 * @param entityType The entity type as defined by the user
 * @param deleteCriteria
 * @param callback Callback.
 */
- (void)deleteEntities:(NSString *)entityType
      deleteCriteria:(NSString *)deleteCriteria
     completionBlock:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject;
/**
 * Counts the number of custom entities meeting the specified where clause, enforcing ownership/ACL permissions.
 *
 * @param entityType The entity type as defined by the user
 * @param whereJson
 * @param callback Callback.
 */
- (void)getCount:(NSString *)entityType
           whereJson:(NSString *)whereJson
     completionBlock:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject;

/**
 *Gets a lits of up to maxReturn of randomly selected Entities based on the type and where condition.
 *
 * @param entityType The entity type as defined by the user
 * @param whereJson Mongo style query string
 * @param maxReturn quantity of returned entities
 * @param callback Callback.
 */
- (void)getRandomEntitiesMatching:(NSString *)entityType
           whereJson:(NSString *)whereJson
        maxReturn:(int)maxReturn
     completionBlock:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject;
/**
 * Retrieves first page of custom entities from the server based on the custom entity type and specified query context, enforcing ownership/ACL permissions.
 *
 * @param entityType The entity type as defined by the user
 * @param rowsPerPage
 * @param searchJson
 * @param sortJson
 * @param doCount
 * @param callback Callback.
 */
- (void)getPage:(NSString *)entityType
             context:(NSString *)context
     completionBlock:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject;

/**
 * Gets the page of custom entities from the server based on the encoded context and specified page offset, enforcing ownership/ACL permissions.
 *
 * @param entityType The entity type as defined by the user
 * @param context
 * @param pageOffset
 * @param callback Callback.
 */
- (void)getPageOffset:(NSString *)entityType
              context:(NSString *)context
           pageOffset:(int)pageOffset
      completionBlock:(BCCompletionBlock)completionBlock
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject;

/**
 * Reads a custom entity, enforcing ownership/ACL permissions.
 *
 * @param entityType The entity type as defined by the user
 * @param entityId
 * @param callback Callback.
 */
- (void)readEntity:(NSString *)entityType
            entityId:(NSString *)entityId
     completionBlock:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject;

/**
 * Replaces the specified custom entity's data, and optionally updates the acl and expiry, on the server, enforcing current ownership/ACL permissions.
 *
 * @param entityType The entity type as defined by the user
 * @param entityId
 * @param version
 * @param dataJson
 * @param acl
 * @param timeToLive
 * @param callback Callback.
 */
- (void)updateEntity:(NSString *)entityType
            entityId:(NSString *)entityId
             version:(int)version
            dataJson:(NSString *)dataJson
                 acl:(NSString *)acl
          timeToLive:(long)timeToLive
     completionBlock:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject;

/**
 * Replaces the specified custom entity's data, and optionally updates the acl and expiry, on the server, enforcing current ownership/ACL permissions.
 *
 * @param entityType The entity type as defined by the user
 * @param entityId
 * @param version
 * @param fieldsJson
 * @param callback Callback.
 */
- (void)updateEntityFields:(NSString *)entityType
                  entityId:(NSString *)entityId
                   version:(int)version
                fieldsJson:(NSString *)fieldsJson
           completionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject;

/**
 * Replaces the specified custom entity's data, and optionally updates the acl and expiry, on the server, enforcing current ownership/ACL permissions.
 *
 * @param entityType The entity type as defined by the user
 * @param entityId
 * @param version
 * @param fieldsJson
 * @param shardKeyJson The shard key field(s) and value(s), as JSON, applicable to the entity being updated.
 * @param callback Callback.
 */
- (void)updateEntityFieldsSharded:(NSString *)entityType
                         entityId:(NSString *)entityId
                          version:(int)version
                       fieldsJson:(NSString *)fieldsJson
                     shardKeyJson:(NSString *)shardKeyJson
                  completionBlock:(BCCompletionBlock)completionBlock
             errorCompletionBlock:(BCErrorCompletionBlock)ecb
                         cbObject:(BCCallbackObject)cbObject;

/**
 * Deletes the specified custom entity singleton, owned by the session's user, for the specified entity type, on the server
 * @param entityType The entity type as defined by the user
 * @param version
 * @param callback Callback.
 * */
- (void)deleteSingleton:(NSString *)entityType
                   version:(int)version
           completionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject;

/**
 * Reads the custom entity singleton owned by the session's user
 * @param entityType The entity type as defined by the user
 * @param callback Callback.
 * */
- (void)readSingleton:(NSString *)entityType
           completionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject;

/**
 * Partially updates the data, of the singleton owned by the user for the specified custom entity type, with the specified fields, on the server
 * @param entityType The entity type as defined by the user
 * @param version
 * @param fieldsJson
 * @param callback Callback. */
- (void)updateSingletonFields:(NSString *)entityType
                      version:(int)version
                   fieldsJson:(NSString *)fieldsJson
              completionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject;

/**
 * Updates the singleton owned by the user for the specified custom entity type on the server, creating the singleton if it does not exist. This operation results in the owned singleton's data being completely replaced by the passed in JSON object
 * @param entityType The entity type as defined by the user
 * @param version
 * @param fieldsJson
 * @param acl
 * @param timeToLive
 * @param callback Callback. */
- (void)updateSingleton:(NSString *)entityType
                    version:(int)version
                   dataJson:(NSString *)dataJson
                        acl:(NSString *)acl
                        timeToLive:(int64_t)timeToLive
            completionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject;

/**
 * Increments the specified fields by the specified amount within custom entity data on the server, enforcing ownership/ACL permissions
 *
 * @param entityType The entity type as defined by the user
 * @param entityId
 * @param fieldsJson
 * @param callback Callback.
 */
- (void)incrementData:(NSString *)entityType
                  entityId:(NSString *)entityId
                fieldsJson:(NSString *)fieldsJson
           completionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject;

/**
 * Increments the specified fields, of the singleton owned by the user, by the specified amount within the custom entity data on the server.
 *
 * @param entityType The entity type as defined by the user
 * @param fieldsJson
 * @param callback Callback.
 */
- (void)incrementSingletonData:(NSString *)entityType
				fieldsJson:(NSString *)fieldsJson
		   completionBlock:(BCCompletionBlock)completionBlock
	  errorCompletionBlock:(BCErrorCompletionBlock)ecb
				  cbObject:(BCCallbackObject)cbObject;

@end

#pragma clang diagnostic pop
