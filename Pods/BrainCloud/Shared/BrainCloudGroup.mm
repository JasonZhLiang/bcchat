//
//  BrainCloudGroup.mm
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2016-05-11.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#include "BrainCloudCallback.hh"
#include "braincloud/BrainCloudClient.h"
#import "BrainCloudClient.hh"
#import "BrainCloudGroup.hh"
#import "TypeHelpers.hh"

@interface BrainCloudGroup ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudGroup

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (void)acceptGroupInvitation:(NSString *)groupId
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupService()->acceptGroupInvitation(
        [groupId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)addGroupMember:(NSString *)groupId
             profileId:(NSString *)profileId
                  role:(GroupMemberRole)role
        jsonAttributes:(NSString *)jsonAttrib
       completionBlock:(BCCompletionBlock)cb
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupService()->addGroupMember(
        [groupId UTF8String], [profileId UTF8String], (BrainCloud::eGroupMember::Role)role,
        TypeHelpers::NSStringToStdString(jsonAttrib), new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)approveGroupJoinRequest:(NSString *)groupId
                      profileId:(NSString *)profileId
                           role:(GroupMemberRole)role
                 jsonAttributes:(NSString *)jsonAttrib
                completionBlock:(BCCompletionBlock)cb
           errorCompletionBlock:(BCErrorCompletionBlock)ecb
                       cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupService()->approveGroupJoinRequest(
        [groupId UTF8String], [profileId UTF8String], (BrainCloud::eGroupMember::Role)role,
        TypeHelpers::NSStringToStdString(jsonAttrib), new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)autoJoinGroup:(NSString *)groupType
     autoJoinStrategy:(AutoJoinStrategy)autoJoinStrategy
        dataQueryJson:(NSString *)dataQueryJson
      completionBlock:(BCCompletionBlock)cb
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject
{
    _client->getGroupService()->autoJoinGroup(
        [groupType UTF8String], (BrainCloud::eAutoJoinStrategy::Strategy)autoJoinStrategy,
        TypeHelpers::NSStringToStdString(dataQueryJson), new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)autoJoinGroupMulti:(NSArray *)groupTypes
     autoJoinStrategy:(AutoJoinStrategy)autoJoinStrategy
                where:(NSString *)where
      completionBlock:(BCCompletionBlock)cb
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject
{
    _client->getGroupService()->autoJoinGroupMulti(
        TypeHelpers::NSStringArrayToVector(groupTypes), (BrainCloud::eAutoJoinStrategy::Strategy)autoJoinStrategy,
        TypeHelpers::NSStringToStdString(where), new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)cancelGroupInvitation:(NSString *)groupId
                    profileId:(NSString *)profileId
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupService()->cancelGroupInvitation(
        [groupId UTF8String], [profileId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)createGroup:(NSString *)name
                      groupType:(NSString *)type
                    isOpenGroup:(BOOL)isOpenGroup
                            acl:(NSString *)acl
                       jsonData:(NSString *)jsonData
            jsonOwnerAttributes:(NSString *)jsonOwnerAttributes
    jsonDefaultMemberAttributes:(NSString *)jsonDefaultMemberAttributes
                completionBlock:(BCCompletionBlock)cb
           errorCompletionBlock:(BCErrorCompletionBlock)ecb
                       cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupService()->createGroup(
        [name UTF8String], [type UTF8String], isOpenGroup ? true : false, [acl UTF8String],
        TypeHelpers::NSStringToStdString(jsonOwnerAttributes),
        TypeHelpers::NSStringToStdString(jsonDefaultMemberAttributes), TypeHelpers::NSStringToStdString(jsonData),
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)createGroupWithSummaryData:(NSString *)name
                         groupType:(NSString *)type
                       isOpenGroup:(BOOL)isOpenGroup
                               acl:(NSString *)acl
                          jsonData:(NSString *)jsonData
               jsonOwnerAttributes:(NSString *)jsonOwnerAttributes
       jsonDefaultMemberAttributes:(NSString *)jsonDefaultMemberAttributes
                   jsonSummaryData:(NSString *)jsonSummaryData
                   completionBlock:(BCCompletionBlock)cb
              errorCompletionBlock:(BCErrorCompletionBlock)ecb
                          cbObject:(BCCallbackObject)cbObject
{
    _client->getGroupService()->createGroupWithSummaryData(
        [name UTF8String], [type UTF8String], isOpenGroup ? true : false, [acl UTF8String],
        TypeHelpers::NSStringToStdString(jsonOwnerAttributes),
        TypeHelpers::NSStringToStdString(jsonDefaultMemberAttributes), TypeHelpers::NSStringToStdString(jsonData),TypeHelpers::NSStringToStdString(jsonSummaryData),
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)createGroupEntity:(NSString *)groupId
               entityType:(NSString *)entityType
     isOwnedByGroupMember:(BOOL)isOwnedByGroupMember
                      acl:(NSString *)acl
                 jsonData:(NSString *)jsonData
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupService()->createGroupEntity(
        [groupId UTF8String], [entityType UTF8String], isOwnedByGroupMember ? true : false, [acl UTF8String],
        [jsonData UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)deleteGroup:(NSString *)groupId
                 version:(int32_t)version
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupService()->deleteGroup(
        [groupId UTF8String], version, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)deleteGroupEntity:(NSString *)groupId
                 entityId:(NSString *)entityId
                  version:(int32_t)version
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupService()->deleteGroupEntity(
        [groupId UTF8String], [entityId UTF8String], version, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getMyGroups:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupService()->getMyGroups(
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)incrementGroupData:(NSString *)groupId
                  jsonData:(NSString *)jsonData
           completionBlock:(BCCompletionBlock)cb
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupService()->incrementGroupData(
        [groupId UTF8String], [jsonData UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)incrementGroupEntityData:(NSString *)groupId
                        entityId:(NSString *)entityId
                        jsonData:(NSString *)jsonData
                 completionBlock:(BCCompletionBlock)cb
            errorCompletionBlock:(BCErrorCompletionBlock)ecb
                        cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupService()->incrementGroupEntityData(
        [groupId UTF8String], [entityId UTF8String], [jsonData UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)inviteGroupMember:(NSString *)groupId
                profileId:(NSString *)profileId
                     role:(GroupMemberRole)role
           jsonAttributes:(NSString *)jsonAttrib
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupService()->inviteGroupMember(
        [groupId UTF8String], [profileId UTF8String], (BrainCloud::eGroupMember::Role)role,
        TypeHelpers::NSStringToStdString(jsonAttrib), new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)joinGroup:(NSString *)groupId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupService()->joinGroup(
        [groupId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)leaveGroup:(NSString *)groupId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupService()->leaveGroup(
        [groupId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)listGroupsPage:(NSString *)jsonContext
       completionBlock:(BCCompletionBlock)cb
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupService()->listGroupsPage(
        [jsonContext UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)listGroupsPageByOffset:(NSString *)encodedContext
                    pageOffset:(int32_t)offset
               completionBlock:(BCCompletionBlock)cb
          errorCompletionBlock:(BCErrorCompletionBlock)ecb
                      cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupService()->listGroupsPageByOffset(
        [encodedContext UTF8String], offset, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)listGroupsWithMember:(NSString *)profileId
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupService()->listGroupsWithMember(
        [profileId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)readGroup:(NSString *)groupId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupService()->readGroup(
        [groupId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)readGroupData:(NSString *)groupId
      completionBlock:(BCCompletionBlock)cb
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject
{
    _client->getGroupService()->readGroupData(
        [groupId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)readGroupEntitiesPage:(NSString *)jsonContext
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupService()->readGroupEntitiesPage(
        [jsonContext UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)readGroupEntitiesPageByOffset:(NSString *)encodedContext
                           pageOffset:(int32_t)offset
                      completionBlock:(BCCompletionBlock)cb
                 errorCompletionBlock:(BCErrorCompletionBlock)ecb
                             cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupService()->readGroupEntitiesPageByOffset(
        [encodedContext UTF8String], offset, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)readGroupEntity:(NSString *)groupId
               entityId:(NSString *)entityId
        completionBlock:(BCCompletionBlock)cb
   errorCompletionBlock:(BCErrorCompletionBlock)ecb
               cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupService()->readGroupEntity(
        [groupId UTF8String], [entityId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)readGroupMembers:(NSString *)groupId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupService()->readGroupMembers(
        [groupId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)rejectGroupInvitation:(NSString *)groupId
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupService()->rejectGroupInvitation(
        [groupId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)rejectGroupJoinRequest:(NSString *)groupId
                     profileId:(NSString *)profileId
               completionBlock:(BCCompletionBlock)cb
          errorCompletionBlock:(BCErrorCompletionBlock)ecb
                      cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupService()->rejectGroupJoinRequest(
        [groupId UTF8String], [profileId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)removeGroupMember:(NSString *)groupId
                profileId:(NSString *)profileId
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupService()->removeGroupMember(
        [groupId UTF8String], [profileId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)updateGroupData:(NSString *)groupId
                version:(int32_t)version
               jsonData:(NSString *)jsonData
        completionBlock:(BCCompletionBlock)cb
   errorCompletionBlock:(BCErrorCompletionBlock)ecb
               cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupService()->updateGroupData(
        [groupId UTF8String], version, [jsonData UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)updateGroupEntityData:(NSString *)groupId
                     entityId:(NSString *)entityId
                      version:(int32_t)version
                     jsonData:(NSString *)jsonData
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupService()->updateGroupEntityData(
        [groupId UTF8String], [entityId UTF8String], version, [jsonData UTF8String],
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)updateGroupMember:(NSString *)groupId
                profileId:(NSString *)profileId
                     role:(GroupMemberRole)role
           jsonAttributes:(NSString *)jsonAttrib
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupService()->updateGroupMember(
        [groupId UTF8String], [profileId UTF8String], (BrainCloud::eGroupMember::Role)role,
        TypeHelpers::NSStringToStdString(jsonAttrib), new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)updateGroupName:(NSString *)groupId
                   name:(NSString *)name
        completionBlock:(BCCompletionBlock)cb
   errorCompletionBlock:(BCErrorCompletionBlock)ecb
               cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupService()->updateGroupName(
        [groupId UTF8String], [name UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)setGroupOpen:(NSString *)groupId
         isOpenGroup:(bool)isOpenGroup
     completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject
{
    _client->getGroupService()->setGroupOpen(
         [groupId UTF8String], isOpenGroup, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)updateGroupSummaryData:(NSString *)groupId
                       version:(int)version
                   summaryData:(NSString *)summaryData
               completionBlock:(BCCompletionBlock)cb
          errorCompletionBlock:(BCErrorCompletionBlock)ecb
                      cbObject:(BCCallbackObject)cbObject
{
    _client->getGroupService()->updateGroupSummaryData(
        [groupId UTF8String], version, TypeHelpers::NSStringToStdString(summaryData), new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getRandomGroupsMatching:(NSString *)jsonWhere
                      maxReturn:(int)maxReturn
                completionBlock:(BCCompletionBlock)cb
           errorCompletionBlock:(BCErrorCompletionBlock)ecb
                       cbObject:(BCCallbackObject)cbObject
{
    _client->getGroupService()->getRandomGroupsMatching(
        TypeHelpers::NSStringToStdString(jsonWhere), maxReturn, new BrainCloudCallback(cb, ecb, cbObject));
}

@end
