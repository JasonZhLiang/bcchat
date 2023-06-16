//
//  BrainCloudGroup.hh
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2016-05-11.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#pragma once
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

#import "BrainCloudCompletionBlocks.hh"
#import <Foundation/Foundation.h>

@class BrainCloudClient;

typedef NS_ENUM(NSUInteger, GroupMemberRole) { UNKNOWN, MEMBER, ADMIN, OWNER, OTHER };
typedef NS_ENUM(NSUInteger, AutoJoinStrategy) { JoinFirstGroup, JoinRandomGroup };

@interface BrainCloudGroup : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
 * Accept an outstanding invitation to join the group.
 *
 * Service Name - group
 * Service Operation - ACCEPT_GROUP_INVITATION
 *
 * @param groupId ID of the group.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)acceptGroupInvitation:(NSString *)groupId
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject;

/**
 * Add a member to the group.
 *
 * Service Name - group
 * Service Operation - ADD_GROUP_MEMBER
 *
 * @param groupId ID of the group.
 * @param profileId Profile ID of the member being added.
 * @param role Role of the member being added.
 * @param jsonAttributes Attributes of the member being added.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)addGroupMember:(NSString *)groupId
             profileId:(NSString *)profileId
                  role:(GroupMemberRole)role
        jsonAttributes:(NSString *)jsonAttrib
       completionBlock:(BCCompletionBlock)cb
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject;

/**
 * Approve an outstanding request to join the group.
 *
 * Service Name - group
 * Service Operation - APPROVE_GROUP_JOREQUEST
 *
 * @param groupId ID of the group.
 * @param profileId Profile ID of the invitation being deleted.
 * @param role Role of the member being invited.
 * @param jsonAttributes Attributes of the member being invited.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)approveGroupJoinRequest:(NSString *)groupId
                      profileId:(NSString *)profileId
                           role:(GroupMemberRole)role
                 jsonAttributes:(NSString *)jsonAttrib
                completionBlock:(BCCompletionBlock)cb
           errorCompletionBlock:(BCErrorCompletionBlock)ecb
                       cbObject:(BCCallbackObject)cbObject;

/**
 * Automatically join an open group that matches the search criteria and has space available.
 *
 * Service Name - group
 * Service Operation - AUTO_JOIN_GROUP
 *
 * @param groupType Name of the associated group type.
 * @param autoJoinStrategy Selection strategy to employ when there are multiple matches
 * @param dataQueryJson Query parameters (optional)
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)autoJoinGroup:(NSString *)groupType
     autoJoinStrategy:(AutoJoinStrategy)autoJoinStrategy
        dataQueryJson:(NSString *)dataQueryJson
      completionBlock:(BCCompletionBlock)cb
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject;

/**
 * Find and join an open group in the pool of groups in multiple group types provided as input arguments.
 *
 * Service Name - group
 * Service Operation - AUTO_JOIN_GROUP_MULTI
 *
 * @param groupType Name of the associated group type.
 * @param autoJoinStrategy Selection strategy to employ when there are multiple matches
 * @param where Query parameters (optional)
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)autoJoinGroupMulti:(NSArray *)groupTypes
     autoJoinStrategy:(AutoJoinStrategy)autoJoinStrategy
                where:(NSString *)where
      completionBlock:(BCCompletionBlock)cb
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject;

/**
 * Cancel an outstanding invitation to the group.
 *
 * Service Name - group
 * Service Operation - CANCEL_GROUP_INVITATION
 *
 * @param groupId ID of the group.
 * @param profileId Profile ID of the invitation being deleted.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)cancelGroupInvitation:(NSString *)groupId
                    profileId:(NSString *)profileId
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject;

/**
 * Create a group.
 *
 * Service Name - group
 * Service Operation - CREATE_GROUP
 *
 * @param name Name of the group.
 * @param groupType Name of the type of group.
 * @param isOpenGroup true if group is open; false if closed.
 * @param acl The group's access control list. A null ACL implies default.
 * @param jsonOwnerAttributes Attributes for the group owner (current player).
 * @param jsonDefaultMemberAttributes Default attributes for group members.
 * @param jsonData Custom application data.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
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

/**
 * Create a group with summary data.
 *
 * Service Name - group
 * Service Operation - CREATE_GROUP
 *
 * @param name Name of the group.
 * @param groupType Name of the type of group.
 * @param isOpenGroup true if group is open; false if closed.
 * @param acl The group's access control list. A null ACL implies default.
 * @param jsonOwnerAttributes Attributes for the group owner (current player).
 * @param jsonDefaultMemberAttributes Default attributes for group members.
 * @param jsonData Custom application data.
 * @param jsonSummaryData Custom application data.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
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
                          cbObject:(BCCallbackObject)cbObject;

/**
 * Create a group entity.
 *
 * Service Name - group
 * Service Operation - CREATE_GROUP_ENTITY
 *
 * @param groupId ID of the group.
 * @param isOwnedByGroupMember true if entity is owned by a member; false if
 * owned by the entire group.
 * @param entityType Type of the group entity.
 * @param acl Access control list for the group entity.
 * @param jsonData Custom application data.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)createGroupEntity:(NSString *)groupId
               entityType:(NSString *)entityType
     isOwnedByGroupMember:(BOOL)isOwnedByGroupMember
                      acl:(NSString *)acl
                 jsonData:(NSString *)jsonData
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject;

/**
 * Create a group entity.
 *
 * Service Name - group
 * Service Operation - CREATE_GROUP_ENTITY
 *
 * @param groupId ID of the group.
 * @param isOwnedByGroupMember true if entity is owned by a member; false if
 * owned by the entire group.
 * @param entityType Type of the group entity.
 * @param acl Access control list for the group entity.
 * @param jsonData Custom application data.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)deleteGroup:(NSString *)groupId
                 version:(int32_t)version
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
 * Delete a group entity.
 *
 * Service Name - group
 * Service Operation - DELETE_GROUP_ENTITY
 *
 * @param groupId ID of the group.
 * @param entityId ID of the entity.
 * @param version The current version of the group entity (for concurrency
 * checking).
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)deleteGroupEntity:(NSString *)groupId
                 entityId:(NSString *)entityId
                  version:(int32_t)version
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject;

/**
 * Read information on groups to which the current player belongs.
 *
 * Service Name - group
 * Service Operation - GET_MY_GROUPS
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getMyGroups:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
 * Increment elements for the group's data field.
 *
 * Service Name - group
 * Service Operation - INCREMENT_GROUP_DATA
 *
 * @param groupId ID of the group.
 * @param jsonData Partial data map with incremental values.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 * @param returnData Should the group data be returned in the response?
 */
