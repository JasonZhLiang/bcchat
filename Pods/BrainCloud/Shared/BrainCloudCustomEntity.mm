//
//  BrainCloudEntity.m
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-06.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#include "BrainCloudCallback.hh"
#import "TypeHelpers.hh"
#include "braincloud/BrainCloudClient.h"
#import "BrainCloudClient.hh"
#import "BrainCloudCustomEntity.hh"

@interface BrainCloudCustomEntity ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudCustomEntity

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (void)createEntity:(NSString *)entityType
            dataJson:(NSString *)dataJson
                 acl:(NSString *)acl
          timeToLive:(long)timeToLive
             isOwned:(bool)isOwned
     completionBlock:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject
{
    _client->getCustomEntityService()->createEntity(
                                              [entityType UTF8String],
                                              [dataJson UTF8String],
                                              [acl UTF8String],
                                              timeToLive,
                                              isOwned,
                                              new BrainCloudCallback(completionBlock, ecb, cbObject));
}


- (void)deleteEntity:(NSString *)entityType
            entityId:(NSString *)entityId
      jsonEntityData:(NSString *)jsonEntityData
             version:(int)version
     completionBlock:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject
{
    _client->getCustomEntityService()->deleteEntity(
                                                    [entityType UTF8String],
                                                    [entityId UTF8String],
                                                    [jsonEntityData UTF8String],
                                                    version,
                                                    new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)deleteEntities:(NSString *)entityType
      deleteCriteria:(NSString *)deleteCriteria
     completionBlock:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject
{
    _client->getCustomEntityService()->deleteEntities([entityType UTF8String], [deleteCriteria UTF8String],new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)getCount:(NSString *)entityType
       whereJson:(NSString *)whereJson
 completionBlock:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)ecb
        cbObject:(BCCallbackObject)cbObject
{
    _client->getCustomEntityService()->getCount(
                                                    [entityType UTF8String],
                                                    [whereJson UTF8String],
                                                    new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)getRandomEntitiesMatching:(NSString *)entityType
       whereJson:(NSString *)whereJson
        maxReturn:(int)maxReturn
 completionBlock:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)ecb
        cbObject:(BCCallbackObject)cbObject
{
    _client->getCustomEntityService()->getRandomEntitiesMatching(
                                                    [entityType UTF8String],
                                                    [whereJson UTF8String],
                                                            maxReturn,
                                                    new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)getPage:(NSString *)entityType
             context:(NSString *)context
     completionBlock:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject
{
    _client->getCustomEntityService()->getEntityPage(
                                                [entityType UTF8String],
                                                [context UTF8String],
                                                new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)getPageOffset:(NSString *)entityType
              context:(NSString *)context
           pageOffset:(int)pageOffset
      completionBlock:(BCCompletionBlock)completionBlock
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject
{
    _client->getCustomEntityService()->getEntityPageOffset(
                                                     [entityType UTF8String],
                                                     [context UTF8String],
                                                     pageOffset,
                                                     new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)readEntity:(NSString *)entityType
          entityId:(NSString *)entityId
   completionBlock:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)ecb
          cbObject:(BCCallbackObject)cbObject
{
    _client->getCustomEntityService()->readEntity(
                                                           [entityType UTF8String],
                                                           [entityId UTF8String],
                                                           new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)updateEntity:(NSString *)entityType
            entityId:(NSString *)entityId
             version:(int)version
            dataJson:(NSString *)dataJson
                 acl:(NSString *)acl
          timeToLive:(long)timeToLive
     completionBlock:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject
{
    _client->getCustomEntityService()->updateEntity(
                                                    [entityType UTF8String],
                                                    [entityId UTF8String],
                                                    version,
                                                    [dataJson UTF8String],
                                                    [acl UTF8String],
                                                    timeToLive,
                                                  new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)updateEntityFields:(NSString *)entityType
                  entityId:(NSString *)entityId
                   version:(int)version
                fieldsJson:(NSString *)fieldsJson
           completionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject
{
    _client->getCustomEntityService()->updateEntityFields(
                                                    [entityType UTF8String],
                                                    [entityId UTF8String],
                                                    version,
                                                    [fieldsJson UTF8String],
                                                    new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)updateEntityFieldsSharded:(NSString *)entityType
                         entityId:(NSString *)entityId
                          version:(int)version
                       fieldsJson:(NSString *)fieldsJson
                     shardKeyJson:(NSString *)shardKeyJson
                  completionBlock:(BCCompletionBlock)completionBlock
             errorCompletionBlock:(BCErrorCompletionBlock)ecb
                         cbObject:(BCCallbackObject)cbObject
{
    _client->getCustomEntityService()->updateEntityFieldsSharded(
                                                    [entityType UTF8String],
                                                    [entityId UTF8String],
                                                    version,
                                                    [fieldsJson UTF8String],
                                                    [shardKeyJson UTF8String],
                                                    new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)deleteSingleton:(NSString *)entityType
                   version:(int)version
           completionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject
{
        _client->getCustomEntityService()->deleteSingleton(
                                                    [entityType UTF8String],
                                                    version,
                                                    new BrainCloudCallback(completionBlock, ecb, cbObject));}

- (void)readSingleton:(NSString *)entityType
           completionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject
{
        _client->getCustomEntityService()->readSingleton(
                                                    [entityType UTF8String],
                                                    new BrainCloudCallback(completionBlock, ecb, cbObject));}

- (void)updateSingletonFields:(NSString *)entityType
                      version:(int)version
                   fieldsJson:(NSString *)fieldsJson
              completionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject
{
        _client->getCustomEntityService()->updateSingletonFields(
                                                    [entityType UTF8String],
                                                    version,
                                                    [fieldsJson UTF8String],
                                                    new BrainCloudCallback(completionBlock, ecb, cbObject));}

- (void)updateSingleton:(NSString *)entityType
                    version:(int)version
                   dataJson:(NSString *)dataJson
                        acl:(NSString *)acl
                 timeToLive:(int64_t)timeToLive
            completionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject
{
        _client->getCustomEntityService()->updateSingleton(
                                                    [entityType UTF8String],
                                                    version,
                                                    [dataJson UTF8String],
                                                    [acl UTF8String],
                                                    timeToLive,
                                                    new BrainCloudCallback(completionBlock, ecb, cbObject));}

- (void)incrementData:(NSString *)entityType
                  entityId:(NSString *)entityId
                fieldsJson:(NSString *)fieldsJson
           completionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject
{
        _client->getCustomEntityService()->incrementData(
                                                    [entityType UTF8String],
                                                    [entityId UTF8String],
                                                    [fieldsJson UTF8String],
                                                    new BrainCloudCallback(completionBlock, ecb, cbObject));}

- (void)incrementSingletonData:(NSString *)entityType
				fieldsJson:(NSString *)fieldsJson
		   completionBlock:(BCCompletionBlock)completionBlock
	  errorCompletionBlock:(BCErrorCompletionBlock)ecb
				  cbObject:(BCCallbackObject)cbObject
{
		_client->getCustomEntityService()->incrementSingletonData(
													[entityType UTF8String],
													[fieldsJson UTF8String],
													new BrainCloudCallback(completionBlock, ecb, cbObject));}

@end
