Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30F95511C7
	for <lists+linux-block@lfdr.de>; Mon, 20 Jun 2022 09:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239343AbiFTHsc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 20 Jun 2022 03:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239527AbiFTHs3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 03:48:29 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFC21008;
        Mon, 20 Jun 2022 00:48:24 -0700 (PDT)
Received: from host86-158-155-35.range86-158.btcentralplus.com ([86.158.155.35] helo=[192.168.1.218])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1o3C8z-0005bP-5U;
        Mon, 20 Jun 2022 08:48:21 +0100
Message-ID: <63a9cfb7-4999-d902-a7df-278e2ec37593@youngman.org.uk>
Date:   Mon, 20 Jun 2022 08:48:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: About the md-bitmap behavior
Content-Language: en-GB
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-raid@vger.kernel.org,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <d4163d9f-8900-1ec1-ffb8-c3834c512279@gmx.com>
From:   Wols Lists <antlists@youngman.org.uk>
In-Reply-To: <d4163d9f-8900-1ec1-ffb8-c3834c512279@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 20/06/2022 08:29, Qu Wenruo wrote:
> Hi,
> 
> Recently I'm trying to implement a write-intent bitmap for btrfs to
> address its write-hole problems for RAID56.

Is there any reason you want a bit-map? Not a journal?

The write-hole has been addressed with journaling already, and this will 
be adding a new and not-needed feature - not saying it wouldn't be nice 
to have, but do we need another way to skin this cat?

Cheers,
Wol
