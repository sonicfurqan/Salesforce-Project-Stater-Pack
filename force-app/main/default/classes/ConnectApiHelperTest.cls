/*
Copyright (c) 2015, salesforce.com, Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright notice,
      this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice,
      this list of conditions and the following disclaimer in the documentation
      and/or other materials provided with the distribution.
    * Neither the name of the salesforce.com, Inc. nor the names of its contributors
      may be used to endorse or promote products derived from this software
      without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
OF THE POSSIBILITY OF SUCH DAMAGE.
*/

/**
 *
 * Unit tests for ConnectApiHelper.
 *
 * This class works with API version 35.0. There are separate classes
 * that work with earlier and later versions. 
 *
 * See https://github.com/forcedotcom/ConnectApiHelper for more information.
 *
 */

@IsTest(SeeAllData=true)
public class ConnectApiHelperTest {

   
    @isTest(seeAllData=true) // Adding SeeAllData=true as connectapi needs real data to execute test scripts.
    static void createFeedItem_Test() {
       
        
        // We can put the link and hashtag parts into a text segment to post the feed item. When it gets retrieved, it will have
        // separate segments for the text, link and hashtag.
        String expectedText = 'Text ';
        String expectedLink = 'http://link.com';
        String expectedHashtag = 'hashtag';
        String expectedBoldText = 'Bold text';
        ConnectApi.FeedItemInput feedItemInput = new ConnectApi.FeedItemInput();
 //initiation of messageSegments
        ConnectApi.MessageBodyInput messageBodyInput = new ConnectApi.MessageBodyInput();
        messageBodyInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();
 //preparing input text with all kinds of data to messageSegments
        ConnectApi.TextSegmentInput textSegmentInput = new ConnectApi.TextSegmentInput();
        textSegmentInput.text = expectedText + expectedLink + ' #' + expectedHashtag;
        messageBodyInput.messageSegments.add(textSegmentInput);
        //passing mention as input to messageSegments
        ConnectApi.MentionSegmentInput mentionSegmentInput = new ConnectApi.MentionSegmentInput();
        mentionSegmentInput.id = UserInfo.getUserId();
        messageBodyInput.messageSegments.add(mentionSegmentInput);
        //passing markup as input to messageSegments
        ConnectApi.MarkupBeginSegmentInput markupBeginSegmentInput = new ConnectApi.MarkupBeginSegmentInput();
        markupBeginSegmentInput.markupType = ConnectApi.MarkupType.Bold;
        messageBodyInput.messageSegments.add(markupBeginSegmentInput);
        //passing text as input to messageSegments
        textSegmentInput = new ConnectApi.TextSegmentInput();
        textSegmentInput.text = expectedBoldText;
        messageBodyInput.messageSegments.add(textSegmentInput);
        //passing markup text as input to messageSegments
        ConnectApi.MarkupEndSegmentInput markupEndSegmentInput = new ConnectApi.MarkupEndSegmentInput();
        markupEndSegmentInput.markupType = ConnectApi.MarkupType.Bold;
        messageBodyInput.messageSegments.add(markupEndSegmentInput);
        //adding all messageSegments as feed item body
        feedItemInput.body = messageBodyInput;
        feedItemInput.feedElementType = ConnectApi.FeedElementType.FeedItem;
        feedItemInput.subjectId = UserInfo.getUserId();
        //calling ConnectApi to update the feed item body 
        ConnectApi.FeedElement feedElement = ConnectApi.ChatterFeeds.postFeedElement(Network.getNetworkId(), feedItemInput);
        ConnectApiHelper.createFeedItemInputFromBody(feedElement.body,'string');
        
    }
    
}