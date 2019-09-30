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
global class ConnectApiHelper {

    /**
    * @description  Takes an output body and returns a feed item input body that matches it.
    *  retrieves a feed item and want to either re-post or edit it.
    * @param        body  - feeditem body
    * @param        strCommentLine   - constructed string
    * @returns      input for ConnectApi
    **/
    public static ConnectApi.FeedItemInput createFeedItemInputFromBody(ConnectApi.FeedBody body, String strCommentLine) {
        //to prepage input message by updating its body
        ConnectApi.MessageBodyInput bodyInput = createInputFromBody(body,strCommentLine);
        ConnectApi.FeedItemInput input = new ConnectApi.FeedItemInput();
        input.body = bodyInput;
        return input;
    }

    private static ConnectApi.MessageBodyInput createInputFromBody(ConnectApi.FeedBody body, String strCommentLine) {
        ConnectApi.MessageBodyInput input = new ConnectApi.MessageBodyInput();
        input.messageSegments = new List<ConnectApi.MessageSegmentInput>();
        //To add our custom string to messageSegments
        ConnectApi.TextSegmentInput textInputDispString = new ConnectApi.TextSegmentInput();
        textInputDispString.Text = strCommentLine;
        input.messageSegments.add(textInputDispString);
        //To loop entire message body, update the message with given text or link or linkattachments or mentions or rich text
        for (ConnectApi.MessageSegment segment : body.messageSegments) {
            //To handel palin text and add to messageSegment
            if (segment instanceof ConnectApi.TextSegment) {
                ConnectApi.TextSegment textOutput = (ConnectApi.TextSegment) segment;
                ConnectApi.TextSegmentInput textInput = new ConnectApi.TextSegmentInput();
                textInput.text = textOutput.text;
                input.messageSegments.add(textInput);
            }
            //To handel '@'mention and add to messageSegment
            else if (segment instanceof ConnectApi.MentionSegment) {
                ConnectApi.MentionSegment mentionOutput = (ConnectApi.MentionSegment) segment;
                ConnectApi.MentionSegmentInput mentionInput = new ConnectApi.MentionSegmentInput();
                mentionInput.id = mentionOutput.record.id;
                input.messageSegments.add(mentionInput);
            }
             //To handel '#' and add to messageSegment
            else if (segment instanceof ConnectApi.HashtagSegment) {
                ConnectApi.HashtagSegment hashtagOutput = (ConnectApi.HashtagSegment) segment;
                ConnectApi.HashtagSegmentInput hashtagInput = new ConnectApi.HashtagSegmentInput();
                hashtagInput.tag = hashtagOutput.tag;
                input.messageSegments.add(hashtagInput);
            }
             //To handel link and add to messageSegment
            else if (segment instanceof ConnectApi.LinkSegment) {
                ConnectApi.LinkSegment linkOutput = (ConnectApi.LinkSegment) segment;
                ConnectApi.LinkSegmentInput linkInput = new ConnectApi.LinkSegmentInput();
                linkInput.url = linkOutput.url;
                input.messageSegments.add(linkInput);
            }
             //To apply markup style to input data and add to messageSegment
            else if (segment instanceof ConnectApi.MarkupBeginSegment) {
                ConnectApi.MarkupBeginSegment markupBeginOutput = (ConnectApi.MarkupBeginSegment) segment;
                ConnectApi.MarkupBeginSegmentInput markupBeginInput = new ConnectApi.MarkupBeginSegmentInput();
                //adds markup tag to messge if its not Hyperlink'<'
                if(markupBeginOutput.markupType!=ConnectApi.MarkupType.Hyperlink){
                    markupBeginInput.markupType = markupBeginOutput.markupType;
                    input.messageSegments.add(markupBeginInput);
                }
            }
            //To apply markup style to input data and add to messageSegment
            else if (segment instanceof ConnectApi.MarkupEndSegment) {
                ConnectApi.MarkupEndSegment markupEndOutput = (ConnectApi.MarkupEndSegment) segment;
                ConnectApi.MarkupEndSegmentInput markupEndInput = new ConnectApi.MarkupEndSegmentInput();
                //adds markup tag to messge if its not Hyperlink'>'
                if(markupEndOutput.markupType!=ConnectApi.MarkupType.Hyperlink){
                    markupEndInput.markupType = markupEndOutput.markupType;
                    input.messageSegments.add(markupEndInput);
                }
            }
             //To handel in line images and add to messageSegment
            else if (segment instanceof ConnectApi.InlineImageSegment) {
                ConnectApi.InlineImageSegment inlineImageOutput = (ConnectApi.InlineImageSegment) segment;
                ConnectApi.InlineImageSegmentInput inlineImageInput = new ConnectApi.InlineImageSegmentInput();
                inlineImageInput.fileId = inlineImageOutput.thumbnails.fileId;
                inlineImageInput.altText = inlineImageOutput.altText;
                input.messageSegments.add(inlineImageInput);
            }
        }
        return input;
    }
    

}