- (void)incrementGroupData:(NSString *)groupId
                  jsonData:(NSString *)jsonData
           completionBlock:(BCCompletionBlock)cb
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject;

/**
 * Increment elements for the group entity's data field.
 *
 * Service Name - group
 * Service Operation - INCREMENT_GROUP_ENTITY_DATA
 *
 * @param groupId ID of the group.
 * @param entityId ID of the entity.
 * @param jsonData Partial data map with incremental values.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)incrementGroupEntityData:(NSString *)groupId
                        entityId:(NSString *)entityId
                        jsonData:(NSString *)jsonData
                 completionBlock:(BCCompletionBlock)cb
            errorCompletionBlock:(BCErrorCompletionBlock)ecb
                        cbObject:(BCCallbackObject)cbObject;

/**
 * Invite a member to the group.
 *
 * Service Name - group
 * Service Operation - INVITE_GROUP_MEMBER
 *
 * @param groupId ID of the group.
 * @param profileId Profile ID of the member being invited.
 * @param role Role of the member being invited.
 * @param jsonAttributes Attributes of the member being invited.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)inviteGroupMember:(NSString *)groupId
                profileId:(NSString *)profileId
                     role:(GroupMemberRole)role
           jsonAttributes:(NSString *)jsonAttrib
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject;

/**
 * Join an open group or request to join a closed group.
 *
 * Service Name - group
 * Service Operation - JOGROUP
 *
 * @param groupId ID of the group.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)joinGroup:(NSString *)groupId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
 * Leave a group in which the player is a member.
 *
 * Service Name - group
 * Service Operation - LEAVE_GROUP
 *
 * @param groupId ID of the group.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)leaveGroup:(NSString *)groupId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
 * Read a page of group information.
 *
 * Service Name - group
 * Service Operation - LIST_GROUPS_PAGE
 *
 * @param context Query context.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)listGroupsPage:(NSString *)jsonContext
       completionBlock:(BCCompletionBlock)cb
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject;

/**
 * Read a page of group information.
 *
 * Service Name - group
 * Service Operation - LIST_GROUPS_PAGE_BY_OFFSET
 *
 * @param encodedContext Encoded reference query context.
 * @param offset Number of pages by which to offset the query.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)listGroupsPageByOffset:(NSString *)encodedContext
                    pageOffset:(int32_t)offset
               completionBlock:(BCCompletionBlock)cb
          errorCompletionBlock:(BCErrorCompletionBlock)ecb
                      cbObject:(BCCallbackObject)cbObject;

/**
 * Read information on groups to which the specified player belongs.  Access is
 * subject to restrictions.
 *
 * Service Name - group
 * Service Operation - LIST_GROUPS_WITH_MEMBER
 *
 * @param profileId
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)listGroupsWithMember:(NSString *)profileId
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject;

/**
 * Read the specified group.
 *
 * Service Name - group
 * Service Operation - READ_GROUP
 *
 * @param groupId ID of the group.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)readGroup:(NSString *)groupId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
 * Read the specified group's data.
 *
 * Service Name - group
 * Service Operation - READ_GROUP_DATA
 *
 * @param groupId ID of the group.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)readGroupData:(NSString *)groupId
      completionBlock:(BCCompletionBlock)cb
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject;

/**
 * Read a page of group entity information.
 *
 * Service Name - group
 * Service Operation - READ_GROUP_ENTITIES_PAGE
 *
 * @param context Query context.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)readGroupEntitiesPage:(NSString *)jsonContext
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject;

/**
 * Read a page of group entity information.
 *
 * Service Name - group
 * Service Operation - READ_GROUP_ENTITIES_PAGE
 *
 * @param context Query context.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)readGroupEntitiesPageByOffset:(NSString *)encodedContext
                           pageOffset:(int32_t)offset
                      completionBlock:(BCCompletionBlock)cb
                 errorCompletionBlock:(BCErrorCompletionBlock)ecb
                             cbObject:(BCCallbackObject)cbObject;

/**
 * Read the specified group entity.
 *
 * Service Name - group
 * Service Operation - READ_GROUP_ENTITY
 *
 * @param groupId ID of the group.
 * @param entityId ID of the entity.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)readGroupEntity:(NSString *)groupId
               entityId:(NSString *)entityId
        completionBlock:(BCCompletionBlock)cb
   errorCompletionBlock:(BCErrorCompletionBlock)ecb
               cbObject:(BCCallbackObject)cbObject;

/**
 * Read the members of the group.
 *
 * Service Name - group
 * Service Operation - READ_MEMBERS_OF_GROUP
 *
 * @param groupId ID of the group.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)readGroupMembers:(NSString *)groupId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
 * Reject an outstanding invitation to join the group.
 *
 * Service Name - group
 * Service Operation - REJECT_GROUP_INVITATION
 *
 * @param groupId ID of the group.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)rejectGroupInvitation:(NSString *)groupId
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject;

/**
 * Reject an outstanding request to join the group.
 *
 * Service Name - group
 * Service Operation - REJECT_GROUP_JOREQUEST
 *
 * @param groupId ID of the group.
 * @param profileId Profile ID of the invitation being deleted.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)rejectGroupJoinRequest:(NSString *)groupId
                     profileId:(NSString *)profileId
               completionBlock:(BCCompletionBlock)cb
          errorCompletionBlock:(BCErrorCompletionBlock)ecb
                      cbObject:(BCCallbackObject)cbObject;

/**
 * Remove a member from the group.
 *
 * Service Name - group
 * Service Operation - REMOVE_GROUP_MEMBER
 *
 * @param groupId ID of the group.
 * @param profileId Profile ID of the member being deleted.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)removeGroupMember:(NSString *)groupId
                profileId:(NSString *)profileId
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject;

/**
 * Updates a group's data.
 *
 * Service Name - group
 * Service Operation - UPDATE_GROUP_DATA
 *
 * @param groupId ID of the group.
 * @param version Version to verify.
 * @param jsonData Data to apply.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)updateGroupData:(NSString *)groupId
                version:(int32_t)version
               jsonData:(NSString *)jsonData
        completionBlock:(BCCompletionBlock)cb
   errorCompletionBlock:(BCErrorCompletionBlock)ecb
               cbObject:(BCCallbackObject)cbObject;

/**
 * Update a group entity.
 *
 * Service Name - group
 * Service Operation - UPDATE_GROUP_ENTITY_DATA
 *
 * @param groupId ID of the group.
 * @param entityId ID of the entity.
 * @param version The current version of the group entity (for concurrency
 * checking).
 * @param jsonData Custom application data.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)updateGroupEntityData:(NSString *)groupId
                     entityId:(NSString *)entityId
                      version:(int32_t)version
                     jsonData:(NSString *)jsonData
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject;

/**
 * Update a member of the group.
 *
 * Service Name - group
 * Service Operation - UPDATE_GROUP_MEMBER
 *
 * @param groupId ID of the group.
 * @param profileId Profile ID of the member being updated.
 * @param role Role of the member being updated (optional).
 * @param jsonAttributes Attributes of the member being updated (optional).
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)updateGroupMember:(NSString *)groupId
                profileId:(NSString *)profileId
                     role:(GroupMemberRole)role
           jsonAttributes:(NSString *)jsonAttrib
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject;

/**
 * Updates a group's name.
 *
 * Service Name - group
 * Service Operation - UPDATE_GROUP_NAME
 *
 * @param groupId ID of the group.
 * @param name Name to apply.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)updateGroupName:(NSString *)groupId
                   name:(NSString *)name
        completionBlock:(BCCompletionBlock)cb
   errorCompletionBlock:(BCErrorCompletionBlock)ecb
               cbObject:(BCCallbackObject)cbObject;

/**
 * Set whether a group is open true or false
 *
 * Service Name - group
 * Service Operation - SET_GROUP_OPEN
 *
 * @param groupId ID of the group.
 * @param isOpenGroup whether its open or not.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)setGroupOpen:(NSString *)groupId
         isOpenGroup:(bool)isOpenGroup
     completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject;

/**
 * Update a group's summary data
 *
 * Service Name - group
 * Service Operation - UPDATE_GROUP_SUMMARY_DATA
 *
 * @param groupId ID of the group.
 * @param version is the version.
 * @param summaryData custom app data
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)updateGroupSummaryData:(NSString *)groupId
                       version:(int)version
                   summaryData:(NSString *)summaryData
               completionBlock:(BCCompletionBlock)cb
          errorCompletionBlock:(BCErrorCompletionBlock)ecb
                      cbObject:(BCCallbackObject)cbObject;

/**
 * Gets a list of up to maxReturn randomly selected gorups form the server based on the where condition
 *
 * Service Name - group
 * Service Operation - GET_RANDOM_GROUPS_MATCHING
 *
 * @param jsonWhere where to search
 * @param maxReturn max num groups wanted
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server
 * response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getRandomGroupsMatching:(NSString *)groupId
                      maxReturn:(int)maxReturn
                completionBlock:(BCCompletionBlock)cb
           errorCompletionBlock:(BCErrorCompletionBlock)ecb
                       cbObject:(BCCallbackObject)cbObject;

@end


#pragma clang diagnostic pop
